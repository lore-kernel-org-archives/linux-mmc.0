From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/5] MMC: mmci: Seperate ux500 variants from generic code
Date: Wed, 14 Mar 2012 14:19:59 +0000
Message-ID: <1331734803-17954-2-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45900 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2CNOUK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 10:20:10 -0400
Received: by wibhj6 with SMTP id hj6so7240835wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 07:20:09 -0700 (PDT)
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

This is a step in the right direction for future Device
Tree support. It will allow variant specific attributes
to be collected from a Device Tree without overloading
the MMCI core. It will also provide additional future
variants a cleaner way to add support.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/Makefile     |    2 +-
 drivers/mmc/host/mmci-ux500.c |   93 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.c       |   90 ++++------------------------------------
 drivers/mmc/host/mmci.h       |   37 ++++++++++++++++
 4 files changed, 139 insertions(+), 83 deletions(-)
 create mode 100644 drivers/mmc/host/mmci-ux500.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 745f8fc..58e2bdc 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -2,7 +2,7 @@
 # Makefile for MMC/SD host controller drivers
 #
 
-obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
+obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o mmci-ux500.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
diff --git a/drivers/mmc/host/mmci-ux500.c b/drivers/mmc/host/mmci-ux500.c
new file mode 100644
index 0000000..82e60f9
--- /dev/null
+++ b/drivers/mmc/host/mmci-ux500.c
@@ -0,0 +1,93 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/* MMCIPOWER bits */
+#define MCI_DATA2DIREN		(1 << 2)
+#define MCI_CMDDIREN		(1 << 3)
+#define MCI_DATA0DIREN		(1 << 4)
+#define MCI_DATA31DIREN	(1 << 5)
+#define MCI_FBCLKEN		(1 << 7)
+
+static struct variant_data variant_u300 = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg_enable		= MCI_ST_U300_HWFCEN,
+	.datalength_bits	= 16,
+	.sdio			= true,
+};
+
+static struct variant_data variant_ux500 = {
+	.fifosize		= 30 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.datalength_bits	= 24,
+	.sdio			= true,
+	.st_clkdiv		= true,
+};
+
+static struct variant_data variant_ux500v2 = {
+	.fifosize		= 30 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.datalength_bits	= 24,
+	.sdio			= true,
+	.st_clkdiv		= true,
+	.blksz_datactrl16	= true,
+};
+
+static struct amba_id mmci_ux500_ids[] = {
+	/* ST Micro variants */
+	{
+		.id     = 0x00180180,
+		.mask   = 0x00ffffff,
+		.data	= &variant_u300,
+	},
+	{
+		.id     = 0x00280180,
+		.mask   = 0x00ffffff,
+		.data	= &variant_u300,
+	},
+	{
+		.id     = 0x00480180,
+		.mask   = 0xf0ffffff,
+		.data	= &variant_ux500,
+	},
+	{
+		.id     = 0x10480180,
+		.mask   = 0xf0ffffff,
+		.data	= &variant_ux500v2,
+	},
+	{ 0, 0 },
+};
+
+MODULE_DEVICE_TABLE(amba, mmci_ux500_ids);
+
+static struct amba_driver mmci_ux500_driver = {
+	.drv		= {
+		.name	= DRIVER_NAME,
+	},
+	.probe		= mmci_probe,
+	.remove		= __devexit_p(mmci_remove),
+	.suspend	= mmci_suspend,
+	.resume		= mmci_resume,
+	.id_table	= mmci_ux500_ids,
+};
+
+static int __init mmci_ux500_init(void)
+{
+	return amba_driver_register(&mmci_ux500_driver);
+}
+
+static void __exit mmci_ux500_exit(void)
+{
+	amba_driver_unregister(&mmci_ux500_driver);
+}
+
+module_init(mmci_ux500_init);
+module_exit(mmci_ux500_exit);
+module_param(fmax, uint, 0444);
+
+MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 304f2f9..ff44586 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,34 +37,6 @@
 
 #include "mmci.h"
 
-#define DRIVER_NAME "mmci-pl18x"
-
-static unsigned int fmax = 515633;
-
-/**
- * struct variant_data - MMCI variant-specific quirks
- * @clkreg: default value for MCICLOCK register
- * @clkreg_enable: enable value for MMCICLOCK register
- * @datalength_bits: number of bits in the MMCIDATALENGTH register
- * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
- *	      is asserted (likewise for RX)
- * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
- *		  is asserted (likewise for RX)
- * @sdio: variant supports SDIO
- * @st_clkdiv: true if using a ST-specific clock divider algorithm
- * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
- */
-struct variant_data {
-	unsigned int		clkreg;
-	unsigned int		clkreg_enable;
-	unsigned int		datalength_bits;
-	unsigned int		fifosize;
-	unsigned int		fifohalfsize;
-	bool			sdio;
-	bool			st_clkdiv;
-	bool			blksz_datactrl16;
-};
-
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -77,35 +49,6 @@ static struct variant_data variant_arm_extended_fifo = {
 	.datalength_bits	= 16,
 };
 
