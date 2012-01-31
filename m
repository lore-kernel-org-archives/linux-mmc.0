From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Fix PowerOff Notify suspend/resume
Date: Tue, 31 Jan 2012 15:44:03 +0530
Message-ID: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, saugata.das@linaro.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Modified the mmc_poweroff to resume before sending the
poweroff notification command. In sleep mode only AWAKE
and RESET commands are allowed, so before sending the
poweroff notification command resume from sleep mode and
then send the notification command.

POwerOff Notify is tested on a Synopsis Designware Host
Controller(eMMC 4.5). The suspend to RAM and resume works fine.

This patch is successfully applied on the Chris's mmc-next
branch

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
Tested-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c  |   28 ++++++++++++++++++++--------
 drivers/mmc/core/mmc.c   |   17 ++++++++++++-----
 include/linux/mmc/card.h |    4 ++++
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bec0bf2..14ec575 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1239,7 +1239,8 @@ static void mmc_poweroff_notify(struct mmc_host *host)
 	int err = 0;
 
 	card = host->card;
-
+	mmc_claim_host(host);
+
 	/*
 	 * Send power notify command only if card
 	 * is mmc and notify state is powered ON
@@ -1269,6 +1270,7 @@ static void mmc_poweroff_notify(struct mmc_host *host)
 		/* Set the card state to no notification after the poweroff */
 		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
 	}
+	mmc_release_host(host);
 }
 
 /*
@@ -1327,12 +1329,28 @@ static void mmc_power_up(struct mmc_host *host)
 
 void mmc_power_off(struct mmc_host *host)
 {
+	int err = 0;
 	mmc_host_clk_hold(host);
 
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
-	mmc_poweroff_notify(host);
+	/*
+	 * For eMMC 4.5 device send AWAKE command before
+	 * POWER_OFF_NOTIFY command, because in sleep state
+	 * eMMC 4.5 devices respond to only RESET and AWAKE cmd
+	 */
+	if (host->card && mmc_card_is_sleep(host->card) &&
+	    host->bus_ops->resume) {
+		err = host->bus_ops->resume(host);
+
+		if (!err)
+			mmc_poweroff_notify(host);
+		else
+			pr_warning("%s: error %d during resume "
+				   "(continue with poweroff sequence)\n",
+				   mmc_hostname(host), err);
+	}
 
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
@@ -2386,12 +2404,6 @@ int mmc_suspend_host(struct mmc_host *host)
 		 */
 		if (mmc_try_claim_host(host)) {
 			if (host->bus_ops->suspend) {
-				/*
-				 * For eMMC 4.5 device send notify command
-				 * before sleep, because in sleep state eMMC 4.5
-				 * devices respond to only RESET and AWAKE cmd
-				 */
-				mmc_poweroff_notify(host);
 				err = host->bus_ops->suspend(host);
 			}
 			mmc_do_release_host(host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2bc586b..c3f09a2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1330,11 +1330,13 @@ static int mmc_suspend(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	if (mmc_card_can_sleep(host))
+	if (mmc_card_can_sleep(host)) {
 		err = mmc_card_sleep(host);
-	else if (!mmc_host_is_spi(host))
+		if (!err)
+			mmc_card_set_sleep(host->card);
+	} else if (!mmc_host_is_spi(host))
 		mmc_deselect_cards(host);
-	host->card->state &= ~MMC_STATE_HIGHSPEED;
+	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 	mmc_release_host(host);
 
 	return err;
@@ -1354,7 +1356,11 @@ static int mmc_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	err = mmc_init_card(host, host->ocr, host->card);
+	if (mmc_card_is_sleep(host->card)) {
+		err = mmc_card_awake(host);
+		mmc_card_clr_sleep(host->card);
+	} else
+		err = mmc_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
 
 	return err;
@@ -1364,7 +1370,8 @@ static int mmc_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	host->card->state &= ~MMC_STATE_HIGHSPEED;
+	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
+	mmc_card_clr_sleep(host->card);
 	mmc_claim_host(host);
 	ret = mmc_init_card(host, host->ocr, host->card);
 	mmc_release_host(host);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9a0663..1a1ca71 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -219,6 +219,7 @@ struct mmc_card {
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
+#define MMC_STATE_SLEEP		(1<<9)		/* card is in sleep state */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -384,6 +385,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_uhs(c)	((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
+#define mmc_card_is_sleep(c)	((c)->state & MMC_STATE_SLEEP)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -395,7 +397,9 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
+#define mmc_card_set_sleep(c)	((c)->state |= MMC_STATE_SLEEP)
 
+#define mmc_card_clr_sleep(c)	((c)->state &= ~MMC_STATE_SLEEP)
 /*
  * Quirk add/remove for MMC products.
  */
-- 
1.7.1
