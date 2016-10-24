From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 2/5] mmc: zx: Initial support for ZX mmc controller
Date: Mon, 24 Oct 2016 17:11:53 +0800
Message-ID: <1477300316-1420-3-git-send-email-jun.nie@linaro.org>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35164 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcJXJMT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 05:12:19 -0400
Received: by mail-pf0-f181.google.com with SMTP id s8so95419345pfj.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 02:12:19 -0700 (PDT)
In-Reply-To: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

This platform driver adds initial support for the DW host controller
found on ZTE SoCs.

It has been tested on ZX296718 EVB board currently. More support on
timing tuning will be added when hardware is available.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/Kconfig     |   9 ++
 drivers/mmc/host/Makefile    |   1 +
 drivers/mmc/host/dw_mmc-zx.c | 230 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc-zx.h |  23 +++++
 4 files changed, 263 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5274f50..2b3202c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -662,6 +662,15 @@ config MMC_DW_ROCKCHIP
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on RK3066, RK3188 and RK3288 SoC's.
 
+config MMC_DW_ZX
+	tristate "ZTE specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for ZTE SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on ZX296718 SoC's.
+
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on HAS_DMA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e2bdaaf..9766143 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
+obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
new file mode 100644
index 0000000..d0e4ef2
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -0,0 +1,230 @@
+/*
+ * ZX Specific Extensions for Synopsys DW Multimedia Card Interface driver
+ *
+ * Copyright (C) 2016, Linaro Ltd.
+ * Copyright (C) 2016, ZTE Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mmc/dw_mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+#include "dw_mmc-zx.h"
+
+#define ZX_DLL_LOCKED BIT(2)
+
+struct dw_mci_zx_priv_data {
+	struct regmap	*sysc_base;
+};
+
+static int dw_mci_zx_emmc_set_delay(struct dw_mci *host, unsigned int delay,
+				    unsigned int clk_flag)
+{
+	struct dw_mci_zx_priv_data *priv = host->priv;
+	struct regmap *sysc_base = priv->sysc_base;
+	unsigned int clksel;
+	unsigned int loop = 1000;
+	int ret;
+
+	ret = regmap_write(sysc_base, LB_AON_EMMC_CFG_REG0,
+			   PARA_DLL_START_POINT(4) | PARA_DLL_LOCK_NUM(4));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(sysc_base, LB_AON_EMMC_CFG_REG1, &clksel);
+	if (ret)
+		return ret;
+
+	if (clk_flag) {
+		clksel &= ~(CLK_SAMP_DELAY(0x7F));
+		clksel |= (delay << 8);
+	} else {
+		clksel &= ~(READ_DQS_DELAY(0x7F));
+		clksel |= delay;
+	}
+
+	regmap_write(sysc_base, LB_AON_EMMC_CFG_REG1, clksel);
+	regmap_write(sysc_base, LB_AON_EMMC_CFG_REG0,
+		     PARA_DLL_START_POINT(4) | PARA_DLL_LOCK_NUM(4) |
+		     DLL_REG_SET);
+
+	do {
+		ret = regmap_read(sysc_base, LB_AON_EMMC_CFG_REG2, &clksel);
+		if (ret)
+			return ret;
+
+	} while (--loop && !(clksel & ZX_DLL_LOCKED));
+
+	if (!loop) {
+		dev_err(host->dev, "Error: %s dll lock fail\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int dw_mci_zx_emmc_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	struct dw_mci *host = slot->host;
+	struct mmc_host *mmc = slot->mmc;
+	int len, start = 0, end = 0, delay, best = 0;
+	int ret = 0;
+
+	for (delay = 1 ; delay < 128; delay++) {
+		ret = dw_mci_zx_emmc_set_delay(host, delay, 1);
+		if (ret)
+			return ret;
+
+		if (mmc_send_tuning(mmc, opcode, NULL)) {
+			if (start >= 0) {
+				end = delay - 1;
+				/* check and update longest good range */
+				if ((end - start) > len) {
+					best = (start + end) >> 1;
+					len = end - start;
+				}
+			}
+			start = -1;
+			end = 0;
+			continue;
+		}
+		if (start < 0)
+			start = delay;
+	}
+
+	if (start >= 0) {
+		end = delay - 1;
+		if ((end - start) > len) {
+			best = (start + end) >> 1;
+			len = end - start;
+		}
+	}
+	if (best < 0)
+		return -EIO;
+
+	dev_info(host->dev, "%s best range: start %d end %d\n", __func__,
+		 start, end);
+	dw_mci_zx_emmc_set_delay(host, best, 1);
+	return 0;
+}
+
+static int dw_mci_zx_prepare_hs400_tuning(struct dw_mci *host,
+					  struct mmc_ios *ios)
+{
+	int ret;
+
+	/* config phase shift 90 */
+	ret = dw_mci_zx_emmc_set_delay(host, 32, 0);
+	if (ret < 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int dw_mci_zx_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	struct dw_mci *host = slot->host;
+
+	if (host->verid == 0x290a) /* emmc */
+		return dw_mci_zx_emmc_execute_tuning(slot, opcode);
+
+	return 0;
+}
+
+static int dw_mci_zx_parse_dt(struct dw_mci *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct device_node *node;
+	struct dw_mci_zx_priv_data *priv;
+	struct regmap *sysc_base;
+	int ret;
+
+	node = of_parse_phandle(np, "zte,aon-syscon", 0);
+	if (node) {
+		sysc_base = syscon_node_to_regmap(node);
+		of_node_put(node);
+
+		if (IS_ERR(sysc_base)) {
+			ret = PTR_ERR(sysc_base);
+			if (ret != -EPROBE_DEFER)
+				dev_err(host->dev, "Can't get syscon: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->sysc_base = sysc_base;
+	host->priv = priv;
+
+	return 0;
+}
+
+static unsigned long zx_dwmmc_caps[3] = {
+	MMC_CAP_HW_RESET,
+	0,
+	0,
+};
+
+static const struct dw_mci_drv_data zx_drv_data = {
+	.caps			= zx_dwmmc_caps,
+	.execute_tuning		= dw_mci_zx_execute_tuning,
+	.prepare_hs400_tuning	= dw_mci_zx_prepare_hs400_tuning,
+	.parse_dt               = dw_mci_zx_parse_dt,
+};
+
+static const struct of_device_id dw_mci_zx_match[] = {
+	{ .compatible = "zte,dw-mshc", .data = &zx_drv_data},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_zx_match);
+
+static int dw_mci_zx_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data;
+	const struct of_device_id *match;
+
+	match = of_match_node(dw_mci_zx_match, pdev->dev.of_node);
+	drv_data = match->data;
+
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+static const struct dev_pm_ops dw_mci_zx_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
+			   dw_mci_runtime_resume,
+			   NULL)
+};
+
+static struct platform_driver dw_mci_zx_pltfm_driver = {
+	.probe		= dw_mci_zx_probe,
+	.remove		= dw_mci_pltfm_remove,
+	.driver		= {
+		.name		= "dwmmc_zx",
+		.of_match_table	= dw_mci_zx_match,
+		.pm		= &dw_mci_zx_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dw_mci_zx_pltfm_driver);
+
+MODULE_DESCRIPTION("ZTE emmc/sd driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/dw_mmc-zx.h b/drivers/mmc/host/dw_mmc-zx.h
new file mode 100644
index 0000000..b1aac52
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-zx.h
@@ -0,0 +1,23 @@
+#ifndef _DW_MMC_ZX_H_
+#define _DW_MMC_ZX_H_
+
+/* dll reg offset*/
+#define LB_AON_EMMC_CFG_REG0  0x1B0
+#define LB_AON_EMMC_CFG_REG1  0x1B4
+#define LB_AON_EMMC_CFG_REG2  0x1B8
+
+/* LB_AON_EMMC_CFG_REG0 register defines */
+#define PARA_DLL_START_POINT(x)	(((x) & 0xFF) << 0)
+#define DLL_REG_SET		BIT(8)
+#define PARA_DLL_LOCK_NUM(x)	(((x) & 7) << 16)
+#define PARA_PHASE_DET_SEL(x)	(((x) & 7) << 20)
+#define PARA_DLL_BYPASS_MODE	BIT(23)
+#define PARA_HALF_CLK_MODE	BIT(24)
+
+/* LB_AON_EMMC_CFG_REG1 register defines */
+#define READ_DQS_DELAY(x)	(((x) & 0x7F) << 0)
+#define READ_DQS_BYPASS_MODE	BIT(7)
+#define CLK_SAMP_DELAY(x)	(((x) & 0x7F) << 8)
+#define CLK_SAMP_BYPASS_MODE	BIT(15)
+
+#endif /* _DW_MMC_ZX_H_ */
-- 
1.9.1

