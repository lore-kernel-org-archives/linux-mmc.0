From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 2/4] mmc: sdhci-pxav2: switch to managed clk and sdhci_pltfm_unregister()
Date: Wed, 23 Aug 2017 13:15:01 +0900
Message-ID: <1503461703-16225-3-git-send-email-yamada.masahiro@socionext.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Hu Ziji <huziji@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The difference between sdhci_pxav2_remove() and sdhci_pltfm_unregister()
is clk_put().  It will go away by using the managed resource clk, then
sdhci_pltfm_unregister() can be reused.

Also, rename the jump labels to say what the goto does. (Coding style
suggested by Documentation/process/coding-style.rst)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4: None
Changes in v3:
  - Newly added

Changes in v2: None

 drivers/mmc/host/sdhci-pxav2.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 995083ce1c46..8986f9d9cf98 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -178,17 +178,17 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	clk = clk_get(dev, "PXA-SDHCLK");
+	clk = devm_clk_get(dev, "PXA-SDHCLK");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(clk);
-		goto err_clk_get;
+		goto free;
 	}
 	pltfm_host->clk = clk;
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable io clock\n");
-		goto err_clk_enable;
+		goto free;
 	}
 
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
@@ -223,34 +223,18 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-		goto err_add_host;
+		goto disable_clk;
 	}
 
 	return 0;
 
-err_add_host:
+disable_clk:
 	clk_disable_unprepare(clk);
-err_clk_enable:
-	clk_put(clk);
-err_clk_get:
+free:
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-static int sdhci_pxav2_remove(struct platform_device *pdev)
-{
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	sdhci_remove_host(host, 1);
-
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_put(pltfm_host->clk);
-	sdhci_pltfm_free(pdev);
-
-	return 0;
-}
-
 static struct platform_driver sdhci_pxav2_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav2",
@@ -258,7 +242,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= sdhci_pxav2_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.7.4
