From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v6 5/5] mmc: core: Fixup signal voltage switch
Date: Mon, 28 Jan 2013 15:08:28 +0100
Message-ID: <1359382108-958-6-git-send-email-johan.rudholm@stericsson.com>
References: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:53166 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756957Ab3A1OJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 09:09:34 -0500
In-Reply-To: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>, Johan Rudholm <johan.rudholm@stericsson.com>, Kevin Liu <kliu5@marvell.com>

When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
clock should be gated for 5 ms during the step. After enabling the
clock, the host should wait for at least 1 ms before checking for
failure. Failure by the card to switch is indicated by dat[0:3] being
pulled low. The host should check for this condition and power-cycle
the card if failure is indicated.

Add a retry mechanism for the SDIO case.

If the voltage switch fails repeatedly, give up and continue the
initialization using the original voltage.

This patch places a couple of requirements on the host driver:

 1) mmc_set_ios with ios.clock = 0 must gate the clock
 2) mmc_power_off must actually cut the power to the card
 3) The card_busy host_ops member must be implemented

if these requirements are not fulfilled, the 1.8V signal voltage switch
will still be attempted but may not be successful.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/core.c |   83 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/sd.c   |   21 +++++++++---
 drivers/mmc/core/sdio.c |   20 ++++++++++--
 3 files changed, 107 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3823351..2aee757 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1340,6 +1340,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
+	u32 clock;
 
 	BUG_ON(!host);
 
@@ -1347,20 +1348,82 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
 	 */
-	if (signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
-		cmd.opcode = SD_SWITCH_VOLTAGE;
-		cmd.arg = 0;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		return __mmc_set_signal_voltage(host, signal_voltage);
 
-		err = mmc_wait_for_cmd(host, &cmd, 0);
-		if (err)
-			return err;
+	/*
+	 * If we cannot switch voltages, return failure so the caller
+	 * can continue without UHS mode
+	 */
+	if (!host->ops->start_signal_voltage_switch)
+		return -EPERM;
+	if (!host->ops->card_busy)
+		pr_warning("%s: cannot verify signal voltage switch\n",
+				mmc_hostname(host));
+
+	cmd.opcode = SD_SWITCH_VOLTAGE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err)
+		return err;
 
-		if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
-			return -EIO;
+	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
+		return -EIO;
+
+	mmc_host_clk_hold(host);
+	/*
+	 * The card should drive cmd and dat[0:3] low immediately
+	 * after the response of cmd11, but wait 1 ms to be sure
+	 */
+	mmc_delay(1);
+	if (host->ops->card_busy && !host->ops->card_busy(host)) {
+		err = -EAGAIN;
+		goto power_cycle;
 	}
+	/*
+	 * During a signal voltage level switch, the clock must be gated
+	 * for 5 ms according to the SD spec
+	 */
+	clock = host->ios.clock;
+	host->ios.clock = 0;
+	mmc_set_ios(host);
 
-	return __mmc_set_signal_voltage(host, signal_voltage);
+	if (__mmc_set_signal_voltage(host, signal_voltage)) {
+		/*
+		 * Voltages may not have been switched, but we've already
+		 * sent CMD11, so a power cycle is required anyway
+		 */
+		err = -EAGAIN;
+		goto power_cycle;
+	}
+
+	/* Keep clock gated for at least 5 ms */
+	mmc_delay(5);
+	host->ios.clock = clock;
+	mmc_set_ios(host);
+
+	/* Wait for at least 1 ms according to spec */
+	mmc_delay(1);
+
+	/*
+	 * Failure to switch is indicated by the card holding
+	 * dat[0:3] low
+	 */
+	if (host->ops->card_busy && host->ops->card_busy(host))
+		err = -EAGAIN;
+
+power_cycle:
+	if (err) {
+		pr_debug("%s: Signal voltage switch failed, "
+			"power cycling card\n", mmc_hostname(host));
+		mmc_power_cycle(host);
+	}
+
+	mmc_host_clk_release(host);
+
+	return err;
 }
 
 /*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9a59fcd..03134b1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -712,6 +712,14 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
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
@@ -733,9 +741,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 
 	/*
 	 * If the host supports one of UHS-I modes, request the card
-	 * to switch to 1.8V signaling level.
+	 * to switch to 1.8V signaling level. If the card has failed
+	 * repeatedly to switch however, skip this.
 	 */
-	if (mmc_host_uhs(host))
+	if (retries && mmc_host_uhs(host))
 		ocr |= SD_OCR_S18R;
 
 	/*
@@ -746,7 +755,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	if (max_current > 150)
 		ocr |= SD_OCR_XPC;
 
-try_again:
 	err = mmc_send_app_op_cond(host, ocr, rocr);
 	if (err)
 		return err;
@@ -758,8 +766,11 @@ try_again:
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
-		if (err) {
-			ocr &= ~SD_OCR_S18R;
+		if (err == -EAGAIN) {
+			retries--;
+			goto try_again;
+		} else if (err) {
+			retries = 0;
 			goto try_again;
 		}
 	}
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 1a726ae..aa0719a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -584,10 +584,19 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
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
@@ -646,9 +655,16 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * systems that claim 1.8v signalling in fact do not support
 	 * it.
 	 */
-	if ((ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
+	if (!powered_resume && (ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
-		if (err) {
+		if (err == -EAGAIN) {
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
-- 
1.7.10

