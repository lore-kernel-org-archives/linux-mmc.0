From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 3/4] mmc: sdhci-of-arasan: fix clk prepare and unprepare for PM callback
Date: Thu, 22 Oct 2015 11:37:06 +0800
Message-ID: <1445485026-11983-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:42895 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbJVDip (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 23:38:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch use clk_prepare_enable and clk_disable_unprepare for
system PM callback instead of directly use clk_enable and clk_disable
without clk_prepare/unprepare.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4f30716..2d327d4 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -99,8 +99,8 @@ static int sdhci_arasan_suspend(struct device *dev)
 		}
 	}
 
-	clk_disable(pltfm_host->clk);
-	clk_disable(sdhci_arasan->clk_ahb);
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
 	return 0;
 }
@@ -120,13 +120,13 @@ static int sdhci_arasan_resume(struct device *dev)
 	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
 	int ret;
 
-	ret = clk_enable(sdhci_arasan->clk_ahb);
+	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
 		dev_err(dev, "Cannot enable AHB clock.\n");
 		return ret;
 	}
 
-	ret = clk_enable(pltfm_host->clk);
+	ret = clk_prepare_enable(pltfm_host->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable SD clock.\n");
 		goto err_clk_en;
@@ -143,9 +143,9 @@ static int sdhci_arasan_resume(struct device *dev)
 	return sdhci_resume_host(host);
 
 err_phy_power:
-	clk_disable(pltfm_host->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 err_clk_en:
-	clk_disable(sdhci_arasan->clk_ahb);
+	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 	return ret;
 }
 #endif /* ! CONFIG_PM_SLEEP */
-- 
2.3.7