-static struct variant_data variant_u300 = {
-	.fifosize		= 16 * 4,
-	.fifohalfsize		= 8 * 4,
-	.clkreg_enable		= MCI_ST_U300_HWFCEN,
-	.datalength_bits	= 16,
-	.sdio			= true,
-};
-
-static struct variant_data variant_ux500 = {
-	.fifosize		= 30 * 4,
-	.fifohalfsize		= 8 * 4,
-	.clkreg			= MCI_CLK_ENABLE,
-	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
-	.datalength_bits	= 24,
-	.sdio			= true,
-	.st_clkdiv		= true,
-};
-
-static struct variant_data variant_ux500v2 = {
-	.fifosize		= 30 * 4,
-	.fifohalfsize		= 8 * 4,
-	.clkreg			= MCI_CLK_ENABLE,
-	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
-	.datalength_bits	= 24,
-	.sdio			= true,
-	.st_clkdiv		= true,
-	.blksz_datactrl16	= true,
-};
-
 /*
  * This must be called with host->lock held
  */
@@ -1125,7 +1068,7 @@ static const struct mmc_host_ops mmci_ops = {
 	.get_cd		= mmci_get_cd,
 };
 
-static int __devinit mmci_probe(struct amba_device *dev,
+extern int __devinit mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
@@ -1376,8 +1319,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
  out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mmci_probe);
 
-static int __devexit mmci_remove(struct amba_device *dev)
+extern int __devexit mmci_remove(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 
@@ -1428,9 +1372,10 @@ static int __devexit mmci_remove(struct amba_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmci_remove);
 
 #ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, pm_message_t state)
+extern int mmci_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	int ret = 0;
@@ -1445,8 +1390,9 @@ static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mmci_suspend);
 
-static int mmci_resume(struct amba_device *dev)
+extern int mmci_resume(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	int ret = 0;
@@ -1461,6 +1407,7 @@ static int mmci_resume(struct amba_device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mmci_resume);
 #else
 #define mmci_suspend	NULL
 #define mmci_resume	NULL
@@ -1482,27 +1429,6 @@ static struct amba_id mmci_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= &variant_arm,
 	},
-	/* ST Micro variants */
-	{
-		.id     = 0x00180180,
-		.mask   = 0x00ffffff,
-		.data	= &variant_u300,
-	},
-	{
-		.id     = 0x00280180,
-		.mask   = 0x00ffffff,
-		.data	= &variant_u300,
-	},
-	{
-		.id     = 0x00480180,
-		.mask   = 0xf0ffffff,
-		.data	= &variant_ux500,
-	},
-	{
-		.id     = 0x10480180,
-		.mask   = 0xf0ffffff,
-		.data	= &variant_ux500v2,
-	},
 	{ 0, 0 },
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79e4143..4ede20d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -7,6 +7,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/amba/mmci.h>
+#include <linux/scatterlist.h>
+#include <linux/amba/bus.h>
+
+#define DRIVER_NAME "mmci-pl18x"
+
 #define MMCIPOWER		0x000
 #define MCI_PWR_OFF		0x00
 #define MCI_PWR_UP		0x02
@@ -162,6 +168,8 @@
 
 #define NR_SG		16
 
+static unsigned int fmax = 515633;
+
 struct clk;
 struct variant_data;
 struct dma_chan;
@@ -218,3 +226,32 @@ struct mmci_host {
 #endif
 };
 
+/**
+ * struct variant_data - MMCI variant-specific quirks
+ * @clkreg: default value for MCICLOCK register
+ * @clkreg_enable: enable value for MMCICLOCK register
+ * @datalength_bits: number of bits in the MMCIDATALENGTH register
+ * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
+ *	      is asserted (likewise for RX)
+ * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
+ *		  is asserted (likewise for RX)
+ * @sdio: variant supports SDIO
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
+ * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
+ */
+struct variant_data {
+	unsigned int		clkreg;
+	unsigned int		clkreg_enable;
+	unsigned int		datalength_bits;
+	unsigned int		fifosize;
+	unsigned int		fifohalfsize;
+	bool			sdio;
+	bool			st_clkdiv;
+	bool			blksz_datactrl16;
+};
+
+extern int __devinit mmci_probe(struct amba_device *dev,
+				const struct amba_id *id);
+extern int __devexit mmci_remove(struct amba_device *dev);
+extern int mmci_suspend(struct amba_device *dev, pm_message_t state);
+extern int mmci_resume(struct amba_device *dev);
-- 
1.7.5.4

