From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH 2/2] mmc: core: Add poweroff notify handling feature
Date: Mon,  5 Sep 2011 17:19:59 +0530
Message-ID: <1315223399-21599-3-git-send-email-girish.shivananjappa@linaro.org>
References: <1315223399-21599-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45711 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1IELu2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2011 07:50:28 -0400
In-Reply-To: <1315223399-21599-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This patch adds the handling of the poweroff notify feature
during powerdown phase.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c  |   29 +++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |    3 +++
 drivers/mmc/host/sdhci.c |   11 +++++++++++
 include/linux/mmc/card.h |   29 +++++++++++++++++++++++++----
 include/linux/mmc/host.h |    7 +++++--
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a65e1ca..37b09d7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1130,9 +1130,38 @@ static void mmc_power_up(struct mmc_host *host)
 
 static void mmc_power_off(struct mmc_host *host)
 {
+	struct mmc_card	*card = host->card;
+	unsigned int notify_type;
+	unsigned int timeout;
+	int err;
+
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
+	if (mmc_card_mmc(card) && mmc_card_powernotify_on(card)) {
+
+		if (host->power_notify_type == MMC_POWEROFF_NOTIFY_SHORT) {
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
+		mmc_card_set_powernotify_off(card);
+	}
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
 	 * this mmc host. This value will be used at next power up.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2f06b37..b369c6f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -720,8 +720,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				EXT_CSD_POWER_OFF_NOTIFICATION,
 				EXT_CSD_POWER_ON,
 				card->ext_csd.generic_cmd6_time);
+
 		if (err && err != -EBADMSG)
 			goto free_card;
+
+		mmc_card_set_powernotify_on(card);
 	}
 
 	/*
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..a24a31b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2566,6 +2566,17 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
+	if (mmc->caps == MMC_CAP_POWER_OFF_NOTIFY) {
+		/*
+		 * If Notify capability is enabled and
+		 * platform data is not initialised, set default to
+		 * long power off notify timeout value
+		 */
+		if (mmc->power_notify_type == MMC_POWEROFF_NOTIFY_NONE)
+			mmc->power_notify_type = MMC_POWEROFF_NOTIFY_LONG;
+	} else {
+		mmc->power_notify_type = MMC_POWEROFF_NOTIFY_NONE;
+	}
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2bf2843..d40b7b3 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -179,7 +179,12 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
-	unsigned int		quirks; 	/* card quirks */
+	unsigned int	poweroff_notify_state;/*eMMC4.5 notify feature  */
+#define MMC_NO_POWER_NITOFICATION	0
+#define MMC_POWERED_ON		1
+#define MMC_POWEROFF_SHORT	2
+#define MMC_POWEROFF_LONG	3
+	unsigned int		quirks;		/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
 						/* for byte mode */
@@ -192,9 +197,9 @@ struct mmc_card {
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
 
 	unsigned int		erase_size;	/* erase size in sectors */
- 	unsigned int		erase_shift;	/* if erase unit is power 2 */
- 	unsigned int		pref_erase;	/* in sectors */
- 	u8			erased_byte;	/* value of erased bytes */
+	unsigned int		erase_shift;	/* if erase unit is power 2 */
+	unsigned int		pref_erase;	/* in sectors */
+	u8			erased_byte;	/* value of erased bytes */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
@@ -325,6 +330,22 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 
+#define mmc_card_powernotify_on(c)		\
+		((c)->poweroff_notify_state == MMC_POWERED_ON)
+#define mmc_card_powernotify_short(c)	\
+		((c)->poweroff_notify_state == MMC_POWEROFF_SHORT)
+#define mmc_card_powernotify_long(c)	\
+		((c)->poweroff_notify_state == MMC_POWEROFF_LONG)
+
+#define mmc_card_set_powernotify_off(c)	\
+		((c)->poweroff_notify_state = MMC_NO_POWER_NITOFICATION)
+#define mmc_card_set_powernotify_on(c)	\
+		((c)->poweroff_notify_state = MMC_POWERED_ON)
+#define mmc_card_set_powernotify_short(c)	\
+		((c)->poweroff_notify_state = MMC_POWEROFF_SHORT)
+#define mmc_card_set_powernotify_long(c)	\
+		((c)->poweroff_notify_state = MMC_POWEROFF_LONG)
+
 /*
  * Quirk add/remove for MMC products.
  */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 21c85e1..354752a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -229,10 +229,13 @@ struct mmc_host {
 #define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
 #define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
-#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*NOtify poweroff supported */
+#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
-
+#define MMC_POWEROFF_NOTIFY_NONE	0
+#define MMC_POWEROFF_NOTIFY_SHORT	1
+#define MMC_POWEROFF_NOTIFY_LONG	2
+	unsigned int		power_notify_type;
 #ifdef CONFIG_MMC_CLKGATE
 	int			clk_requests;	/* internal reference counter */
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
-- 
1.7.1

