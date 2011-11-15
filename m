From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Fix power_off_notify during suspend
Date: Tue, 15 Nov 2011 11:55:46 +0530
Message-ID: <1321338346-10911-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The eMMC 4.5 devices respond to only RESET and AWAKE command in the sleep
state. Hence the mmc switch command to notify power off state should be sent
before the device enters sleep state.

This patch fixes the same.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c |   81 ++++++++++++++++++++++++++++------------------
 drivers/mmc/core/mmc.c  |    2 +-
 2 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 74a012a..7ee2e07 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1225,6 +1225,46 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_host_clk_release(host);
 }
 
+static void mmc_poweroff_notify(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	unsigned int timeout;
+	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
+	int err = 0;
+
+	card = host->card;
+
+	/*
+	 * Send power notify command only if card
+	 * is mmc and notify state is powered ON
+	 */
+	if (card && mmc_card_mmc(card) &&
+	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
+
+		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
+			notify_type = EXT_CSD_POWER_OFF_SHORT;
+			timeout = card->ext_csd.generic_cmd6_time;
+			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
+		} else {
+			notify_type = EXT_CSD_POWER_OFF_LONG;
+			timeout = card->ext_csd.power_off_longtime;
+			card->poweroff_notify_state = MMC_POWEROFF_LONG;
+		}
+
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_POWER_OFF_NOTIFICATION,
+				 notify_type, timeout);
+
+		if (err && err != -EBADMSG)
+			pr_err("Device failed to respond within %d poweroff "
+			       "time. Forcefully powering down the device\n",
+			       timeout);
+
+		/* Set the card state to no notification after the poweroff */
+		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
+	}
+}
+
 /*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
@@ -1281,42 +1321,12 @@ static void mmc_power_up(struct mmc_host *host)
 
 void mmc_power_off(struct mmc_host *host)
 {
-	struct mmc_card *card;
-	unsigned int notify_type;
-	unsigned int timeout;
-	int err;
-
 	mmc_host_clk_hold(host);
 
-	card = host->card;
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
-	if (card && mmc_card_mmc(card) &&
-	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
-
-		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
-			notify_type = EXT_CSD_POWER_OFF_SHORT;
-			timeout = card->ext_csd.generic_cmd6_time;
-			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
-		} else {
-			notify_type = EXT_CSD_POWER_OFF_LONG;
-			timeout = card->ext_csd.power_off_longtime;
-			card->poweroff_notify_state = MMC_POWEROFF_LONG;
-		}
-
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_POWER_OFF_NOTIFICATION,
-				 notify_type, timeout);
-
-		if (err && err != -EBADMSG)
-			pr_err("Device failed to respond within %d poweroff "
-			       "time. Forcefully powering down the device\n",
-			       timeout);
-
-		/* Set the card state to no notification after the poweroff */
-		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
-	}
+	mmc_poweroff_notify(host);
 
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
@@ -2314,8 +2324,15 @@ int mmc_suspend_host(struct mmc_host *host)
 		 * pre-claim the host.
 		 */
 		if (mmc_try_claim_host(host)) {
-			if (host->bus_ops->suspend)
+			if (host->bus_ops->suspend) {
+				/*
+				 * For eMMC 4.5 device send notify command
+				 * before sleep, because in sleep state eMMC 4.5
+				 * devices respond to only RESET and AWAKE cmd
+				 */
+				mmc_poweroff_notify(host);
 				err = host->bus_ops->suspend(host);
+			}
 			if (err == -ENOSYS || !host->bus_ops->resume) {
 				/*
 				 * We simply "remove" the card in this case.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4db73a9..a1223bd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -875,7 +875,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * set the notification byte in the ext_csd register of device
 	 */
 	if ((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) &&
-	    (card->poweroff_notify_state == MMC_NO_POWER_NOTIFICATION)) {
+	    (card->ext_csd.rev >= 6)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_OFF_NOTIFICATION,
 				 EXT_CSD_POWER_ON,
-- 
1.7.1
