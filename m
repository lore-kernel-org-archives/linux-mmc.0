From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci: put together into one condition checking
Date: Fri, 07 Oct 2016 14:08:43 +0900
Message-ID: <1475816923-24532-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60925 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751627AbcJGFIv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2016 01:08:51 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OEN01JE4VMODQ20@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Oct 2016 14:08:48 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

value of ios->timing is not related with SDCHI v3.0.
If Controller version is v3.0, SDHCI_QUIRK_NO_HISPD_BIT is meaningless.
To prevent the setting wrong bit moves into one codntion checking.
(e.g sdhci-s3c doesn't use SDHCI_CTRL_HISPD bit, instead using this bit as
 other purpose.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..f854c66 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1619,7 +1619,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if ((ios->timing == MMC_TIMING_SD_HS ||
-	     ios->timing == MMC_TIMING_MMC_HS)
+	     ios->timing == MMC_TIMING_MMC_HS ||
+	     ios->timing == MMC_TIMING_MMC_HS400 ||
+	     ios->timing == MMC_TIMING_MMC_HS200 ||
+	     ios->timing == MMC_TIMING_MMC_DDR52 ||
+	     ios->timing == MMC_TIMING_UHS_SDR50 ||
+	     ios->timing == MMC_TIMING_UHS_SDR104 ||
+	     ios->timing == MMC_TIMING_UHS_DDR50 ||
+	     ios->timing == MMC_TIMING_UHS_SDR25)
 	    && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
@@ -1628,16 +1635,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
 
-		/* In case of UHS-I modes, set High Speed Enable */
-		if ((ios->timing == MMC_TIMING_MMC_HS400) ||
-		    (ios->timing == MMC_TIMING_MMC_HS200) ||
-		    (ios->timing == MMC_TIMING_MMC_DDR52) ||
-		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
-		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
-		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
-		    (ios->timing == MMC_TIMING_UHS_SDR25))
-			ctrl |= SDHCI_CTRL_HISPD;
-
 		if (!host->preset_enabled) {
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 			/*
-- 
1.9.1

