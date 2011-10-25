From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH 2/3] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Tue, 25 Oct 2011 18:07:09 +0530
Message-ID: <1319546229-31804-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: zhangfei.gao@marvell.com, dwang4@marvell.com, njun@marvell.com, wuqm@marvell.com, prakity@marvell.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/mmc/host/Kconfig                |   13 ++
 drivers/mmc/host/Makefile               |    1 +
 drivers/mmc/host/sdhci-pxav1.c          |  256 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c                |    3 +
 drivers/mmc/host/sdhci.h                |    1 +
 include/linux/platform_data/pxa_sdhci.h |    1 +
 6 files changed, 275 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pxav1.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c87096..9c9b73a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -207,6 +207,19 @@ config MMC_SDHCI_PXAV2
 
 	  If unsure, say N.
 
+config MMC_SDHCI_PXAV1
+	tristate "Marvell PXA16X SD Host Controller support (PXAV1)"
+	depends on CLKDEV_LOOKUP
+	select MMC_SDHCI
+	select MMC_SDHCI_PLTFM
+	default CPU_PXA168
+	help
+	  This selects the Marvell(R) PXAV1 SD Host Controller.
+	  If you have a PXA16X platform with SD Host Controller
+	  and a card slot, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index b4b83f3..5094af8 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
+obj-$(CONFIG_MMC_SDHCI_PXAV1)	+= sdhci-pxav1.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxav1.c b/drivers/mmc/host/sdhci-pxav1.c
new file mode 100644
index 0000000..a0f6285
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxav1.c
@@ -0,0 +1,256 @@
+/*
+ * Copyright (C) 2011 Marvell International Ltd.
+ *		Zhangfei Gao <zhangfei.gao@marvell.com>
+ *		Kevin Wang <dwang4@marvell.com>
+ *		Jun Nie <njun@marvell.com>
+ *		Qiming Wu <wuqm@marvell.com>
+ *		Philip Rakity <prakity@marvell.com>
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
+#include <linux/platform_data/pxa_sdhci.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SD_FIFO_PARAM		0xe0
+#define DIS_PAD_SD_CLK_GATE	0x0400 /* Turn on/off Dynamic SD Clock Gating */
+#define CLK_GATE_SETTING_BITS	DIS_PAD_SD_CLK_GATE
+
+#define SD_CLOCK_BURST_SIZE_SETUP	0xe6
+#define SDCLK_SEL_SHIFT		8
+#define SDCLK_SEL_MASK		0x3
+#define SDCLK_DELAY_SHIFT	10
+#define SDCLK_DELAY_MASK	0x3c
+
+#define SD_CE_ATA_2		0xea
+#define MMC_CARD		0x1000
+#define MMC_WIDTH		0x0100
+
+
+static void pxav1_set_private_registers(struct sdhci_host *host, u8 mask)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (mask == SDHCI_RESET_ALL) {
+		u16 tmp = 0;
+
+		/*
+		 * tune timing of read data/command when crc error happen
+		 * no performance impact
+		 */
+		if (pdata && pdata->clk_delay_sel) {
+			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+
+			tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
+				<< SDCLK_DELAY_SHIFT;
+			tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+			tmp |= (pdata->clk_delay_sel & SDCLK_SEL_MASK)
+				<< SDCLK_SEL_SHIFT;
+
+			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+		}
+
+		/* no clock gating */
+		tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+		tmp |= DIS_PAD_SD_CLK_GATE;
+		writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+	}
+}
+
+static int pxav1_mmc_set_width(struct sdhci_host *host, int width)
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
+static u32 pxav1_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
+/*
+ * we cannot talk to controller for 8 bus cycles according to sdio spec
+ * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+ * which is quite a LONG TIME on a fast cpu -- so delay if needed
+ */
+static void platform_specific_completion(struct sdhci_host *host)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
+		mdelay(pdata->delay_in_ms);
+}
+
+
+static struct sdhci_ops pxav1_sdhci_ops = {
+	.get_max_clock = pxav1_get_max_clock,
+	.platform_reset_exit = pxav1_set_private_registers,
+	.platform_8bit_width = pxav1_mmc_set_width,
+	.platform_specific_completion = &platform_specific_completion,
+};
+
+static int __devinit sdhci_pxav1_probe(struct platform_device *pdev)
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
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
+		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
+		| SDHCI_QUIRK_NO_BUSY_IRQ
+		| SDHCI_QUIRK_32BIT_DMA_SIZE;
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
+	host->ops = &pxav1_sdhci_ops;
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
+static int __devexit sdhci_pxav1_remove(struct platform_device *pdev)
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
+static struct platform_driver sdhci_pxav1_driver = {
+	.driver		= {
+		.name	= "sdhci-pxav1",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_pxav1_probe,
+	.remove		= __devexit_p(sdhci_pxav1_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+static int __init sdhci_pxav1_init(void)
+{
+	return platform_driver_register(&sdhci_pxav1_driver);
+}
+
+static void __exit sdhci_pxav1_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxav1_driver);
+}
+
+module_init(sdhci_pxav1_init);
+module_exit(sdhci_pxav1_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for pxav1");
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..26043aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -960,6 +960,9 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
+	if (host->ops->platform_specific_completion)
+		host->ops->platform_specific_completion(host);
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 745c42f..363eebc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -274,6 +274,7 @@ struct sdhci_ops {
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 
+	void	(*platform_specific_completion)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 51ad099..b77f017 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -51,6 +51,7 @@ struct sdhci_pxa_platdata {
 	unsigned int	host_caps;
 	unsigned int	quirks;
 	unsigned int	pm_caps;
+	unsigned int	delay_in_ms;
 };
 
 struct sdhci_pxa {
-- 
1.6.3.3
