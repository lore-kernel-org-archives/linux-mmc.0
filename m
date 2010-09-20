From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Mon, 20 Sep 2010 17:46:02 +0800
Message-ID: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485e76e62d08b930490adc71b
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52392 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab0ITJqE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 05:46:04 -0400
Received: by iwn5 with SMTP id 5so4137431iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 02:46:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--001485e76e62d08b930490adc71b
Content-Type: text/plain; charset=ISO-8859-1

Hi, Chris,

Here is patch to support pxa168(aspen)/pxa910(ttc)/mmp2, the
controller follow sdh 3.0.
Currently verified sd, Micron 16G emmc need some workaround, 8G is OK,
marvell 8787 would be verified later.
Help review.

>From 76c61b86ae8ae6b84030a31ec4ae7c08214de18b Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Change-Id: I9f22b5a5664d4dd1b6cd2f8f4ef15a373ce123ff

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  253 ++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-pxa.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
new file mode 100644
index 0000000..55e1c85
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
+#define __PLAT_PXA_SDHCI_H __FILE__
+
+/* pxa specific quirks */
+/* Card alwayes wired to host, like emmc */
+#define PXA_QUIRK_BROKEN_CARD_DETECTION (1<<0)
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
index 697bbfe..3a9f7fe 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)	+= sdhci-mv.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..3e091c1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,253 @@
+/* linux/drivers/mmc/host/sdhci-pxa.c
+ *
+ * Copyright 2010 Marvell
+ *      Zhangfei Gao <zhangfei.gao@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Supports:
+ * SDHCI support for MMP2/PXA910/PXA168
+ *
+ * Based on sdhci-platfm.c
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
+	struct resource *iomem;
+	struct sdhci_pxa *pxa;
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
+		clk_disable(pxa->clk);
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
+	int ret = 0;
+
+	ret = sdhci_suspend_host(host, state);
+
+	return ret;
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+	int ret = 0;
+
+	ret = sdhci_resume_host(host);
+
+	return ret;
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static struct platform_driver sdhci_pxa_driver = {
+	.probe		= sdhci_pxa_probe,
+	.remove		= sdhci_pxa_remove,
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

--001485e76e62d08b930490adc71b
Content-Type: application/octet-stream;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geb50gj20

RnJvbSA3NmM2MWI4NmFlOGFlNmI4NDAzMGEzMWVjNGFlN2MwODIxNGRlMThiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogYWRkIHN1cHBvcnQgb2Ygc2RoY2ktcHhhIGRyaXZlcgoKCVN1cHBvcnQgTWFydmVsbCBQ
WEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyCgpDaGFuZ2UtSWQ6IEk5ZjIyYjVh
NTY2NGQ0ZGQxYjZjZDJmOGY0ZWYxNWEzNzNjZTEyM2ZmCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2Zl
aSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4YS9p
bmNsdWRlL3BsYXQvc2RoY2kuaCB8ICAgMzIgKysrKwogZHJpdmVycy9tbWMvaG9zdC9LY29uZmln
ICAgICAgICAgICAgICAgfCAgIDEyICsrCiBkcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlICAgICAg
ICAgICAgICB8ICAgIDEgKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAgICAg
fCAgMjUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI5OCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQt
cHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0
L3NkaGNpLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNTVlMWM4NQotLS0g
L2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCkBA
IC0wLDAgKzEsMzIgQEAKKy8qIGxpbnV4L2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9z
ZGhjaS5oCisgKgorICogQ29weXJpZ2h0IDIwMTAgTWFydmVsbAorICoJWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogUFhBIFBsYXRmb3JtIC0gU0RIQ0kgcGxh
dGZvcm0gZGF0YSBkZWZpbml0aW9ucworICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwor
ICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisqLworCisjaWZu
ZGVmIF9fUExBVF9QWEFfU0RIQ0lfSAorI2RlZmluZSBfX1BMQVRfUFhBX1NESENJX0ggX19GSUxF
X18KKworLyogcHhhIHNwZWNpZmljIHF1aXJrcyAqLworLyogQ2FyZCBhbHdheWVzIHdpcmVkIHRv
IGhvc3QsIGxpa2UgZW1tYyAqLworI2RlZmluZSBQWEFfUVVJUktfQlJPS0VOX0NBUkRfREVURUNU
SU9OICgxPDwwKQorLyogUmVxdWlyZSBjbG9jayBmcmVlIHJ1bm5pbmcgKi8KKyNkZWZpbmUJUFhB
X1FVSVJLX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HICgxPDwxKQorCisvKioKKyAqIHN0cnVjdCBweGFf
c2RoY2lfcGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQWEEgU0RIQ0kKKyAq
IEBtYXhfc3BlZWQ6IFRoZSBtYXhpbXVtIHNwZWVkIHN1cHBvcnRlZC4KKyAqIEBweGFfcXVpcmtz
OiBzcGVjaWZpYyBxdWlyayBvZiBweGEKKyovCitzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhIHsK
Kwl1bnNpZ25lZCBpbnQJbWF4X3NwZWVkOworCXVuc2lnbmVkIGludAlweGFfcXVpcms7Cit9Owor
CisjZW5kaWYgLyogX19QTEFUX1BYQV9TREhDSV9IICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9ob3N0L0tjb25maWcgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcKaW5kZXggNmYxMmQ1ZC4u
NDBhYTNiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCisrKyBiL2RyaXZl
cnMvbW1jL2hvc3QvS2NvbmZpZwpAQCAtMTU4LDYgKzE1OCwxOCBAQCBjb25maWcgTU1DX1NESENJ
X1MzQwogCiAJICBJZiB1bnN1cmUsIHNheSBOLgogCitjb25maWcgTU1DX1NESENJX1BYQQorCXRy
aXN0YXRlICJNYXJ2ZWxsIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBIb3N0IENvbnRyb2xsZXIgc3Vw
cG9ydCIKKwlkZXBlbmRzIG9uIEFSQ0hfUFhBIHx8IEFSQ0hfTU1QCisJc2VsZWN0IE1NQ19TREhD
SQorCXNlbGVjdCBNTUNfU0RIQ0lfSU9fQUNDRVNTT1JTCisJaGVscAorCSAgVGhpcyBzZWxlY3Rz
IHRoZSBNYXJ2ZWxsKFIpIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBIb3N0IENvbnRyb2xsZXIuCisJ
ICBJZiB5b3UgaGF2ZSBhIFBYQTE2OC9QWEE5MTAvTU1QMiBwbGF0Zm9ybSB3aXRoIFNEIEhvc3Qg
Q29udHJvbGxlciBhbmQgYQorCSAgY2FyZCBzbG90LHNheSBZIG9yIE0gaGVyZS4KKworCSAgSWYg
dW5zdXJlLCBzYXkgTi4KKwogY29uZmlnIE1NQ19TREhDSV9TUEVBUgogCXRyaXN0YXRlICJTREhD
SSBzdXBwb3J0IG9uIFNUIFNQRUFyIHBsYXRmb3JtIgogCWRlcGVuZHMgb24gTU1DX1NESENJICYm
IFBMQVRfU1BFQVIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUgYi9kcml2
ZXJzL21tYy9ob3N0L01ha2VmaWxlCmluZGV4IDY5N2JiZmUuLjNhOWY3ZmUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9NYWtlZmls
ZQpAQCAtMTMsNiArMTMsNyBAQCBvYmotJChDT05GSUdfTU1DX01YQykJCSs9IG14Y21tYy5vCiBv
YmotJChDT05GSUdfTU1DX1NESENJKQkJKz0gc2RoY2kubwogb2JqLSQoQ09ORklHX01NQ19TREhD
SV9NVikJKz0gc2RoY2ktbXYubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9QQ0kpCSs9IHNkaGNp
LXBjaS5vCitvYmotJChDT05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktcHhhLm8KIG9iai0k
KENPTkZJR19NTUNfU0RIQ0lfUzNDKQkrPSBzZGhjaS1zM2Mubwogb2JqLSQoQ09ORklHX01NQ19T
REhDSV9TUEVBUikJKz0gc2RoY2ktc3BlYXIubwogb2JqLSQoQ09ORklHX01NQ19XQlNEKQkJKz0g
d2JzZC5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1weGEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li4zZTA5MWMxCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEu
YwpAQCAtMCwwICsxLDI1MyBAQAorLyogbGludXgvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEu
YworICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwKKyAqICAgICAgWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFz
CisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLworCisv
KiBTdXBwb3J0czoKKyAqIFNESENJIHN1cHBvcnQgZm9yIE1NUDIvUFhBOTEwL1BYQTE2OAorICoK
KyAqIEJhc2VkIG9uIHNkaGNpLXBsYXRmbS5jCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgv
bW1jL2hvc3QuaD4KKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5o
PgorI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgorI2luY2x1ZGUgPHBsYXQvc2RoY2kuaD4KKyNpbmNs
dWRlICJzZGhjaS5oIgorCisjZGVmaW5lIERSSVZFUl9OQU1FCSJzZGhjaS1weGEiCisKKyNkZWZp
bmUgU0RfRklGT19QQVJBTQkJMHgxMDQKKyNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkweDQw
MAorCitzdHJ1Y3Qgc2RoY2lfcHhhIHsKKwlzdHJ1Y3Qgc2RoY2lfaG9zdAkJKmhvc3Q7CisJc3Ry
dWN0IHNkaGNpX3B4YV9wbGF0ZGF0YQkqcGRhdGE7CisJc3RydWN0IGNsawkJCSpjbGs7CisJc3Ry
dWN0IHJlc291cmNlCQkJKnJlczsKKworCXU4IGNsa19lbmFibGU7Cit9OworCisvKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKipcCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqIFNESENJIGNvcmUgY2FsbGJh
Y2tzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqCitcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCitzdGF0aWMg
dm9pZCBzZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9j
aykKK3sKKwlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCXUzMiB0
bXAgPSAwOworCisJaWYgKGNsb2NrID09IDApIHsKKwkJaWYgKHB4YS0+Y2xrX2VuYWJsZSkgewor
CQkJY2xrX2Rpc2FibGUocHhhLT5jbGspOworCQkJcHhhLT5jbGtfZW5hYmxlID0gMDsKKwkJfQor
CX0gZWxzZSB7CisJCWlmICgwID09IHB4YS0+Y2xrX2VuYWJsZSkgeworCQkJaWYgKHB4YS0+cGRh
dGEtPnB4YV9xdWlyaworCQkJCQkmIFBYQV9RVUlSS19ESVNBQkxFX0NMT0NLX0dBVElORykgewor
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
c2RoY2lfaG9zdCAqaG9zdCA9IE5VTEw7CisJc3RydWN0IHJlc291cmNlICppb21lbTsKKwlzdHJ1
Y3Qgc2RoY2lfcHhhICpweGE7CisJaW50IHJldCwgaXJxOworCisJaXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCAwKTsKKwlpZiAoaXJxIDwgMCkgeworCQlkZXZfZXJyKGRldiwgIm5vIGlycSBz
cGVjaWZpZWRcbiIpOworCQlyZXR1cm4gaXJxOworCX0KKworCWlvbWVtID0gcGxhdGZvcm1fZ2V0
X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKKwlpZiAoIWlvbWVtKSB7CisJCWRl
dl9lcnIoZGV2LCAibm8gbWVtb3J5IHNwZWNpZmllZFxuIik7CisJCXJldHVybiAtRU5PRU5UOwor
CX0KKworCWhvc3QgPSBzZGhjaV9hbGxvY19ob3N0KCZwZGV2LT5kZXYsIHNpemVvZihzdHJ1Y3Qg
c2RoY2lfcHhhKSk7CisJaWYgKElTX0VSUihob3N0KSkgeworCQlkZXZfZXJyKGRldiwgImZhaWxl
ZCB0byBhbGxvYyBob3N0XG4iKTsKKwkJcmV0ID0gUFRSX0VSUihob3N0KTsKKwkJZ290byBvdXQ7
CisJfQorCisJcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKwlweGEtPmhvc3QgPSBob3N0OworCXB4
YS0+cGRhdGEgPSBwZGF0YTsKKwlweGEtPmNsa19lbmFibGUgPSAwOworCisJcHhhLT5jbGsgPSBj
bGtfZ2V0KGRldiwgIlBYQS1TREhDTEsiKTsKKwlpZiAoSVNfRVJSKHB4YS0+Y2xrKSkgeworCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgaW8gY2xvY2tcbiIpOworCQlyZXQgPSBQVFJfRVJS
KHB4YS0+Y2xrKTsKKwkJZ290byBvdXQ7CisJfQorCisJcHhhLT5yZXMgPSByZXF1ZXN0X21lbV9y
ZWdpb24oaW9tZW0tPnN0YXJ0LCByZXNvdXJjZV9zaXplKGlvbWVtKSwKKwkJbW1jX2hvc3RuYW1l
KGhvc3QtPm1tYykpOworCWlmICghcHhhLT5yZXMpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAi
Y2Fubm90IHJlcXVlc3QgcmVnaW9uXG4iKTsKKwkJcmV0ID0gLUVCVVNZOworCQlnb3RvIG91dDsK
Kwl9CisKKwlob3N0LT5pb2FkZHIgPSBpb3JlbWFwKGlvbWVtLT5zdGFydCwgcmVzb3VyY2Vfc2l6
ZShpb21lbSkpOworCWlmICghaG9zdC0+aW9hZGRyKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwg
ImZhaWxlZCB0byByZW1hcCByZWdpc3RlcnNcbiIpOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3Rv
IG91dDsKKwl9CisKKwlob3N0LT5od19uYW1lID0gIk1NQyI7CisJaG9zdC0+b3BzID0gJnNkaGNp
X3B4YV9vcHM7CisJaG9zdC0+aXJxID0gaXJxOworCWhvc3QtPnF1aXJrcyA9IFNESENJX1FVSVJL
X0JST0tFTl9BRE1BIHwgU0RIQ0lfUVVJUktfQlJPS0VOX1RJTUVPVVRfVkFMOworCisJaWYgKHBk
YXRhLT5weGFfcXVpcmsgJiBQWEFfUVVJUktfQlJPS0VOX0NBUkRfREVURUNUSU9OKQorCQlob3N0
LT5xdWlya3MgfD0gU0RIQ0lfUVVJUktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCisJcmV0ID0g
c2RoY2lfYWRkX2hvc3QoaG9zdCk7CisJaWYgKHJldCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJmYWlsZWQgdG8gYWRkIGhvc3RcbiIpOworCQlnb3RvIG91dDsKKwl9CisKKwlpZiAocHhhLT5w
ZGF0YS0+bWF4X3NwZWVkKQorCQlob3N0LT5tbWMtPmZfbWF4ID0gcHhhLT5wZGF0YS0+bWF4X3Nw
ZWVkOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgaG9zdCk7CisKKwlyZXR1cm4gMDsK
K291dDoKKwlpZiAoaG9zdCkgeworCQlpZiAoaG9zdC0+aW9hZGRyKQorCQkJaW91bm1hcChob3N0
LT5pb2FkZHIpOworCQlpZiAocHhhLT5yZXMpCisJCQlyZWxlYXNlX21lbV9yZWdpb24ocHhhLT5y
ZXMtPnN0YXJ0LAorCQkJCQlyZXNvdXJjZV9zaXplKHB4YS0+cmVzKSk7CisJCXNkaGNpX2ZyZWVf
aG9zdChob3N0KTsKKwl9CisKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IF9fZGV2ZXhp
dCBzZGhjaV9weGFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3Ry
dWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlzdHJ1
Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCWludCBkZWFkID0gMDsKKwl1
MzIgc2NyYXRjaDsKKworCWlmIChob3N0KSB7CisJCXNjcmF0Y2ggPSByZWFkbChob3N0LT5pb2Fk
ZHIgKyBTREhDSV9JTlRfU1RBVFVTKTsKKwkJaWYgKHNjcmF0Y2ggPT0gKHUzMiktMSkKKwkJCWRl
YWQgPSAxOworCisJCXNkaGNpX3JlbW92ZV9ob3N0KGhvc3QsIGRlYWQpOworCisJCWlmIChob3N0
LT5pb2FkZHIpCisJCQlpb3VubWFwKGhvc3QtPmlvYWRkcik7CisJCWlmIChweGEtPnJlcykKKwkJ
CXJlbGVhc2VfbWVtX3JlZ2lvbihweGEtPnJlcy0+c3RhcnQsCisJCQkJCXJlc291cmNlX3NpemUo
cHhhLT5yZXMpKTsKKwkJY2xrX2Rpc2FibGUocHhhLT5jbGspOworCQljbGtfcHV0KHB4YS0+Y2xr
KTsKKworCQlzZGhjaV9mcmVlX2hvc3QoaG9zdCk7CisJCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIE5VTEwpOworCX0KKworCXJldHVybiAwOworfQorCisjaWZkZWYgQ09ORklHX1BNCitzdGF0
aWMgaW50IHNkaGNpX3B4YV9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwgcG1f
bWVzc2FnZV90IHN0YXRlKQoreworCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gcGxhdGZvcm1f
Z2V0X2RydmRhdGEoZGV2KTsKKwlpbnQgcmV0ID0gMDsKKworCXJldCA9IHNkaGNpX3N1c3BlbmRf
aG9zdChob3N0LCBzdGF0ZSk7CisKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IHNkaGNp
X3B4YV9yZXN1bWUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQoreworCXN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKKwlpbnQgcmV0ID0gMDsK
KworCXJldCA9IHNkaGNpX3Jlc3VtZV9ob3N0KGhvc3QpOworCisJcmV0dXJuIHJldDsKK30KKyNl
bHNlCisjZGVmaW5lIHNkaGNpX3B4YV9zdXNwZW5kCU5VTEwKKyNkZWZpbmUgc2RoY2lfcHhhX3Jl
c3VtZQlOVUxMCisjZW5kaWYKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc2RoY2lf
cHhhX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gc2RoY2lfcHhhX3Byb2JlLAorCS5yZW1vdmUJCT0g
c2RoY2lfcHhhX3JlbW92ZSwKKwkuc3VzcGVuZAk9IHNkaGNpX3B4YV9zdXNwZW5kLAorCS5yZXN1
bWUJCT0gc2RoY2lfcHhhX3Jlc3VtZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSBEUklWRVJf
TkFNRSwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJfSwKK307CisKKy8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKlwKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorICogRHJpdmVyIGluaXQvZXhpdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICoKK1wqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KKworc3RhdGljIGlu
dCBfX2luaXQgc2RoY2lfcHhhX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVy
X3JlZ2lzdGVyKCZzZGhjaV9weGFfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IHNk
aGNpX3B4YV9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnNkaGNp
X3B4YV9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChzZGhjaV9weGFfaW5pdCk7Cittb2R1bGVf
ZXhpdChzZGhjaV9weGFfZXhpdCk7CisKK01PRFVMRV9ERVNDUklQVElPTigiU0RIIGNvbnRyb2xs
ZXIgZHJpdmVyIGZvciBQWEExNjgvUFhBOTEwL01NUDIiKTsKK01PRFVMRV9BVVRIT1IoIlpoYW5n
ZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQ
TCB2MiIpOwotLSAKMS43LjAuNAoK
--001485e76e62d08b930490adc71b--
