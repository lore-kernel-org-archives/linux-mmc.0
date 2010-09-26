From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 26 Sep 2010 06:56:51 -0400
Message-ID: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=005045013e1513495e049127784b
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47230 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0IZK4x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 06:56:53 -0400
Received: by iwn5 with SMTP id 5so3808849iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 03:56:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--005045013e1513495e049127784b
Content-Type: text/plain; charset=ISO-8859-1

Assume the sdhci-pltfm call back are accepted

>From f7e1cc9975cbed2d993d4209eae36f8f300fb18c Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Sun, 26 Sep 2010 17:13:43 -0400
Subject: [PATCH 2/2] mmc: add support of sdhci-pxa driver

	Support Marvell PXA168/PXA910/MMP2 SD Host Controller

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   32 +++++++
 drivers/mmc/host/Kconfig               |   11 +++
 drivers/mmc/host/Makefile              |    1 +
 drivers/mmc/host/sdhci-pxa.c           |  143 ++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-pxa.c

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
new file mode 100644
index 0000000..3d5f5ef
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -0,0 +1,32 @@
+/* arch/arm/plat-pxa/include/plat/sdhci.h
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
index 6f12d5d..9510976 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -158,6 +158,17 @@ config MMC_SDHCI_S3C

 	  If unsure, say N.

+config MMC_SDHCI_PXA
+	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
+	depends on ARCH_PXA || ARCH_MMP
+	depends on MMC_SDHCI_PLTFM
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
index ef32c32..d166493 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC)		+= ushc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
 sdhci-platform-y				:= sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_PXA)		+= sdhci-pxa.o

 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
new file mode 100644
index 0000000..12ede18
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -0,0 +1,143 @@
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
+ * Based on  sdhci-pltfm.c
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/sdhci.h>
+#include <linux/sdhci-pltfm.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+#define SD_FIFO_PARAM		0x104
+#define DIS_PAD_SD_CLK_GATE	0x400
+
+struct sdhci_pxa {
+	struct sdhci_pxa_platdata	*pdata;
+	struct clk			*clk;
+
+	u32 quirks;
+	u8 clk_enable;
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * SDHCI core callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+static void sdhci_pxa_set_clock(struct sdhci_host *host, unsigned int clock)
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
+	.set_clock	= sdhci_pxa_set_clock,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * sdhci-pltfm callbacks                                                      *
+ *                                                                           *
+\*****************************************************************************/
+static int sdhci_pxa_init(struct sdhci_host *host, struct
sdhci_pltfm_data *pdata, void* priv_pdata)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+	struct device *dev = mmc_dev(host->mmc);
+
+	pxa->pdata = priv_pdata;
+	pxa->clk_enable = 0;
+
+	pxa->clk = clk_get(dev, "PXA-SDHCLK");
+	if (IS_ERR(pxa->clk)) {
+		dev_err(dev, "clk err\n");
+		return -ENODEV;
+	}
+	clk_enable(pxa->clk);
+	dev_dbg(dev, "SDHC clock:%lu\n", clk_get_rate(pxa->clk));
+
+	pxa->clk_enable = 0;
+	pxa->quirks = pdata->quirks;
+
+	if (pxa->pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETECTION)
+		pxa->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	return 0;
+}
+
+static unsigned int sdhci_pxa_get_quirk(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	return pxa->quirks;
+}
+
+static void sdhci_pxa_set_max_speed(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	if (pxa->pdata->max_speed)
+		host->mmc->f_max = pxa->pdata->max_speed;
+}
+
+static void sdhci_pxa_exit(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	if (pxa->clk_enable)
+		clk_disable(pxa->clk);
+	clk_put(pxa->clk);
+}
+
+static struct sdhci_host *sdhci_pxa_alloc_host(struct device *dev)
+{
+	return sdhci_alloc_host(dev, sizeof(struct sdhci_pxa));
+}
+
+struct sdhci_pltfm_data sdhci_pxa_pdata = {
+	.ops	= &sdhci_pxa_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+	.init	= sdhci_pxa_init,
+	.exit	= sdhci_pxa_exit,
+	.get_quirk	= sdhci_pxa_get_quirk,
+	.set_max_speed	= sdhci_pxa_set_max_speed,
+	.alloc_host	= sdhci_pxa_alloc_host,
+};
+
+MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
+MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4

--005045013e1513495e049127784b
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Disposition: attachment;
	filename="0002-mmc-add-support-of-sdhci-pxa-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geki9tyd0

