From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 07/12] mmc: sd: set current limit for uhs cards
Date: Fri, 15 Apr 2011 16:08:57 +0530
Message-ID: <1302863942-1774-8-git-send-email-arindam.nath@amd.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58389 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1DOKl2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 06:41:28 -0400
Received: by pvg12 with SMTP id 12so1008425pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:41:27 -0700 (PDT)
In-Reply-To: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

We decide on the current limit to be set for the card based on the
Capability of Host Controller to provide current at 1.8V signalling,
and the maximum current limit of the card as indicated by CMD6
mode 0. We then set the current limit for the card using CMD6 mode 1.
As per the Physical Layer Spec v3.01, the current limit switch is
only applicable for SDR50, SDR104, and DDR50 bus speed modes. For
other UHS-I modes, we set the default current limit of 200mA.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c |   10 +++++++
 include/linux/mmc/card.h |    9 ++++++
 include/linux/mmc/host.h |    4 +++
 4 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bf5710c..001d2e8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -520,6 +520,64 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+static int sd_set_current_limit(struct mmc_card *card, u8 *status)
+{
+	int current_limit = 0;
+	int err;
+
+	/*
+	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
+	 * bus speed modes. For other bus speed modes, we set the default
+	 * current limit of 200mA.
+	 */
+	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
+	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
+	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
+		if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
+			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
+				current_limit = SD_SET_CURRENT_LIMIT_800;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_600)
+				current_limit = SD_SET_CURRENT_LIMIT_600;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_400)
+				current_limit = SD_SET_CURRENT_LIMIT_400;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_200)
+				current_limit = SD_SET_CURRENT_LIMIT_200;
+		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_600) {
+			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_600)
+				current_limit = SD_SET_CURRENT_LIMIT_600;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_400)
+				current_limit = SD_SET_CURRENT_LIMIT_400;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_200)
+				current_limit = SD_SET_CURRENT_LIMIT_200;
+		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_400) {
+			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
+				current_limit = SD_SET_CURRENT_LIMIT_400;
+			else if (card->sw_caps.sd3_curr_limit &
+					SD_MAX_CURRENT_200)
+				current_limit = SD_SET_CURRENT_LIMIT_200;
+		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_200) {
+			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
+				current_limit = SD_SET_CURRENT_LIMIT_200;
+		}
+	} else
+		current_limit = SD_SET_CURRENT_LIMIT_200;
+
+	err = mmc_sd_switch(card, 1, 3, current_limit, status);
+	if (err)
+		return err;
+
+	if (((status[15] >> 4) & 0x0F) != current_limit)
+		printk(KERN_WARNING "%s: Problem setting current limit!\n",
+			mmc_hostname(card->host));
+
+	return 0;
+}
+
 /*
  * UHS-I specific initialization procedure
  */
@@ -558,6 +616,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 
 	/* Set bus speed mode of the card */
 	err = sd_set_bus_speed_mode(card, status);
+	if (err)
+		goto out;
+
+	/* Set current limit for the card */
+	err = sd_set_current_limit(card, status);
 
 out:
 	kfree(status);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a4fcb5..21b2290 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2240,6 +2240,16 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		if (max_current_180 > 150)
 			mmc->caps |= MMC_CAP_SET_XPC_180;
+
+		/* Maximum current capabilities of the host at 1.8V */
+		if (max_current_180 >= 800)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_800;
+		else if (max_current_180 >= 600)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_600;
+		else if (max_current_180 >= 400)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_400;
+		else
+			mmc->caps |= MMC_CAP_MAX_CURRENT_200;
 	}
 
 	mmc->ocr_avail = ocr_avail;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6a47d35..d7f81a7 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -108,6 +108,15 @@ struct sd_switch_caps {
 #define SD_DRIVER_TYPE_C	0x04
 #define SD_DRIVER_TYPE_D	0x08
 	unsigned int		sd3_curr_limit;
+#define SD_SET_CURRENT_LIMIT_200	0
+#define SD_SET_CURRENT_LIMIT_400	1
+#define SD_SET_CURRENT_LIMIT_600	2
+#define SD_SET_CURRENT_LIMIT_800	3
+
+#define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
+#define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
+#define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
+#define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
 };
 
 struct sdio_cccr {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f20eb5..1a73e38 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -203,6 +203,10 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_MAX_CURRENT_200	(1 << 26)	/* Host max current limit is 200mA */
+#define MMC_CAP_MAX_CURRENT_400	(1 << 27)	/* Host max current limit is 400mA */
+#define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
+#define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.1

