From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH V4 1/1]MMC: add support of sdhci-pxa driver
Date: Mon, 25 Oct 2010 06:00:37 -0400
Message-ID: <AANLkTi=kS7YV4B0OEHNfm1hjCAsgeUHB7cMR10yBwMRF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00163684828368be9c04936e10ed
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0JYKAj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2010 06:00:39 -0400
Received: by fxm16 with SMTP id 16so2728878fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 25 Oct 2010 03:00:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: "eric.y.miao" <eric.y.miao@gmail.com>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>

--00163684828368be9c04936e10ed
Content-Type: text/plain; charset=ISO-8859-1

Hi, Chris

Add default working speed in this version, thanks.

>From 2c03c2e0bf53ad958fd74eb39ededf55cf7a1878 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH 1/3] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  257 ++++++++++++++++++++++++++++++++
 4 files changed, 302 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-pxa.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
new file mode 100644
index 0000000..38e86ad
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
+/* pxa specific flag */
+/* Require clock free running */
+#define	PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+
+/**
+ * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
+ * @max_speed: The maximum speed supported.
+ * @quirks: quirks of specific device
+ * @flags: flags for platfrom requirement
+*/
+struct sdhci_pxa_platdata {
+	unsigned int	max_speed;
+	unsigned int	quirks;
+	unsigned int	flags;
+};
+
+#endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c9c2520..c387402 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -155,6 +155,18 @@ config MMC_SDHCI_S3C

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
index 6c4ac67..7b645ff 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..d52e971
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,257 @@
+/* linux/drivers/mmc/host/sdhci-pxa.c
+ *
+ * Copyright (C) 2010 Marvell International Ltd.
+ *		Zhangfei Gao <zhangfei.gao@marvell.com>
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
+			if (pxa->pdata->flags
+					& PXA_FLAG_DISABLE_CLOCK_GATING) {
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
+		return PTR_ERR(host);
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
+	if (pdata->quirks)
+		host->quirks |= pdata->quirks;
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto out;
+	}
+
+	if (pxa->pdata->max_speed)
+		host->mmc->f_max = pxa->pdata->max_speed;
+	else
+		host->mmc->f_max = 50000000;
+
+
+	platform_set_drvdata(pdev, host);
+
+	return 0;
+out:
+	if (host) {
+		clk_put(pxa->clk);
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
+static int sdhci_pxa_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static struct platform_driver sdhci_pxa_driver = {
+	.probe		= sdhci_pxa_probe,
+	.remove		= __devexit_p(sdhci_pxa_remove),
+	.suspend	= sdhci_pxa_suspend,
+	.resume		= sdhci_pxa_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
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

--00163684828368be9c04936e10ed
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfpw0k1i0

RnJvbSAyYzAzYzJlMGJmNTNhZDk1OGZkNzRlYjM5ZWRlZGY1NWNmN2ExODc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8zXSBtbWM6IGFkZCBzdXBwb3J0IG9mIHNkaGNpLXB4YSBkcml2ZXIKCglTdXBwb3J0IE1hcnZl
bGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3QgQ29udHJvbGxlcgoKU2lnbmVkLW9mZi1ieTog
WmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CkFja2VkLWJ5OiBIYW9qaWFu
IFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1w
eGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggfCAgIDMyICsrKysKIGRyaXZlcnMvbW1jL2hvc3QvS2Nv
bmZpZyAgICAgICAgICAgICAgIHwgICAxMiArKwogZHJpdmVycy9tbWMvaG9zdC9NYWtlZmlsZSAg
ICAgICAgICAgICAgfCAgICAxICsKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAgICAg
ICAgIHwgIDI1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFu
Z2VkLCAzMDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaAogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9w
bGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUv
cGxhdC9zZGhjaS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjM4ZTg2YWQK
LS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2ku
aApAQCAtMCwwICsxLDMyIEBACisvKiBsaW51eC9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3Bs
YXQvc2RoY2kuaAorICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwKKyAqCVpoYW5nZmVpIEdh
byA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgorICoKKyAqIFBYQSBQbGF0Zm9ybSAtIFNESENJ
IHBsYXRmb3JtIGRhdGEgZGVmaW5pdGlvbnMKKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIg
YXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorKi8KKwor
I2lmbmRlZiBfX1BMQVRfUFhBX1NESENJX0gKKyNkZWZpbmUgX19QTEFUX1BYQV9TREhDSV9ICisK
Ky8qIHB4YSBzcGVjaWZpYyBmbGFnICovCisvKiBSZXF1aXJlIGNsb2NrIGZyZWUgcnVubmluZyAq
LworI2RlZmluZQlQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElORyAoMTw8MCkKKworLyoqCisg
KiBzdHJ1Y3QgcHhhX3NkaGNpX3BsYXRkYXRhKCkgLSBQbGF0Zm9ybSBkZXZpY2UgZGF0YSBmb3Ig
UFhBIFNESENJCisgKiBAbWF4X3NwZWVkOiBUaGUgbWF4aW11bSBzcGVlZCBzdXBwb3J0ZWQuCisg
KiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2aWNlCisgKiBAZmxhZ3M6IGZsYWdzIGZv
ciBwbGF0ZnJvbSByZXF1aXJlbWVudAorKi8KK3N0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgewor
CXVuc2lnbmVkIGludAltYXhfc3BlZWQ7CisJdW5zaWduZWQgaW50CXF1aXJrczsKKwl1bnNpZ25l
ZCBpbnQJZmxhZ3M7Cit9OworCisjZW5kaWYgLyogX19QTEFUX1BYQV9TREhDSV9IICovCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25m
aWcKaW5kZXggYzljMjUyMC4uYzM4NzQwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9L
Y29uZmlnCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZwpAQCAtMTU1LDYgKzE1NSwxOCBA
QCBjb25maWcgTU1DX1NESENJX1MzQwogCiAJICBJZiB1bnN1cmUsIHNheSBOLgogCitjb25maWcg
TU1DX1NESENJX1BYQQorCXRyaXN0YXRlICJNYXJ2ZWxsIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBI
b3N0IENvbnRyb2xsZXIgc3VwcG9ydCIKKwlkZXBlbmRzIG9uIEFSQ0hfUFhBIHx8IEFSQ0hfTU1Q
CisJc2VsZWN0IE1NQ19TREhDSQorCXNlbGVjdCBNTUNfU0RIQ0lfSU9fQUNDRVNTT1JTCisJaGVs
cAorCSAgVGhpcyBzZWxlY3RzIHRoZSBNYXJ2ZWxsKFIpIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBI
b3N0IENvbnRyb2xsZXIuCisJICBJZiB5b3UgaGF2ZSBhIFBYQTE2OC9QWEE5MTAvTU1QMiBwbGF0
Zm9ybSB3aXRoIFNEIEhvc3QgQ29udHJvbGxlciBhbmQgYQorCSAgY2FyZCBzbG90LHNheSBZIG9y
IE0gaGVyZS4KKworCSAgSWYgdW5zdXJlLCBzYXkgTi4KKwogY29uZmlnIE1NQ19TREhDSV9TUEVB
UgogCXRyaXN0YXRlICJTREhDSSBzdXBwb3J0IG9uIFNUIFNQRUFyIHBsYXRmb3JtIgogCWRlcGVu
ZHMgb24gTU1DX1NESENJICYmIFBMQVRfU1BFQVIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hv
c3QvTWFrZWZpbGUgYi9kcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlCmluZGV4IDZjNGFjNjcuLjdi
NjQ1ZmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9NYWtlZmlsZQpAQCAtOCw2ICs4LDcgQEAgb2JqLSQoQ09ORklHX01NQ19JTVgp
CQkrPSBpbXhtbWMubwogb2JqLSQoQ09ORklHX01NQ19NWEMpCQkrPSBteGNtbWMubwogb2JqLSQo
Q09ORklHX01NQ19TREhDSSkJCSs9IHNkaGNpLm8KIG9iai0kKENPTkZJR19NTUNfU0RIQ0lfUENJ
KQkrPSBzZGhjaS1wY2kubworb2JqLSQoQ09ORklHX01NQ19TREhDSV9QWEEpCSs9IHNkaGNpLXB4
YS5vCiBvYmotJChDT05GSUdfTU1DX1NESENJX1MzQykJKz0gc2RoY2ktczNjLm8KIG9iai0kKENP
TkZJR19NTUNfU0RIQ0lfU1BFQVIpCSs9IHNkaGNpLXNwZWFyLm8KIG9iai0kKENPTkZJR19NTUNf
V0JTRCkJCSs9IHdic2QubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEu
YyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uZDUyZTk3MQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktcHhhLmMKQEAgLTAsMCArMSwyNTcgQEAKKy8qIGxpbnV4L2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktcHhhLmMKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMTAgTWFydmVsbCBJbnRlcm5hdGlv
bmFsIEx0ZC4KKyAqCQlaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KKyAq
CQlLZXZpbiBXYW5nIDxkd2FuZzRAbWFydmVsbC5jb20+CisgKgkJTWluZ3dlaSBXYW5nIDxtd3dh
bmdAbWFydmVsbC5jb20+CisgKgkJUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4K
KyAqCQlNYXJrIEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4KKyAqCisgKiBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2
ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
LgorICovCisKKy8qIFN1cHBvcnRzOgorICogU0RIQ0kgc3VwcG9ydCBmb3IgTU1QMi9QWEE5MTAv
UFhBMTY4CisgKgorICogUmVmZXIgc2RoY2ktczNjLmMKKyAqLworCisjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxs
aW51eC9tbWMvaG9zdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgorI2luY2x1ZGUgPGxpbnV4
L2lvLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVkZSA8cGxhdC9zZGhjaS5oPgor
I2luY2x1ZGUgInNkaGNpLmgiCisKKyNkZWZpbmUgRFJJVkVSX05BTUUJInNkaGNpLXB4YSIKKwor
I2RlZmluZSBTRF9GSUZPX1BBUkFNCQkweDEwNAorI2RlZmluZSBESVNfUEFEX1NEX0NMS19HQVRF
CTB4NDAwCisKK3N0cnVjdCBzZGhjaV9weGEgeworCXN0cnVjdCBzZGhjaV9ob3N0CQkqaG9zdDsK
KwlzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhCSpwZGF0YTsKKwlzdHJ1Y3QgY2xrCQkJKmNsazsK
KwlzdHJ1Y3QgcmVzb3VyY2UJCQkqcmVzOworCisJdTggY2xrX2VuYWJsZTsKK307CisKKy8qKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogU0RIQ0kgY29yZSBj
YWxsYmFja3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KK3N0
YXRpYyB2b2lkIHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50
IGNsb2NrKQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJ
dTMyIHRtcCA9IDA7CisKKwlpZiAoY2xvY2sgPT0gMCkgeworCQlpZiAocHhhLT5jbGtfZW5hYmxl
KSB7CisJCQljbGtfZGlzYWJsZShweGEtPmNsayk7CisJCQlweGEtPmNsa19lbmFibGUgPSAwOwor
CQl9CisJfSBlbHNlIHsKKwkJaWYgKDAgPT0gcHhhLT5jbGtfZW5hYmxlKSB7CisJCQlpZiAocHhh
LT5wZGF0YS0+ZmxhZ3MKKwkJCQkJJiBQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElORykgewor
CQkJCXRtcCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOworCQkJCXRtcCB8
PSBESVNfUEFEX1NEX0NMS19HQVRFOworCQkJCXdyaXRlbCh0bXAsIGhvc3QtPmlvYWRkciArIFNE
X0ZJRk9fUEFSQU0pOworCQkJfQorCQkJY2xrX2VuYWJsZShweGEtPmNsayk7CisJCQlweGEtPmNs
a19lbmFibGUgPSAxOworCQl9CisJfQorfQorCitzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhj
aV9weGFfb3BzID0geworCS5zZXRfY2xvY2sgPSBzZXRfY2xvY2ssCit9OworCisvKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKipcCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqIERldmljZSBwcm9iaW5nL3Jl
bW92YWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqCitcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCisKK3N0YXRp
YyBpbnQgX19kZXZpbml0IHNkaGNpX3B4YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQoreworCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKnBkYXRhID0gcGRldi0+ZGV2LnBs
YXRmb3JtX2RhdGE7CisJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKKwlzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCA9IE5VTEw7CisJc3RydWN0IHJlc291cmNlICppb21lbSA9IE5VTEw7
CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gTlVMTDsKKwlpbnQgcmV0LCBpcnE7CisKKwlpcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOworCWlmIChpcnEgPCAwKSB7CisJCWRldl9lcnIo
ZGV2LCAibm8gaXJxIHNwZWNpZmllZFxuIik7CisJCXJldHVybiBpcnE7CisJfQorCisJaW9tZW0g
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOworCWlmICgh
aW9tZW0pIHsKKwkJZGV2X2VycihkZXYsICJubyBtZW1vcnkgc3BlY2lmaWVkXG4iKTsKKwkJcmV0
dXJuIC1FTk9FTlQ7CisJfQorCisJaG9zdCA9IHNkaGNpX2FsbG9jX2hvc3QoJnBkZXYtPmRldiwg
c2l6ZW9mKHN0cnVjdCBzZGhjaV9weGEpKTsKKwlpZiAoSVNfRVJSKGhvc3QpKSB7CisJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGFsbG9jIGhvc3RcbiIpOworCQlyZXR1cm4gUFRSX0VSUihob3N0
KTsKKwl9CisKKwlweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCXB4YS0+aG9zdCA9IGhvc3Q7CisJ
cHhhLT5wZGF0YSA9IHBkYXRhOworCXB4YS0+Y2xrX2VuYWJsZSA9IDA7CisKKwlweGEtPmNsayA9
IGNsa19nZXQoZGV2LCAiUFhBLVNESENMSyIpOworCWlmIChJU19FUlIocHhhLT5jbGspKSB7CisJ
CWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBpbyBjbG9ja1xuIik7CisJCXJldCA9IFBUUl9F
UlIocHhhLT5jbGspOworCQlnb3RvIG91dDsKKwl9CisKKwlweGEtPnJlcyA9IHJlcXVlc3RfbWVt
X3JlZ2lvbihpb21lbS0+c3RhcnQsIHJlc291cmNlX3NpemUoaW9tZW0pLAorCQltbWNfaG9zdG5h
bWUoaG9zdC0+bW1jKSk7CisJaWYgKCFweGEtPnJlcykgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJjYW5ub3QgcmVxdWVzdCByZWdpb25cbiIpOworCQlyZXQgPSAtRUJVU1k7CisJCWdvdG8gb3V0
OworCX0KKworCWhvc3QtPmlvYWRkciA9IGlvcmVtYXAoaW9tZW0tPnN0YXJ0LCByZXNvdXJjZV9z
aXplKGlvbWVtKSk7CisJaWYgKCFob3N0LT5pb2FkZHIpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIHJlbWFwIHJlZ2lzdGVyc1xuIik7CisJCXJldCA9IC1FTk9NRU07CisJCWdv
dG8gb3V0OworCX0KKworCWhvc3QtPmh3X25hbWUgPSAiTU1DIjsKKwlob3N0LT5vcHMgPSAmc2Ro
Y2lfcHhhX29wczsKKwlob3N0LT5pcnEgPSBpcnE7CisJaG9zdC0+cXVpcmtzID0gU0RIQ0lfUVVJ
UktfQlJPS0VOX0FETUEgfCBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9VVF9WQUw7CisKKwlpZiAo
cGRhdGEtPnF1aXJrcykKKwkJaG9zdC0+cXVpcmtzIHw9IHBkYXRhLT5xdWlya3M7CisKKwlyZXQg
PSBzZGhjaV9hZGRfaG9zdChob3N0KTsKKwlpZiAocmV0KSB7CisJCWRldl9lcnIoJnBkZXYtPmRl
diwgImZhaWxlZCB0byBhZGQgaG9zdFxuIik7CisJCWdvdG8gb3V0OworCX0KKworCWlmIChweGEt
PnBkYXRhLT5tYXhfc3BlZWQpCisJCWhvc3QtPm1tYy0+Zl9tYXggPSBweGEtPnBkYXRhLT5tYXhf
c3BlZWQ7CisJZWxzZQorCQlob3N0LT5tbWMtPmZfbWF4ID0gNTAwMDAwMDA7CisKKworCXBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOworCisJcmV0dXJuIDA7CitvdXQ6CisJaWYgKGhv
c3QpIHsKKwkJY2xrX3B1dChweGEtPmNsayk7CisJCWlmIChob3N0LT5pb2FkZHIpCisJCQlpb3Vu
bWFwKGhvc3QtPmlvYWRkcik7CisJCWlmIChweGEtPnJlcykKKwkJCXJlbGVhc2VfbWVtX3JlZ2lv
bihweGEtPnJlcy0+c3RhcnQsCisJCQkJCXJlc291cmNlX3NpemUocHhhLT5yZXMpKTsKKwkJc2Ro
Y2lfZnJlZV9ob3N0KGhvc3QpOworCX0KKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQg
X19kZXZleGl0IHNkaGNpX3B4YV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
K3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
OworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJaW50IGRlYWQg
PSAwOworCXUzMiBzY3JhdGNoOworCisJaWYgKGhvc3QpIHsKKwkJc2NyYXRjaCA9IHJlYWRsKGhv
c3QtPmlvYWRkciArIFNESENJX0lOVF9TVEFUVVMpOworCQlpZiAoc2NyYXRjaCA9PSAodTMyKS0x
KQorCQkJZGVhZCA9IDE7CisKKwkJc2RoY2lfcmVtb3ZlX2hvc3QoaG9zdCwgZGVhZCk7CisKKwkJ
aWYgKGhvc3QtPmlvYWRkcikKKwkJCWlvdW5tYXAoaG9zdC0+aW9hZGRyKTsKKwkJaWYgKHB4YS0+
cmVzKQorCQkJcmVsZWFzZV9tZW1fcmVnaW9uKHB4YS0+cmVzLT5zdGFydCwKKwkJCQkJcmVzb3Vy
Y2Vfc2l6ZShweGEtPnJlcykpOworCQlpZiAocHhhLT5jbGtfZW5hYmxlKSB7CisJCQljbGtfZGlz
YWJsZShweGEtPmNsayk7CisJCQlweGEtPmNsa19lbmFibGUgPSAwOworCQl9CisJCWNsa19wdXQo
cHhhLT5jbGspOworCisJCXNkaGNpX2ZyZWVfaG9zdChob3N0KTsKKwkJcGxhdGZvcm1fc2V0X2Ry
dmRhdGEocGRldiwgTlVMTCk7CisJfQorCisJcmV0dXJuIDA7Cit9CisKKyNpZmRlZiBDT05GSUdf
UE0KK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
ZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBw
bGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJcmV0dXJuIHNkaGNpX3N1c3BlbmRfaG9zdCho
b3N0LCBzdGF0ZSk7Cit9CisKK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3Jlc3VtZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpkZXYpCit7CisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9y
bV9nZXRfZHJ2ZGF0YShkZXYpOworCisJcmV0dXJuIHNkaGNpX3Jlc3VtZV9ob3N0KGhvc3QpOwor
fQorI2Vsc2UKKyNkZWZpbmUgc2RoY2lfcHhhX3N1c3BlbmQJTlVMTAorI2RlZmluZSBzZGhjaV9w
eGFfcmVzdW1lCU5VTEwKKyNlbmRpZgorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBz
ZGhjaV9weGFfZHJpdmVyID0geworCS5wcm9iZQkJPSBzZGhjaV9weGFfcHJvYmUsCisJLnJlbW92
ZQkJPSBfX2RldmV4aXRfcChzZGhjaV9weGFfcmVtb3ZlKSwKKwkuc3VzcGVuZAk9IHNkaGNpX3B4
YV9zdXNwZW5kLAorCS5yZXN1bWUJCT0gc2RoY2lfcHhhX3Jlc3VtZSwKKwkuZHJpdmVyCQk9IHsK
KwkJLm5hbWUJPSBEUklWRVJfTkFNRSwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJfSwKK307
CisKKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogRHJp
dmVyIGluaXQvZXhpdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKi8KKworc3RhdGljIGludCBfX2luaXQgc2RoY2lfcHhhX2luaXQodm9pZCkKK3sKKwlyZXR1
cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZzZGhjaV9weGFfZHJpdmVyKTsKK30KKworc3Rh
dGljIHZvaWQgX19leGl0IHNkaGNpX3B4YV9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVy
X3VucmVnaXN0ZXIoJnNkaGNpX3B4YV9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChzZGhjaV9w
eGFfaW5pdCk7Cittb2R1bGVfZXhpdChzZGhjaV9weGFfZXhpdCk7CisKK01PRFVMRV9ERVNDUklQ
VElPTigiU0RIIGNvbnRyb2xsZXIgZHJpdmVyIGZvciBQWEExNjgvUFhBOTEwL01NUDIiKTsKK01P
RFVMRV9BVVRIT1IoIlpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPiIpOwor
TU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwotLSAKMS43LjAuNAoK
--00163684828368be9c04936e10ed--
