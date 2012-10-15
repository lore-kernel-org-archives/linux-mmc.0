From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [RFC/PATCH v2] mmc: core: Fixup signal voltage switch
Date: Mon, 15 Oct 2012 14:07:06 +0200
Message-ID: <1350302826-28294-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:44096 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2JOMJB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 08:09:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Johan Rudholm <johan.rudholm@stericsson.com>

When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
clock should be gated for 5 ms during the step. After enabling the
clock, the host should wait for at least 1 ms before checking for
failure. Failure by the card to switch is indicated by dat[0:3] being
pulled low. The host should check for this condition and power-cycle
the card if failure is indicated.

Add a retry mechanism for the SDIO case.

If the voltage switch fails repeatedly, give up and continue the
initialization using the original voltage.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
This rfc/patch is based on the following two patches:

[PATCH v2 1/2] mmc: core: Proper signal voltage switch
[PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail

This patch has been tested with a couple of UHS micro-SD cards, one of
which sometimes requires up to five power cycles before it accepts the
signal voltage switch. The patch has also been tested with various
other micro-SD cards, as well as one SDIO WLAN chip (cw1200) to check
for regressions. The patch has been tested with CONFIG_MMC_CLKGATE.

I'd be very grateful if someone could help me test this patch with a
SDIO card that supports 1.8V and perhaps also a combo card (which does
seem to be rare these days?)?

Changelog:
	v1 -> v2
	- Removed reset of signal voltage in mmc_sd_get_cid, since
	  "mmc: core: reset signal voltage on power up"
	previous two patches -> v1:
	- Keep calls to mmc_host_clk_hold / mmc_host_clk_release
	- Add retry-loop / power cycle in sdio.c
	- Fall back to 3.3 V if the switch repeatedly fails
	- Add an extra argument to the card_busy host_ops function,
	  which can be used to signal polling use of the function

---
 drivers/mmc/core/core.c  |   31 ++++++++++++++++++++++++++++++-
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/sd.c    |   29 ++++++++++++++++++++++++-----
 drivers/mmc/core/sdio.c  |   28 ++++++++++++++++++++++++++--
 include/linux/mmc/host.h |    6 ++++++
 5 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06c42cf..160760c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1243,8 +1243,37 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 	host->ios.signal_voltage = signal_voltage;
 
 	if (host->ops->start_signal_voltage_switch) {
+		u32 clock;
+
 		mmc_host_clk_hold(host);
+		clock = host->ios.clock;
+		if (cmd11) {
+			host->ios.clock = 0;
+			mmc_set_ios(host);
+		}
+
 		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+
+		if (err && cmd11) {
+			host->ios.clock = clock;
+			mmc_set_ios(host);
+		} else if (cmd11) {
+			/* Stop clock for at least 5 ms according to spec */
+			mmc_delay(5);
+			host->ios.clock = clock;
+			mmc_set_ios(host);
+
+			/* Wait for at least 1 ms according to spec */
+			mmc_delay(1);
+
+			/*
+			 * Failure to switch is indicated by the card holding
+			 * dat[0:3] low
+			 */
+			if (host->ops->card_busy &&
+					host->ops->card_busy(host, 0))
+				err = -EAGAIN;
+		}
 		mmc_host_clk_release(host);
 	}
 
@@ -1284,7 +1313,7 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
  * If a host does all the power sequencing itself, ignore the
  * initial MMC_POWER_UP stage.
  */
-static void mmc_power_up(struct mmc_host *host)
+void mmc_power_up(struct mmc_host *host)
 {
 	int bit;
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..5a5170d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
+void mmc_power_up(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 74972c2..0b456de 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -713,6 +713,14 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 {
 	int err;
 	u32 max_current;
+	int retries = 10;
+
+try_again:
+	if (!retries) {
+		ocr &= ~SD_OCR_S18R;
+		pr_warning("%s: Skipping voltage switch\n",
+			mmc_hostname(host));
+	}
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -734,9 +742,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 
 	/*
 	 * If the host supports one of UHS-I modes, request the card
-	 * to switch to 1.8V signaling level.
+	 * to switch to 1.8V signaling level. If the card has failed
+	 * repeatedly to switch however, skip this.
 	 */
-	if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+	if (retries && host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
 	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
 		ocr |= SD_OCR_S18R;
 
@@ -748,7 +757,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	if (max_current > 150)
 		ocr |= SD_OCR_XPC;
 
-try_again:
 	err = mmc_send_app_op_cond(host, ocr, rocr);
 	if (err)
 		return err;
@@ -760,8 +768,19 @@ try_again:
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
-		if (err) {
-			ocr &= ~SD_OCR_S18R;
+		if (err == -EAGAIN) {
+			/* Power cycle card */
+			pr_warning("%s: Signal voltage switch failed, "
+				"power cycling card (retries = %d)\n",
+				mmc_hostname(host), retries);
+			mmc_power_off(host);
+			/* Wait at least 1 ms according to spec */
+			mmc_delay(1);
+			mmc_power_up(host);
+			retries--;
+			goto try_again;
+		} else if (err) {
+			retries = 0;
 			goto try_again;
 		}
 	}
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..7955917 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -583,10 +583,19 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 {
 	struct mmc_card *card;
 	int err;
+	int retries = 10;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
+try_again:
+	if (!retries) {
+		pr_warning("%s: Skipping voltage switch\n",
+				mmc_hostname(host));
+		ocr &= ~R4_18V_PRESENT;
+		host->ocr &= ~R4_18V_PRESENT;
+	}
+
 	/*
 	 * Inform the card of the voltage
 	 */
@@ -645,14 +654,29 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * systems that claim 1.8v signalling in fact do not support
 	 * it.
 	 */
-	if ((ocr & R4_18V_PRESENT) &&
+	if (!powered_resume && (ocr & R4_18V_PRESENT) &&
 		(host->caps &
 			(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
 			 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
 			 MMC_CAP_UHS_DDR50))) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
 				true);
-		if (err) {
+		if (err == -EAGAIN) {
+			/* Power cycle card */
+			pr_warning("%s: Signal voltage switch failed, "
+				"power cycling card (retries = %d)\n",
+				mmc_hostname(host), retries);
+			mmc_power_off(host);
+			/* Wait at least 1 ms according to spec */
+			mmc_delay(1);
+			mmc_power_up(host);
+			sdio_reset(host);
+			mmc_go_idle(host);
+			mmc_send_if_cond(host, host->ocr_avail);
+			mmc_remove_card(card);
+			retries--;
+			goto try_again;
+		} else if (err) {
 			ocr &= ~R4_18V_PRESENT;
 			host->ocr &= ~R4_18V_PRESENT;
 		}
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7abb0e1..139a0c1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -131,6 +131,12 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 
+	/*
+	 * Check if the card is pulling dat0 low. keep_busy can be used to
+	 * indicate that the function will be called in a polling manner.
+	 */
+	int	(*card_busy)(struct mmc_host *host, int keep_busy);
+
 	/* The tuning command opcode value is different for SD and eMMC cards */
 	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
-- 
1.7.10

