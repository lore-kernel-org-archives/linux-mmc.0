From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 3/4] mmc: sdhci-pltfm: Support optional pm properties
Date: Mon, 19 Nov 2012 10:26:20 +0530
Message-ID: <1353300981-24652-4-git-send-email-a.kesavan@samsung.com>
References: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:24347 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab2KSEw1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 23:52:27 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDP00GKIXIZW1N0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:20 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDP00338XGFP3E0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:52:20 +0900 (KST)
In-reply-to: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

Add support for optional pm capabilities such as MMC_PM_KEEP_POWER
and MMC_PM_WAKE_SDIO_IRQ.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 2716445..c6c3b12 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -89,6 +89,12 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
+
+		if (of_find_property(np, "keep-power-in-suspend", NULL))
+			host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
+
+		if (of_find_property(np, "enable-sdio-wakeup", NULL))
+			host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 	}
 }
 #else
-- 
1.6.6.1

