From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Wed, 18 Jul 2012 14:22:23 +0800
Message-ID: <20120718062223.GA2711@aarontestpc.amd.com>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
 <1341296172-10645-3-git-send-email-aaron.lu@amd.com>
 <CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
 <20120717134325.GA2567@localhost.localdomain>
 <87fw8qieap.fsf@octavius.laptop.org>
 <20120718050939.GA30490@srdclcs1.amd.com>
 <87liihocxj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:45444
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039Ab2GRGWh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 02:22:37 -0400
Content-Disposition: inline
In-Reply-To: <87liihocxj.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi Chris,

On Wed, Jul 18, 2012 at 01:28:40AM -0400, Chris Ball wrote:
> Hi Aaron,
> 
> On Wed, Jul 18 2012, Aaron Lu wrote:
> > Is the following patch OK? This is based on top of current mmc-next with
> > the previous one in tree. Not sure if this is what you want though.
> 
> Yes, that's perfect; squashed into the original patch and pushed out
> to mmc-next.  Thanks!
> 
> Having there be so many MAX_CURRENT defines -- and having them be
> split in the middle between CAP_ and CAP2_ -- is starting to feel
> a bit awkward.

I agree.

> Does anyone have ideas on how that might be tidied up,
> since we have an opportunity to come up with a better plan
> before this gets merged soon?

What about we add three fields in mmc_host to store the max current
value for 3.3v/3.0v/1.8v and use that when needed instead of the cap
setting of the host?

I've prepared the following code, please check if this is better than
the current one:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 312b78d..2232004 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -517,11 +517,36 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+/* Get host's max current setting at its current voltage */
+static u32 sd_get_host_max_current(struct mmc_host *host)
+{
+	u32 voltage, max_current;
+
+	voltage = 1 << host->ios.vdd;
+	switch (voltage) {
+	case MMC_VDD_165_195:
+		max_current = host->max_current_180;
+		break;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		max_current = host->max_current_300;
+		break;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+		max_current = host->max_current_330;
+		break;
+	default:
+		max_current = 0;
+	}
+
+	return max_current;
+}
+
 static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 {
 	int current_limit = SD_SET_CURRENT_NO_CHANGE;
 	int err;
-	u32 voltage;
+	u32 max_current;
 
 	/*
 	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
@@ -535,9 +560,9 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 
 	/*
 	 * Host has different current capabilities when operating at
-	 * different voltages, so find out the current voltage first.
+	 * different voltages, so find out its max current first.
 	 */
-	voltage = 1 << card->host->ios.vdd;
+	max_current = sd_get_host_max_current(card->host);
 
 	/*
 	 * We only check host's capability here, if we set a limit that is
@@ -547,34 +572,15 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	 * when we set current limit to 400/600/800ma, the card will draw its
 	 * maximum 300ma from the host.
 	 */
-	if (voltage == MMC_VDD_165_195) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_180)
-			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_180)
-			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_180)
-			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_180)
-			current_limit = SD_SET_CURRENT_LIMIT_200;
-	} else if (voltage & (MMC_VDD_29_30 | MMC_VDD_30_31)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_300)
-			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_300)
-			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_300)
-			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_300)
-			current_limit = SD_SET_CURRENT_LIMIT_200;
-	} else if (voltage & (MMC_VDD_32_33 | MMC_VDD_33_34)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_330)
-			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_330)
-			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_330)
-			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_330)
-			current_limit = SD_SET_CURRENT_LIMIT_200;
-	}
+
+	if (max_current >= 800)
+		current_limit = SD_SET_CURRENT_LIMIT_800;
+	else if (max_current >= 600)
+		current_limit = SD_SET_CURRENT_LIMIT_600;
+	else if (max_current >= 400)
+		current_limit = SD_SET_CURRENT_LIMIT_400;
+	else if (max_current >= 200)
+		current_limit = SD_SET_CURRENT_LIMIT_200;
 
 	if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
 		err = mmc_sd_switch(card, 1, 3, current_limit, status);
