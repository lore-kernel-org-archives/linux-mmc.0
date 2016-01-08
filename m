From: Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH v3 12/14] mmc: sdhci-pic32: Add PIC32 SDHCI host controller driver
Date: Thu, 7 Jan 2016 17:00:27 -0700
Message-ID: <1452211389-31025-13-git-send-email-joshua.henderson@microchip.com>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Andrei Pistirica <andrei.pistirica@microchip.com>, Joshua Henderson <joshua.henderson@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Corneliu Doban <cdoban@broadcom.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Lokesh Vutla <lokeshvutla@ti.com>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, yangbo lu <yangbo.lu@freescale.com>, Kevin Hao <haokexin@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Andy Green <andy.green@linaro.org>li
List-Id: linux-mmc@vger.kernel.org

From: Andrei Pistirica <andrei.pistirica@microchip.com>

This driver supports the SDHCI host controller found on a PIC32.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/mmc/host/Kconfig       |   11 ++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-pic32.c |  257 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-pic32.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1dee533..c6a8916 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -785,3 +785,14 @@ config MMC_MTK
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
 	  This is needed if support for any SD/SDIO/MMC devices is required.
 	  If unsure, say N.
+
+config MMC_SDHCI_MICROCHIP_PIC32
+        tristate "Microchip PIC32MZDA SDHCI support"
+        depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
+        help
+          This selects the Secure Digital Host Controller Interface (SDHCI)
+          for PIC32MZDA platform.
+
+          If you have a controller with this interface, say Y or M here.
+
+          If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 3595f83..af918d2 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
+obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
new file mode 100644
index 0000000..059df70
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -0,0 +1,257 @@
+/*
+ * Support of SDHCI platform devices for Microchip PIC32.
+ *
+ * Copyright (C) 2015 Microchip
+ * Andrei Pistirica, Paul Thacker
+ *
+ * Inspired by sdhci-pltfm.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/mmc/host.h>
+#include <linux/io.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+#include <linux/platform_data/sdhci-pic32.h>
+
+#define SDH_SHARED_BUS_CTRL		0x000000E0
+#define SDH_SHARED_BUS_NR_CLK_PINS_MASK	0x7
+#define SDH_SHARED_BUS_NR_IRQ_PINS_MASK	0x30
+#define SDH_SHARED_BUS_CLK_PINS		0x10
+#define SDH_SHARED_BUS_IRQ_PINS		0x14
+#define SDH_CAPS_SDH_SLOT_TYPE_MASK	0xC0000000
+#define SDH_SLOT_TYPE_REMOVABLE		0x0
+#define SDH_SLOT_TYPE_EMBEDDED		0x1
+#define SDH_SLOT_TYPE_SHARED_BUS	0x2
+#define SDHCI_CTRL_CDSSEL		0x80
+#define SDHCI_CTRL_CDTLVL		0x40
+
+#define ADMA_FIFO_RD_THSHLD	512
+#define ADMA_FIFO_WR_THSHLD	512
+
+struct pic32_sdhci_priv {
+	struct platform_device	*pdev;
+	struct clk *sys_clk;
+	struct clk *base_clk;
+};
+
+static unsigned int pic32_sdhci_get_max_clock(struct sdhci_host *host)
+{
+	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
+
+	return clk_get_rate(sdhci_pdata->base_clk);
+}
+
+static void pic32_sdhci_set_bus_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	if (width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl |= SDHCI_CTRL_8BITBUS;
+	} else {
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl &= ~SDHCI_CTRL_8BITBUS;
+		if (width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
+
+	/* CD select and test bits must be set for errata workaround. */
+	ctrl &= ~SDHCI_CTRL_CDTLVL;
+	ctrl |= SDHCI_CTRL_CDSSEL;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
+static unsigned int pic32_sdhci_get_ro(struct sdhci_host *host)
+{
+	/*
+	 * The SDHCI_WRITE_PROTECT bit is unstable on current hardware so we
+	 * can't depend on its value in any way.
+	 */
+	return 0;
+}
+
+static const struct sdhci_ops pic32_sdhci_ops = {
+	.get_max_clock = pic32_sdhci_get_max_clock,
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = pic32_sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.get_ro = pic32_sdhci_get_ro,
+};
+
+static struct sdhci_pltfm_data sdhci_pic32_pdata = {
+	.ops = &pic32_sdhci_ops,
+	.quirks = SDHCI_QUIRK_NO_HISPD_BIT,
+	.quirks2 = SDHCI_QUIRK2_NO_1_8_V,
+};
+
+static void pic32_sdhci_shared_bus(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	u32 bus = readl(host->ioaddr + SDH_SHARED_BUS_CTRL);
+	u32 clk_pins = (bus & SDH_SHARED_BUS_NR_CLK_PINS_MASK) >> 0;
+	u32 irq_pins = (bus & SDH_SHARED_BUS_NR_IRQ_PINS_MASK) >> 4;
+
+	/* select first clock */
+	if (clk_pins & 1)
+		bus |= (1 << SDH_SHARED_BUS_CLK_PINS);
+
+	/* select first interrupt */
+	if (irq_pins & 1)
+		bus |= (1 << SDH_SHARED_BUS_IRQ_PINS);
+
+	writel(bus, host->ioaddr + SDH_SHARED_BUS_CTRL);
+}
+
+static int pic32_sdhci_probe_platform(struct platform_device *pdev,
+				      struct pic32_sdhci_priv *pdata)
+{
+	int ret = 0;
+	u32 caps_slot_type;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	/* Check card slot connected on shared bus. */
+	host->caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
+	caps_slot_type = (host->caps & SDH_CAPS_SDH_SLOT_TYPE_MASK) >> 30;
+	if (caps_slot_type == SDH_SLOT_TYPE_SHARED_BUS)
+		pic32_sdhci_shared_bus(pdev);
+
+	return ret;
+}
+
+static int pic32_sdhci_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct pic32_sdhci_priv *sdhci_pdata;
+	struct pic32_sdhci_platform_data *plat_data;
+	int ret;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_pic32_pdata,
+				sizeof(struct pic32_sdhci_priv));
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		goto err;
+	}
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_pdata = sdhci_pltfm_priv(pltfm_host);
+
+	plat_data = pdev->dev.platform_data;
+	if (plat_data && plat_data->setup_dma) {
+		ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
+					   ADMA_FIFO_WR_THSHLD);
+		if (ret)
+			goto err_host;
+	}
+
+	sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
+	if (IS_ERR(sdhci_pdata->sys_clk)) {
+		ret = PTR_ERR(sdhci_pdata->sys_clk);
+		dev_err(&pdev->dev, "Error getting clock\n");
+		goto err_host;
+	}
+
+	ret = clk_prepare_enable(sdhci_pdata->sys_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Error enabling clock\n");
+		goto err_host;
+	}
+
+	sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
+	if (IS_ERR(sdhci_pdata->base_clk)) {
+		ret = PTR_ERR(sdhci_pdata->base_clk);
+		dev_err(&pdev->dev, "Error getting clock\n");
+		goto err_sys_clk;
+	}
+
+	ret = clk_prepare_enable(sdhci_pdata->base_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Error enabling clock\n");
+		goto err_base_clk;
+	}
+
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_base_clk;
+
+	ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to probe platform!\n");
+		goto err_base_clk;
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding host\n");
+		goto err_base_clk;
+	}
+
+	dev_info(&pdev->dev, "Successfully added sdhci host\n");
+	return 0;
+
+err_base_clk:
+	clk_disable_unprepare(sdhci_pdata->base_clk);
+err_sys_clk:
+	clk_disable_unprepare(sdhci_pdata->sys_clk);
+err_host:
+	sdhci_pltfm_free(pdev);
+err:
+	dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
+	return ret;
+}
+
+static int pic32_sdhci_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
+	u32 scratch;
+
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	sdhci_remove_host(host, scratch == (u32)~0);
+	clk_disable_unprepare(sdhci_pdata->base_clk);
+	clk_disable_unprepare(sdhci_pdata->sys_clk);
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id pic32_sdhci_id_table[] = {
+	{ .compatible = "microchip,pic32mzda-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
+
+static struct platform_driver pic32_sdhci_driver = {
+	.driver = {
+		.name	= "pic32-sdhci",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
+	},
+	.probe		= pic32_sdhci_probe,
+	.remove		= pic32_sdhci_remove,
+};
+
+module_platform_driver(pic32_sdhci_driver);
+
+MODULE_DESCRIPTION("Microchip PIC32 SDHCI driver");
+MODULE_AUTHOR("Pistirica Sorin Andrei & Sandeep Sheriker");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
