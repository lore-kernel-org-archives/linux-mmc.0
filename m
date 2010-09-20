From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Mon, 20 Sep 2010 08:09:26 -0400
Message-ID: <AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
	<20100920095042.GC4058@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636b2b206a6ae7f0490afc84b
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41465 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab0ITMJ1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 08:09:27 -0400
Received: by yxp4 with SMTP id 4so1277863yxp.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 05:09:27 -0700 (PDT)
In-Reply-To: <20100920095042.GC4058@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--001636b2b206a6ae7f0490afc84b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 5:50 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:
>
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>> new file mode 100644
>> index 0000000..3e091c1
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -0,0 +1,253 @@
>> +/* linux/drivers/mmc/host/sdhci-pxa.c
>> + *
>> + * Copyright 2010 Marvell
>> + * =A0 =A0 =A0Zhangfei Gao <zhangfei.gao@marvell.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/* Supports:
>> + * SDHCI support for MMP2/PXA910/PXA168
>> + *
>> + * Based on sdhci-platfm.c
>> + */
>
> Why is it only "based on" and not directly using it?

Thanks for your suggestion.
This is the first stage, already implement sd card function, we will
have some patches later to enhance the driver.
We have to access many private registers to enable specific control.
Besides some sdio device need some specific control, like marvell 8787
host sleep, it is much reasonable to implement inside the driver.

>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyXLnIACgkQD27XaX1/VRs1tACguzCS47XrzzMD+mWwFOSkgr1q
> AR8AnRbztMJI30NqFihZyE8bkVlFJe18
> =3DBsNX
> -----END PGP SIGNATURE-----
>
>

Update pm interface,

>From b49462b85bdc8f81cc074079fa768d53d8653cb1 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 10:51:28 -0400
Subject: [PATCH] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
 drivers/mmc/host/Kconfig               |   12 ++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  260 ++++++++++++++++++++++++++++=
