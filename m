From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 3/3] mmc: sirf: fix the capbility to support DDR50
Date: Sun,  4 Oct 2015 12:04:13 +0000
Message-ID: <1443960253-4082-3-git-send-email-21cnbao@gmail.com>
References: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34985 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbJDLzw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Oct 2015 07:55:52 -0400
Received: by pacfv12 with SMTP id fv12so151807453pac.2
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2015 04:55:52 -0700 (PDT)
In-Reply-To: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: workgroup.linux@csr.com, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Weijun Yang <york.yang@csr.com>

According to hardware spec, validate DDR50 mode
for SDXC.

Signed-off-by: Weijun Yang <york.yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 8842945..f5488c4 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -50,7 +50,8 @@ static u32 sdhci_sirf_readl_le(struct sdhci_host *host, int reg)
 	if (unlikely((reg == SDHCI_CAPABILITIES_1) &&
 			(host->mmc->caps & MMC_CAP_UHS_SDR50))) {
 		/* fake CAP_1 register */
-		val = SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
+		val = SDHCI_SUPPORT_DDR50 |
+			SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
 	}
 
 	if (unlikely(reg == SDHCI_SLOT_INT_STATUS)) {
-- 
1.9.1

