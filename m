From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1
Date: Fri, 12 Jan 2018 14:42:50 +0800
Message-ID: <1515739370-102434-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:52039 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeALGyH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jan 2018 01:54:07 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

Add CQHCI initialization and implement CQHCI operations for Arasan
SDHCI variant host, namely arasan,sdhci-5.1, which is used by Rockchip
RK3399 platform.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/Kconfig           |   1 +
 drivers/mmc/host/sdhci-of-arasan.c | 137 +++++++++++++++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2fda095..45aed90 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -133,6 +133,7 @@ config MMC_SDHCI_OF_ARASAN
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
 	depends on COMMON_CLK
+	select MMC_CQHCI
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
 	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index fb57206..e30c84f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -25,11 +25,13 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
-#include "sdhci-pltfm.h"
 #include <linux/of.h>
 
-#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
+#include "cqhci.h"
+#include "sdhci-pltfm.h"
 
+#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
+#define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
 #define VENDOR_ENHANCED_STROBE		BIT(0)
 
 #define PHY_CLK_TOO_SLOW_HZ		400000
@@ -90,6 +92,7 @@ struct sdhci_arasan_data {
 	struct phy	*phy;
 	bool		is_phy_on;
 
+	bool		has_cqe;
 	struct clk_hw	sdcardclk_hw;
 	struct clk      *sdcardclk;
 
@@ -290,6 +293,61 @@ static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
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
+	.set_clock = sdhci_arasan_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_arasan_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.irq = sdhci_arasan_cqhci_irq,
+};
+
+static struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
+	.ops = &sdhci_arasan_cqe_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -309,6 +367,12 @@ static int sdhci_arasan_suspend(struct device *dev)
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
@@ -365,10 +429,18 @@ static int sdhci_arasan_resume(struct device *dev)
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
 }
 #endif /* ! CONFIG_PM_SLEEP */
-
 static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 			 sdhci_arasan_resume);
 
@@ -568,6 +640,49 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
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
+	cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
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
@@ -579,8 +694,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
-				sizeof(*sdhci_arasan));
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "arasan,sdhci-5.1"))
+		host = sdhci_pltfm_init(pdev, &sdhci_arasan_cqe_pdata,
+					sizeof(*sdhci_arasan));
+	else
+		host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
+					sizeof(*sdhci_arasan));
+
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -675,9 +796,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 					sdhci_arasan_hs400_enhanced_strobe;
 		host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_arasan_voltage_switch;
+		sdhci_arasan->has_cqe = true;
+		host->mmc->caps2 |= (MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
 	}
 
-	ret = sdhci_add_host(host);
+	ret = sdhci_arasan_add_host(sdhci_arasan);
 	if (ret)
 		goto err_add_host;
 
-- 
1.9.1


