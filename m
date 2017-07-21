From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] mmc: sdhci-xenon: ignore timing DDR52 in tuning
Date: Fri, 21 Jul 2017 11:30:58 -0700
Message-ID: <1500661858-17610-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57748 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750849AbdGUS2j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 14:28:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

Emmc DDR52 mode uses fixed delay, return earlier if
timing is MMC_TIMING_MMC_DDR52 in execute tuning function.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
 drivers/mmc/host/sdhci-xenon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 6ef33aa..edd4d915 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -311,7 +311,8 @@ static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
-	if (host->timing == MMC_TIMING_UHS_DDR50)
+	if (host->timing == MMC_TIMING_UHS_DDR50 ||
+		host->timing == MMC_TIMING_MMC_DDR52)
 		return 0;
 
 	/*
-- 
1.9.1

