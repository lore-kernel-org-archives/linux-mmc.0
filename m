From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Mon, 18 Oct 2010 08:32:46 -0400
Message-ID: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=002215048e07a411aa0492e35ff4
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48335 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab0JRMdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 08:33:22 -0400
Received: by mail-iw0-f174.google.com with SMTP id 35so1119613iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Oct 2010 05:32:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

--002215048e07a411aa0492e35ff4
Content-Type: text/plain; charset=ISO-8859-1

Update with comments from Matt and Eric.
Test with sd and emmc.

>From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH] mmc: add support of sdhci-pxa driver

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
index 0000000..93b9237
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,259 @@
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

--002215048e07a411aa0492e35ff4
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfg1a2j70

RnJvbSBlNWRkNTU0ZWQ0ZDM0ODhhODNkOWE0ODg4ZDY4ZDFkODU0ODJmNzQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogYWRkIHN1cHBvcnQgb2Ygc2RoY2ktcHhhIGRyaXZlcgoKCVN1cHBvcnQgTWFydmVsbCBQ
WEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyCgpTaWduZWQtb2ZmLWJ5OiBaaGFu
Z2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4
YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCB8ICAgMzIgKysrKwogZHJpdmVycy9tbWMvaG9zdC9LY29u
ZmlnICAgICAgICAgICAgICAgfCAgIDEyICsrCiBkcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlICAg
ICAgICAgICAgICB8ICAgIDEgKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAg
ICAgfCAgMjU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5n
ZWQsIDMwNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3Bs
YXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9w
bGF0L3NkaGNpLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMzhlODZhZAot
LS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5o
CkBAIC0wLDAgKzEsMzIgQEAKKy8qIGxpbnV4L2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxh
dC9zZGhjaS5oCisgKgorICogQ29weXJpZ2h0IDIwMTAgTWFydmVsbAorICoJWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogUFhBIFBsYXRmb3JtIC0gU0RIQ0kg
cGxhdGZvcm0gZGF0YSBkZWZpbml0aW9ucworICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBh
cworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisqLworCisj
aWZuZGVmIF9fUExBVF9QWEFfU0RIQ0lfSAorI2RlZmluZSBfX1BMQVRfUFhBX1NESENJX0gKKwor
LyogcHhhIHNwZWNpZmljIGZsYWcgKi8KKy8qIFJlcXVpcmUgY2xvY2sgZnJlZSBydW5uaW5nICov
CisjZGVmaW5lCVBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HICgxPDwwKQorCisvKioKKyAq
IHN0cnVjdCBweGFfc2RoY2lfcGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQ
WEEgU0RIQ0kKKyAqIEBtYXhfc3BlZWQ6IFRoZSBtYXhpbXVtIHNwZWVkIHN1cHBvcnRlZC4KKyAq
IEBxdWlya3M6IHF1aXJrcyBvZiBzcGVjaWZpYyBkZXZpY2UKKyAqIEBmbGFnczogZmxhZ3MgZm9y
IHBsYXRmcm9tIHJlcXVpcmVtZW50CisqLworc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSB7CisJ
dW5zaWduZWQgaW50CW1heF9zcGVlZDsKKwl1bnNpZ25lZCBpbnQJcXVpcmtzOworCXVuc2lnbmVk
IGludAlmbGFnczsKK307CisKKyNlbmRpZiAvKiBfX1BMQVRfUFhBX1NESENJX0ggKi8KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZp
ZwppbmRleCBjOWMyNTIwLi5jMzg3NDAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L0tj
b25maWcKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCkBAIC0xNTUsNiArMTU1LDE4IEBA
IGNvbmZpZyBNTUNfU0RIQ0lfUzNDCiAKIAkgIElmIHVuc3VyZSwgc2F5IE4uCiAKK2NvbmZpZyBN
TUNfU0RIQ0lfUFhBCisJdHJpc3RhdGUgIk1hcnZlbGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhv
c3QgQ29udHJvbGxlciBzdXBwb3J0IgorCWRlcGVuZHMgb24gQVJDSF9QWEEgfHwgQVJDSF9NTVAK
KwlzZWxlY3QgTU1DX1NESENJCisJc2VsZWN0IE1NQ19TREhDSV9JT19BQ0NFU1NPUlMKKwloZWxw
CisJICBUaGlzIHNlbGVjdHMgdGhlIE1hcnZlbGwoUikgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhv
c3QgQ29udHJvbGxlci4KKwkgIElmIHlvdSBoYXZlIGEgUFhBMTY4L1BYQTkxMC9NTVAyIHBsYXRm
b3JtIHdpdGggU0QgSG9zdCBDb250cm9sbGVyIGFuZCBhCisJICBjYXJkIHNsb3Qsc2F5IFkgb3Ig
TSBoZXJlLgorCisJICBJZiB1bnN1cmUsIHNheSBOLgorCiBjb25maWcgTU1DX1NESENJX1NQRUFS
CiAJdHJpc3RhdGUgIlNESENJIHN1cHBvcnQgb24gU1QgU1BFQXIgcGxhdGZvcm0iCiAJZGVwZW5k
cyBvbiBNTUNfU0RIQ0kgJiYgUExBVF9TUEVBUgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9z
dC9NYWtlZmlsZSBiL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKaW5kZXggNmM0YWM2Ny4uN2I2
NDVmZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9NYWtlZmlsZQorKysgYi9kcml2ZXJz
L21tYy9ob3N0L01ha2VmaWxlCkBAIC04LDYgKzgsNyBAQCBvYmotJChDT05GSUdfTU1DX0lNWCkJ
CSs9IGlteG1tYy5vCiBvYmotJChDT05GSUdfTU1DX01YQykJCSs9IG14Y21tYy5vCiBvYmotJChD
T05GSUdfTU1DX1NESENJKQkJKz0gc2RoY2kubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9QQ0kp
CSs9IHNkaGNpLXBjaS5vCitvYmotJChDT05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktcHhh
Lm8KIG9iai0kKENPTkZJR19NTUNfU0RIQ0lfUzNDKQkrPSBzZGhjaS1zM2Mubwogb2JqLSQoQ09O
RklHX01NQ19TREhDSV9TUEVBUikJKz0gc2RoY2ktc3BlYXIubwogb2JqLSQoQ09ORklHX01NQ19X
QlNEKQkJKz0gd2JzZC5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi45M2I5MjM3Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1weGEuYwpAQCAtMCwwICsxLDI1OSBAQAorLyogbGludXgvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1weGEuYworICoKKyAqIENvcHlyaWdodCAoQykgMjAxMCBNYXJ2ZWxsIEludGVybmF0aW9u
YWwgTHRkLgorICoJCVpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgorICoJ
CUtldmluIFdhbmcgPGR3YW5nNEBtYXJ2ZWxsLmNvbT4KKyAqCQlNaW5nd2VpIFdhbmcgPG13d2Fu
Z0BtYXJ2ZWxsLmNvbT4KKyAqCQlQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgor
ICoJCU1hcmsgQnJvd24gPG1hcmtiQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Cisg
KiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZl
cnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24u
CisgKi8KKworLyogU3VwcG9ydHM6CisgKiBTREhDSSBzdXBwb3J0IGZvciBNTVAyL1BYQTkxMC9Q
WEExNjgKKyAqCisgKiBSZWZlciBzZGhjaS1zM2MuYworICovCisKKyNpbmNsdWRlIDxsaW51eC9k
ZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxp
bnV4L21tYy9ob3N0Lmg+CisjaW5jbHVkZSA8bGludXgvY2xrLmg+CisjaW5jbHVkZSA8bGludXgv
aW8uaD4KKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4KKyNpbmNsdWRlIDxwbGF0L3NkaGNpLmg+Cisj
aW5jbHVkZSAic2RoY2kuaCIKKworI2RlZmluZSBEUklWRVJfTkFNRQkic2RoY2ktcHhhIgorCisj
ZGVmaW5lIFNEX0ZJRk9fUEFSQU0JCTB4MTA0CisjZGVmaW5lIERJU19QQURfU0RfQ0xLX0dBVEUJ
MHg0MDAKKworc3RydWN0IHNkaGNpX3B4YSB7CisJc3RydWN0IHNkaGNpX2hvc3QJCSpob3N0Owor
CXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEJKnBkYXRhOworCXN0cnVjdCBjbGsJCQkqY2xrOwor
CXN0cnVjdCByZXNvdXJjZQkJCSpyZXM7CisKKwl1OCBjbGtfZW5hYmxlOworfTsKKworLyoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqXAorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisgKiBTREhDSSBjb3JlIGNh
bGxiYWNrcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICoKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorXCoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworc3Rh
dGljIHZvaWQgc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQg
Y2xvY2spCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKwl1
MzIgdG1wID0gMDsKKworCWlmIChjbG9jayA9PSAwKSB7CisJCWlmIChweGEtPmNsa19lbmFibGUp
IHsKKwkJCWNsa19kaXNhYmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xrX2VuYWJsZSA9IDA7CisJ
CX0KKwl9IGVsc2UgeworCQlpZiAoMCA9PSBweGEtPmNsa19lbmFibGUpIHsKKwkJCWlmIChweGEt
PnBkYXRhLT5mbGFncworCQkJCQkmIFBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7CisJ
CQkJdG1wID0gcmVhZGwoaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7CisJCQkJdG1wIHw9
IERJU19QQURfU0RfQ0xLX0dBVEU7CisJCQkJd3JpdGVsKHRtcCwgaG9zdC0+aW9hZGRyICsgU0Rf
RklGT19QQVJBTSk7CisJCQl9CisJCQljbGtfZW5hYmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xr
X2VuYWJsZSA9IDE7CisJCX0KKwl9Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNp
X3B4YV9vcHMgPSB7CisJLnNldF9jbG9jayA9IHNldF9jbG9jaywKK307CisKKy8qKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogRGV2aWNlIHByb2JpbmcvcmVt
b3ZhbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
CisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KKworc3RhdGlj
IGludCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCit7CisJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRhdGEgPSBwZGV2LT5kZXYucGxh
dGZvcm1fZGF0YTsKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2OworCXN0cnVjdCBz
ZGhjaV9ob3N0ICpob3N0ID0gTlVMTDsKKwlzdHJ1Y3QgcmVzb3VyY2UgKmlvbWVtID0gTlVMTDsK
KwlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBOVUxMOworCWludCByZXQsIGlycTsKKworCWlycSA9
IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7CisJaWYgKGlycSA8IDApIHsKKwkJZGV2X2Vycihk
ZXYsICJubyBpcnEgc3BlY2lmaWVkXG4iKTsKKwkJcmV0dXJuIGlycTsKKwl9CisKKwlpb21lbSA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7CisJaWYgKCFp
b21lbSkgeworCQlkZXZfZXJyKGRldiwgIm5vIG1lbW9yeSBzcGVjaWZpZWRcbiIpOworCQlyZXR1
cm4gLUVOT0VOVDsKKwl9CisKKwlob3N0ID0gc2RoY2lfYWxsb2NfaG9zdCgmcGRldi0+ZGV2LCBz
aXplb2Yoc3RydWN0IHNkaGNpX3B4YSkpOworCWlmIChJU19FUlIoaG9zdCkpIHsKKwkJZGV2X2Vy
cihkZXYsICJmYWlsZWQgdG8gYWxsb2MgaG9zdFxuIik7CisJCXJldHVybiBQVFJfRVJSKGhvc3Qp
OworCX0KKworCXB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJcHhhLT5ob3N0ID0gaG9zdDsKKwlw
eGEtPnBkYXRhID0gcGRhdGE7CisJcHhhLT5jbGtfZW5hYmxlID0gMDsKKworCXB4YS0+Y2xrID0g
Y2xrX2dldChkZXYsICJQWEEtU0RIQ0xLIik7CisJaWYgKElTX0VSUihweGEtPmNsaykpIHsKKwkJ
ZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGlvIGNsb2NrXG4iKTsKKwkJcmV0ID0gUFRSX0VS
UihweGEtPmNsayk7CisJCWdvdG8gb3V0OworCX0KKworCXB4YS0+cmVzID0gcmVxdWVzdF9tZW1f
cmVnaW9uKGlvbWVtLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShpb21lbSksCisJCW1tY19ob3N0bmFt
ZShob3N0LT5tbWMpKTsKKwlpZiAoIXB4YS0+cmVzKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwg
ImNhbm5vdCByZXF1ZXN0IHJlZ2lvblxuIik7CisJCXJldCA9IC1FQlVTWTsKKwkJZ290byBvdXQ7
CisJfQorCisJaG9zdC0+aW9hZGRyID0gaW9yZW1hcChpb21lbS0+c3RhcnQsIHJlc291cmNlX3Np
emUoaW9tZW0pKTsKKwlpZiAoIWhvc3QtPmlvYWRkcikgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJmYWlsZWQgdG8gcmVtYXAgcmVnaXN0ZXJzXG4iKTsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290
byBvdXQ7CisJfQorCisJaG9zdC0+aHdfbmFtZSA9ICJNTUMiOworCWhvc3QtPm9wcyA9ICZzZGhj
aV9weGFfb3BzOworCWhvc3QtPmlycSA9IGlycTsKKwlob3N0LT5xdWlya3MgPSBTREhDSV9RVUlS
S19CUk9LRU5fQURNQSB8IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsKKworCWlmIChw
ZGF0YS0+cXVpcmtzKQorCQlob3N0LT5xdWlya3MgfD0gcGRhdGEtPnF1aXJrczsKKworCXJldCA9
IHNkaGNpX2FkZF9ob3N0KGhvc3QpOworCWlmIChyZXQpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIGFkZCBob3N0XG4iKTsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKHB4YS0+
cGRhdGEtPm1heF9zcGVlZCkKKwkJaG9zdC0+bW1jLT5mX21heCA9IHB4YS0+cGRhdGEtPm1heF9z
cGVlZDsKKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOworCisJcmV0dXJuIDA7
CitvdXQ6CisJaWYgKGhvc3QpIHsKKwkJY2xrX3B1dChweGEtPmNsayk7CisJCWlmIChob3N0LT5p
b2FkZHIpCisJCQlpb3VubWFwKGhvc3QtPmlvYWRkcik7CisJCWlmIChweGEtPnJlcykKKwkJCXJl
bGVhc2VfbWVtX3JlZ2lvbihweGEtPnJlcy0+c3RhcnQsCisJCQkJCXJlc291cmNlX3NpemUocHhh
LT5yZXMpKTsKKwkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOworCX0KKworCXJldHVybiByZXQ7Cit9
CisKK3N0YXRpYyBpbnQgX19kZXZleGl0IHNkaGNpX3B4YV9yZW1vdmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9z
dCk7CisJaW50IGRlYWQgPSAwOworCXUzMiBzY3JhdGNoOworCisJaWYgKGhvc3QpIHsKKwkJc2Ny
YXRjaCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNESENJX0lOVF9TVEFUVVMpOworCQlpZiAoc2Ny
YXRjaCA9PSAodTMyKS0xKQorCQkJZGVhZCA9IDE7CisKKwkJc2RoY2lfcmVtb3ZlX2hvc3QoaG9z
dCwgZGVhZCk7CisKKwkJaWYgKGhvc3QtPmlvYWRkcikKKwkJCWlvdW5tYXAoaG9zdC0+aW9hZGRy
KTsKKwkJaWYgKHB4YS0+cmVzKQorCQkJcmVsZWFzZV9tZW1fcmVnaW9uKHB4YS0+cmVzLT5zdGFy
dCwKKwkJCQkJcmVzb3VyY2Vfc2l6ZShweGEtPnJlcykpOworCQlpZiAocHhhLT5jbGtfZW5hYmxl
KSB7CisJCQljbGtfZGlzYWJsZShweGEtPmNsayk7CisJCQlweGEtPmNsa19lbmFibGUgPSAwOwor
CQl9CisJCWNsa19wdXQocHhhLT5jbGspOworCisJCXNkaGNpX2ZyZWVfaG9zdChob3N0KTsKKwkJ
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisJfQorCisJcmV0dXJuIDA7Cit9CisK
KyNpZmRlZiBDT05GSUdfUE0KK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3N1c3BlbmQoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqZGV2KQoreworCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEodG9fcGxhdGZvcm1fZGV2aWNlKGRldikpOworCisJcmV0dXJuIHNkaGNp
X3N1c3BlbmRfaG9zdChob3N0LCBzdGF0ZSk7Cit9CisKK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3Jl
c3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCit7CisJc3RydWN0IHNkaGNpX2hvc3Qg
Kmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YSh0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KSk7CisK
KwlyZXR1cm4gc2RoY2lfcmVzdW1lX2hvc3QoaG9zdCk7Cit9CisjZWxzZQorI2RlZmluZSBzZGhj
aV9weGFfc3VzcGVuZAlOVUxMCisjZGVmaW5lIHNkaGNpX3B4YV9yZXN1bWUJTlVMTAorI2VuZGlm
CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBzZGhjaV9weGFfcG1fb3BzID0gewor
CS5zdXNwZW5kCT0gc2RoY2lfcHhhX3N1c3BlbmQsCisJLnJlc3VtZQkJPSBzZGhjaV9weGFfcmVz
dW1lLAorfTsKKworCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzZGhjaV9weGFfZHJp
dmVyID0geworCS5wcm9iZQkJPSBzZGhjaV9weGFfcHJvYmUsCisJLnJlbW92ZQkJPSBfX2RldmV4
aXRfcChzZGhjaV9weGFfcmVtb3ZlKSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSBEUklWRVJf
TkFNRSwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJCS5wbSA9ICZzZGhjaV9weGFfcG1fb3Bz
LAorCX0sCit9OworCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKipcCisgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICoKKyAqIERyaXZlciBpbml0L2V4aXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCitcKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCisKK3N0YXRpYyBpbnQgX19pbml0IHNkaGNpX3B4YV9pbml0KHZvaWQp
Cit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdpc3Rlcigmc2RoY2lfcHhhX2RyaXZlcik7
Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBzZGhjaV9weGFfZXhpdCh2b2lkKQoreworCXBsYXRm
b3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZzZGhjaV9weGFfZHJpdmVyKTsKK30KKworbW9kdWxlX2lu
aXQoc2RoY2lfcHhhX2luaXQpOworbW9kdWxlX2V4aXQoc2RoY2lfcHhhX2V4aXQpOworCitNT0RV
TEVfREVTQ1JJUFRJT04oIlNESCBjb250cm9sbGVyIGRyaXZlciBmb3IgUFhBMTY4L1BYQTkxMC9N
TVAyIik7CitNT0RVTEVfQVVUSE9SKCJaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxs
LmNvbT4iKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsKLS0gCjEuNy4wLjQKCg==
--002215048e07a411aa0492e35ff4--
