From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V5 2/2] mmc: core: Add Poweroff Notify handling eMMC 4.5
Date: Fri, 16 Sep 2011 18:59:37 +0530
Message-ID: <1316179777-30720-3-git-send-email-girish.shivananjappa@linaro.org>
References: <1316179777-30720-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54266 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab1IPNaB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 09:30:01 -0400
In-Reply-To: <1316179777-30720-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This patch adds the power off notification handling
during suspend and system poweroff.
For suspend mode short timeout is used, whereas for the
normal poweroff long timeout is used.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c  |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |    5 ++++-
 drivers/mmc/host/sdhci.c |   10 ++++++++++
 include/linux/mmc/card.h |   19 +++++++++++++++++++
 include/linux/mmc/host.h |    4 ++++
 5 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91a0a74..157060f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1130,9 +1130,41 @@ static void mmc_power_up(struct mmc_host *host)
 
 static void mmc_power_off(struct mmc_host *host)
 {
+	struct mmc_card *card = host->card;
+	unsigned int notify_type;
+	unsigned int timeout;
+	int err;
+
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
+	if (card != NULL && mmc_card_mmc(card) &&
+		(mmc_card_powernotify_on(card))) {
+
+		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
+			notify_type = EXT_CSD_POWER_OFF_SHORT;
+			timeout = card->ext_csd.generic_cmd6_time;
+			mmc_card_set_powernotify_short(card);
+		} else {
+			notify_type = EXT_CSD_POWER_OFF_LONG;
+			timeout = card->ext_csd.power_off_longtime;
+			mmc_card_set_powernotify_long(card);
+		}
+
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_POWER_OFF_NOTIFICATION,
+				notify_type, timeout);
+
+		if (err && err != -EBADMSG)
+			printk(KERN_ERR "Device failed to respond "
+					"within %d poweroff time."
+					"forcefully powering down"
+					"the device\n", timeout);
+
+		/*Set the card state to no notification after the poweroff*/
+		mmc_card_set_powernotify_off(card);
+	}
+
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
 	 * this mmc host. This value will be used at next power up.
@@ -2022,6 +2054,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 1;
+		host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
 		spin_unlock_irqrestore(&host->lock, flags);
 		cancel_delayed_work_sync(&host->detect);
 
@@ -2044,6 +2077,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 0;
+		host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
 		spin_unlock_irqrestore(&host->lock, flags);
 		mmc_detect_change(host, 0);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2f06b37..63cc77b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -715,7 +715,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * If the host supports the power_off_notify capability then
 	 * set the notification byte in the ext_csd register of device
 	 */
-	if (host->caps & MMC_CAP_POWER_OFF_NOTIFY) {
+	if ((host->caps & MMC_CAP_POWER_OFF_NOTIFY)	&&
+		(mmc_card_powernotify_off(card))) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_POWER_OFF_NOTIFICATION,
 				EXT_CSD_POWER_ON,
@@ -724,6 +725,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	if (!err)
+		mmc_card_set_powernotify_on(card);
 	/*
 	 * Activate high speed (if supported)
 	 */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..92ea734 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2566,6 +2566,16 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
+	/*
+	 * If Notify capability is enabled and
+	 * notify type is not initialised by host, set default to
+	 * long power off notify timeout value
+	 */
+	if (mmc->caps & MMC_CAP_POWER_OFF_NOTIFY)
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+	else
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
+
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2bf2843..1d6a832 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -190,6 +190,11 @@ struct mmc_card {
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
+	unsigned int    poweroff_notify_state;/*eMMC4.5 notify feature  */
+#define MMC_NO_POWER_NOTIFICATION  0
+#define MMC_POWERED_ON     1
+#define MMC_POWEROFF_SHORT 2
+#define MMC_POWEROFF_LONG  3
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -325,6 +330,20 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 
+#define mmc_card_powernotify_on(c)     \
+		((c)->poweroff_notify_state == MMC_POWERED_ON)
+#define mmc_card_powernotify_off(c)    \
+		((c)->poweroff_notify_state == MMC_NO_POWER_NOTIFICATION)
+
+#define mmc_card_set_powernotify_off(c)    \
+		((c)->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION)
+#define mmc_card_set_powernotify_on(c) \
+		((c)->poweroff_notify_state = MMC_POWERED_ON)
+#define mmc_card_set_powernotify_short(c)  \
+		((c)->poweroff_notify_state = MMC_POWEROFF_SHORT)
+#define mmc_card_set_powernotify_long(c)   \
+		((c)->poweroff_notify_state = MMC_POWEROFF_LONG)
+
 /*
  * Quirk add/remove for MMC products.
  */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cf2dadc..4f24702 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -232,6 +232,10 @@ struct mmc_host {
 #define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
+	unsigned int        power_notify_type;
+#define MMC_HOST_PW_NOTIFY_NONE	0
+#define MMC_HOST_PW_NOTIFY_SHORT	1
+#define MMC_HOST_PW_NOTIFY_LONG	2
 
 #ifdef CONFIG_MMC_CLKGATE
 	int			clk_requests;	/* internal reference counter */
-- 
1.7.1

