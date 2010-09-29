From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH V2 1/1]MMC: add support of sdhci-pxa driver
Date: Tue, 28 Sep 2010 23:23:35 -0400
Message-ID: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=002215048fb7a4bb7104915d7cfa
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50700 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0I2DXg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 23:23:36 -0400
Received: by iwn5 with SMTP id 5so468894iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 20:23:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, kmpark@infradead.org, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--002215048fb7a4bb7104915d7cfa
Content-Type: text/plain; charset=ISO-8859-1

Hi, all

We strongly prefer using standalone host driver currently, like
sdhci-s3c.c, the scheme is more mature, more similar as our
controller, and more flexiable for sharing one controller in different
platform with different requirement.
We would rather pay more effort to enable new feature of silicon,  to
enhance the sdhci.c, which benefit much more silicon vender, instead
of paying much effort in how to abstract probe and remove.
For the driver lever, we don't want too much dependence, the more
dependence, the less stability.
The sdhci-pltfm has good idea, however currently it does not meet our
requirement, not say in the future.

Update the patch, help review.

>From 06301de67ec50151fa07246bbbdd2f7400126b3c Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH 1/2] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  259 ++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-pxa.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
new file mode 100644
index 0000000..f7a0968
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -0,0 +1,32 @@
+/* linux/arch/arm/plat-pxa/include/plat/sdhci.h
+ *
+ * Copyright 2010 Marvell
+ *	Zhangfei Gao <zhangfei.gao@marvell.com>
+ *
+ * PXA Platform - SDHCI platform data definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_PXA_SDHCI_H
+#define __PLAT_PXA_SDHCI_H
+
+/* pxa specific quirks */
+/* Card alwayes wired to host, like emmc */
+#define	PXA_QUIRK_BROKEN_CARD_DETECTION (1<<0)
+/* Require clock free running */
+#define	PXA_QUIRK_DISABLE_CLOCK_GATING (1<<1)
+
+/**
+ * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
+ * @max_speed: The maximum speed supported.
+ * @pxa_quirks: specific quirk of pxa
+*/
+struct sdhci_pxa_platdata {
+	unsigned int	max_speed;
+	unsigned int	pxa_quirk;
+};
+
+#endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6f12d5d..40aa3ba 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -158,6 +158,18 @@ config MMC_SDHCI_S3C

 	  If unsure, say N.

