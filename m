From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Wed, 18 Jul 2012 13:09:39 +0800
Message-ID: <20120718050939.GA30490@srdclcs1.amd.com>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
 <1341296172-10645-3-git-send-email-aaron.lu@amd.com>
 <CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
 <20120717134325.GA2567@localhost.localdomain>
 <87fw8qieap.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:34047
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488Ab2GRFJy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 01:09:54 -0400
Content-Disposition: inline
In-Reply-To: <87fw8qieap.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 17, 2012 at 11:43:26AM -0400, Chris Ball wrote:
> >
> > Chris, please let me know how you want to deal with this and I'll be
> > glad to do whatever I can to fix this. Sorry for the trouble.
> 
> No worries, I can rebase it in.  Mind sending a patch on top of current
> mmc-next for me to squash on top of the previous one?

Is the following patch OK? This is based on top of current mmc-next with
the previous one in tree. Not sure if this is what you want though.

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 312b78d..ec03d15 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -557,22 +557,22 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_180)
 			current_limit = SD_SET_CURRENT_LIMIT_200;
 	} else if (voltage & (MMC_VDD_29_30 | MMC_VDD_30_31)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_300)
+		if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_800_300)
 			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_300)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_600_300)
 			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_300)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_400_300)
 			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_300)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_200_300)
 			current_limit = SD_SET_CURRENT_LIMIT_200;
 	} else if (voltage & (MMC_VDD_32_33 | MMC_VDD_33_34)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800_330)
+		if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_800_330)
 			current_limit = SD_SET_CURRENT_LIMIT_800;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600_330)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_600_330)
 			current_limit = SD_SET_CURRENT_LIMIT_600;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400_330)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_400_330)
 			current_limit = SD_SET_CURRENT_LIMIT_400;
-		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200_330)
+		else if (card->host->caps2 & MMC_CAP2_MAX_CURRENT_200_330)
 			current_limit = SD_SET_CURRENT_LIMIT_200;
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 455a093..29d4357 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2920,13 +2920,13 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		/* Maximum current capabilities of the host at 3.3V */
 		if (max_current_330 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800_330;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_800_330;
 		else if (max_current_330 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600_330;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_600_330;
 		else if (max_current_330 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400_330;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_400_330;
 		else if (max_current_330 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200_330;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_200_330;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_300) {
 		int max_current_300;
@@ -2943,13 +2943,13 @@ int sdhci_add_host(struct sdhci_host *host)
 
 		/* Maximum current capabilities of the host at 3.0V */
 		if (max_current_300 >= 800)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_800_300;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_800_300;
 		else if (max_current_300 >= 600)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_600_300;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_600_300;
 		else if (max_current_300 >= 400)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_400_300;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_400_300;
 		else if (max_current_300 >= 200)
-			mmc->caps |= MMC_CAP_MAX_CURRENT_200_300;
+			mmc->caps2 |= MMC_CAP2_MAX_CURRENT_200_300;
 	}
 	if (caps[0] & SDHCI_CAN_VDD_180) {
 		int max_current_180;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 79d8921..4a40312 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -261,14 +261,14 @@ struct mmc_host {
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
+#define MMC_CAP2_MAX_CURRENT_200_300 (1 << 12)	/* Host max current limit is 200mA at 3.0V */
+#define MMC_CAP2_MAX_CURRENT_400_300 (1 << 13)	/* Host max current limit is 400mA at 3.0V */
+#define MMC_CAP2_MAX_CURRENT_600_300 (1 << 14)	/* Host max current limit is 600mA at 3.0V */
+#define MMC_CAP2_MAX_CURRENT_800_300 (1 << 15)	/* Host max current limit is 800mA at 3.0V */
+#define MMC_CAP2_MAX_CURRENT_200_330 (1 << 16)	/* Host max current limit is 200mA at 3.3V */
+#define MMC_CAP2_MAX_CURRENT_400_330 (1 << 17)	/* Host max current limit is 400mA at 3.3V */
+#define MMC_CAP2_MAX_CURRENT_600_330 (1 << 18)	/* Host max current limit is 600mA at 3.3V */
+#define MMC_CAP2_MAX_CURRENT_800_330 (1 << 19)	/* Host max current limit is 800mA at 3.3V */
 #define MMC_CAP2_PACKED_RD	    (1 << 20)	/* Allow packed read */
 #define MMC_CAP2_PACKED_WR	    (1 << 21)	/* Allow packed write */
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \



Thanks,
Aaron

