From: Girish K S <girish.shivananjappa@linaro.org>
Subject: (unknown)
Date: Thu, 22 Sep 2011 16:40:43 +0530
Message-ID: <1316689844-8663-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Subject: 
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the support for power off notify feature
available in eMMC 4.5 devices.
	If the the host has support for this feature, then the
mmc core will notify it to the device by setting the
POWER_OFF_NOTIFICATION byte in the extended csd register
with a value 1(POWER_ON).
	This patch should be applied after Seungwon Jeon's
patch for cmd6 timeout.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 v2:
 adds poweroff notification handling in suspend/normal
 v4:
 updated with review comments of Jeon
 v5:
 This patch version fixes the problem with power off
 notify function, when called for the first time and
 card is not yet initialised.
 v6:
 fixes checkpatch errors. The patches are generated after
 rebasing to chris's mmc-next branch.
 
 drivers/mmc/core/mmc.c   |   17 +++++++++++++++++
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/mmc.h  |    6 ++++++
 4 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7adc30d..a547f49 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -412,6 +412,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->erased_byte = 0x0;
 
+	if (card->ext_csd.rev >= 6) {
+		card->ext_csd.power_off_longtime = 10 *
+			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
+	}
 out:
 	return err;
 }
@@ -713,6 +717,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * If the host supports the power_off_notify capability then
+	 * set the notification byte in the ext_csd register of device
+	 */
+	if (host->caps & MMC_CAP_POWER_OFF_NOTIFY) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_POWER_OFF_NOTIFICATION,
+				EXT_CSD_POWER_ON,
+				card->ext_csd.generic_cmd6_time);
+		if (err && err != -EBADMSG)
+			goto free_card;
+	}
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5294ddf..0f9dbd6 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -53,6 +53,7 @@ struct mmc_ext_csd {
 	u8			rst_n_function;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
+	unsigned int		power_off_longtime;	/* Units: ms */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
 	unsigned int		card_type;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b2aefea..ed49e88 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -235,6 +235,7 @@ struct mmc_host {
 #define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
+#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index ed8fca8..95912da 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -270,6 +270,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_POWER_OFF_NOTIFICATION	34 /* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
@@ -294,6 +295,7 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
 #define EXT_CSD_TRIM_MULT		232	/* RO */
+#define EXT_CSD_POWER_OFF_LONG_TIME	247 /*RO*/
 
 /*
  * EXT_CSD field definitions
@@ -331,6 +333,10 @@ struct _mmc_csd {
 
 #define EXT_CSD_RST_N_EN_MASK	0x3
 #define EXT_CSD_RST_N_ENABLED	1	/* RST_n is enabled on card */
+#define EXT_CSD_NO_POWER_NOTIFICATION	0
+#define EXT_CSD_POWER_ON	1
+#define EXT_CSD_POWER_OFF_SHORT	2
+#define EXT_CSD_POWER_OFF_LONG	3
 
 /*
  * MMC_SWITCH access modes
-- 
1.7.1
