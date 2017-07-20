From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFT PATCH] mmc: sdhci-of-arasan: Add command queue support
Date: Thu, 20 Jul 2017 09:43:18 +0800
Message-ID: <1500514998-183947-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:56127 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdGTBn7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 21:43:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>

Just for folks who are interested in testing CQE using RK3399
platforms. And This patch depends on the unmerged CQE support
for mmc core which could be found here:

http://www.spinics.net/lists/linux-mmc/msg44648.html

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/Kconfig           |   1 +
 drivers/mmc/host/sdhci-of-arasan.c | 199 ++++++++++++++++++++++++++++++++++---
 2 files changed, 186 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2242633..a14efcb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -123,6 +123,7 @@ config MMC_SDHCI_OF_ARASAN
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
 	depends on COMMON_CLK
+	select MMC_CQHC
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
 	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b13c0a7..02e198b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -24,10 +24,13 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include "sdhci-pltfm.h"
 #include <linux/of.h>
 
+#include "cqhci.h"
+#include "sdhci-pltfm.h"
+
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
 #define VENDOR_ENHANCED_STROBE		BIT(0)
@@ -89,7 +92,7 @@ struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
 	struct phy	*phy;
 	bool		is_phy_on;
-
+	bool		has_cqe;
 	struct clk_hw	sdcardclk_hw;
 	struct clk      *sdcardclk;
 
@@ -262,23 +265,70 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
-static struct sdhci_ops sdhci_arasan_ops = {
+static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_arasan->has_cqe)
+		return 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static void sdhci_arasan_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static void sdhci_arasan_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+
+	/*
+	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
+	 * the case after tuning, so ensure the buffer is drained.
+	 */
+	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	while (reg & SDHCI_DATA_AVAILABLE) {
+		sdhci_readl(host, SDHCI_BUFFER);
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	}
+
+	sdhci_cqe_enable(mmc);
+}
+
+static const struct cqhci_host_ops sdhci_arasan_cqhci_ops = {
+	.enable         = sdhci_arasan_cqe_enable,
+	.disable        = sdhci_cqe_disable,
+	.dumpregs       = sdhci_arasan_dumpregs,
+};
+
+static struct sdhci_ops sdhci_arasan_cqe_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.irq = sdhci_arasan_cqhci_irq,
 };
 
-static struct sdhci_pltfm_data sdhci_arasan_pdata = {
-	.ops = &sdhci_arasan_ops,
+static struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
+	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
-#ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
@@ -286,7 +336,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
  *
  * Put the device in a low power state.
  */
-static int sdhci_arasan_suspend(struct device *dev)
+static int __maybe_unused sdhci_arasan_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -297,6 +347,12 @@ static int sdhci_arasan_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
+	if (sdhci_arasan->has_cqe) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -324,7 +380,7 @@ static int sdhci_arasan_suspend(struct device *dev)
  *
  * Resume operation after suspend
  */
-static int sdhci_arasan_resume(struct device *dev)
+static int __maybe_unused sdhci_arasan_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -353,12 +409,70 @@ static int sdhci_arasan_resume(struct device *dev)
 		sdhci_arasan->is_phy_on = true;
 	}
 
-	return sdhci_resume_host(host);
+	ret = sdhci_resume_host(host);
+	if (ret) {
+		dev_err(dev, "Cannot resume host.\n");
+		return ret;
+	}
+
+	if (sdhci_arasan->has_cqe)
+		return cqhci_resume(host->mmc);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_arasan_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (sdhci_arasan->has_cqe) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(sdhci_arasan->clk_ahb);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_arasan_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	clk_prepare_enable(pltfm_host->clk);
+	clk_prepare_enable(sdhci_arasan->clk_ahb);
+
+	ret = sdhci_runtime_resume_host(host);
+	if (ret)
+		return ret;
+
+	if (sdhci_arasan->has_cqe)
+		return cqhci_resume(host->mmc);
+
+	return 0;
 }
-#endif /* ! CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
-			 sdhci_arasan_resume);
+static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend,
+				sdhci_arasan_resume)
+	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
+			   sdhci_arasan_runtime_resume,
+			   NULL)
+};
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* SoC-specific compatible strings w/ soc_ctl_map */
@@ -556,6 +670,49 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
+static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
+{
+	struct sdhci_host *host = sdhci_arasan->host;
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	if (!sdhci_arasan->has_cqe)
+		return sdhci_add_host(host);
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	cq_host = devm_kzalloc(host->mmc->parent,
+			       sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + 0x200;
+	cq_host->ops = &sdhci_arasan_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64)
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret)
+		goto cleanup;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+
 static int sdhci_arasan_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -567,8 +724,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
+	host = sdhci_pltfm_init(pdev, &sdhci_arasan_cqe_pdata,
 				sizeof(*sdhci_arasan));
+
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -619,6 +777,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	sdhci_get_of_property(pdev);
 
 	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
@@ -663,12 +827,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 					sdhci_arasan_hs400_enhanced_strobe;
 		host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_arasan_voltage_switch;
+		sdhci_arasan->has_cqe = true;
+		host->mmc->caps2 |= MMC_CAP2_CQE;
 	}
 
-	ret = sdhci_add_host(host);
+	ret = sdhci_arasan_add_host(sdhci_arasan);
 	if (ret)
 		goto err_add_host;
 
+	pm_runtime_put(&pdev->dev);
 	return 0;
 
 err_add_host:
@@ -677,6 +844,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 unreg_clk:
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 clk_disable_all:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
@@ -704,6 +874,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	ret = sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
-- 
1.9.1


