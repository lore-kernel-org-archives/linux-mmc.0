From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V5 1/2] mmc: core: Add power off notify feature(eMMC 4.5)
Date: Tue, 13 Sep 2011 18:28:05 +0530
Message-ID: <1315918686-14375-2-git-send-email-girish.shivananjappa@linaro.org>
References: <1315918686-14375-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36488 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab1IMM6Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2011 08:58:16 -0400
In-Reply-To: <1315918686-14375-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

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
 drivers/mmc/core/mmc.c   |   19 +++++++++++++++++--
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/mmc.h  |    7 +++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 68eb368..2f06b37 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -410,10 +410,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->erased_byte = 0x0;
 
-	if (card->ext_csd.rev >= 6)
+	if (card->ext_csd.rev >= 6) {
 		card->ext_csd.generic_cmd6_time = 10 *
 			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
-
+		card->ext_csd.power_off_longtime = 10 *
+			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
+	}
 out:
 	return err;
 }
@@ -710,6 +712,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
index e992fe3..2bf2843 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -53,6 +53,7 @@ struct mmc_ext_csd {
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		generic_cmd6_time;	/* Units: ms */
+	unsigned int		power_off_longtime;	/* Units: ms */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
 	unsigned int		card_type;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1d09562..cf2dadc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -229,6 +229,7 @@ struct mmc_host {
 #define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
 #define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
+#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index e869f00..a788e01 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -270,6 +270,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_POWER_OFF_NOTIFICATION	34 /* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
@@ -293,6 +294,7 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
 #define EXT_CSD_TRIM_MULT		232	/* RO */
+#define EXT_CSD_POWER_OFF_LONG_TIME	247 /*RO*/
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 
 /*
@@ -329,6 +331,11 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_BD_BLK_EN	BIT(2)
 #define EXT_CSD_SEC_GB_CL_EN	BIT(4)
 
+#define EXT_CSD_NO_POWER_NOTIFICATION	0
+#define EXT_CSD_POWER_ON	1
+#define EXT_CSD_POWER_OFF_SHORT	2
+#define EXT_CSD_POWER_OFF_LONG	3
+
 /*
  * MMC_SWITCH access modes
  */
-- 
1.7.1

