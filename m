From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v2 2/3] mmc: support sdhci-pxa910
Date: Wed, 25 May 2011 05:23:12 -0400
Message-ID: <1306315392-15864-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:48633 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab1EYJXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 05:23:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Jun Nie <njun@marvell.com>, Qiming Wu <wuqm@marvell.com>

	SDHCI driver for pxa910 SoCs, the driver based on sdhci-pltfm to handle resource etc.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Jun Nie <njun@marvell.com>
Signed-off-by: Qiming Wu <wuqm@marvell.com>
---
 drivers/mmc/host/Kconfig        |   13 ++
 drivers/mmc/host/Makefile       |    1 +
 drivers/mmc/host/sdhci-pxa910.c |  297 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pxa910.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 513df18..865dc86 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -194,6 +194,19 @@ config MMC_SDHCI_MMP2
 
 	  If unsure, say N.
 
+config MMC_SDHCI_PXA910
+	tristate "Marvell PXA910 SD Host Controller support"
+	depends on ARCH_MMP
+	select MMC_SDHCI
+	select MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Marvell(R) PXA910 SD Host Controller.
+	  If you have a PXA910 platform with SD Host Controller
+	  and a card slot, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f8650e0..5b75609 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_MMP2)	+= sdhci-mmp2.o
+obj-$(CONFIG_MMC_SDHCI_PXA910)	+= sdhci-pxa910.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa910.c b/drivers/mmc/host/sdhci-pxa910.c
new file mode 100644
index 0000000..56ef328
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa910.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright (C) 2010 Marvell International Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <plat/sdhci.h>
+#include <linux/slab.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SD_FIFO_PARAM		0xe0
+#define DIS_PAD_SD_CLK_GATE	0x0400 /* Turn on/off Dynamic SD Clock Gating */
+#define CLK_GATE_ON		0x0200 /* Disable/enable Clock Gate */
+#define CLK_GATE_CTL		0x0100 /* Clock Gate Control */
+#define CLK_GATE_SETTING_BITS	(DIS_PAD_SD_CLK_GATE | \
+		CLK_GATE_ON | CLK_GATE_CTL)
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP	0xe6
+#define SDCLK_SEL_SHIFT		8
+#define SDCLK_SEL_MASK		0x3
+#define SDCLK_DELAY_SHIFT	10
+#define SDCLK_DELAY_MASK	0x3c
+
+#define SDHCI_HOST_CONTROL	0x28
+#define  SDHCI_CTRL_4BITBUS	0x02
+
+#define SD_CE_ATA_2		0xea
+#define MMC_CARD		0x1000
+#define MMC_WIDTH		0x0100
+
+static void pxa910_sdh_specific_ctrl(struct sdhci_host *host,
+				struct sdhci_pxa_platdata *pdata)
+{
+	u16 tmp = 0;
+
+	/*
+	 * tune timing of read data/command when crc error happen
+	 * no performance impact
+	 */
+	if (pdata->clk_delay_sel == 1) {
+		tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+
+		tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+		tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
+			<< SDCLK_DELAY_SHIFT;
+		tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+		tmp |= (1 & SDCLK_SEL_MASK) << SDCLK_SEL_SHIFT;
+
+		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+	}
+
+	if (pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
+		tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+		tmp &= ~CLK_GATE_SETTING_BITS;
+		tmp |= CLK_GATE_SETTING_BITS;
+		writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+	}
+}
+
+static int pxa910_mmc_set_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+	u16 tmp;
+
+	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
+	tmp = readw(host->ioaddr + SD_CE_ATA_2);
+	if (width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		tmp |= MMC_CARD | MMC_WIDTH;
+	} else {
+		tmp &= ~(MMC_CARD | MMC_WIDTH);
+		if (width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
+	writew(tmp, host->ioaddr + SD_CE_ATA_2);
+	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+
+	return 0;
+}
+
+static unsigned int pxa910_get_ro(struct sdhci_host *host)
+{
+	/* Micro SD does not support write-protect feature */
+	return 0;
+}
+
+static void pxa910_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	if (clock)
+		pxa910_sdh_specific_ctrl(host, pxa->pdata);
+}
+
+static u32 pxa910_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	return clk_get_rate(pxa->clk);
+}
+
+static int __devinit sdhci_pxa910_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host = NULL;
+	struct sdhci_pxa *pxa = NULL;
+	int ret;
+	struct clk *clk;
+
+	pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
+	if (!pxa) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+	if (!pxa->ops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pxa->pdata = pdata;
+
+	clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	pxa->clk = clk;
+	clk_enable(clk);
+
+	host = sdhci_pltfm_init(pdev, NULL);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = pxa;
+
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
+		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
+
+	if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		/* on-chip device */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+	}
+
+	/* If slot design supports 8 bit data, indicate this to MMC. */
+	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+	if (pdata && pdata->quirks)
+		host->quirks |= pdata->quirks;
+	if (pdata && pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+	if (pdata && pdata->pm_caps)
+		host->mmc->pm_caps |= pdata->pm_caps;
+
+	pxa->ops->get_max_clock = pxa910_get_max_clock;
+	pxa->ops->set_clock = pxa910_set_clock;
+	pxa->ops->platform_8bit_width = pxa910_mmc_set_width;
+	if (pdata && pdata->flags & PXA_FLAG_CARD_NO_WP)
+		pxa->ops->get_ro = pxa910_get_ro;
+
+	host->ops = pxa->ops;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto out;
+	}
+
+	if (pxa->pdata->max_speed) {
+		host->mmc->f_max = pxa->pdata->max_speed;
+		if (!(host->mmc->f_max > 25000000))
+			host->mmc->caps &= ~(MMC_CAP_SD_HIGHSPEED |
+					MMC_CAP_MMC_HIGHSPEED);
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+out:
+	if (host) {
+		clk_disable(pltfm_host->clk);
+		clk_put(pltfm_host->clk);
+		sdhci_pltfm_free(pdev);
+	}
+
+	if (pxa)
+		kfree(pxa->ops);
+	kfree(pxa);
+
+	return ret;
+}
+
+static int __devexit sdhci_pxa910_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	int dead = 0;
+	u32 scratch;
+
+	if (host) {
+		scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+		if (scratch == (u32)-1)
+			dead = 1;
+
+		sdhci_remove_host(host, dead);
+
+		clk_disable(pxa->clk);
+		clk_put(pxa->clk);
+		sdhci_pltfm_free(pdev);
+
+		platform_set_drvdata(pdev, NULL);
+	}
+
+	if (pxa)
+		kfree(pxa->ops);
+	kfree(pxa);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_pxa910_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pxa910_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pxa910_suspend	NULL
+#define sdhci_pxa910_resume	NULL
+#endif
+
+
+static struct platform_driver sdhci_pxa910_driver = {
+	.driver		= {
+		.name	= "sdhci-pxa910",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_pxa910_probe,
+	.remove		= __devexit_p(sdhci_pxa910_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pxa910_suspend,
+	.resume		= sdhci_pxa910_resume,
+#endif
+};
+static int __init sdhci_pxa910_init(void)
+{
+	return platform_driver_register(&sdhci_pxa910_driver);
+}
+
+static void __exit sdhci_pxa910_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxa910_driver);
+}
+
+module_init(sdhci_pxa910_init);
+module_exit(sdhci_pxa910_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for pxa910");
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.0.4

