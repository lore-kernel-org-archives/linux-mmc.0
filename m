From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] mmc: sunxi: Add runtime_pm support
Date: Wed, 20 Dec 2017 11:50:35 +0100
Message-ID: <412579f183c42f6fe2ea04f294dfb788be5e4875.1513766964.git-series.maxime.ripard@free-electrons.com>
References: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54100 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbdLTKux (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Dec 2017 05:50:53 -0500
In-Reply-To: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
References: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

So far, even if our card was not in use, we didn't shut down our main
clock, which meant that it was still output on the MMC bus.

While this obviously means that we could save some power there, it also
created issues when it comes with EMC control since we'll have a perfect
peak at the card clock rate.

Let's implement runtime_pm with autosuspend so that we will shut down the
clock when it's not been in use for quite some time.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 90 ++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3ce46ebd3488..c6a0bd0e0476 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -35,6 +35,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/scatterlist.h>
@@ -1217,29 +1218,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 	}
 
-	ret = clk_prepare_enable(host->clk_mmc);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable mmc clk err %d\n", ret);
-		goto error_disable_clk_ahb;
-	}
-
-	ret = clk_prepare_enable(host->clk_output);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
-		goto error_disable_clk_mmc;
-	}
-
-	ret = clk_prepare_enable(host->clk_sample);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable sample clk err %d\n", ret);
-		goto error_disable_clk_output;
-	}
-
 	if (!IS_ERR(host->reset)) {
 		ret = reset_control_reset(host->reset);
 		if (ret) {
 			dev_err(&pdev->dev, "reset err %d\n", ret);
-			goto error_disable_clk_sample;
+			goto error_disable_clk_ahb;
 		}
 	}
 
@@ -1258,12 +1241,6 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 error_assert_reset:
 	if (!IS_ERR(host->reset))
 		reset_control_assert(host->reset);
-error_disable_clk_sample:
-	clk_disable_unprepare(host->clk_sample);
-error_disable_clk_output:
-	clk_disable_unprepare(host->clk_output);
-error_disable_clk_mmc:
-	clk_disable_unprepare(host->clk_mmc);
 error_disable_clk_ahb:
 	clk_disable_unprepare(host->clk_ahb);
 	return ret;
@@ -1280,6 +1257,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "mmc alloc host failed\n");
 		return -ENOMEM;
 	}
+	platform_set_drvdata(pdev, mmc);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -1340,12 +1318,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto error_free_dma;
 
 	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
-	platform_set_drvdata(pdev, mmc);
+
 	return 0;
 
 error_free_dma:
@@ -1361,27 +1343,75 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
 
 	mmc_remove_host(mmc);
+	pm_runtime_force_suspend(&pdev->dev);
 	disable_irq(host->irq);
 	sunxi_mmc_reset_host(host);
 
 	if (!IS_ERR(host->reset))
 		reset_control_assert(host->reset);
 
-	clk_disable_unprepare(host->clk_sample);
+	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+	mmc_free_host(mmc);
+
+	return 0;
+}
+
+static int sunxi_mmc_runtime_resume(struct device *dev)
+{
+	struct mmc_host	*mmc = dev_get_drvdata(dev);
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = clk_prepare_enable(host->clk_mmc);
+	if (ret) {
+		dev_err(dev, "Enable mmc clk err %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(host->clk_output);
+	if (ret) {
+		dev_err(dev, "Enable output clk err %d\n", ret);
+		goto error_disable_clk_mmc;
+	}
+
+	ret = clk_prepare_enable(host->clk_sample);
+	if (ret) {
+		dev_err(dev, "Enable sample clk err %d\n", ret);
+		goto error_disable_clk_output;
+	}
+
+	return 0;
+
+error_disable_clk_output:
 	clk_disable_unprepare(host->clk_output);
+error_disable_clk_mmc:
 	clk_disable_unprepare(host->clk_mmc);
-	clk_disable_unprepare(host->clk_ahb);
+	return ret;
+}
 
-	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-	mmc_free_host(mmc);
+static int sunxi_mmc_runtime_suspend(struct device *dev)
+{
+	struct mmc_host	*mmc = dev_get_drvdata(dev);
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	clk_disable_unprepare(host->clk_sample);
+	clk_disable_unprepare(host->clk_output);
+	clk_disable_unprepare(host->clk_mmc);
 
 	return 0;
 }
 
+static const struct dev_pm_ops sunxi_mmc_pm_ops = {
+	SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
+			   sunxi_mmc_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver sunxi_mmc_driver = {
 	.driver = {
 		.name	= "sunxi-mmc",
 		.of_match_table = of_match_ptr(sunxi_mmc_of_match),
+		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
 	.remove		= sunxi_mmc_remove,
-- 
git-series 0.9.1
