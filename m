From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v4 1/5] mmc: support sdhci-pxav3.c
Date: Wed,  8 Jun 2011 17:41:57 +0800
Message-ID: <1307526121-12059-2-git-send-email-zhangfei.gao@marvell.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:32919 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1FHJmJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 05:42:09 -0400
In-Reply-To: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>

	SDHCI driver for PXAV3 SoCs, such as MMP2, the driver based on sdhci-pltfm to handle resource etc.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   35 ++++-
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxav3.c         |  289 ++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pxav3.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..6873dc5 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -15,21 +15,46 @@
 
 /* pxa specific flag */
 /* Require clock free running */
-#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
-
+#define PXA_FLAG_ENABLE_CLOCK_GATING (1<<0)
+/* card alwayes wired to host, like on-chip emmc */
+#define PXA_FLAG_CARD_PERMANENT	(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
 
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
- * @max_speed: the maximum speed supported
- * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay_cycles:
+ *	mmp2: each step is roughly 100ps, 5bits width
+ *	pxa910: each step is 1ns, 4bits width
+ * @clk_delay_sel: select clk_delay, used on pxa910
+ *	0: choose feedback clk
+ *	1: choose feedback clk + delay value
+ *	2: choose internal clk
+ * @clk_delay_enable: enable clk_delay or not, used on pxa910
+ * @ext_cd_gpio: gpio pin used for external CD line
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
+ * @max_speed: the maximum speed supported
+ * @host_caps: Standard MMC host capabilities bit field.
+ * @quirks: quirks of platfrom
+ * @pm_caps: pm_caps of platfrom
  */
 struct sdhci_pxa_platdata {
+	unsigned int	flags;
+	unsigned int	clk_delay_cycles;
+	unsigned int	clk_delay_sel;
+	bool		clk_delay_enable;
+	unsigned int	ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
 	unsigned int	max_speed;
+	unsigned int	host_caps;
 	unsigned int	quirks;
-	unsigned int	flags;
+	unsigned int	pm_caps;
+};
+
+struct sdhci_pxa {
+	u8	clk_enable;
+	u8	power_mode;
 };
 
 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 74e77c9..6525a04 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -193,6 +193,18 @@ config MMC_SDHCI_PXA
 
 	  If unsure, say N.
 