RnJvbSBmN2UxY2M5OTc1Y2JlZDJkOTkzZDQyMDllYWUzNmY4ZjMwMGZiMThjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogU3VuLCAyNiBTZXAgMjAxMCAxNzoxMzo0MyAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8yXSBtbWM6IGFkZCBzdXBwb3J0IG9mIHNkaGNpLXB4YSBkcml2ZXIKCglTdXBwb3J0IE1hcnZl
bGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3QgQ29udHJvbGxlcgoKU2lnbmVkLW9mZi1ieTog
WmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vcGxh
dC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggfCAgIDMyICsrKysrKysKIGRyaXZlcnMvbW1jL2hv
c3QvS2NvbmZpZyAgICAgICAgICAgICAgIHwgICAxMSArKysKIGRyaXZlcnMvbW1jL2hvc3QvTWFr
ZWZpbGUgICAgICAgICAgICAgIHwgICAgMSArCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5j
ICAgICAgICAgICB8ICAxNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmls
ZXMgY2hhbmdlZCwgMTg3IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCgpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmggYi9hcmNoL2FybS9wbGF0LXB4YS9p
bmNsdWRlL3BsYXQvc2RoY2kuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4z
ZDVmNWVmCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0
L3NkaGNpLmgKQEAgLTAsMCArMSwzMiBAQAorLyogYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9w
bGF0L3NkaGNpLmgKKyAqCisgKiBDb3B5cmlnaHQgMjAxMCBNYXJ2ZWxsCisgKglaaGFuZ2ZlaSBH
YW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KKyAqCisgKiBQWEEgUGxhdGZvcm0gLSBTREhD
SSBwbGF0Zm9ybSBkYXRhIGRlZmluaXRpb25zCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAy
IGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyovCisK
KyNpZm5kZWYgX19QTEFUX1BYQV9TREhDSV9ICisjZGVmaW5lIF9fUExBVF9QWEFfU0RIQ0lfSCBf
X0ZJTEVfXworCisvKiBweGEgc3BlY2lmaWMgcXVpcmtzICovCisvKiBDYXJkIGFsd2F5ZXMgd2ly
ZWQgdG8gaG9zdCwgbGlrZSBlbW1jICovCisjZGVmaW5lIFBYQV9RVUlSS19CUk9LRU5fQ0FSRF9E
RVRFQ1RJT04gKDE8PDApCisvKiBSZXF1aXJlIGNsb2NrIGZyZWUgcnVubmluZyAqLworI2RlZmlu
ZQlQWEFfUVVJUktfRElTQUJMRV9DTE9DS19HQVRJTkcgKDE8PDEpCisKKy8qKgorICogc3RydWN0
IHB4YV9zZGhjaV9wbGF0ZGF0YSgpIC0gUGxhdGZvcm0gZGV2aWNlIGRhdGEgZm9yIFBYQSBTREhD
SQorICogQG1heF9zcGVlZDogVGhlIG1heGltdW0gc3BlZWQgc3VwcG9ydGVkLgorICogQHB4YV9x
dWlya3M6IHNwZWNpZmljIHF1aXJrIG9mIHB4YQorKi8KK3N0cnVjdCBzZGhjaV9weGFfcGxhdGRh
dGEgeworCXVuc2lnbmVkIGludAltYXhfc3BlZWQ7CisJdW5zaWduZWQgaW50CXB4YV9xdWlyazsK
K307CisKKyNlbmRpZiAvKiBfX1BMQVRfUFhBX1NESENJX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZwppbmRleCA2ZjEy
ZDVkLi45NTEwOTc2IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcKKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCkBAIC0xNTgsNiArMTU4LDE3IEBAIGNvbmZpZyBNTUNf
U0RIQ0lfUzNDCiAKIAkgIElmIHVuc3VyZSwgc2F5IE4uCiAKK2NvbmZpZyBNTUNfU0RIQ0lfUFhB
CisJdHJpc3RhdGUgIk1hcnZlbGwgUFhBMTY4L1BYQTkxMC9NTVAyIFNEIEhvc3QgQ29udHJvbGxl
ciBzdXBwb3J0IgorCWRlcGVuZHMgb24gQVJDSF9QWEEgfHwgQVJDSF9NTVAKKwlkZXBlbmRzIG9u
IE1NQ19TREhDSV9QTFRGTQorCWhlbHAKKwkgIFRoaXMgc2VsZWN0cyB0aGUgTWFydmVsbChSKSBQ
WEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9sbGVyLgorCSAgSWYgeW91IGhhdmUgYSBQ
WEExNjgvUFhBOTEwL01NUDIgcGxhdGZvcm0gd2l0aCBTRCBIb3N0IENvbnRyb2xsZXIgYW5kIGEK
KwkgIGNhcmQgc2xvdCxzYXkgWSBvciBNIGhlcmUuCisKKwkgIElmIHVuc3VyZSwgc2F5IE4uCisK
IGNvbmZpZyBNTUNfU0RIQ0lfU1BFQVIKIAl0cmlzdGF0ZSAiU0RIQ0kgc3VwcG9ydCBvbiBTVCBT
UEVBciBwbGF0Zm9ybSIKIAlkZXBlbmRzIG9uIE1NQ19TREhDSSAmJiBQTEFUX1NQRUFSCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlIGIvZHJpdmVycy9tbWMvaG9zdC9NYWtl
ZmlsZQppbmRleCBlZjMyYzMyLi5kMTY2NDkzIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0
L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvTWFrZWZpbGUKQEAgLTM4LDYgKzM4LDcg
QEAgb2JqLSQoQ09ORklHX01NQ19VU0hDKQkJKz0gdXNoYy5vCiBvYmotJChDT05GSUdfTU1DX1NE
SENJX1BMVEZNKQkJCSs9IHNkaGNpLXBsYXRmb3JtLm8KIHNkaGNpLXBsYXRmb3JtLXkJCQkJOj0g
c2RoY2ktcGx0Zm0ubwogc2RoY2ktcGxhdGZvcm0tJChDT05GSUdfTU1DX1NESENJX0NOUzNYWFgp
CSs9IHNkaGNpLWNuczN4eHgubworc2RoY2ktcGxhdGZvcm0tJChDT05GSUdfTU1DX1NESENJX1BY
QSkJCSs9IHNkaGNpLXB4YS5vCiAKIG9iai0kKENPTkZJR19NTUNfU0RIQ0lfT0YpCSs9IHNkaGNp
LW9mLm8KIHNkaGNpLW9mLXkJCQkJOj0gc2RoY2ktb2YtY29yZS5vCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4xMmVkZTE4Ci0tLSAvZGV2L251bGwK
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAtMCwwICsxLDE0MyBAQAorLyog
bGludXgvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYworICoKKyAqIENvcHlyaWdodCAyMDEw
IE1hcnZlbGwKKyAqICAgICAgWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLworCisvKiBTdXBwb3J0czoKKyAqIFNESENJIHN1
cHBvcnQgZm9yIE1NUDIvUFhBOTEwL1BYQTE2OAorICoKKyAqIEJhc2VkIG9uICBzZGhjaS1wbHRm
bS5jCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvbW1jL2hvc3QuaD4KKyNpbmNsdWRlIDxs
aW51eC9jbGsuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4L2Vyci5o
PgorI2luY2x1ZGUgPHBsYXQvc2RoY2kuaD4KKyNpbmNsdWRlIDxsaW51eC9zZGhjaS1wbHRmbS5o
PgorI2luY2x1ZGUgInNkaGNpLmgiCisjaW5jbHVkZSAic2RoY2ktcGx0Zm0uaCIKKworI2RlZmlu
ZSBTRF9GSUZPX1BBUkFNCQkweDEwNAorI2RlZmluZSBESVNfUEFEX1NEX0NMS19HQVRFCTB4NDAw
CisKK3N0cnVjdCBzZGhjaV9weGEgeworCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEJKnBkYXRh
OworCXN0cnVjdCBjbGsJCQkqY2xrOworCisJdTMyIHF1aXJrczsKKwl1OCBjbGtfZW5hYmxlOwor
fTsKKworLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqXAorICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCisgKiBT
REhDSSBjb3JlIGNhbGxiYWNrcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICoKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgorXCoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqLworc3RhdGljIHZvaWQgc2RoY2lfcHhhX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9
IHNkaGNpX3ByaXYoaG9zdCk7CisJdTMyIHRtcCA9IDA7CisKKwlpZiAoY2xvY2sgPT0gMCkgewor
CQlpZiAocHhhLT5jbGtfZW5hYmxlKSB7CisJCQljbGtfZGlzYWJsZShweGEtPmNsayk7CisJCQlw
eGEtPmNsa19lbmFibGUgPSAwOworCQl9CisJfSBlbHNlIHsKKwkJaWYgKDAgPT0gcHhhLT5jbGtf
ZW5hYmxlKSB7CisJCQlpZiAocHhhLT5wZGF0YS0+cHhhX3F1aXJrCisJCQkJCSYgUFhBX1FVSVJL
X0RJU0FCTEVfQ0xPQ0tfR0FUSU5HKSB7CisJCQkJdG1wID0gcmVhZGwoaG9zdC0+aW9hZGRyICsg
U0RfRklGT19QQVJBTSk7CisJCQkJdG1wIHw9IERJU19QQURfU0RfQ0xLX0dBVEU7CisJCQkJd3Jp
dGVsKHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7CisJCQl9CisJCQljbGtfZW5h
YmxlKHB4YS0+Y2xrKTsKKwkJCXB4YS0+Y2xrX2VuYWJsZSA9IDE7CisJCX0KKwl9Cit9CisKK3N0
YXRpYyBzdHJ1Y3Qgc2RoY2lfb3BzIHNkaGNpX3B4YV9vcHMgPSB7CisJLnNldF9jbG9jawk9IHNk
aGNpX3B4YV9zZXRfY2xvY2ssCit9OworCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKipcCisgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICoKKyAqIHNkaGNpLXBsdGZtIGNhbGxiYWNrcyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKKyAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKgorXCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqLworc3RhdGljIGludCBzZGhjaV9weGFfaW5pdChz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGEgKnBkYXRhLCB2
b2lkKiBwcml2X3BkYXRhKQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYo
aG9zdCk7CisJc3RydWN0IGRldmljZSAqZGV2ID0gbW1jX2Rldihob3N0LT5tbWMpOworCisJcHhh
LT5wZGF0YSA9IHByaXZfcGRhdGE7CisJcHhhLT5jbGtfZW5hYmxlID0gMDsKKworCXB4YS0+Y2xr
ID0gY2xrX2dldChkZXYsICJQWEEtU0RIQ0xLIik7CisJaWYgKElTX0VSUihweGEtPmNsaykpIHsK
KwkJZGV2X2VycihkZXYsICJjbGsgZXJyXG4iKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCWNs
a19lbmFibGUocHhhLT5jbGspOworCWRldl9kYmcoZGV2LCAiU0RIQyBjbG9jazolbHVcbiIsIGNs
a19nZXRfcmF0ZShweGEtPmNsaykpOworCisJcHhhLT5jbGtfZW5hYmxlID0gMDsKKwlweGEtPnF1
aXJrcyA9IHBkYXRhLT5xdWlya3M7CisKKwlpZiAocHhhLT5wZGF0YS0+cHhhX3F1aXJrICYgUFhB
X1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTikKKwkJcHhhLT5xdWlya3MgfD0gU0RIQ0lfUVVJ
UktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB1bnNp
Z25lZCBpbnQgc2RoY2lfcHhhX2dldF9xdWlyayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKK3sK
KwlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCisJcmV0dXJuIHB4
YS0+cXVpcmtzOworfQorCitzdGF0aWMgdm9pZCBzZGhjaV9weGFfc2V0X21heF9zcGVlZChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKK3sKKwlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBzZGhjaV9w
cml2KGhvc3QpOworCisJaWYgKHB4YS0+cGRhdGEtPm1heF9zcGVlZCkKKwkJaG9zdC0+bW1jLT5m
X21heCA9IHB4YS0+cGRhdGEtPm1heF9zcGVlZDsKK30KKworc3RhdGljIHZvaWQgc2RoY2lfcHhh
X2V4aXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhh
ID0gc2RoY2lfcHJpdihob3N0KTsKKworCWlmIChweGEtPmNsa19lbmFibGUpCisJCWNsa19kaXNh
YmxlKHB4YS0+Y2xrKTsKKwljbGtfcHV0KHB4YS0+Y2xrKTsKK30KKworc3RhdGljIHN0cnVjdCBz
ZGhjaV9ob3N0ICpzZGhjaV9weGFfYWxsb2NfaG9zdChzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJ
cmV0dXJuIHNkaGNpX2FsbG9jX2hvc3QoZGV2LCBzaXplb2Yoc3RydWN0IHNkaGNpX3B4YSkpOwor
fQorCitzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhjaV9weGFfcGRhdGEgPSB7CisJLm9wcwk9
ICZzZGhjaV9weGFfb3BzLAorCS5xdWlya3MgPSBTREhDSV9RVUlSS19CUk9LRU5fQURNQSB8IFNE
SENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTCwKKwkuaW5pdAk9IHNkaGNpX3B4YV9pbml0LAor
CS5leGl0CT0gc2RoY2lfcHhhX2V4aXQsCisJLmdldF9xdWlyawk9IHNkaGNpX3B4YV9nZXRfcXVp
cmssCisJLnNldF9tYXhfc3BlZWQJPSBzZGhjaV9weGFfc2V0X21heF9zcGVlZCwKKwkuYWxsb2Nf
aG9zdAk9IHNkaGNpX3B4YV9hbGxvY19ob3N0LAorfTsKKworTU9EVUxFX0RFU0NSSVBUSU9OKCJT
REggY29udHJvbGxlciBkcml2ZXIgZm9yIFBYQTE2OC9QWEE5MTAvTU1QMiIpOworTU9EVUxFX0FV
VEhPUigiWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Iik7CitNT0RVTEVf
TElDRU5TRSgiR1BMIHYyIik7Ci0tIAoxLjcuMC40Cgo=
--005045013e1513495e049127784b--
