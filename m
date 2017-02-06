From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 3/9] mmc: cavium: Add MMC platform driver for Octeon SOCs
Date: Mon,  6 Feb 2017 14:39:46 +0100
Message-ID: <20170206133953.8390-4-jglauber@cavium.com>
References: <20170206133953.8390-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206133953.8390-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add a platform driver for Octeon MIPS SOCs.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 drivers/mmc/host/Kconfig               |  10 ++
 drivers/mmc/host/Makefile              |   2 +
 drivers/mmc/host/cavium-mmc.h          |  19 ++++
 drivers/mmc/host/cavium-pltfm-octeon.c | 181 +++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f08691a..68cc811 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -622,6 +622,16 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 	help
 	  If you say yes here SD-Cards may work on the EZkit.
 
+config MMC_CAVIUM_OCTEON
+	tristate "Cavium OCTEON SD/MMC Card Interface support"
+	depends on CAVIUM_OCTEON_SOC
+	help
+	  This selects Cavium OCTEON SD/MMC card Interface.
+	  If you have an OCTEON board with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
 	depends on HAS_DMA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6d548c4..c7f0ccf 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
+octeon-mmc-objs := cavium-mmc.o cavium-pltfm-octeon.o
+obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
 obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
 obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
 obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
index 27fb02b..e900dd1 100644
--- a/drivers/mmc/host/cavium-mmc.h
+++ b/drivers/mmc/host/cavium-mmc.h
@@ -16,6 +16,25 @@
 
 #define CAVIUM_MAX_MMC		4
 
+#define MIO_EMM_DMA_CFG		0x00
+#define MIO_EMM_DMA_ADR		0x08
+
+#define MIO_EMM_CFG		0x00
+#define MIO_EMM_SWITCH		0x48
+#define MIO_EMM_DMA		0x50
+#define MIO_EMM_CMD		0x58
+#define MIO_EMM_RSP_STS		0x60
+#define MIO_EMM_RSP_LO		0x68
+#define MIO_EMM_RSP_HI		0x70
+#define MIO_EMM_INT		0x78
+#define MIO_EMM_INT_EN		0x80
+#define MIO_EMM_WDOG		0x88
+#define MIO_EMM_SAMPLE		0x90
+#define MIO_EMM_STS_MASK	0x98
+#define MIO_EMM_RCA		0xa0
+#define MIO_EMM_BUF_IDX		0xe0
+#define MIO_EMM_BUF_DAT		0xe8
+
 struct cvm_mmc_host {
 	struct device *dev;
 	void __iomem *base;
diff --git a/drivers/mmc/host/cavium-pltfm-octeon.c b/drivers/mmc/host/cavium-pltfm-octeon.c
new file mode 100644
index 0000000..e2a1d1f
--- /dev/null
+++ b/drivers/mmc/host/cavium-pltfm-octeon.c
@@ -0,0 +1,181 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2016 Cavium Inc.
+ */
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <asm/octeon/octeon.h>
+#include "cavium-mmc.h"
+
+#define CVMX_MIO_BOOT_CTL CVMX_ADD_IO_SEG(0x00011800000000D0ull)
+
+static void octeon_mmc_acquire_bus(struct cvm_mmc_host *host)
+{
+	/* Switch the MMC controller onto the bus. */
+	down(&octeon_bootbus_sem);
+	writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
+}
+
+static void octeon_mmc_release_bus(struct cvm_mmc_host *host)
+{
+	up(&octeon_bootbus_sem);
+}
+
+static void octeon_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
+{
+	writeq(val, host->base + MIO_EMM_INT);
+	writeq(val, host->base + MIO_EMM_INT_EN);
+}
+
+static int octeon_mmc_probe(struct platform_device *pdev)
+{
+	struct device_node *cn, *node = pdev->dev.of_node;
+	struct cvm_mmc_host *host;
+	struct resource	*res;
+	void __iomem *base;
+	int mmc_irq[9];
+	int i, ret = 0;
+	u64 val;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	host->dev = &pdev->dev;
+	host->acquire_bus = octeon_mmc_acquire_bus;
+	host->release_bus = octeon_mmc_release_bus;
+	host->int_enable = octeon_mmc_int_enable;
+
+	host->sys_freq = octeon_get_io_clock_rate();
+
+	/* First one is EMM second DMA */
+	for (i = 0; i < 2; i++) {
+		mmc_irq[i] = platform_get_irq(pdev, i);
+		if (mmc_irq[i] < 0)
+			return mmc_irq[i];
+	}
+	host->last_slot = -1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
+		return -ENXIO;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->base = (void __iomem *)base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[1] is missing\n");
+		return -EINVAL;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->dma_base = (void __iomem *)base;
+
+	/*
+	 * Clear out any pending interrupts that may be left over from
+	 * bootloader.
+	 */
+	val = readq(host->base + MIO_EMM_INT);
+	writeq(val, host->base + MIO_EMM_INT);
+
+	ret = devm_request_irq(&pdev->dev, mmc_irq[0],
+			       cvm_mmc_interrupt, 0, KBUILD_MODNAME, host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+			mmc_irq[0]);
+		return ret;
+	}
+
+	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev, "power",
+							 GPIOD_OUT_HIGH);
+	if (IS_ERR(host->global_pwr_gpiod)) {
+		dev_err(&pdev->dev, "Invalid power GPIO\n");
+		return PTR_ERR(host->global_pwr_gpiod);
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	for_each_child_of_node(node, cn) {
+		struct platform_device *slot_pdev;
+
+		slot_pdev = of_platform_device_create(cn, NULL, &pdev->dev);
+		ret = cvm_mmc_slot_probe(&slot_pdev->dev, host);
+		if (ret) {
+			dev_err(&pdev->dev, "Error populating slots\n");
+			gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int octeon_mmc_remove(struct platform_device *pdev)
+{
+	union mio_emm_dma_cfg dma_cfg;
+	struct cvm_mmc_host *host = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+		if (host->slot[i])
+			cvm_mmc_slot_remove(host->slot[i]);
+
+	dma_cfg.val = readq(host->dma_base + MIO_EMM_DMA_CFG);
+	dma_cfg.s.en = 0;
+	writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
+
+	gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+
+	return 0;
+}
+
+static const struct of_device_id octeon_mmc_match[] = {
+	{
+		.compatible = "cavium,octeon-6130-mmc",
+	},
+	{
+		.compatible = "cavium,octeon-7890-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mmc_match);
+
+static struct platform_driver octeon_mmc_driver = {
+	.probe		= octeon_mmc_probe,
+	.remove		= octeon_mmc_remove,
+	.driver		= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table = octeon_mmc_match,
+	},
+};
+
+static int __init octeon_mmc_init(void)
+{
+	return platform_driver_register(&octeon_mmc_driver);
+}
+
+static void __exit octeon_mmc_cleanup(void)
+{
+	platform_driver_unregister(&octeon_mmc_driver);
+}
+
+module_init(octeon_mmc_init);
+module_exit(octeon_mmc_cleanup);
+
+MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Low-level driver for Cavium OCTEON MMC/SSD card");
+MODULE_LICENSE("GPL");
-- 
2.9.0.rc0.21.g7777322