+config MMC_SDHCI_PXAV3
+	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
+	select MMC_SDHCI
+	select MMC_SDHCI_PLTFM
+	default CPU_MMP2
+	help
+	  This selects the Marvell(R) PXAV3 SD Host Controller.
+	  If you have a MMP2 platform with SD Host Controller
+	  and a card slot, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index bf479ab..688cc52 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
new file mode 100644
index 0000000..901f00f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -0,0 +1,289 @@
+/*
+ * Copyright (C) 2010 Marvell International Ltd.
+ *		Zhangfei Gao <zhangfei.gao@marvell.com>
+ *		Kevin Wang <dwang4@marvell.com>
+ *		Mingwei Wang <mwwang@marvell.com>
+ *		Philip Rakity <prakity@marvell.com>
+ *		Mark Brown <markb@marvell.com>
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
+#include <linux/delay.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SD_CLOCK_BURST_SIZE_SETUP		0x10A
+#define SDCLK_SEL	0x100
+#define SDCLK_DELAY_SHIFT	9
+#define SDCLK_DELAY_MASK	0x1f
+
+#define SD_CFG_FIFO_PARAM       0x100
+#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
+#define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
+#define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
+
+#define SD_SPI_MODE          0x108
+#define SD_CE_ATA_1          0x10C
+
+#define SD_CE_ATA_2          0x10E
+#define SDCE_MISC_INT		(1<<2)
+#define SDCE_MISC_INT_EN	(1<<1)
+
+static void pxav3_set_private_registers(struct sdhci_host *host, u8 mask)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (mask == SDHCI_RESET_ALL) {
+		/*
+		 * tune timing of read data/command when crc error happen
+		 * no performance impact
+		 */
+		if (pdata && 0 != pdata->clk_delay_cycles) {
+			u16 tmp;
+
+			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
+				<< SDCLK_DELAY_SHIFT;
+			tmp |= SDCLK_SEL;
+			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+		}
+	}
+}
+
+#define MAX_WAIT_COUNT 5
+static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	u16 tmp;
+	int count;
+
+	if (pxa->power_mode == MMC_POWER_UP
+			&& power_mode == MMC_POWER_ON) {
+
+		dev_dbg(mmc_dev(host->mmc),
+				"%s: slot->power_mode = %d,"
+				"ios->power_mode = %d\n",
+				__func__,
+				pxa->power_mode,
+				power_mode);
+
+		/* set we want notice of when 74 clocks are sent */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT_EN;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+		/* start sending the 74 clocks */
+		tmp = readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+		tmp |= SDCFG_GEN_PAD_CLK_ON;
+		writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+
+		/* slowest speed is about 100KHz or 10usec per clock */
+		udelay(740);
+		count = 0;
+
+		while (count++ < MAX_WAIT_COUNT) {
+			if ((readw(host->ioaddr + SD_CE_ATA_2)
+						& SDCE_MISC_INT) == 0)
+				break;
+			udelay(10);
+		}
+
+		if (count == MAX_WAIT_COUNT)
+			dev_warn(mmc_dev(host->mmc), "74 clock interrupt not cleared\n");
+
+		/* clear the interrupt bit if posted */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+	}
+	pxa->power_mode = power_mode;
+}
+
+static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+{
+	u16 ctrl_2;
+
+	/*
+	 * Set V18_EN -- UHS modes do not work without this.
+	 * does not change signaling voltage
+	 */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR12:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
+		break;
+	}
+
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	dev_dbg(mmc_dev(host->mmc),
+		"%s uhs = %d, ctrl_2 = %04X\n",
+		__func__, uhs, ctrl_2);
+
+	return 0;
+}
+
+static struct sdhci_ops pxav3_sdhci_ops = {
+	.platform_reset_exit = pxav3_set_private_registers,
+	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
+};
+
+static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
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
+	if (!pxa)
+		return -ENOMEM;
+
+	host = sdhci_pltfm_init(pdev, NULL);
+	if (IS_ERR(host)) {
+		kfree(pxa);
+		return PTR_ERR(host);
+	}
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = pxa;
+
+	clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
+	}
+	pltfm_host->clk = clk;
+	clk_enable(clk);
+
+	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+
+	/* enable 1/8V DDR capable */
+	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
+	if (pdata) {
+		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+			/* on-chip device */
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		}
+
+		/* If slot design supports 8 bit data, indicate this to MMC. */
+		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
+			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+		if (pdata->quirks)
+			host->quirks |= pdata->quirks;
+		if (pdata->host_caps)
+			host->mmc->caps |= pdata->host_caps;
+		if (pdata->pm_caps)
+			host->mmc->pm_caps |= pdata->pm_caps;
+	}
+
+	host->ops = &pxav3_sdhci_ops;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto err_add_host;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+
+err_add_host:
+	clk_disable(clk);
+	clk_put(clk);
+err_clk_get:
+	sdhci_pltfm_free(pdev);
+	kfree(pxa);
+	return ret;
+}
+
+static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	sdhci_remove_host(host, 1);
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+	sdhci_pltfm_free(pdev);
+	kfree(pxa);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_pxav3_driver = {
+	.driver		= {
+		.name	= "sdhci-pxav3",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_pxav3_probe,
+	.remove		= __devexit_p(sdhci_pxav3_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+static int __init sdhci_pxav3_init(void)
+{
+	return platform_driver_register(&sdhci_pxav3_driver);
+}
+
+static void __exit sdhci_pxav3_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxav3_driver);
+}
+
+module_init(sdhci_pxav3_init);
+module_exit(sdhci_pxav3_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for pxav3");
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.0.4