++++
 4 files changed, 305 insertions(+), 0 deletions(-)
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
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)	+=3D sdhci-mv.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_PXA)	+=3D sdhci-pxa.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..c375a6d
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,260 @@
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
+			if (pxa->pdata->pxa_quirk
+					& PXA_QUIRK_DISABLE_CLOCK_GATING) {
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
+		ret =3D PTR_ERR(host);
+		goto out;
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
+	if (pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETECTION)
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
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
+static int sdhci_pxa_suspend(struct platform_device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct sdhci_host *host =3D platform_get_drvdata(dev);
+	int ret =3D 0;
+
+	ret =3D sdhci_suspend_host(host, state);
+
+	return ret;
+}
+
+static int sdhci_pxa_resume(struct platform_device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct sdhci_host *host =3D platform_get_drvdata(dev);
+	int ret =3D 0;
+
+	ret =3D sdhci_resume_host(host);
+
+	return ret;
+}
+#else
+#define sdhci_pxa_suspend	NULL
+#define sdhci_pxa_resume	NULL
+#endif
+
+static const struct dev_pm_ops sdhci_pxa_pm_ops =3D {
+	.suspend	=3D sdhci_pxa_suspend,
+	.resume		=3D sdhci_pxa_resume,
+};
+
+
+static struct platform_driver sdhci_pxa_driver =3D {
+	.probe		=3D sdhci_pxa_probe,
+	.remove		=3D __devexit_p(sdhci_pxa_remove),
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+		.pm =3D &sdhci_pxa_pm_ops,
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

--001636b2b206a6ae7f0490afc84b
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gebzvzph1

RnJvbSBiNDk0NjJiODViZGM4ZjgxY2MwNzQwNzlmYTc2OGQ1M2Q4NjUzY2IxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxMDo1MToyOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IG1tYzogYWRkIHN1cHBvcnQgb2Ygc2RoY2ktcHhhIGRyaXZlcgoKCVN1cHBvcnQgTWFydmVsbCBQ
WEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyCgpTaWduZWQtb2ZmLWJ5OiBaaGFu
Z2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4
YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCB8ICAgMzIgKysrKwogZHJpdmVycy9tbWMvaG9zdC9LY29u
ZmlnICAgICAgICAgICAgICAgfCAgIDEyICsrCiBkcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlICAg
ICAgICAgICAgICB8ICAgIDEgKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAg
ICAgfCAgMjYwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5n
ZWQsIDMwNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3Bs
YXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9w
bGF0L3NkaGNpLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNTVlMWM4NQot
LS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5o
CkBAIC0wLDAgKzEsMzIgQEAKKy8qIGxpbnV4L2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxh
dC9zZGhjaS5oCisgKgorICogQ29weXJpZ2h0IDIwMTAgTWFydmVsbAorICoJWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogUFhBIFBsYXRmb3JtIC0gU0RIQ0kg
cGxhdGZvcm0gZGF0YSBkZWZpbml0aW9ucworICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBh
cworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisqLworCisj
aWZuZGVmIF9fUExBVF9QWEFfU0RIQ0lfSAorI2RlZmluZSBfX1BMQVRfUFhBX1NESENJX0ggX19G
SUxFX18KKworLyogcHhhIHNwZWNpZmljIHF1aXJrcyAqLworLyogQ2FyZCBhbHdheWVzIHdpcmVk
IHRvIGhvc3QsIGxpa2UgZW1tYyAqLworI2RlZmluZSBQWEFfUVVJUktfQlJPS0VOX0NBUkRfREVU
RUNUSU9OICgxPDwwKQorLyogUmVxdWlyZSBjbG9jayBmcmVlIHJ1bm5pbmcgKi8KKyNkZWZpbmUJ
UFhBX1FVSVJLX0RJU0FCTEVfQ0xPQ0tfR0FUSU5HICgxPDwxKQorCisvKioKKyAqIHN0cnVjdCBw
eGFfc2RoY2lfcGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQWEEgU0RIQ0kK
KyAqIEBtYXhfc3BlZWQ6IFRoZSBtYXhpbXVtIHNwZWVkIHN1cHBvcnRlZC4KKyAqIEBweGFfcXVp
cmtzOiBzcGVjaWZpYyBxdWlyayBvZiBweGEKKyovCitzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRh
IHsKKwl1bnNpZ25lZCBpbnQJbWF4X3NwZWVkOworCXVuc2lnbmVkIGludAlweGFfcXVpcms7Cit9
OworCisjZW5kaWYgLyogX19QTEFUX1BYQV9TREhDSV9IICovCmRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L0tjb25maWcgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcKaW5kZXggNmYxMmQ1
ZC4uNDBhYTNiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCisrKyBiL2Ry
aXZlcnMvbW1jL2hvc3QvS2NvbmZpZwpAQCAtMTU4LDYgKzE1OCwxOCBAQCBjb25maWcgTU1DX1NE
SENJX1MzQwogCiAJICBJZiB1bnN1cmUsIHNheSBOLgogCitjb25maWcgTU1DX1NESENJX1BYQQor
CXRyaXN0YXRlICJNYXJ2ZWxsIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBIb3N0IENvbnRyb2xsZXIg
c3VwcG9ydCIKKwlkZXBlbmRzIG9uIEFSQ0hfUFhBIHx8IEFSQ0hfTU1QCisJc2VsZWN0IE1NQ19T
REhDSQorCXNlbGVjdCBNTUNfU0RIQ0lfSU9fQUNDRVNTT1JTCisJaGVscAorCSAgVGhpcyBzZWxl
Y3RzIHRoZSBNYXJ2ZWxsKFIpIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBIb3N0IENvbnRyb2xsZXIu
CisJICBJZiB5b3UgaGF2ZSBhIFBYQTE2OC9QWEE5MTAvTU1QMiBwbGF0Zm9ybSB3aXRoIFNEIEhv
c3QgQ29udHJvbGxlciBhbmQgYQorCSAgY2FyZCBzbG90LHNheSBZIG9yIE0gaGVyZS4KKworCSAg
SWYgdW5zdXJlLCBzYXkgTi4KKwogY29uZmlnIE1NQ19TREhDSV9TUEVBUgogCXRyaXN0YXRlICJT
REhDSSBzdXBwb3J0IG9uIFNUIFNQRUFyIHBsYXRmb3JtIgogCWRlcGVuZHMgb24gTU1DX1NESENJ
ICYmIFBMQVRfU1BFQVIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUgYi9k
cml2ZXJzL21tYy9ob3N0L01ha2VmaWxlCmluZGV4IDY5N2JiZmUuLjNhOWY3ZmUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9NYWtl
ZmlsZQpAQCAtMTMsNiArMTMsNyBAQCBvYmotJChDT05GSUdfTU1DX01YQykJCSs9IG14Y21tYy5v
CiBvYmotJChDT05GSUdfTU1DX1NESENJKQkJKz0gc2RoY2kubwogb2JqLSQoQ09ORklHX01NQ19T
REhDSV9NVikJKz0gc2RoY2ktbXYubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9QQ0kpCSs9IHNk
aGNpLXBjaS5vCitvYmotJChDT05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktcHhhLm8KIG9i
ai0kKENPTkZJR19NTUNfU0RIQ0lfUzNDKQkrPSBzZGhjaS1zM2Mubwogb2JqLSQoQ09ORklHX01N
Q19TREhDSV9TUEVBUikJKz0gc2RoY2ktc3BlYXIubwogb2JqLSQoQ09ORklHX01NQ19XQlNEKQkJ
Kz0gd2JzZC5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwLi5jMzc1YTZkCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
eGEuYwpAQCAtMCwwICsxLDI2MCBAQAorLyogbGludXgvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
eGEuYworICoKKyAqIENvcHlyaWdodCAyMDEwIE1hcnZlbGwKKyAqICAgICAgWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAy
IGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLwor
CisvKiBTdXBwb3J0czoKKyAqIFNESENJIHN1cHBvcnQgZm9yIE1NUDIvUFhBOTEwL1BYQTE2OAor
ICoKKyAqIEJhc2VkIG9uIHNkaGNpLXBsYXRmbS5jCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2Rl
bGF5Lmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGlu
dXgvbW1jL2hvc3QuaD4KKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4KKyNpbmNsdWRlIDxsaW51eC9p
by5oPgorI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgorI2luY2x1ZGUgPHBsYXQvc2RoY2kuaD4KKyNp
bmNsdWRlICJzZGhjaS5oIgorCisjZGVmaW5lIERSSVZFUl9OQU1FCSJzZGhjaS1weGEiCisKKyNk
ZWZpbmUgU0RfRklGT19QQVJBTQkJMHgxMDQKKyNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkw
eDQwMAorCitzdHJ1Y3Qgc2RoY2lfcHhhIHsKKwlzdHJ1Y3Qgc2RoY2lfaG9zdAkJKmhvc3Q7CisJ
c3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YQkqcGRhdGE7CisJc3RydWN0IGNsawkJCSpjbGs7CisJ
c3RydWN0IHJlc291cmNlCQkJKnJlczsKKworCXU4IGNsa19lbmFibGU7Cit9OworCisvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKipcCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqIFNESENJIGNvcmUgY2Fs
bGJhY2tzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqCitcKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCitzdGF0
aWMgdm9pZCBzZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBj
bG9jaykKK3sKKwlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCXUz
MiB0bXAgPSAwOworCisJaWYgKGNsb2NrID09IDApIHsKKwkJaWYgKHB4YS0+Y2xrX2VuYWJsZSkg
eworCQkJY2xrX2Rpc2FibGUocHhhLT5jbGspOworCQkJcHhhLT5jbGtfZW5hYmxlID0gMDsKKwkJ
fQorCX0gZWxzZSB7CisJCWlmICgwID09IHB4YS0+Y2xrX2VuYWJsZSkgeworCQkJaWYgKHB4YS0+
cGRhdGEtPnB4YV9xdWlyaworCQkJCQkmIFBYQV9RVUlSS19ESVNBQkxFX0NMT0NLX0dBVElORykg
eworCQkJCXRtcCA9IHJlYWRsKGhvc3QtPmlvYWRkciArIFNEX0ZJRk9fUEFSQU0pOworCQkJCXRt
cCB8PSBESVNfUEFEX1NEX0NMS19HQVRFOworCQkJCXdyaXRlbCh0bXAsIGhvc3QtPmlvYWRkciAr
IFNEX0ZJRk9fUEFSQU0pOworCQkJfQorCQkJY2xrX2VuYWJsZShweGEtPmNsayk7CisJCQlweGEt
PmNsa19lbmFibGUgPSAxOworCQl9CisJfQorfQorCitzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBz
ZGhjaV9weGFfb3BzID0geworCS5zZXRfY2xvY2sgPSBzZXRfY2xvY2ssCit9OworCisvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKipcCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqIERldmljZSBwcm9iaW5n
L3JlbW92YWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqCitcKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCisKK3N0
YXRpYyBpbnQgX19kZXZpbml0IHNkaGNpX3B4YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQoreworCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKnBkYXRhID0gcGRldi0+ZGV2
LnBsYXRmb3JtX2RhdGE7CisJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsKKwlzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IE5VTEw7CisJc3RydWN0IHJlc291cmNlICppb21lbSA9IE5V
TEw7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gTlVMTDsKKwlpbnQgcmV0LCBpcnE7CisKKwlp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOworCWlmIChpcnEgPCAwKSB7CisJCWRldl9l
cnIoZGV2LCAibm8gaXJxIHNwZWNpZmllZFxuIik7CisJCXJldHVybiBpcnE7CisJfQorCisJaW9t
ZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOworCWlm
ICghaW9tZW0pIHsKKwkJZGV2X2VycihkZXYsICJubyBtZW1vcnkgc3BlY2lmaWVkXG4iKTsKKwkJ
cmV0dXJuIC1FTk9FTlQ7CisJfQorCisJaG9zdCA9IHNkaGNpX2FsbG9jX2hvc3QoJnBkZXYtPmRl
diwgc2l6ZW9mKHN0cnVjdCBzZGhjaV9weGEpKTsKKwlpZiAoSVNfRVJSKGhvc3QpKSB7CisJCWRl
dl9lcnIoZGV2LCAiZmFpbGVkIHRvIGFsbG9jIGhvc3RcbiIpOworCQlyZXQgPSBQVFJfRVJSKGhv
c3QpOworCQlnb3RvIG91dDsKKwl9CisKKwlweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCXB4YS0+
aG9zdCA9IGhvc3Q7CisJcHhhLT5wZGF0YSA9IHBkYXRhOworCXB4YS0+Y2xrX2VuYWJsZSA9IDA7
CisKKwlweGEtPmNsayA9IGNsa19nZXQoZGV2LCAiUFhBLVNESENMSyIpOworCWlmIChJU19FUlIo
cHhhLT5jbGspKSB7CisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBpbyBjbG9ja1xuIik7
CisJCXJldCA9IFBUUl9FUlIocHhhLT5jbGspOworCQlnb3RvIG91dDsKKwl9CisKKwlweGEtPnJl
cyA9IHJlcXVlc3RfbWVtX3JlZ2lvbihpb21lbS0+c3RhcnQsIHJlc291cmNlX3NpemUoaW9tZW0p
LAorCQltbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7CisJaWYgKCFweGEtPnJlcykgeworCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJjYW5ub3QgcmVxdWVzdCByZWdpb25cbiIpOworCQlyZXQgPSAtRUJV
U1k7CisJCWdvdG8gb3V0OworCX0KKworCWhvc3QtPmlvYWRkciA9IGlvcmVtYXAoaW9tZW0tPnN0
YXJ0LCByZXNvdXJjZV9zaXplKGlvbWVtKSk7CisJaWYgKCFob3N0LT5pb2FkZHIpIHsKKwkJZGV2
X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlbWFwIHJlZ2lzdGVyc1xuIik7CisJCXJldCA9
IC1FTk9NRU07CisJCWdvdG8gb3V0OworCX0KKworCWhvc3QtPmh3X25hbWUgPSAiTU1DIjsKKwlo
b3N0LT5vcHMgPSAmc2RoY2lfcHhhX29wczsKKwlob3N0LT5pcnEgPSBpcnE7CisJaG9zdC0+cXVp
cmtzID0gU0RIQ0lfUVVJUktfQlJPS0VOX0FETUEgfCBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9V
VF9WQUw7CisKKwlpZiAocGRhdGEtPnB4YV9xdWlyayAmIFBYQV9RVUlSS19CUk9LRU5fQ0FSRF9E
RVRFQ1RJT04pCisJCWhvc3QtPnF1aXJrcyB8PSBTREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRF
Q1RJT047CisKKwlyZXQgPSBzZGhjaV9hZGRfaG9zdChob3N0KTsKKwlpZiAocmV0KSB7CisJCWRl
dl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBhZGQgaG9zdFxuIik7CisJCWdvdG8gb3V0Owor
CX0KKworCWlmIChweGEtPnBkYXRhLT5tYXhfc3BlZWQpCisJCWhvc3QtPm1tYy0+Zl9tYXggPSBw
eGEtPnBkYXRhLT5tYXhfc3BlZWQ7CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBob3N0
KTsKKworCXJldHVybiAwOworb3V0OgorCWlmIChob3N0KSB7CisJCWlmIChob3N0LT5pb2FkZHIp
CisJCQlpb3VubWFwKGhvc3QtPmlvYWRkcik7CisJCWlmIChweGEtPnJlcykKKwkJCXJlbGVhc2Vf
bWVtX3JlZ2lvbihweGEtPnJlcy0+c3RhcnQsCisJCQkJCXJlc291cmNlX3NpemUocHhhLT5yZXMp
KTsKKwkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOworCX0KKworCXJldHVybiByZXQ7Cit9CisKK3N0
YXRpYyBpbnQgX19kZXZleGl0IHNkaGNpX3B4YV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJ
aW50IGRlYWQgPSAwOworCXUzMiBzY3JhdGNoOworCisJaWYgKGhvc3QpIHsKKwkJc2NyYXRjaCA9
IHJlYWRsKGhvc3QtPmlvYWRkciArIFNESENJX0lOVF9TVEFUVVMpOworCQlpZiAoc2NyYXRjaCA9
PSAodTMyKS0xKQorCQkJZGVhZCA9IDE7CisKKwkJc2RoY2lfcmVtb3ZlX2hvc3QoaG9zdCwgZGVh
ZCk7CisKKwkJaWYgKGhvc3QtPmlvYWRkcikKKwkJCWlvdW5tYXAoaG9zdC0+aW9hZGRyKTsKKwkJ
aWYgKHB4YS0+cmVzKQorCQkJcmVsZWFzZV9tZW1fcmVnaW9uKHB4YS0+cmVzLT5zdGFydCwKKwkJ
CQkJcmVzb3VyY2Vfc2l6ZShweGEtPnJlcykpOworCQljbGtfZGlzYWJsZShweGEtPmNsayk7CisJ
CWNsa19wdXQocHhhLT5jbGspOworCisJCXNkaGNpX2ZyZWVfaG9zdChob3N0KTsKKwkJcGxhdGZv
cm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisJfQorCisJcmV0dXJuIDA7Cit9CisKKyNpZmRl
ZiBDT05GSUdfUE0KK3N0YXRpYyBpbnQgc2RoY2lfcHhhX3N1c3BlbmQoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqZGV2KQoreworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0
Zm9ybV9kZXZpY2UoZGV2KTsKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKGRldik7CisJaW50IHJldCA9IDA7CisKKwlyZXQgPSBzZGhjaV9zdXNwZW5kX2hv
c3QoaG9zdCwgc3RhdGUpOworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBzZGhjaV9w
eGFfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7CisJc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCWludCByZXQgPSAwOwor
CisJcmV0ID0gc2RoY2lfcmVzdW1lX2hvc3QoaG9zdCk7CisKKwlyZXR1cm4gcmV0OworfQorI2Vs
c2UKKyNkZWZpbmUgc2RoY2lfcHhhX3N1c3BlbmQJTlVMTAorI2RlZmluZSBzZGhjaV9weGFfcmVz
dW1lCU5VTEwKKyNlbmRpZgorCitzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgc2RoY2lf
cHhhX3BtX29wcyA9IHsKKwkuc3VzcGVuZAk9IHNkaGNpX3B4YV9zdXNwZW5kLAorCS5yZXN1bWUJ
CT0gc2RoY2lfcHhhX3Jlc3VtZSwKK307CisKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgc2RoY2lfcHhhX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gc2RoY2lfcHhhX3Byb2JlLAorCS5y
ZW1vdmUJCT0gX19kZXZleGl0X3Aoc2RoY2lfcHhhX3JlbW92ZSksCisJLmRyaXZlcgkJPSB7CisJ
CS5uYW1lCT0gRFJJVkVSX05BTUUsCisJCS5vd25lcgk9IFRISVNfTU9EVUxFLAorCQkucG0gPSAm
c2RoY2lfcHhhX3BtX29wcywKKwl9LAorfTsKKworLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqXAorICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqCisgKiBEcml2ZXIgaW5pdC9leGl0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKgorXCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworCitzdGF0aWMgaW50IF9faW5pdCBzZGhj
aV9weGFfaW5pdCh2b2lkKQoreworCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnNk
aGNpX3B4YV9kcml2ZXIpOworfQorCitzdGF0aWMgdm9pZCBfX2V4aXQgc2RoY2lfcHhhX2V4aXQo
dm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rlcigmc2RoY2lfcHhhX2RyaXZlcik7
Cit9CisKK21vZHVsZV9pbml0KHNkaGNpX3B4YV9pbml0KTsKK21vZHVsZV9leGl0KHNkaGNpX3B4
YV9leGl0KTsKKworTU9EVUxFX0RFU0NSSVBUSU9OKCJTREggY29udHJvbGxlciBkcml2ZXIgZm9y
IFBYQTE2OC9QWEE5MTAvTU1QMiIpOworTU9EVUxFX0FVVEhPUigiWmhhbmdmZWkgR2FvIDx6aGFu
Z2ZlaS5nYW9AbWFydmVsbC5jb20+Iik7CitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Ci0tIAox
LjcuMC40Cgo=
--001636b2b206a6ae7f0490afc84b--
