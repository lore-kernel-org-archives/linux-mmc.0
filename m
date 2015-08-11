From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/2] mmc: sirf: fix the capbility to support DDR50
Date: Tue, 11 Aug 2015 08:42:47 +0000
Message-ID: <1439282567-6362-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34697 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbbHKIgI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Aug 2015 04:36:08 -0400
Received: by pawu10 with SMTP id u10so159569708paw.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2015 01:36:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Weijun Yang <york.yang@csr.com>

According to hardware spec, validate DDR50 mode
for SDXC.

Signed-off-by: Weijun Yang <york.yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 0110bae..03efcfc 100644
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

