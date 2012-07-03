From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Tue, 3 Jul 2012 14:16:12 +0800
Message-ID: <1341296172-10645-3-git-send-email-aaron.lu@amd.com>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:24198 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900Ab2GCGQt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 02:16:49 -0400
In-Reply-To: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Host has different current capabilities at different voltages, we need
to record these settings seperately. Before set current limit for the sd
card, find out the current voltage first and then find out the current
capabilities of the host to set the limit.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/core/sd.c    | 58 ++++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.c | 28 +++++++++++++++++++----
 include/linux/mmc/host.h | 16 +++++++++----
 3 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ae72d6e..4b4cf4d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -521,11 +521,39 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 {
 	int current_limit = SD_SET_CURRENT_NO_CHANGE;
 	int err;
+	u8 voltage;
 
 	/*
 	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
 	 * bus speed modes. For other bus speed modes, we do not change the
 	 * current limit.
+	 */
+	if ((card->sd_bus_speed != UHS_SDR50_BUS_SPEED) &&
+	    (card->sd_bus_speed != UHS_SDR104_BUS_SPEED) &&
+	    (card->sd_bus_speed != UHS_DDR50_BUS_SPEED))
+		return 0;
+
+	/*
+	 * Host has different current capabilities when operating at
+	 * different voltages, so find out the current voltage first.
+	 */
+	switch (1 << card->host->ios.vdd) {
+		case MMC_VDD_165_195:
+			voltage = 0; /* host's voltage is 1.8V */
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			voltage = 1; /* host's voltage is 3.0V */
+			break;
+		case MMC_VDD_32_33:
+		case MMC_VDD_33_34:
+			voltage = 2; /* host's voltage is 3.3V */
+			break;
+		default:
+			BUG(); /* host's voltage is invalid */
+	}
+
+	/*
 	 * We only check host's capability here, if we set a limit that is
 	 * higher than the card's maximum current, the card will be using its
 	 * maximum current, e.g. if the card's maximum current is 300ma, and
@@ -533,16 +561,32 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	 * when we set current limit to 400/600/800ma, the card will draw its
 	 * maximum 300ma from the host.
 	 */
-	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
-	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
-	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800)
+	if (voltage == 0) {
+		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_180)
+			current_limit = SD_SET_CURRENT_LIMIT_800;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_180)
+			current_limit = SD_SET_CURRENT_LIMIT_600;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_180)
+			current_limit = SD_SET_CURRENT_LIMIT_400;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_180)
+			current_limit = SD_SET_CURRENT_LIMIT_200;
+	} else if (voltage == 1) {
+		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_300)
+			current_limit = SD_SET_CURRENT_LIMIT_800;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_300)
+			current_limit = SD_SET_CURRENT_LIMIT_600;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_300)
+			current_limit = SD_SET_CURRENT_LIMIT_400;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_300)
+			current_limit = SD_SET_CURRENT_LIMIT_200;
+	} else if (voltage == 2) {
+		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_330)
 			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600)
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_330)
 			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400)
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_330)
 			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200)
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_330)
 			current_limit = SD_SET_CURRENT_LIMIT_200;
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index caba999..00c2cbb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2897,6 +2897,16 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		if (max_current_330 > 150)
 			mmc->caps |= MMC_CAP_SET_XPC_330;
+
+		/* Maximum current capabilities of the host at 3.3V */
+		if (max_current_330 >= 800)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_800_330;
+		else if (max_current_330 >= 600)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_600_330;
+		else if (max_current_330 >= 400)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_400_330;
+		else if (max_current_330 >= 200)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_200_330;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_300) {
 		int max_current_300;
@@ -2910,6 +2920,16 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		if (max_current_300 > 150)
 			mmc->caps |= MMC_CAP_SET_XPC_300;
+
+		/* Maximum current capabilities of the host at 3.0V */
+		if (max_current_300 >= 800)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_800_300;
+		else if (max_current_300 >= 600)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_600_300;
+		else if (max_current_300 >= 400)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_400_300;
+		else if (max_current_300 >= 200)
+			mmc->caps |= MMC_CAP_MAX_CURRENT_200_300;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_180) {
 		int max_current_180;
@@ -2926,13 +2946,13 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		/* Maximum current capabilities of the host at 1.8V */
 		if (max_current_180 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800;
+			mmc->caps |= MMC_CAP_MAX_CURRENT_800_180;
 		else if (max_current_180 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600;
+			mmc->caps |= MMC_CAP_MAX_CURRENT_600_180;
 		else if (max_current_180 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400;
+			mmc->caps |= MMC_CAP_MAX_CURRENT_400_180;
 		else if (max_current_180 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200;
+			mmc->caps |= MMC_CAP_MAX_CURRENT_200_180;
 	}
 
 	mmc->ocr_avail = ocr_avail;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 65c64ee..ca84ffb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -238,10 +238,10 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-#define MMC_CAP_MAX_CURRENT_200	(1 << 26)	/* Host max current limit is 200mA */
-#define MMC_CAP_MAX_CURRENT_400	(1 << 27)	/* Host max current limit is 400mA */
-#define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
-#define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
+#define MMC_CAP_MAX_CURRENT_200_180 (1 << 26)	/* Host max current limit is 200mA at 1.8V */
+#define MMC_CAP_MAX_CURRENT_400_180 (1 << 27)	/* Host max current limit is 400mA at 1.8V */
+#define MMC_CAP_MAX_CURRENT_600_180 (1 << 28)	/* Host max current limit is 600mA at 1.8V */
+#define MMC_CAP_MAX_CURRENT_800_180 (1 << 29)	/* Host max current limit is 800mA at 1.8V */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
@@ -261,6 +261,14 @@ struct mmc_host {
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
+#define MMC_CAP_MAX_CURRENT_200_300 (1 << 12)	/* Host max current limit is 200mA at 3.0V */
+#define MMC_CAP_MAX_CURRENT_400_300 (1 << 13)	/* Host max current limit is 400mA at 3.0V */
+#define MMC_CAP_MAX_CURRENT_600_300 (1 << 14)	/* Host max current limit is 600mA at 3.0V */
+#define MMC_CAP_MAX_CURRENT_800_300 (1 << 15)	/* Host max current limit is 800mA at 3.0V */
+#define MMC_CAP_MAX_CURRENT_200_330 (1 << 16)	/* Host max current limit is 200mA at 3.3V */
+#define MMC_CAP_MAX_CURRENT_400_330 (1 << 17)	/* Host max current limit is 400mA at 3.3V */
+#define MMC_CAP_MAX_CURRENT_600_330 (1 << 18)	/* Host max current limit is 600mA at 3.3V */
+#define MMC_CAP_MAX_CURRENT_800_330 (1 << 19)	/* Host max current limit is 800mA at 3.3V */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.11.1.3.g4c8a9db


