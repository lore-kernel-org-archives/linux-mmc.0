From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v6 4/5] mmc: core: Break out start_signal_voltage_switch
Date: Mon, 28 Jan 2013 15:08:27 +0100
Message-ID: <1359382108-958-5-git-send-email-johan.rudholm@stericsson.com>
References: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:40356 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756989Ab3A1OJg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 09:09:36 -0500
In-Reply-To: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>, Johan Rudholm <johan.rudholm@stericsson.com>

Allow callers to access the start_signal_voltage_switch host_ops
member without going through any cmd11 logic. This is mostly a
preparation for the following signal voltage switch patch.

Also, reset ios.signal_voltage to its original value if
start_signal_voltage_switch fails.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/core.c |   35 +++++++++++++++++++++++------------
 drivers/mmc/core/core.h |    4 ++--
 drivers/mmc/core/mmc.c  |    8 ++++----
 drivers/mmc/core/sd.c   |    2 +-
 drivers/mmc/core/sdio.c |    3 +--
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 304c97c..3823351 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1317,7 +1317,26 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11)
+int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+{
+	int err = 0;
+	int old_signal_voltage = host->ios.signal_voltage;
+
+	host->ios.signal_voltage = signal_voltage;
+	if (host->ops->start_signal_voltage_switch) {
+		mmc_host_clk_hold(host);
+		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+		mmc_host_clk_release(host);
+	}
+
+	if (err)
+		host->ios.signal_voltage = old_signal_voltage;
+
+	return err;
+
+}
+
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
@@ -1328,7 +1347,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
 	 */
-	if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
+	if (signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
 		cmd.opcode = SD_SWITCH_VOLTAGE;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -1341,15 +1360,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 			return -EIO;
 	}
 
-	host->ios.signal_voltage = signal_voltage;
-
-	if (host->ops->start_signal_voltage_switch) {
-		mmc_host_clk_hold(host);
-		err = host->ops->start_signal_voltage_switch(host, &host->ios);
-		mmc_host_clk_release(host);
-	}
-
-	return err;
+	return __mmc_set_signal_voltage(host, signal_voltage);
 }
 
 /*
@@ -1412,7 +1423,7 @@ static void mmc_power_up(struct mmc_host *host)
 	mmc_set_ios(host);
 
 	/* Set signal voltage to 3.3V */
-	mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, false);
+	__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
 	/*
 	 * This delay should be sufficient to allow the power supply
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9007de7..b9f18a2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -40,8 +40,8 @@ void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
-			   bool cmd11);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e6e3911..bd86771 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -769,11 +769,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
 			host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0);
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
 	if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
 			host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* If fails try again during next card power cycle */
 	if (err)
@@ -1221,8 +1221,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			 * WARNING: eMMC rules are NOT the same as SD DDR
 			 */
 			if (ddr == MMC_1_2V_DDR_MODE) {
-				err = mmc_set_signal_voltage(host,
-					MMC_SIGNAL_VOLTAGE_120, 0);
+				err = __mmc_set_signal_voltage(host,
+					MMC_SIGNAL_VOLTAGE_120);
 				if (err)
 					goto err;
 			}
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9373639..9a59fcd 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -757,7 +757,7 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 		if (err) {
 			ocr &= ~SD_OCR_S18R;
 			goto try_again;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 3a64933..1a726ae 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -647,8 +647,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * it.
 	 */
 	if ((ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-				true);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 		if (err) {
 			ocr &= ~R4_18V_PRESENT;
 			host->ocr &= ~R4_18V_PRESENT;
-- 
1.7.10