+config MMC_SDHCI_PXA
+	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
+	depends on ARCH_PXA || ARCH_MMP
+	select MMC_SDHCI
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
+	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller and a
+	  card slot,say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
 	depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index ef32c32..5cdc7c0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)	+= sdhci-mv.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..3f68c67
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,259 @@
+/* linux/drivers/mmc/host/sdhci-pxa.c
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ *      	Zhangfei Gao <zhangfei.gao@marvell.com>
+ *		Kevin Wang <dwang4@marvell.com>
+ *		Mingwei Wang <mwwang@marvell.com>
+ *		Philip Rakity <prakity@marvell.com>
+ *		Mark Brown <markb@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Supports:
+ * SDHCI support for MMP2/PXA910/PXA168
+ *
+ * Refer sdhci-s3c.c
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/sdhci.h>
+#include "sdhci.h"
+
+#define DRIVER_NAME	"sdhci-pxa"
+
+#define SD_FIFO_PARAM		0x104
+#define DIS_PAD_SD_CLK_GATE	0x400
+
+struct sdhci_pxa {
+	struct sdhci_host		*host;
+	struct sdhci_pxa_platdata	*pdata;
+	struct clk			*clk;
+	struct resource			*res;
+
+	u8 clk_enable;
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+static void set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+	u32 tmp = 0;
+
+	if (clock == 0) {
+		if (pxa->clk_enable) {
+			clk_disable(pxa->clk);
+			pxa->clk_enable = 0;
+		}
+	} else {
+		if (0 == pxa->clk_enable) {
+			if (pxa->pdata->pxa_quirk
+					& PXA_QUIRK_DISABLE_CLOCK_GATING) {
+				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
+				tmp |= DIS_PAD_SD_CLK_GATE;
+				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
+			}
+			clk_enable(pxa->clk);
+			pxa->clk_enable = 1;
+		}
+	}
+}
+
+static struct sdhci_ops sdhci_pxa_ops = {
+	.set_clock = set_clock,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device probing/removal                                                    *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
+{
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host = NULL;
+	struct resource *iomem = NULL;
+	struct sdhci_pxa *pxa = NULL;
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no irq specified\n");
+		return irq;
+	}
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		dev_err(dev, "no memory specified\n");
+		return -ENOENT;
+	}
+
+	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
+	if (IS_ERR(host)) {
+		dev_err(dev, "failed to alloc host\n");
+		ret = PTR_ERR(host);
+		goto out;
+	}
+
+	pxa = sdhci_priv(host);
+	pxa->host = host;
+	pxa->pdata = pdata;
+	pxa->clk_enable = 0;
+
+	pxa->clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(pxa->clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret = PTR_ERR(pxa->clk);
+		goto out;
+	}
+
+	pxa->res = request_mem_region(iomem->start, resource_size(iomem),
+		mmc_hostname(host->mmc));
+	if (!pxa->res) {
+		dev_err(&pdev->dev, "cannot request region\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
+	if (!host->ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	host->hw_name = "MMC";
+	host->ops = &sdhci_pxa_ops;
+	host->irq = irq;
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
+	if (pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETECTION)
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto out;
+	}
+
+	if (pxa->pdata->max_speed)
+		host->mmc->f_max = pxa->pdata->max_speed;
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+out:
+	if (host) {
+		if (host->ioaddr)
+			iounmap(host->ioaddr);
+		if (pxa->res)
+			release_mem_region(pxa->res->start,
+					resource_size(pxa->res));
+		sdhci_free_host(host);
+	}
+
+	return ret;
+}
+
+static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pxa *pxa = sdhci_priv(host);
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
+		if (host->ioaddr)
+			iounmap(host->ioaddr);
+		if (pxa->res)
+			release_mem_region(pxa->res->start,
+					resource_size(pxa->res));
+		if (pxa->clk_enable) {
+			clk_disable(pxa->clk);
+			pxa->clk_enable = 0;
+		}
+		clk_put(pxa->clk);
+
+		sdhci_free_host(host);
+		platform_set_drvdata(pdev, NULL);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sdhci_pxa_suspend(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(to_platform_device(dev));
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(to_platform_device(dev));
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static const struct dev_pm_ops sdhci_pxa_pm_ops = {
+	.suspend	= sdhci_pxa_suspend,
+	.resume		= sdhci_pxa_resume,
+};
+
+
+static struct platform_driver sdhci_pxa_driver = {
+	.probe		= sdhci_pxa_probe,
+	.remove		= __devexit_p(sdhci_pxa_remove),
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.pm = &sdhci_pxa_pm_ops,
+	},
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init sdhci_pxa_init(void)
+{
+	return platform_driver_register(&sdhci_pxa_driver);
+}
+
+static void __exit sdhci_pxa_exit(void)
+{
+	platform_driver_unregister(&sdhci_pxa_driver);
+}
+
+module_init(sdhci_pxa_init);
+module_exit(sdhci_pxa_exit);
+
+MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
+MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4

--002215048fb7a4bb7104915d7cfa
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geobx6ue0

RnJvbSAwNjMwMWRlNjdlYzUwMTUxZmEwNzI0NmJiYmRkMmY3NDAwMTI2YjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBtbWM6IGFkZCBzdXBwb3J0IG9mIHNkaGNpLXB4YSBkcml2ZXIKCglTdXBwb3J0IE1hcnZl
bGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3QgQ29udHJvbGxlcgoKU2lnbmVkLW9mZi1ieTog
WmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxh
dC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggfCAgIDMyICsrKysKIGRyaXZlcnMvbW1jL2hvc3Qv
S2NvbmZpZyAgICAgICAgICAgICAgIHwgICAxMiArKwogZHJpdmVycy9tbWMvaG9zdC9NYWtlZmls
ZSAgICAgICAgICAgICAgfCAgICAxICsKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAg
ICAgICAgIHwgIDI1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBj
aGFuZ2VkLCAzMDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaAogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1
ZGUvcGxhdC9zZGhjaS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmY3YTA5
NjgKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2Ro
Y2kuaApAQCAtMCwwICsxLDMyIEBACisvKiBsaW51eC9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRl
L3BsYXQvc2RoY2kuaAorICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwKKyAqCVpoYW5nZmVp
IEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgorICoKKyAqIFBYQSBQbGF0Zm9ybSAtIFNE
SENJIHBsYXRmb3JtIGRhdGEgZGVmaW5pdGlvbnMKKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9u
IDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorKi8K
KworI2lmbmRlZiBfX1BMQVRfUFhBX1NESENJX0gKKyNkZWZpbmUgX19QTEFUX1BYQV9TREhDSV9I
CisKKy8qIHB4YSBzcGVjaWZpYyBxdWlya3MgKi8KKy8qIENhcmQgYWx3YXllcyB3aXJlZCB0byBo
b3N0LCBsaWtlIGVtbWMgKi8KKyNkZWZpbmUJUFhBX1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElP
TiAoMTw8MCkKKy8qIFJlcXVpcmUgY2xvY2sgZnJlZSBydW5uaW5nICovCisjZGVmaW5lCVBYQV9R
VUlSS19ESVNBQkxFX0NMT0NLX0dBVElORyAoMTw8MSkKKworLyoqCisgKiBzdHJ1Y3QgcHhhX3Nk
aGNpX3BsYXRkYXRhKCkgLSBQbGF0Zm9ybSBkZXZpY2UgZGF0YSBmb3IgUFhBIFNESENJCisgKiBA
bWF4X3NwZWVkOiBUaGUgbWF4aW11bSBzcGVlZCBzdXBwb3J0ZWQuCisgKiBAcHhhX3F1aXJrczog
c3BlY2lmaWMgcXVpcmsgb2YgcHhhCisqLworc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSB7CisJ
dW5zaWduZWQgaW50CW1heF9zcGVlZDsKKwl1bnNpZ25lZCBpbnQJcHhhX3F1aXJrOworfTsKKwor
I2VuZGlmIC8qIF9fUExBVF9QWEFfU0RIQ0lfSCAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9LY29uZmlnIGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCmluZGV4IDZmMTJkNWQuLjQw
YWEzYmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZworKysgYi9kcml2ZXJz
L21tYy9ob3N0L0tjb25maWcKQEAgLTE1OCw2ICsxNTgsMTggQEAgY29uZmlnIE1NQ19TREhDSV9T
M0MKIAogCSAgSWYgdW5zdXJlLCBzYXkgTi4KIAorY29uZmlnIE1NQ19TREhDSV9QWEEKKwl0cmlz
dGF0ZSAiTWFydmVsbCBQWEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyIHN1cHBv
cnQiCisJZGVwZW5kcyBvbiBBUkNIX1BYQSB8fCBBUkNIX01NUAorCXNlbGVjdCBNTUNfU0RIQ0kK
KwlzZWxlY3QgTU1DX1NESENJX0lPX0FDQ0VTU09SUworCWhlbHAKKwkgIFRoaXMgc2VsZWN0cyB0
aGUgTWFydmVsbChSKSBQWEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyLgorCSAg
SWYgeW91IGhhdmUgYSBQWEExNjgvUFhBOTEwL01NUDIgcGxhdGZvcm0gd2l0aCBTRCBIb3N0IENv
bnRyb2xsZXIgYW5kIGEKKwkgIGNhcmQgc2xvdCxzYXkgWSBvciBNIGhlcmUuCisKKwkgIElmIHVu
c3VyZSwgc2F5IE4uCisKIGNvbmZpZyBNTUNfU0RIQ0lfU1BFQVIKIAl0cmlzdGF0ZSAiU0RIQ0kg
c3VwcG9ydCBvbiBTVCBTUEVBciBwbGF0Zm9ybSIKIAlkZXBlbmRzIG9uIE1NQ19TREhDSSAmJiBQ
TEFUX1NQRUFSCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlIGIvZHJpdmVy
cy9tbWMvaG9zdC9NYWtlZmlsZQppbmRleCBlZjMyYzMyLi41Y2RjN2MwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL21tYy9ob3N0L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUK
QEAgLTksNiArOSw3IEBAIG9iai0kKENPTkZJR19NTUNfTVhDKQkJKz0gbXhjbW1jLm8KIG9iai0k
KENPTkZJR19NTUNfU0RIQ0kpCQkrPSBzZGhjaS5vCiBvYmotJChDT05GSUdfTU1DX1NESENJX01W
KQkrPSBzZGhjaS1tdi5vCiBvYmotJChDT05GSUdfTU1DX1NESENJX1BDSSkJKz0gc2RoY2ktcGNp
Lm8KK29iai0kKENPTkZJR19NTUNfU0RIQ0lfUFhBKQkrPSBzZGhjaS1weGEubwogb2JqLSQoQ09O
RklHX01NQ19TREhDSV9TM0MpCSs9IHNkaGNpLXMzYy5vCiBvYmotJChDT05GSUdfTU1DX1NESENJ
X1NQRUFSKQkrPSBzZGhjaS1zcGVhci5vCiBvYmotJChDT05GSUdfTU1DX1dCU0QpCQkrPSB3YnNk
Lm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXB4YS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjNm
NjhjNjcKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCkBA
IC0wLDAgKzEsMjU5IEBACisvKiBsaW51eC9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCisg
KgorICogQ29weXJpZ2h0IChDKSAyMDEwIE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKiAg
ICAgIAlaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KKyAqCQlLZXZpbiBX
YW5nIDxkd2FuZzRAbWFydmVsbC5jb20+CisgKgkJTWluZ3dlaSBXYW5nIDxtd3dhbmdAbWFydmVs
bC5jb20+CisgKgkJUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KKyAqCQlNYXJr
IEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIg
YXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICovCisK
Ky8qIFN1cHBvcnRzOgorICogU0RIQ0kgc3VwcG9ydCBmb3IgTU1QMi9QWEE5MTAvUFhBMTY4Cisg
KgorICogUmVmZXIgc2RoY2ktczNjLmMKKyAqLworCisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4K
KyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9tbWMv
aG9zdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+Cisj
aW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVkZSA8cGxhdC9zZGhjaS5oPgorI2luY2x1ZGUg
InNkaGNpLmgiCisKKyNkZWZpbmUgRFJJVkVSX05BTUUJInNkaGNpLXB4YSIKKworI2RlZmluZSBT
RF9GSUZPX1BBUkFNCQkweDEwNAorI2RlZmluZSBESVNfUEFEX1NEX0NMS19HQVRFCTB4NDAwCisK
K3N0cnVjdCBzZGhjaV9weGEgeworCXN0cnVjdCBzZGhjaV9ob3N0CQkqaG9zdDsKKwlzdHJ1Y3Qg
c2RoY2lfcHhhX3BsYXRkYXRhCSpwZGF0YTsKKwlzdHJ1Y3QgY2xrCQkJKmNsazsKKwlzdHJ1Y3Qg
cmVzb3VyY2UJCQkqcmVzOworCisJdTggY2xrX2VuYWJsZTsKK307CisKKy8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogU0RIQ0kgY29yZSBjYWxsYmFja3Mg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KK3N0YXRpYyB2b2lk
IHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQor
eworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJdTMyIHRtcCA9
IDA7CisKKwlpZiAoY2xvY2sgPT0gMCkgeworCQlpZiAocHhhLT5jbGtfZW5hYmxlKSB7CisJCQlj
bGtfZGlzYWJsZShweGEtPmNsayk7CisJCQlweGEtPmNsa19lbmFibGUgPSAwOworCQl9CisJfSBl
bHNlIHsKKwkJaWYgKDAgPT0gcHhhLT5jbGtfZW5hYmxlKSB7CisJCQlpZiAocHhhLT5wZGF0YS0+
cHhhX3F1aXJrCisJCQkJCSYgUFhBX1FVSVJLX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7CisJCQkJ
dG1wID0gcmVhZGwoaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7CisJCQkJdG1wIHw9IERJ
U19QQURfU0RfQ0xLX0dBVEU7CisJCQkJd3JpdGVsKHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfRklG
T19QQVJBTSk7CisJCQl9CisJCQljbGtfZW5hYmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xrX2Vu
YWJsZSA9IDE7CisJCX0KKwl9Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX3B4
YV9vcHMgPSB7CisJLnNldF9jbG9jayA9IHNldF9jbG9jaywKK307CisKKy8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogRGV2aWNlIHByb2JpbmcvcmVtb3Zh
bCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KKworc3RhdGljIGlu
dCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cit7CisJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRhdGEgPSBwZGV2LT5kZXYucGxhdGZv
cm1fZGF0YTsKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2OworCXN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0ID0gTlVMTDsKKwlzdHJ1Y3QgcmVzb3VyY2UgKmlvbWVtID0gTlVMTDsKKwlz
dHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBOVUxMOworCWludCByZXQsIGlycTsKKworCWlycSA9IHBs
YXRmb3JtX2dldF9pcnEocGRldiwgMCk7CisJaWYgKGlycSA8IDApIHsKKwkJZGV2X2VycihkZXYs
ICJubyBpcnEgc3BlY2lmaWVkXG4iKTsKKwkJcmV0dXJuIGlycTsKKwl9CisKKwlpb21lbSA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7CisJaWYgKCFpb21l
bSkgeworCQlkZXZfZXJyKGRldiwgIm5vIG1lbW9yeSBzcGVjaWZpZWRcbiIpOworCQlyZXR1cm4g
LUVOT0VOVDsKKwl9CisKKwlob3N0ID0gc2RoY2lfYWxsb2NfaG9zdCgmcGRldi0+ZGV2LCBzaXpl
b2Yoc3RydWN0IHNkaGNpX3B4YSkpOworCWlmIChJU19FUlIoaG9zdCkpIHsKKwkJZGV2X2Vycihk
ZXYsICJmYWlsZWQgdG8gYWxsb2MgaG9zdFxuIik7CisJCXJldCA9IFBUUl9FUlIoaG9zdCk7CisJ
CWdvdG8gb3V0OworCX0KKworCXB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJcHhhLT5ob3N0ID0g
aG9zdDsKKwlweGEtPnBkYXRhID0gcGRhdGE7CisJcHhhLT5jbGtfZW5hYmxlID0gMDsKKworCXB4
YS0+Y2xrID0gY2xrX2dldChkZXYsICJQWEEtU0RIQ0xLIik7CisJaWYgKElTX0VSUihweGEtPmNs
aykpIHsKKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGlvIGNsb2NrXG4iKTsKKwkJcmV0
ID0gUFRSX0VSUihweGEtPmNsayk7CisJCWdvdG8gb3V0OworCX0KKworCXB4YS0+cmVzID0gcmVx
dWVzdF9tZW1fcmVnaW9uKGlvbWVtLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShpb21lbSksCisJCW1t
Y19ob3N0bmFtZShob3N0LT5tbWMpKTsKKwlpZiAoIXB4YS0+cmVzKSB7CisJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImNhbm5vdCByZXF1ZXN0IHJlZ2lvblxuIik7CisJCXJldCA9IC1FQlVTWTsKKwkJ
Z290byBvdXQ7CisJfQorCisJaG9zdC0+aW9hZGRyID0gaW9yZW1hcChpb21lbS0+c3RhcnQsIHJl
c291cmNlX3NpemUoaW9tZW0pKTsKKwlpZiAoIWhvc3QtPmlvYWRkcikgeworCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVtYXAgcmVnaXN0ZXJzXG4iKTsKKwkJcmV0ID0gLUVOT01F
TTsKKwkJZ290byBvdXQ7CisJfQorCisJaG9zdC0+aHdfbmFtZSA9ICJNTUMiOworCWhvc3QtPm9w
cyA9ICZzZGhjaV9weGFfb3BzOworCWhvc3QtPmlycSA9IGlycTsKKwlob3N0LT5xdWlya3MgPSBT
REhDSV9RVUlSS19CUk9LRU5fQURNQSB8IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsK
KworCWlmIChwZGF0YS0+cHhhX3F1aXJrICYgUFhBX1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElP
TikKKwkJaG9zdC0+cXVpcmtzIHw9IFNESENJX1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTjsK
KworCXJldCA9IHNkaGNpX2FkZF9ob3N0KGhvc3QpOworCWlmIChyZXQpIHsKKwkJZGV2X2Vycigm
cGRldi0+ZGV2LCAiZmFpbGVkIHRvIGFkZCBob3N0XG4iKTsKKwkJZ290byBvdXQ7CisJfQorCisJ
aWYgKHB4YS0+cGRhdGEtPm1heF9zcGVlZCkKKwkJaG9zdC0+bW1jLT5mX21heCA9IHB4YS0+cGRh
dGEtPm1heF9zcGVlZDsKKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOworCisJ
cmV0dXJuIDA7CitvdXQ6CisJaWYgKGhvc3QpIHsKKwkJaWYgKGhvc3QtPmlvYWRkcikKKwkJCWlv
dW5tYXAoaG9zdC0+aW9hZGRyKTsKKwkJaWYgKHB4YS0+cmVzKQorCQkJcmVsZWFzZV9tZW1fcmVn
aW9uKHB4YS0+cmVzLT5zdGFydCwKKwkJCQkJcmVzb3VyY2Vfc2l6ZShweGEtPnJlcykpOworCQlz
ZGhjaV9mcmVlX2hvc3QoaG9zdCk7CisJfQorCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlu
dCBfX2RldmV4aXQgc2RoY2lfcHhhX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQoreworCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRl
dik7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKwlpbnQgZGVh
ZCA9IDA7CisJdTMyIHNjcmF0Y2g7CisKKwlpZiAoaG9zdCkgeworCQlzY3JhdGNoID0gcmVhZGwo
aG9zdC0+aW9hZGRyICsgU0RIQ0lfSU5UX1NUQVRVUyk7CisJCWlmIChzY3JhdGNoID09ICh1MzIp
LTEpCisJCQlkZWFkID0gMTsKKworCQlzZGhjaV9yZW1vdmVfaG9zdChob3N0LCBkZWFkKTsKKwor
CQlpZiAoaG9zdC0+aW9hZGRyKQorCQkJaW91bm1hcChob3N0LT5pb2FkZHIpOworCQlpZiAocHhh
LT5yZXMpCisJCQlyZWxlYXNlX21lbV9yZWdpb24ocHhhLT5yZXMtPnN0YXJ0LAorCQkJCQlyZXNv
dXJjZV9zaXplKHB4YS0+cmVzKSk7CisJCWlmIChweGEtPmNsa19lbmFibGUpIHsKKwkJCWNsa19k
aXNhYmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xrX2VuYWJsZSA9IDA7CisJCX0KKwkJY2xrX3B1
dChweGEtPmNsayk7CisKKwkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOworCQlwbGF0Zm9ybV9zZXRf
ZHJ2ZGF0YShwZGV2LCBOVUxMKTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKworI2lmZGVmIENPTkZJ
R19QTQorc3RhdGljIGludCBzZGhjaV9weGFfc3VzcGVuZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpkZXYpCit7CisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YSh0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KSk7CisKKwlyZXR1cm4gc2RoY2lfc3VzcGVuZF9ob3N0
KGhvc3QsIHN0YXRlKTsKK30KKworc3RhdGljIGludCBzZGhjaV9weGFfcmVzdW1lKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKHRvX3BsYXRmb3JtX2RldmljZShkZXYpKTsKKworCXJldHVybiBzZGhj
aV9yZXN1bWVfaG9zdChob3N0KTsKK30KKyNlbHNlCisjZGVmaW5lIHNkaGNpX3B4YV9zdXNwZW5k
CU5VTEwKKyNkZWZpbmUgc2RoY2lfcHhhX3Jlc3VtZQlOVUxMCisjZW5kaWYKKworc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIHNkaGNpX3B4YV9wbV9vcHMgPSB7CisJLnN1c3BlbmQJPSBz
ZGhjaV9weGFfc3VzcGVuZCwKKwkucmVzdW1lCQk9IHNkaGNpX3B4YV9yZXN1bWUsCit9OworCisK
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNkaGNpX3B4YV9kcml2ZXIgPSB7CisJLnBy
b2JlCQk9IHNkaGNpX3B4YV9wcm9iZSwKKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKHNkaGNpX3B4
YV9yZW1vdmUpLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9IERSSVZFUl9OQU1FLAorCQkub3du
ZXIJPSBUSElTX01PRFVMRSwKKwkJLnBtID0gJnNkaGNpX3B4YV9wbV9vcHMsCisJfSwKK307CisK
Ky8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogRHJpdmVy
IGluaXQvZXhpdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8KKworc3RhdGljIGludCBfX2luaXQgc2RoY2lfcHhhX2luaXQodm9pZCkKK3sKKwlyZXR1cm4g
cGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZzZGhjaV9weGFfZHJpdmVyKTsKK30KKworc3RhdGlj
IHZvaWQgX19leGl0IHNkaGNpX3B4YV9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3Vu
cmVnaXN0ZXIoJnNkaGNpX3B4YV9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChzZGhjaV9weGFf
aW5pdCk7Cittb2R1bGVfZXhpdChzZGhjaV9weGFfZXhpdCk7CisKK01PRFVMRV9ERVNDUklQVElP
TigiU0RIIGNvbnRyb2xsZXIgZHJpdmVyIGZvciBQWEExNjgvUFhBOTEwL01NUDIiKTsKK01PRFVM
RV9BVVRIT1IoIlpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPiIpOworTU9E
VUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwotLSAKMS43LjAuNAoK
--002215048fb7a4bb7104915d7cfa--
