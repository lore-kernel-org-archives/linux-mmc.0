From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 18 Oct 2011 10:35:01 +0530
Message-ID: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the support for power off notify feature, available in
eMMC 4.5 devices. If the the host has support for this feature, then the
mmc core will notify it to the device by setting the POWER_OFF_NOTIFICATION
byte in the extended csd register with a value 1(POWER_ON).

For suspend mode short timeout is used, whereas for the normal poweroff long
timeout is used.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changes in V9:
	Removed the macros not related with the PowerOff notify feature.
	The previous patch with commit id
	bd3151f6c55c553bed2c0df72792841457b75bb5 should be deleted before
	applying this patch.
Changes in V8:
	Updated with review comments of Chris Ball and rebased to 
	chris-mmc/mmc-next branch.
Changes in V7:
	Rebased to chris-mmc/mmc-next branch. merged to patches to single
	patch.
Changes in V6:
	Fixes checkpatch errors. The patches are generated after rebasing to
	 chris's mmc-next branch.
Changes in V5:
	This patch version fixes the problem with power off notify function,
	 when called for the first time and card is not yet initialised.
Changes in V4:
	Updated with review comments of Jeon
Changes in V2:
	Adds poweroff notification handling in suspend/normal.

 drivers/mmc/core/core.c  |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |   23 +++++++++++++++++++++--
 drivers/mmc/host/sdhci.c |    9 +++++++++
 include/linux/mmc/card.h |    6 ++++++
 include/linux/mmc/host.h |    5 +++++
 include/linux/mmc/mmc.h  |    6 ++++++
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 61d7730..b1eca96 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1212,11 +1212,43 @@ static void mmc_power_up(struct mmc_host *host)
 
 void mmc_power_off(struct mmc_host *host)
 {
+	struct mmc_card *card;
+	unsigned int notify_type;
+	unsigned int timeout;
+	int err;
+
 	mmc_host_clk_hold(host);
 
+	card = host->card;
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
+	if (card && mmc_card_mmc(card) &&
+	    card->poweroff_notify_state == MMC_POWERED_ON) {
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
+
 	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
 	 * this mmc host. This value will be used at next power up.
@@ -2208,6 +2240,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 1;
+		host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
 		spin_unlock_irqrestore(&host->lock, flags);
 		cancel_delayed_work_sync(&host->detect);
 
@@ -2231,6 +2264,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 0;
+		host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
 		spin_unlock_irqrestore(&host->lock, flags);
 		mmc_detect_change(host, 0);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4e869d3..f8ea938 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -458,10 +458,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->erased_byte = 0x0;
 
-	if (card->ext_csd.rev >= 6)
+	if (card->ext_csd.rev >= 6) {
 		card->ext_csd.generic_cmd6_time = 10 *
 			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
-	else
+		card->ext_csd.power_off_longtime = 10 *
+			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
+	} else
 		card->ext_csd.generic_cmd6_time = 0;
 
 out:
@@ -846,6 +848,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * If the host supports the power_off_notify capability then
+	 * set the notification byte in the ext_csd register of device
+	 */
+	if ((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) &&
+	    (card->poweroff_notify_state == MMC_NO_POWER_NOTIFICATION)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_POWER_OFF_NOTIFICATION,
+				 EXT_CSD_POWER_ON,
+				 card->ext_csd.generic_cmd6_time);
+		if (err && err != -EBADMSG)
+			goto free_card;
+	}
+
+	if (!err)
+		card->poweroff_notify_state = MMC_POWERED_ON;
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2cc3ffa..91fdaed 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2739,6 +2739,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
+	/*
+	 * If Notify capability is enabled by the host, set notify to
+	 * short power off notify timeout value.
+	 */
+	if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+	else
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
+
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 30d493c..fce88b3 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -54,6 +54,7 @@ struct mmc_ext_csd {
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		generic_cmd6_time;	/* Units: 10ms */
+	unsigned int            power_off_longtime;     /* Units: ms */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
 	unsigned int		card_type;
@@ -209,6 +210,11 @@ struct mmc_card {
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
 #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
 						/* byte mode */
+	unsigned int    poweroff_notify_state;	/* eMMC4.5 notify feature */
+#define MMC_NO_POWER_NOTIFICATION	0
+#define MMC_POWERED_ON			1
+#define MMC_POWEROFF_SHORT		2
+#define MMC_POWEROFF_LONG		3
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aed5bc7..07c0abf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -239,8 +239,13 @@ struct mmc_host {
 	unsigned int		caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
+	unsigned int		power_notify_type;
+#define MMC_HOST_PW_NOTIFY_NONE		0
+#define MMC_HOST_PW_NOTIFY_SHORT	1
+#define MMC_HOST_PW_NOTIFY_LONG		2
 
 #ifdef CONFIG_MMC_CLKGATE
 	int			clk_requests;	/* internal reference counter */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index cd63c2d..8b0e0a7 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -271,6 +271,7 @@ struct _mmc_csd {
  */
 
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
+#define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
@@ -346,6 +347,11 @@ struct _mmc_csd {
 #define EXT_CSD_RST_N_EN_MASK	0x3
 #define EXT_CSD_RST_N_ENABLED	1	/* RST_n is enabled on card */
 
+#define EXT_CSD_NO_POWER_NOTIFICATION	0
+#define EXT_CSD_POWER_ON		1
+#define EXT_CSD_POWER_OFF_SHORT		2
+#define EXT_CSD_POWER_OFF_LONG		3
+
 #define EXT_CSD_PWR_CL_8BIT_MASK	0xF0	/* 8 bit PWR CLS */
 #define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
 #define EXT_CSD_PWR_CL_8BIT_SHIFT	4
-- 
1.7.1