@@ -707,6 +713,7 @@ struct device_type sd_type = {
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 {
 	int err;
+	u32 max_current;
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -734,9 +741,12 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
 		ocr |= SD_OCR_S18R;
 
-	/* If the host can supply more than 150mA, XPC should be set to 1. */
-	if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC_300 |
-	    MMC_CAP_SET_XPC_180))
+	/*
+	 * If the host can supply more than 150mA at current voltage,
+	 * XPC should be set to 1.
+	 */
+	max_current = sd_get_host_max_current(host);
+	if (max_current > 150)
 		ocr |= SD_OCR_XPC;
 
 try_again:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 455a093..a72ad30 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2906,73 +2906,30 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 	if (caps[0] & SDHCI_CAN_VDD_330) {
-		int max_current_330;
-
 		ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
 
-		max_current_330 = ((max_current_caps &
+		mmc->max_current_330 = ((max_current_caps &
 				   SDHCI_MAX_CURRENT_330_MASK) >>
 				   SDHCI_MAX_CURRENT_330_SHIFT) *
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 
-		if (max_current_330 > 150)
-			mmc->caps |= MMC_CAP_SET_XPC_330;
-
-		/* Maximum current capabilities of the host at 3.3V */
-		if (max_current_330 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800_330;
-		else if (max_current_330 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600_330;
-		else if (max_current_330 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400_330;
-		else if (max_current_330 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200_330;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_300) {
-		int max_current_300;
-
 		ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
 
-		max_current_300 = ((max_current_caps &
+		mmc->max_current_300 = ((max_current_caps &
 				   SDHCI_MAX_CURRENT_300_MASK) >>
 				   SDHCI_MAX_CURRENT_300_SHIFT) *
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 
-		if (max_current_300 > 150)
-			mmc->caps |= MMC_CAP_SET_XPC_300;
-
-		/* Maximum current capabilities of the host at 3.0V */
-		if (max_current_300 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800_300;
-		else if (max_current_300 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600_300;
-		else if (max_current_300 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400_300;
-		else if (max_current_300 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200_300;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_180) {
-		int max_current_180;
-
 		ocr_avail |= MMC_VDD_165_195;
 
-		max_current_180 = ((max_current_caps &
+		mmc->max_current_180 = ((max_current_caps &
 				   SDHCI_MAX_CURRENT_180_MASK) >>
 				   SDHCI_MAX_CURRENT_180_SHIFT) *
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
-
-		if (max_current_180 > 150)
-			mmc->caps |= MMC_CAP_SET_XPC_180;
-
-		/* Maximum current capabilities of the host at 1.8V */
-		if (max_current_180 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800_180;
-		else if (max_current_180 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600_180;
-		else if (max_current_180 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400_180;
-		else if (max_current_180 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200_180;
 	}
 
 	mmc->ocr_avail = ocr_avail;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 79d8921..8d2c052 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -189,6 +189,9 @@ struct mmc_host {
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
 	struct notifier_block	pm_notify;
+	u32			max_current_330;
+	u32			max_current_300;
+	u32			max_current_180;
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
@@ -232,16 +235,9 @@ struct mmc_host {
 #define MMC_CAP_UHS_SDR50	(1 << 17)	/* Host supports UHS SDR50 mode */
 #define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
 #define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
-#define MMC_CAP_SET_XPC_330	(1 << 20)	/* Host supports >150mA current at 3.3V */
-#define MMC_CAP_SET_XPC_300	(1 << 21)	/* Host supports >150mA current at 3.0V */
-#define MMC_CAP_SET_XPC_180	(1 << 22)	/* Host supports >150mA current at 1.8V */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-#define MMC_CAP_MAX_CURRENT_200_180 (1 << 26)	/* Host max current limit is 200mA at 1.8V */
-#define MMC_CAP_MAX_CURRENT_400_180 (1 << 27)	/* Host max current limit is 400mA at 1.8V */
-#define MMC_CAP_MAX_CURRENT_600_180 (1 << 28)	/* Host max current limit is 600mA at 1.8V */
-#define MMC_CAP_MAX_CURRENT_800_180 (1 << 29)	/* Host max current limit is 800mA at 1.8V */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
@@ -261,14 +257,6 @@ struct mmc_host {
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
-#define MMC_CAP_MAX_CURRENT_200_300 (1 << 12)	/* Host max current limit is 200mA at 3.0V */
-#define MMC_CAP_MAX_CURRENT_400_300 (1 << 13)	/* Host max current limit is 400mA at 3.0V */
-#define MMC_CAP_MAX_CURRENT_600_300 (1 << 14)	/* Host max current limit is 600mA at 3.0V */
-#define MMC_CAP_MAX_CURRENT_800_300 (1 << 15)	/* Host max current limit is 800mA at 3.0V */
-#define MMC_CAP_MAX_CURRENT_200_330 (1 << 16)	/* Host max current limit is 200mA at 3.3V */
-#define MMC_CAP_MAX_CURRENT_400_330 (1 << 17)	/* Host max current limit is 400mA at 3.3V */
-#define MMC_CAP_MAX_CURRENT_600_330 (1 << 18)	/* Host max current limit is 600mA at 3.3V */
-#define MMC_CAP_MAX_CURRENT_800_330 (1 << 19)	/* Host max current limit is 800mA at 3.3V */
 #define MMC_CAP2_PACKED_RD	    (1 << 20)	/* Allow packed read */
 #define MMC_CAP2_PACKED_WR	    (1 << 21)	/* Allow packed write */
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \


Thanks,
Aaron

