From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci: also set driver type for MMC_DDR52
Date: Mon, 17 Aug 2015 19:34:39 +0800
Message-ID: <1439811279-6340-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48157 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937AbbHQLi3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 07:38:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

commit 08f90f14aa93ad424c20bb176b52f329583e2183 ("mmc: sdhci: clarify
DDR timing mode between SD-UHS and eMMC") added MMC_DDR52 as eMMC's DDR
mode to be distinguished from SD-UHS, but it missed setting driver type
for MMC_DDR52 timing mode. This patches adds the missing driver type
setting.

Fixes: 79f7ae7c45a6("mmc: clarify DDR timing mode between SD-UHS and eMMC")
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..32f2a07 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1559,7 +1559,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
 				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
 				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
-				 (ios->timing == MMC_TIMING_UHS_DDR50))) {
+				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
+				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
-- 
2.5.0

