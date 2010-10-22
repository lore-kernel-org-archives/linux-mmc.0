From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 10:09:03 -0400
Message-ID: <AANLkTikg3-5whd65aZmK4sJSg+vvNke0fSkqSQJ1B5vf@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
	<20101021145249.GA13095@void.printf.net>
	<AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
	<20101022095814.GA13073@void.printf.net>
	<20101022110457.GA14136@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba6141d05508aa0493352ffe
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101022110457.GA14136@void.printf.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: Matt Fleming <matt@console-pimps.org>, "eric.y.miao" <eric.y.miao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--90e6ba6141d05508aa0493352ffe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 22, 2010 at 7:04 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Oct 22, 2010 at 10:58:14AM +0100, Chris Ball wrote:
> [...]
>> +#ifdef CONFIG_PM
>> +static int sdhci_pxa_suspend(struct platform_device *dev)
>> +{
>> + =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(to_platform_d=
evice(dev));
>> +
>> + =A0 =A0 return sdhci_suspend_host(host, state);
>> +}
>> +
>> +static int sdhci_pxa_resume(struct platform_device *dev)
>> +{
>
> These prototypes are not correct, leading to:
>
> =A0CC [M] =A0drivers/mmc/host/sdhci-pxa.o
> drivers/mmc/host/sdhci-pxa.c: In function =91sdhci_pxa_suspend=92:
> drivers/mmc/host/sdhci-pxa.c:205: warning: initialization from incompatib=
le pointer type
> drivers/mmc/host/sdhci-pxa.c:207: error: =91state=92 undeclared (first us=
e in this function)
> drivers/mmc/host/sdhci-pxa.c:207: error: (Each undeclared identifier is r=
eported only once
> drivers/mmc/host/sdhci-pxa.c:207: error: for each function it appears in.=
)
> drivers/mmc/host/sdhci-pxa.c: In function =91sdhci_pxa_resume=92:
> drivers/mmc/host/sdhci-pxa.c:212: warning: initialization from incompatib=
le pointer type
> drivers/mmc/host/sdhci-pxa.c: At top level:
> drivers/mmc/host/sdhci-pxa.c:222: warning: initialization from incompatib=
le pointer type
> drivers/mmc/host/sdhci-pxa.c:223: warning: initialization from incompatib=
le pointer type
>
> when compiled with CONFIG_PM=3Dy.
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

Sorry, forgot open CONFIG_PM.
Updated patch, thanks

>From 88e7f028433fe87b211bf3d75b54261979d0d176 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  254 ++++++++++++++++++++++++++++=
++++
 4 files changed, 299 insertions(+), 0 deletions(-)
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
@@ -8,6 +8,7 @@ obj-$(CONFIG_MMC_IMX)		+=3D imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+=3D sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..abf208c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,254 @@
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
+/*************************************************************************=
****\
+ *                                                                        =
   *
+ * SDHCI core callbacks                                                   =
   *
+ *                                                                        =
   *
+\*************************************************************************=
****/
+static void set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pxa *pxa =3D sdhci_priv(host);
+	u32 tmp =3D 0;
+
+	if (clock =3D=3D 0) {
+		if (pxa->clk_enable) {
+			clk_disable(pxa->clk);
+			pxa->clk_enable =3D 0;
+		}
+	} else {
+		if (0 =3D=3D pxa->clk_enable) {
+			if (pxa->pdata->flags
+					& PXA_FLAG_DISABLE_CLOCK_GATING) {
+				tmp =3D readl(host->ioaddr + SD_FIFO_PARAM);
+				tmp |=3D DIS_PAD_SD_CLK_GATE;
+				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
+			}
+			clk_enable(pxa->clk);
+			pxa->clk_enable =3D 1;
+		}
+	}
+}
+
+static struct sdhci_ops sdhci_pxa_ops =3D {
+	.set_clock =3D set_clock,
+};
+
+/*************************************************************************=
****\
+ *                                                                        =
   *
+ * Device probing/removal                                                 =
   *
+ *                                                                        =
   *
+\*************************************************************************=
****/
+
+static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
+{
+	struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data;
+	struct device *dev =3D &pdev->dev;
+	struct sdhci_host *host =3D NULL;
+	struct resource *iomem =3D NULL;
+	struct sdhci_pxa *pxa =3D NULL;
+	int ret, irq;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no irq specified\n");
+		return irq;
+	}
+
+	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		dev_err(dev, "no memory specified\n");
+		return -ENOENT;
+	}
+
+	host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
+	if (IS_ERR(host)) {
+		dev_err(dev, "failed to alloc host\n");
+		return PTR_ERR(host);
+	}
+
+	pxa =3D sdhci_priv(host);
+	pxa->host =3D host;
+	pxa->pdata =3D pdata;
+	pxa->clk_enable =3D 0;
+
+	pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(pxa->clk)) {
+		dev_err(dev, "failed to get io clock\n");
+		ret =3D PTR_ERR(pxa->clk);
+		goto out;
+	}
+
+	pxa->res =3D request_mem_region(iomem->start, resource_size(iomem),
+		mmc_hostname(host->mmc));
+	if (!pxa->res) {
+		dev_err(&pdev->dev, "cannot request region\n");
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	host->ioaddr =3D ioremap(iomem->start, resource_size(iomem));
+	if (!host->ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	host->hw_name =3D "MMC";
+	host->ops =3D &sdhci_pxa_ops;
+	host->irq =3D irq;
+	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL=
;
+
+	if (pdata->quirks)
+		host->quirks |=3D pdata->quirks;
+
+	ret =3D sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add host\n");
+		goto out;
+	}
+
+	if (pxa->pdata->max_speed)
+		host->mmc->f_max =3D pxa->pdata->max_speed;
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
+	struct sdhci_host *host =3D platform_get_drvdata(pdev);
+	struct sdhci_pxa *pxa =3D sdhci_priv(host);
+	int dead =3D 0;
+	u32 scratch;
+
+	if (host) {
+		scratch =3D readl(host->ioaddr + SDHCI_INT_STATUS);
+		if (scratch =3D=3D (u32)-1)
+			dead =3D 1;
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
+			pxa->clk_enable =3D 0;
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
+static int sdhci_pxa_suspend(struct platform_device *dev, pm_message_t sta=
te)
+{
+	struct sdhci_host *host =3D platform_get_drvdata(dev);
+
+	return sdhci_suspend_host(host, state);
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct sdhci_host *host =3D platform_get_drvdata(dev);
+
+	return sdhci_resume_host(host);
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static struct platform_driver sdhci_pxa_driver =3D {
+	.probe		=3D sdhci_pxa_probe,
+	.remove		=3D __devexit_p(sdhci_pxa_remove),
+	.suspend	=3D sdhci_pxa_suspend,
+	.resume		=3D sdhci_pxa_resume,
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+/*************************************************************************=
****\
+ *                                                                        =
   *
+ * Driver init/exit                                                       =
   *
+ *                                                                        =
   *
+\*************************************************************************=
****/
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
--=20
1.7.0.4

--90e6ba6141d05508aa0493352ffe
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfltytue0

RnJvbSA4OGU3ZjAyODQzM2ZlODdiMjExYmYzZDc1YjU0MjYxOTc5ZDBkMTc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogYWRkIHN1cHBvcnQgb2Ygc2RoY2ktcHhhIGRyaXZlcgoKCVN1cHBvcnQgTWFydmVsbCBQ
WEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyCgpTaWduZWQtb2ZmLWJ5OiBaaGFu
Z2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KQWNrZWQtYnk6IEhhb2ppYW4gWmh1
YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4YS9p
bmNsdWRlL3BsYXQvc2RoY2kuaCB8ICAgMzIgKysrKwogZHJpdmVycy9tbWMvaG9zdC9LY29uZmln
ICAgICAgICAgICAgICAgfCAgIDEyICsrCiBkcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlICAgICAg
ICAgICAgICB8ICAgIDEgKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAgICAg
fCAgMjU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI5OSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQt
cHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0
L3NkaGNpLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMzhlODZhZAotLS0g
L2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCkBA
IC0wLDAgKzEsMzIgQEAKKy8qIGxpbnV4L2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9z
ZGhjaS5oCisgKgorICogQ29weXJpZ2h0IDIwMTAgTWFydmVsbAorICoJWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogUFhBIFBsYXRmb3JtIC0gU0RIQ0kgcGxh
dGZvcm0gZGF0YSBkZWZpbml0aW9ucworICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwor
ICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisqLworCisjaWZu
ZGVmIF9fUExBVF9QWEFfU0RIQ0lfSAorI2RlZmluZSBfX1BMQVRfUFhBX1NESENJX0gKKworLyog
cHhhIHNwZWNpZmljIGZsYWcgKi8KKy8qIFJlcXVpcmUgY2xvY2sgZnJlZSBydW5uaW5nICovCisj
ZGVmaW5lCVBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HICgxPDwwKQorCisvKioKKyAqIHN0
cnVjdCBweGFfc2RoY2lfcGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQWEEg
U0RIQ0kKKyAqIEBtYXhfc3BlZWQ6IFRoZSBtYXhpbXVtIHNwZWVkIHN1cHBvcnRlZC4KKyAqIEBx
dWlya3M6IHF1aXJrcyBvZiBzcGVjaWZpYyBkZXZpY2UKKyAqIEBmbGFnczogZmxhZ3MgZm9yIHBs
YXRmcm9tIHJlcXVpcmVtZW50CisqLworc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSB7CisJdW5z
aWduZWQgaW50CW1heF9zcGVlZDsKKwl1bnNpZ25lZCBpbnQJcXVpcmtzOworCXVuc2lnbmVkIGlu
dAlmbGFnczsKK307CisKKyNlbmRpZiAvKiBfX1BMQVRfUFhBX1NESENJX0ggKi8KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZwpp
bmRleCBjOWMyNTIwLi5jMzg3NDAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L0tjb25m
aWcKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCkBAIC0xNTUsNiArMTU1LDE4IEBAIGNv
bmZpZyBNTUNfU0RIQ0lfUzNDCiAKIAkgIElmIHVuc3VyZSwgc2F5IE4uCiAKK2NvbmZpZyBNTUNf
U0RIQ0lfUFhBCisJdHJpc3RhdGUgIk1hcnZlbGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3Qg
Q29udHJvbGxlciBzdXBwb3J0IgorCWRlcGVuZHMgb24gQVJDSF9QWEEgfHwgQVJDSF9NTVAKKwlz
ZWxlY3QgTU1DX1NESENJCisJc2VsZWN0IE1NQ19TREhDSV9JT19BQ0NFU1NPUlMKKwloZWxwCisJ
ICBUaGlzIHNlbGVjdHMgdGhlIE1hcnZlbGwoUikgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3Qg
Q29udHJvbGxlci4KKwkgIElmIHlvdSBoYXZlIGEgUFhBMTY4L1BYQTkxMC9NTVAyIHBsYXRmb3Jt
IHdpdGggU0QgSG9zdCBDb250cm9sbGVyIGFuZCBhCisJICBjYXJkIHNsb3Qsc2F5IFkgb3IgTSBo
ZXJlLgorCisJICBJZiB1bnN1cmUsIHNheSBOLgorCiBjb25maWcgTU1DX1NESENJX1NQRUFSCiAJ
dHJpc3RhdGUgIlNESENJIHN1cHBvcnQgb24gU1QgU1BFQXIgcGxhdGZvcm0iCiAJZGVwZW5kcyBv
biBNTUNfU0RIQ0kgJiYgUExBVF9TUEVBUgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9N
YWtlZmlsZSBiL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKaW5kZXggNmM0YWM2Ny4uN2I2NDVm
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9NYWtlZmlsZQorKysgYi9kcml2ZXJzL21t
Yy9ob3N0L01ha2VmaWxlCkBAIC04LDYgKzgsNyBAQCBvYmotJChDT05GSUdfTU1DX0lNWCkJCSs9
IGlteG1tYy5vCiBvYmotJChDT05GSUdfTU1DX01YQykJCSs9IG14Y21tYy5vCiBvYmotJChDT05G
SUdfTU1DX1NESENJKQkJKz0gc2RoY2kubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9QQ0kpCSs9
IHNkaGNpLXBjaS5vCitvYmotJChDT05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktcHhhLm8K
IG9iai0kKENPTkZJR19NTUNfU0RIQ0lfUzNDKQkrPSBzZGhjaS1zM2Mubwogb2JqLSQoQ09ORklH
X01NQ19TREhDSV9TUEVBUikJKz0gc2RoY2ktc3BlYXIubwogb2JqLSQoQ09ORklHX01NQ19XQlNE
KQkJKz0gd2JzZC5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwLi5hYmYyMDhjCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1weGEuYwpAQCAtMCwwICsxLDI1NCBAQAorLyogbGludXgvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1weGEuYworICoKKyAqIENvcHlyaWdodCAoQykgMjAxMCBNYXJ2ZWxsIEludGVybmF0aW9uYWwg
THRkLgorICoJCVpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgorICoJCUtl
dmluIFdhbmcgPGR3YW5nNEBtYXJ2ZWxsLmNvbT4KKyAqCQlNaW5nd2VpIFdhbmcgPG13d2FuZ0Bt
YXJ2ZWxsLmNvbT4KKyAqCQlQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgorICoJ
CU1hcmsgQnJvd24gPG1hcmtiQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisg
Ki8KKworLyogU3VwcG9ydHM6CisgKiBTREhDSSBzdXBwb3J0IGZvciBNTVAyL1BYQTkxMC9QWEEx
NjgKKyAqCisgKiBSZWZlciBzZGhjaS1zM2MuYworICovCisKKyNpbmNsdWRlIDxsaW51eC9kZWxh
eS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4
L21tYy9ob3N0Lmg+CisjaW5jbHVkZSA8bGludXgvY2xrLmg+CisjaW5jbHVkZSA8bGludXgvaW8u
aD4KKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4KKyNpbmNsdWRlIDxwbGF0L3NkaGNpLmg+CisjaW5j
bHVkZSAic2RoY2kuaCIKKworI2RlZmluZSBEUklWRVJfTkFNRQkic2RoY2ktcHhhIgorCisjZGVm
aW5lIFNEX0ZJRk9fUEFSQU0JCTB4MTA0CisjZGVmaW5lIERJU19QQURfU0RfQ0xLX0dBVEUJMHg0
MDAKKworc3RydWN0IHNkaGNpX3B4YSB7CisJc3RydWN0IHNkaGNpX2hvc3QJCSpob3N0OworCXN0
cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEJKnBkYXRhOworCXN0cnVjdCBjbGsJCQkqY2xrOworCXN0
cnVjdCByZXNvdXJjZQkJCSpyZXM7CisKKwl1OCBjbGtfZW5hYmxlOworfTsKKworLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqXAorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisgKiBTREhDSSBjb3JlIGNhbGxi
YWNrcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICoKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKgorXCoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworc3RhdGlj
IHZvaWQgc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xv
Y2spCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKwl1MzIg
dG1wID0gMDsKKworCWlmIChjbG9jayA9PSAwKSB7CisJCWlmIChweGEtPmNsa19lbmFibGUpIHsK
KwkJCWNsa19kaXNhYmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xrX2VuYWJsZSA9IDA7CisJCX0K
Kwl9IGVsc2UgeworCQlpZiAoMCA9PSBweGEtPmNsa19lbmFibGUpIHsKKwkJCWlmIChweGEtPnBk
YXRhLT5mbGFncworCQkJCQkmIFBYQV9GTEFHX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7CisJCQkJ
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
ZXYsICJmYWlsZWQgdG8gYWxsb2MgaG9zdFxuIik7CisJCXJldHVybiBQVFJfRVJSKGhvc3QpOwor
CX0KKworCXB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJcHhhLT5ob3N0ID0gaG9zdDsKKwlweGEt
PnBkYXRhID0gcGRhdGE7CisJcHhhLT5jbGtfZW5hYmxlID0gMDsKKworCXB4YS0+Y2xrID0gY2xr
X2dldChkZXYsICJQWEEtU0RIQ0xLIik7CisJaWYgKElTX0VSUihweGEtPmNsaykpIHsKKwkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGlvIGNsb2NrXG4iKTsKKwkJcmV0ID0gUFRSX0VSUihw
eGEtPmNsayk7CisJCWdvdG8gb3V0OworCX0KKworCXB4YS0+cmVzID0gcmVxdWVzdF9tZW1fcmVn
aW9uKGlvbWVtLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShpb21lbSksCisJCW1tY19ob3N0bmFtZSho
b3N0LT5tbWMpKTsKKwlpZiAoIXB4YS0+cmVzKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImNh
bm5vdCByZXF1ZXN0IHJlZ2lvblxuIik7CisJCXJldCA9IC1FQlVTWTsKKwkJZ290byBvdXQ7CisJ
fQorCisJaG9zdC0+aW9hZGRyID0gaW9yZW1hcChpb21lbS0+c3RhcnQsIHJlc291cmNlX3NpemUo
aW9tZW0pKTsKKwlpZiAoIWhvc3QtPmlvYWRkcikgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gcmVtYXAgcmVnaXN0ZXJzXG4iKTsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBv
dXQ7CisJfQorCisJaG9zdC0+aHdfbmFtZSA9ICJNTUMiOworCWhvc3QtPm9wcyA9ICZzZGhjaV9w
eGFfb3BzOworCWhvc3QtPmlycSA9IGlycTsKKwlob3N0LT5xdWlya3MgPSBTREhDSV9RVUlSS19C
Uk9LRU5fQURNQSB8IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsKKworCWlmIChwZGF0
YS0+cXVpcmtzKQorCQlob3N0LT5xdWlya3MgfD0gcGRhdGEtPnF1aXJrczsKKworCXJldCA9IHNk
aGNpX2FkZF9ob3N0KGhvc3QpOworCWlmIChyZXQpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAi
ZmFpbGVkIHRvIGFkZCBob3N0XG4iKTsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKHB4YS0+cGRh
dGEtPm1heF9zcGVlZCkKKwkJaG9zdC0+bW1jLT5mX21heCA9IHB4YS0+cGRhdGEtPm1heF9zcGVl
ZDsKKworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOworCisJcmV0dXJuIDA7Citv
dXQ6CisJaWYgKGhvc3QpIHsKKwkJY2xrX3B1dChweGEtPmNsayk7CisJCWlmIChob3N0LT5pb2Fk
ZHIpCisJCQlpb3VubWFwKGhvc3QtPmlvYWRkcik7CisJCWlmIChweGEtPnJlcykKKwkJCXJlbGVh
c2VfbWVtX3JlZ2lvbihweGEtPnJlcy0+c3RhcnQsCisJCQkJCXJlc291cmNlX3NpemUocHhhLT5y
ZXMpKTsKKwkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOworCX0KKworCXJldHVybiByZXQ7Cit9CisK
K3N0YXRpYyBpbnQgX19kZXZleGl0IHNkaGNpX3B4YV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7
CisJaW50IGRlYWQgPSAwOworCXUzMiBzY3JhdGNoOworCisJaWYgKGhvc3QpIHsKKwkJc2NyYXRj
aCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNESENJX0lOVF9TVEFUVVMpOworCQlpZiAoc2NyYXRj
aCA9PSAodTMyKS0xKQorCQkJZGVhZCA9IDE7CisKKwkJc2RoY2lfcmVtb3ZlX2hvc3QoaG9zdCwg
ZGVhZCk7CisKKwkJaWYgKGhvc3QtPmlvYWRkcikKKwkJCWlvdW5tYXAoaG9zdC0+aW9hZGRyKTsK
KwkJaWYgKHB4YS0+cmVzKQorCQkJcmVsZWFzZV9tZW1fcmVnaW9uKHB4YS0+cmVzLT5zdGFydCwK
KwkJCQkJcmVzb3VyY2Vfc2l6ZShweGEtPnJlcykpOworCQlpZiAocHhhLT5jbGtfZW5hYmxlKSB7
CisJCQljbGtfZGlzYWJsZShweGEtPmNsayk7CisJCQlweGEtPmNsa19lbmFibGUgPSAwOworCQl9
CisJCWNsa19wdXQocHhhLT5jbGspOworCisJCXNkaGNpX2ZyZWVfaG9zdChob3N0KTsKKwkJcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisJfQorCisJcmV0dXJuIDA7Cit9CisKKyNp
ZmRlZiBDT05GSUdfUE0KK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3N1c3BlbmQoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJcmV0dXJuIHNkaGNpX3N1
c3BlbmRfaG9zdChob3N0LCBzdGF0ZSk7Cit9CisKK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3Jlc3Vt
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCit7CisJc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCisJcmV0dXJuIHNkaGNpX3Jlc3VtZV9o
b3N0KGhvc3QpOworfQorI2Vsc2UKKyNkZWZpbmUgc2RoY2lfcHhhX3N1c3BlbmQJTlVMTAorI2Rl
ZmluZSBzZGhjaV9weGFfcmVzdW1lCU5VTEwKKyNlbmRpZgorCitzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBzZGhjaV9weGFfZHJpdmVyID0geworCS5wcm9iZQkJPSBzZGhjaV9weGFfcHJv
YmUsCisJLnJlbW92ZQkJPSBfX2RldmV4aXRfcChzZGhjaV9weGFfcmVtb3ZlKSwKKwkuc3VzcGVu
ZAk9IHNkaGNpX3B4YV9zdXNwZW5kLAorCS5yZXN1bWUJCT0gc2RoY2lfcHhhX3Jlc3VtZSwKKwku
ZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSBEUklWRVJfTkFNRSwKKwkJLm93bmVyCT0gVEhJU19NT0RV
TEUsCisJfSwKK307CisKKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKlwKKyAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKgorICogRHJpdmVyIGluaXQvZXhpdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKK1wqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KKworc3RhdGljIGludCBfX2luaXQgc2RoY2lfcHhhX2luaXQodm9p
ZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZzZGhjaV9weGFfZHJpdmVy
KTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IHNkaGNpX3B4YV9leGl0KHZvaWQpCit7CisJcGxh
dGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJnNkaGNpX3B4YV9kcml2ZXIpOworfQorCittb2R1bGVf
aW5pdChzZGhjaV9weGFfaW5pdCk7Cittb2R1bGVfZXhpdChzZGhjaV9weGFfZXhpdCk7CisKK01P
RFVMRV9ERVNDUklQVElPTigiU0RIIGNvbnRyb2xsZXIgZHJpdmVyIGZvciBQWEExNjgvUFhBOTEw
L01NUDIiKTsKK01PRFVMRV9BVVRIT1IoIlpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQG1hcnZl
bGwuY29tPiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwotLSAKMS43LjAuNAoK
--90e6ba6141d05508aa0493352ffe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--90e6ba6141d05508aa0493352ffe--
