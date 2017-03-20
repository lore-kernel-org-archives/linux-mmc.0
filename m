From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 21/25] mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
Date: Mon, 20 Mar 2017 19:50:49 +0200
Message-ID: <1490032253-6030-22-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756304AbdCTR6e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:34 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Do not use suspend/resume callbacks with runtime pm. It doesn't make sense
and isn't being used, so remove.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b5fd82e26125..7e8163affb26 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1783,12 +1783,6 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 			mmc_retune_needed(host->mmc);
 	}
 
-	if (chip->fixes && chip->fixes->suspend) {
-		ret = chip->fixes->suspend(chip);
-		if (ret)
-			goto err_pci_runtime_suspend;
-	}
-
 	return 0;
 
 err_pci_runtime_suspend:
@@ -1808,12 +1802,6 @@ static int sdhci_pci_runtime_resume(struct device *dev)
 	if (!chip)
 		return 0;
 
-	if (chip->fixes && chip->fixes->resume) {
-		ret = chip->fixes->resume(chip);
-		if (ret)
-			return ret;
-	}
-
 	for (i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
-- 
1.9.1

