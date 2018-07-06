From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC
 MSHC driver
Date: Fri, 6 Jul 2018 15:23:55 +0800
Message-ID: <20180706152355.442433b1@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706151930.78b3024b@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Prabu Thangamuthu <Prabu.T@synopsys.com>, Manjunath M B <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Add a driver for SDHCI OF Synopsys DesignWare Cores Mobile Storage

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/Kconfig            |  11 +++
 drivers/mmc/host/Makefile           |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 116 ++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..694d0828215d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -176,6 +176,17 @@ config MMC_SDHCI_OF_HLWD
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_DWCMSHC
+	tristate "SDHCI OF support for the Synopsys DWC MSHC"
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  This selects Synopsys DesignWare Cores Mobile Storage Controller
+	  support.
+	  If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
+
 config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 85dc1322c3de..a18fbba1b97e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
new file mode 100644
index 000000000000..1b7cd144fb01
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Synopsys DesignWare Cores Mobile Storage Host Controller
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+
+struct dwcmshc_priv {
+	struct clk	*bus_clk;
+};
+
+static const struct sdhci_ops sdhci_dwcmshc_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+};
+
+static int dwcmshc_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct dwcmshc_priv *priv;
+	int err;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
+				sizeof(struct dwcmshc_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pltfm_host->clk)) {
+		err = PTR_ERR(pltfm_host->clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
+		goto free_pltfm;
+	}
+	err = clk_prepare_enable(pltfm_host->clk);
+	if (err)
+		goto free_pltfm;
+
+	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(priv->bus_clk))
+		clk_prepare_enable(priv->bus_clk);
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto err_clk;
+
+	sdhci_get_of_property(pdev);
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+static int dwcmshc_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_remove_host(host, 0);
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{ .compatible = "snps,dwcmshc-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
+
+static struct platform_driver sdhci_dwcmshc_driver = {
+	.driver	= {
+		.name	= "sdhci-dwcmshc",
+		.of_match_table = sdhci_dwcmshc_dt_ids,
+	},
+	.probe	= dwcmshc_probe,
+	.remove	= dwcmshc_remove,
+};
+module_platform_driver(sdhci_dwcmshc_driver);
+
+MODULE_DESCRIPTION("SDHCI platform driver for Synopsys DWC MSHC");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0
