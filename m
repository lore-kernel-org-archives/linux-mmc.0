From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci: check the quirk HISPD_BIT for SD3.0 card
Date: Thu, 15 Nov 2012 17:15:31 +0900
Message-ID: <50A4A4A3.90903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27251 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab2KOIPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Nov 2012 03:15:40 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDI00J2NS9EFU30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Nov 2012 17:15:38 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MDI00D5HSA14G90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Nov 2012 17:15:38 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

If SD-card is more than SD3.0 card, set to ctrl with UHS-I modes.
But in case of Samsung-SoC, didn't use the SDHCI_CTRL_HISPD.
So need to check the quirk for SDHCI_QUIRK_NO_HISPD_BIT.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f6534e..b42d551 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1418,11 +1418,12 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		unsigned int clock;
 
 		/* In case of UHS-I modes, set High Speed Enable */
-		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+		if (((ios->timing == MMC_TIMING_MMC_HS200) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
 		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
-		    (ios->timing == MMC_TIMING_UHS_SDR25))
+		    (ios->timing == MMC_TIMING_UHS_SDR25)) &&
+		    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 			ctrl |= SDHCI_CTRL_HISPD;
 
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
1.7.4.1
