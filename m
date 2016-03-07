From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 3/4] mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free for err handling
Date: Mon,  7 Mar 2016 23:39:08 +0800
Message-ID: <1457365148-23373-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Currently, some err handling of sdhci_arasan_probe return directly
without calling sdhci_pltfm_free. This patch fixes them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index ae8052d..91b7c62 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -147,19 +147,21 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
 		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
-		return PTR_ERR(sdhci_arasan->clk_ahb);
+		ret = PTR_ERR(sdhci_arasan->clk_ahb);
+		goto err_pltfm_free;
 	}
 
 	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		dev_err(&pdev->dev, "clk_xin clock not found.\n");
-		return PTR_ERR(clk_xin);
+		ret = PTR_ERR(clk_xin);
+		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
-		return ret;
+		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(clk_xin);
@@ -179,17 +181,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto err_pltfm_free;
+		goto clk_disable_all;
 
 	return 0;
 
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
-
+err_pltfm_free:
+	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
2.3.7
