From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND v3 7/7] mmc: sdhci: clarify DDR timing mode between
 SD-UHS and eMMC
Date: Fri, 14 Mar 2014 21:12:48 +0900
Message-ID: <003901cf3f7e$b6cd22c0$24676840$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006601cf2a57$8af1af90$a0d50eb0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57720 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbaCNMMt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 08:12:49 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2F00JG7DXCU500@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Mar 2014 21:12:48 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

Added MMC_DDR52 as eMMC's DDR mode is distinguished from SD-UHS.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f95211..6926b42 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1510,6 +1510,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 
 		/* In case of UHS-I modes, set High Speed Enable */
 		if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+		    (ios->timing == MMC_TIMING_MMC_DDR52) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
 		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
 		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
@@ -1570,7 +1571,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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


