From: Jiancheng Xue <xuejiancheng@hisilicon.com>
Subject: [PATCH 2/2] mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc
Date: Wed, 18 Oct 2017 07:16:28 -0400
Message-ID: <1508325388-7260-3-git-send-email-xuejiancheng@hisilicon.com>
References: <1508325388-7260-1-git-send-email-xuejiancheng@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8520 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758872AbdJRDNw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2017 23:13:52 -0400
In-Reply-To: <1508325388-7260-1-git-send-email-xuejiancheng@hisilicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, project-aspen-dev@linaro.org, xuejiancheng@hisilicon.com, hermit.wangheming@hisilicon.com, tianshuliang <tianshuliang@hisilicon.com>

From: tianshuliang <tianshuliang@hisilicon.com>

Hi3798cv200 SoC extends the dw-mshc controller for additional clock
and bus control. Add support for these extensions.

Signed-off-by: tianshuliang <tianshuliang@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
 drivers/mmc/host/Kconfig              |   9 ++
 drivers/mmc/host/Makefile             |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 191 ++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc-hi3798cv200.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c15637..2bf6aa8 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -712,6 +712,15 @@ config MMC_DW_K3
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on Hisilicon K3 SoC's.
 
+config MMC_DW_HI3798CV200
+	tristate "Hi3798cv200 specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for HiSilicon hi3798cv200 SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on HiSilicon hi3798cv200 SoC's.
+
 config MMC_DW_PCI
 	tristate "Synopsys Designware MCI support on PCI bus"
 	depends on MMC_DW && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 303f5cd..6e015d8 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_MMC_CAVIUM_THUNDERX) += thunderx-mmc.o
 obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
 obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
 obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
+obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
new file mode 100644
index 0000000..bd24001
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (c) 2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define ALL_INT_CLR		0x1EFFF
+
+#define SDMMC_DDR_REG		0x10c
+#define SDMMC_ENABLE_SH		0x110
+#define SDMMC_DDR_HS400		BIT(31)
+#define SDMMC_ENABLE_SH_PHASE	BIT(0)
+#define SDMMC_DRV_PS_135	3
+#define SDMMC_DRV_PS_180	4
+
+struct hi3798cv200_priv {
+	struct clk		*sample_clk;
+	struct clk		*drive_clk;
+};
+
+static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	u32 regs;
+	struct hi3798cv200_priv *priv = host->priv;
+	u32 drive_phase[] = {0, 45, 90, 135, 180, 225, 270, 315};
+
+	regs = mci_readl(host, UHS_REG);
+	if (ios->timing == MMC_TIMING_MMC_HS400)
+		regs &= ~(0x1 << 16);
+	mci_writel(host, UHS_REG, regs);
+
+	regs = mci_readl(host, ENABLE_SH);
+	if (ios->timing == MMC_TIMING_MMC_DDR52)
+		regs |= SDMMC_ENABLE_SH_PHASE;
+	else
+		regs &= ~SDMMC_ENABLE_SH_PHASE;
+	mci_writel(host, ENABLE_SH, regs);
+
+	regs = mci_readl(host, DDR_REG);
+	if (ios->timing == MMC_TIMING_MMC_HS400)
+		regs |= SDMMC_DDR_HS400;
+	else
+		regs &= ~SDMMC_DDR_HS400;
+	mci_writel(host, DDR_REG, regs);
+
+	if ((ios->timing == MMC_TIMING_MMC_HS) ||
+		(ios->timing == MMC_TIMING_LEGACY))
+		clk_set_phase(priv->drive_clk, drive_phase[SDMMC_DRV_PS_180]);
+	else if (ios->timing == MMC_TIMING_MMC_HS200)
+		clk_set_phase(priv->drive_clk, drive_phase[SDMMC_DRV_PS_135]);
+}
+
+static int
+dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	struct dw_mci *host = slot->host;
+	struct hi3798cv200_priv *priv = host->priv;
+	u32 index, found = 0;
+	u32 sample_phase[] = {0, 45, 90, 135, 180, 225, 270, 315};
+	int err = 0, raise_point = -1, fall_point = -1, prev_err = -1;
+
+	for (index = 0; index < ARRAY_SIZE(sample_phase); index++) {
+		clk_set_phase(priv->sample_clk, sample_phase[index]);
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+
+		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		if (!err)
+			found = 1;
+		if (index > 0) {
+			if (err && !prev_err)
+				fall_point = index - 1;
+			if (!err && prev_err)
+				raise_point = index;
+		}
+
+		if ((raise_point != -1) && (fall_point != -1))
+			goto tuning_out;
+		prev_err = err;
+		err = 0;
+	}
+
+tuning_out:
+	if (found) {
+		if (raise_point == -1)
+			raise_point = 0;
+		if (fall_point == -1)
+			fall_point = ARRAY_SIZE(sample_phase)-1;
+		if (fall_point < raise_point) {
+			if ((raise_point + fall_point)
+				> (ARRAY_SIZE(sample_phase) - 1))
+				index = fall_point / 2;
+			else
+				index =	(raise_point +
+				ARRAY_SIZE(sample_phase) - 1) / 2;
+		} else
+			index = (raise_point + fall_point) / 2;
+
+		clk_set_phase(priv->sample_clk, sample_phase[index]);
+		dev_dbg(host->dev, "Tuning clk_sample[%d, %d], set[%d]\n",
+			raise_point, fall_point, sample_phase[index]);
+	} else {
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+		dev_err(host->dev, "No valid clk_sample shift! use default\n");
+		return -1;
+	}
+	mci_writel(host, RINTSTS, ALL_INT_CLR);
+	return err;
+}
+
+static int dw_mci_hi3798cv200_dt(struct dw_mci *host)
+{
+	struct hi3798cv200_priv *priv;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
+	if (IS_ERR(priv->sample_clk))
+		dev_dbg(host->dev, "ciu-sample not available\n");
+	else {
+		if (clk_prepare_enable(priv->sample_clk))
+			dev_err(host->dev, "failed to enable ciu-sample clock\n");
+	}
+
+	priv->drive_clk = devm_clk_get(host->dev, "ciu-drive");
+	if (IS_ERR(priv->drive_clk))
+		dev_dbg(host->dev, "ciu-drive not available\n");
+	else {
+		if (clk_prepare_enable(priv->drive_clk))
+			dev_err(host->dev, "failed to enable ciu-drive clock\n");
+	}
+
+	host->priv = priv;
+
+	return 0;
+}
+
+static const struct dw_mci_drv_data hi3798cv200_data = {
+	.set_ios	= dw_mci_hi3798cv200_set_ios,
+	.parse_dt	= dw_mci_hi3798cv200_dt,
+	.execute_tuning	= dw_mci_hi3798cv200_execute_tuning,
+};
+
+static const struct of_device_id dw_mci_hi3798cv200_match[] = {
+	{ .compatible = "hisilicon,hi3798cv200-dw-mshc",
+		.data = &hi3798cv200_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
+
+static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data;
+	const struct of_device_id *match;
+
+	match = of_match_node(dw_mci_hi3798cv200_match, pdev->dev.of_node);
+	drv_data = match->data;
+
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+static struct platform_driver dw_mci_hi3798cv200_pltfm_driver = {
+	.probe		= dw_mci_hi3798cv200_probe,
+	.remove		= dw_mci_pltfm_remove,
+	.driver		= {
+		.name		= "dwmmc_hi3798cv200",
+		.of_match_table	= dw_mci_hi3798cv200_match,
+	},
+};
+
+module_platform_driver(dw_mci_hi3798cv200_pltfm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MMC driver for the Hisilicon MMC Host Controller");
-- 
2.7.4

