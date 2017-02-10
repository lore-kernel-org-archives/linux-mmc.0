From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 34/39] mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
Date: Fri, 10 Feb 2017 14:55:47 +0200
Message-ID: <1486731352-8018-35-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbdBJNY1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:24:27 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Do not use suspend/resume callbacks with runtime pm. It doesn't make sense
and isn't being used, so remove.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 8315522fb2bb..cdf959bb782e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1750,12 +1750,6 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 			goto err_pci_runtime_suspend;
 	}
 
-	if (chip->fixes && chip->fixes->suspend) {
-		ret = chip->fixes->suspend(chip);
-		if (ret)
-			goto err_pci_runtime_suspend;
-	}
-
 	return 0;
 
 err_pci_runtime_suspend:
@@ -1775,12 +1769,6 @@ static int sdhci_pci_runtime_resume(struct device *dev)
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

