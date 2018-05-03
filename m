From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v6 1/3] mmc: dw_mmc-bluefield: Add driver extension
Date: Thu,  3 May 2018 11:45:14 -0400
Message-ID: <1525362316-40240-1-git-send-email-lsun@mellanox.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This commit adds extension to the dw_mmc driver for Mellanox BlueField
SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
this SoC.

Signed-off-by: Liming Sun <lsun@mellanox.com>
Reviewed-by: David Woods <dwoods@mellanox.com>
---
 drivers/mmc/host/Kconfig            |  9 ++++
 drivers/mmc/host/Makefile           |  1 +
 drivers/mmc/host/dw_mmc-bluefield.c | 87 +++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9589f9c..26ac6b5 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -717,6 +717,15 @@ config MMC_DW_K3
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on Hisilicon K3 SoC's.
 
+config MMC_DW_BLUEFIELD
+	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for Mellanox BlueField SoC specific extensions to
+	  the Synopsys DesignWare Memory Card Interface driver. Select this
+	  option for platforms based on Mellanox BlueField SoC's.
+
 config MMC_DW_PCI
 	tristate "Synopsys Designware MCI support on PCI bus"
 	depends on MMC_DW && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6aead24..267b3f1 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
 obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
+obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
new file mode 100644
index 0000000..21db031
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Mellanox Technologies.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/of.h>
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define UHS_REG_EXT_SAMPLE_WIDTH	7
+#define UHS_REG_EXT_SAMPLE_SHIFT	16
+#define UHS_REG_EXT_DRIVE_WIDTH	7
+#define UHS_REG_EXT_DRIVE_SHIFT	23
+
+#define BLUEFIELD_UHS_REG_EXT_SAMPLE	2
+#define BLUEFIELD_UHS_REG_EXT_DRIVE	4
+
+#define SET_REG_FIELD(reg, value, width, shift) \
+	((reg) = (((reg) & ~(((1 << (width)) - 1) << (shift))) | \
+		((value) << (shift))))
+
+static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	u32 reg;
+
+	/* Update the Drive and Sample fields in register UHS_REG_EXT. */
+	reg = mci_readl(host, UHS_REG_EXT);
+	SET_REG_FIELD(reg, BLUEFIELD_UHS_REG_EXT_SAMPLE,
+		      UHS_REG_EXT_SAMPLE_WIDTH, UHS_REG_EXT_SAMPLE_SHIFT);
+	SET_REG_FIELD(reg, BLUEFIELD_UHS_REG_EXT_DRIVE,
+		      UHS_REG_EXT_DRIVE_WIDTH, UHS_REG_EXT_DRIVE_SHIFT);
+	mci_writel(host, UHS_REG_EXT, reg);
+}
+
+static const struct dw_mci_drv_data bluefield_drv_data = {
+	.set_ios		= dw_mci_bluefield_set_ios
+};
+
+static const struct of_device_id dw_mci_bluefield_match[] = {
+	{ .compatible = "mellanox,bluefield-dw-mshc",
+		.data = &bluefield_drv_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
+
+static int dw_mci_bluefield_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data = NULL;
+	const struct of_device_id *match;
+
+	if (pdev->dev.of_node) {
+		match = of_match_node(dw_mci_bluefield_match,
+				      pdev->dev.of_node);
+		drv_data = match->data;
+	}
+
+	return dw_mci_pltfm_register(pdev, drv_data);
+}
+
+static struct platform_driver dw_mci_bluefield_pltfm_driver = {
+	.probe		= dw_mci_bluefield_probe,
+	.remove		= dw_mci_pltfm_remove,
+	.driver		= {
+		.name		= "dwmmc_bluefield",
+		.of_match_table	= dw_mci_bluefield_match,
+		.pm		= &dw_mci_pltfm_pmops,
+	},
+};
+
+module_platform_driver(dw_mci_bluefield_pltfm_driver);
+
+MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1
