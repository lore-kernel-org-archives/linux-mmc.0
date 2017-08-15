From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2] mmc: sdhci: fix SDHCI_QUIRK_NO_HISPD_BIT handling
Date: Tue, 15 Aug 2017 10:16:47 +0800
Message-ID: <1502763407-49116-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:2362
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753152AbdHOCdh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 22:33:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

SD controller with SDHCI_QUIRK_NO_HISPD_BIT quirk probably
use high speed enable bit for other purpose. So this bit
shouldn't be changed for high speed enabling for this type of
SD controller.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes for v2:
	- Removed duplicate perenthesis.
	- Added "Acked-by: Adrian Hunter".
---
 drivers/mmc/host/sdhci.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a1ad2dd..315bded 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1641,19 +1641,20 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if ((ios->timing == MMC_TIMING_SD_HS ||
-	     ios->timing == MMC_TIMING_MMC_HS ||
-	     ios->timing == MMC_TIMING_MMC_HS400 ||
-	     ios->timing == MMC_TIMING_MMC_HS200 ||
-	     ios->timing == MMC_TIMING_MMC_DDR52 ||
-	     ios->timing == MMC_TIMING_UHS_SDR50 ||
-	     ios->timing == MMC_TIMING_UHS_SDR104 ||
-	     ios->timing == MMC_TIMING_UHS_DDR50 ||
-	     ios->timing == MMC_TIMING_UHS_SDR25)
-	    && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
-		ctrl |= SDHCI_CTRL_HISPD;
-	else
-		ctrl &= ~SDHCI_CTRL_HISPD;
+	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
+		if (ios->timing == MMC_TIMING_SD_HS ||
+		     ios->timing == MMC_TIMING_MMC_HS ||
+		     ios->timing == MMC_TIMING_MMC_HS400 ||
+		     ios->timing == MMC_TIMING_MMC_HS200 ||
+		     ios->timing == MMC_TIMING_MMC_DDR52 ||
+		     ios->timing == MMC_TIMING_UHS_SDR50 ||
+		     ios->timing == MMC_TIMING_UHS_SDR104 ||
+		     ios->timing == MMC_TIMING_UHS_DDR50 ||
+		     ios->timing == MMC_TIMING_UHS_SDR25)
+			ctrl |= SDHCI_CTRL_HISPD;
+		else
+			ctrl &= ~SDHCI_CTRL_HISPD;
+	}
 
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
-- 
2.1.0.27.g96db324

