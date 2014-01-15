From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 7/7] mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC
Date: Wed, 15 Jan 2014 23:12:51 +0900
Message-ID: <002501cf11fb$e014d980$a03e8c80$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57239 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbaAOOMy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:12:54 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG007K94TF2K60@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:12:51 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>
Cc: linux-mmc@vger.kernel.org

Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/sdhci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ec3eb30..6c3482a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1505,6 +1505,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 
 		/* In case of UHS-I modes, set High Speed Enable */
 		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+		    (ios->timing == MMC_TIMING_MMC_DDR52) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
 		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
@@ -1565,7 +1566,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 			else if (ios->timing == MMC_TIMING_UHS_SDR50)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-			else if (ios->timing == MMC_TIMING_UHS_DDR50)
+			else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
+				 (ios->timing == MMC_TIMING_MMC_DDR52))
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		}
-- 
1.7.0.4


