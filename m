From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:07:33 -0800
Message-ID: <661A407B-8073-4B51-AE40-E3BA6D0B5C42@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_661A407B80734B51AE40E3BA6D0B5C42marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53208 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752007Ab0LVHMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:12:22 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_661A407B80734B51AE40E3BA6D0B5C42marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 870945e223db3080a0d70663ee7c516d12b6e750 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 10:55:35 -0800
Subject: [PATCH] ARM: mmp: add mmc resource for sdh controllers

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h      |   30 ++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h |    2 +
 arch/arm/mach-mmp/mmp2.c                   |   35 ++++++++++++++++++++++++=
++++
 3 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/incl=
ude/mach/mmp2.h
index dbba6e8..01f93a8 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
=20
+#include <plat/sdhci.h>
+
 struct sys_timer;
=20
 extern struct sys_timer mmp2_timer;
@@ -22,6 +24,10 @@ extern struct pxa_device_desc mmp2_device_twsi3;
 extern struct pxa_device_desc mmp2_device_twsi4;
 extern struct pxa_device_desc mmp2_device_twsi5;
 extern struct pxa_device_desc mmp2_device_twsi6;
+extern struct pxa_device_desc mmp2_device_sdh0;
+extern struct pxa_device_desc mmp2_device_sdh1;
+extern struct pxa_device_desc mmp2_device_sdh2;
+extern struct pxa_device_desc mmp2_device_sdh3;
=20
 static inline int mmp2_add_uart(int id)
 {
@@ -63,5 +69,29 @@ static inline int mmp2_add_twsi(int id, struct i2c_pxa_p=
latform_data *data,
 	return pxa_register_device(d, data, sizeof(*data));
 }
=20
+static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
+{
+	struct pxa_device_desc *d =3D NULL;
+
+	switch (id) {
+	case 0:
+		d =3D &mmp2_device_sdh0;
+		break;
+	case 1:
+		d =3D &mmp2_device_sdh1;
+		break;
+	case 2:
+		d =3D &mmp2_device_sdh2;
+		break;
+	case 3:
+		d =3D &mmp2_device_sdh3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pxa_register_device(d, data, sizeof(*data));
+}
+
 #endif /* __ASM_MACH_MMP2_H */
=20
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp=
/include/mach/regs-apmu.h
index ac47023..f7011ef 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -27,6 +27,8 @@
 #define APMU_DMA	APMU_REG(0x064)
 #define APMU_GEU	APMU_REG(0x068)
 #define APMU_BUS	APMU_REG(0x06c)
+#define APMU_SDH2	APMU_REG(0x0e8)
+#define APMU_SDH3	APMU_REG(0x0ec)
=20
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 2e3dd08..8e6c3ac 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -115,6 +115,29 @@ void __init mmp2_init_irq(void)
 	mmp2_init_gpio();
 }
=20
+static void sdhc_clk_enable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =3D  __raw_readl(clk->clk_rst);
+	clk_rst |=3D clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+static void sdhc_clk_disable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =3D  __raw_readl(clk->clk_rst);
+	clk_rst &=3D ~clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+struct clkops sdhc_clk_ops =3D {
+	.enable		=3D sdhc_clk_enable,
+	.disable	=3D sdhc_clk_disable,
+};
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
 static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
@@ -128,6 +151,10 @@ static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
 static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
=20
 static APMU_CLK(nand, NAND, 0xbf, 100000000);
+static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
=20
 static struct clk_lookup mmp2_clkregs[] =3D {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -141,6 +168,10 @@ static struct clk_lookup mmp2_clkregs[] =3D {
 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-pxa.3", "PXA-SDHCLK"),
 };
=20
 static int __init mmp2_init(void)
@@ -191,4 +222,8 @@ MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4, 0xd4033000, =
0x70);
 MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
 MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
 MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
+MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
+MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
+MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
+MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);
=20
--=20
1.6.0.4

--_002_661A407B80734B51AE40E3BA6D0B5C42marvellcom_
Content-Type: application/octet-stream;
	name="0002-ARM-mmp-add-mmc-resource-for-sdh-controllers.patch"
Content-Description: 0002-ARM-mmp-add-mmc-resource-for-sdh-controllers.patch
Content-Disposition: attachment;
	filename="0002-ARM-mmp-add-mmc-resource-for-sdh-controllers.patch";
	size=4820; creation-date="Tue, 21 Dec 2010 23:07:34 GMT";
	modification-date="Tue, 21 Dec 2010 23:07:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NzA5NDVlMjIzZGIzMDgwYTBkNzA2NjNlZTdjNTE2ZDEyYjZlNzUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDEwOjU1OjM1IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gQVJN
OiBtbXA6IGFkZCBtbWMgcmVzb3VyY2UgZm9yIHNkaCBjb250cm9sbGVycwoKU2lnbmVkLW9mZi1i
eTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNo
LW1tcC9pbmNsdWRlL21hY2gvbW1wMi5oICAgICAgfCAgIDMwICsrKysrKysrKysrKysrKysrKysr
KysrKwogYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3JlZ3MtYXBtdS5oIHwgICAgMiAr
CiBhcmNoL2FybS9tYWNoLW1tcC9tbXAyLmMgICAgICAgICAgICAgICAgICAgfCAgIDM1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRl
L21hY2gvbW1wMi5oIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL21tcDIuaAppbmRl
eCBkYmJhNmU4Li4wMWY5M2E4IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRl
L21hY2gvbW1wMi5oCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9tbXAyLmgK
QEAgLTEsNiArMSw4IEBACiAjaWZuZGVmIF9fQVNNX01BQ0hfTU1QMl9ICiAjZGVmaW5lIF9fQVNN
X01BQ0hfTU1QMl9ICiAKKyNpbmNsdWRlIDxwbGF0L3NkaGNpLmg+CisKIHN0cnVjdCBzeXNfdGlt
ZXI7CiAKIGV4dGVybiBzdHJ1Y3Qgc3lzX3RpbWVyIG1tcDJfdGltZXI7CkBAIC0yMiw2ICsyNCwx
MCBAQCBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBtbXAyX2RldmljZV90d3NpMzsKIGV4
dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIG1tcDJfZGV2aWNlX3R3c2k0OwogZXh0ZXJuIHN0
cnVjdCBweGFfZGV2aWNlX2Rlc2MgbW1wMl9kZXZpY2VfdHdzaTU7CiBleHRlcm4gc3RydWN0IHB4
YV9kZXZpY2VfZGVzYyBtbXAyX2RldmljZV90d3NpNjsKK2V4dGVybiBzdHJ1Y3QgcHhhX2Rldmlj
ZV9kZXNjIG1tcDJfZGV2aWNlX3NkaDA7CitleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBt
bXAyX2RldmljZV9zZGgxOworZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgbW1wMl9kZXZp
Y2Vfc2RoMjsKK2V4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIG1tcDJfZGV2aWNlX3NkaDM7
CiAKIHN0YXRpYyBpbmxpbmUgaW50IG1tcDJfYWRkX3VhcnQoaW50IGlkKQogewpAQCAtNjMsNSAr
NjksMjkgQEAgc3RhdGljIGlubGluZSBpbnQgbW1wMl9hZGRfdHdzaShpbnQgaWQsIHN0cnVjdCBp
MmNfcHhhX3BsYXRmb3JtX2RhdGEgKmRhdGEsCiAJcmV0dXJuIHB4YV9yZWdpc3Rlcl9kZXZpY2Uo
ZCwgZGF0YSwgc2l6ZW9mKCpkYXRhKSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgaW50IG1tcDJfYWRk
X3NkaG9zdChpbnQgaWQsIHN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgKmRhdGEpCit7CisJc3Ry
dWN0IHB4YV9kZXZpY2VfZGVzYyAqZCA9IE5VTEw7CisKKwlzd2l0Y2ggKGlkKSB7CisJY2FzZSAw
OgorCQlkID0gJm1tcDJfZGV2aWNlX3NkaDA7CisJCWJyZWFrOworCWNhc2UgMToKKwkJZCA9ICZt
bXAyX2RldmljZV9zZGgxOworCQlicmVhazsKKwljYXNlIDI6CisJCWQgPSAmbW1wMl9kZXZpY2Vf
c2RoMjsKKwkJYnJlYWs7CisJY2FzZSAzOgorCQlkID0gJm1tcDJfZGV2aWNlX3NkaDM7CisJCWJy
ZWFrOworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCXJldHVybiBweGFfcmVn
aXN0ZXJfZGV2aWNlKGQsIGRhdGEsIHNpemVvZigqZGF0YSkpOworfQorCiAjZW5kaWYgLyogX19B
U01fTUFDSF9NTVAyX0ggKi8KIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVk
ZS9tYWNoL3JlZ3MtYXBtdS5oIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3JlZ3Mt
YXBtdS5oCmluZGV4IGFjNDcwMjMuLmY3MDExZWYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
bW1wL2luY2x1ZGUvbWFjaC9yZWdzLWFwbXUuaAorKysgYi9hcmNoL2FybS9tYWNoLW1tcC9pbmNs
dWRlL21hY2gvcmVncy1hcG11LmgKQEAgLTI3LDYgKzI3LDggQEAKICNkZWZpbmUgQVBNVV9ETUEJ
QVBNVV9SRUcoMHgwNjQpCiAjZGVmaW5lIEFQTVVfR0VVCUFQTVVfUkVHKDB4MDY4KQogI2RlZmlu
ZSBBUE1VX0JVUwlBUE1VX1JFRygweDA2YykKKyNkZWZpbmUgQVBNVV9TREgyCUFQTVVfUkVHKDB4
MGU4KQorI2RlZmluZSBBUE1VX1NESDMJQVBNVV9SRUcoMHgwZWMpCiAKICNkZWZpbmUgQVBNVV9G
TkNMS19FTgkoMSA8PCA0KQogI2RlZmluZSBBUE1VX0FYSUNMS19FTgkoMSA8PCAzKQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvbW1wMi5jIGIvYXJjaC9hcm0vbWFjaC1tbXAvbW1wMi5j
CmluZGV4IDJlM2RkMDguLjhlNmMzYWMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtbW1wL21t
cDIuYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC9tbXAyLmMKQEAgLTExNSw2ICsxMTUsMjkgQEAg
dm9pZCBfX2luaXQgbW1wMl9pbml0X2lycSh2b2lkKQogCW1tcDJfaW5pdF9ncGlvKCk7CiB9CiAK
K3N0YXRpYyB2b2lkIHNkaGNfY2xrX2VuYWJsZShzdHJ1Y3QgY2xrICpjbGspCit7CisJdWludDMy
X3QgY2xrX3JzdDsKKworCWNsa19yc3QgID0gIF9fcmF3X3JlYWRsKGNsay0+Y2xrX3JzdCk7CisJ
Y2xrX3JzdCB8PSBjbGstPmVuYWJsZV92YWw7CisJX19yYXdfd3JpdGVsKGNsa19yc3QsIGNsay0+
Y2xrX3JzdCk7Cit9CisKK3N0YXRpYyB2b2lkIHNkaGNfY2xrX2Rpc2FibGUoc3RydWN0IGNsayAq
Y2xrKQoreworCXVpbnQzMl90IGNsa19yc3Q7CisKKwljbGtfcnN0ICA9ICBfX3Jhd19yZWFkbChj
bGstPmNsa19yc3QpOworCWNsa19yc3QgJj0gfmNsay0+ZW5hYmxlX3ZhbDsKKwlfX3Jhd193cml0
ZWwoY2xrX3JzdCwgY2xrLT5jbGtfcnN0KTsKK30KKworc3RydWN0IGNsa29wcyBzZGhjX2Nsa19v
cHMgPSB7CisJLmVuYWJsZQkJPSBzZGhjX2Nsa19lbmFibGUsCisJLmRpc2FibGUJPSBzZGhjX2Ns
a19kaXNhYmxlLAorfTsKKwogLyogQVBCIHBlcmlwaGVyYWwgY2xvY2tzICovCiBzdGF0aWMgQVBC
Q19DTEsodWFydDEsIE1NUDJfVUFSVDEsIDEsIDI2MDAwMDAwKTsKIHN0YXRpYyBBUEJDX0NMSyh1
YXJ0MiwgTU1QMl9VQVJUMiwgMSwgMjYwMDAwMDApOwpAQCAtMTI4LDYgKzE1MSwxMCBAQCBzdGF0
aWMgQVBCQ19DTEsodHdzaTUsIE1NUDJfVFdTSTUsIDAsIDI2MDAwMDAwKTsKIHN0YXRpYyBBUEJD
X0NMSyh0d3NpNiwgTU1QMl9UV1NJNiwgMCwgMjYwMDAwMDApOwogCiBzdGF0aWMgQVBNVV9DTEso
bmFuZCwgTkFORCwgMHhiZiwgMTAwMDAwMDAwKTsKK3N0YXRpYyBBUE1VX0NMS19PUFMoc2RoMCwg
U0RIMCwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19jbGtfb3BzKTsKK3N0YXRpYyBBUE1VX0NMS19P
UFMoc2RoMSwgU0RIMSwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19jbGtfb3BzKTsKK3N0YXRpYyBB
UE1VX0NMS19PUFMoc2RoMiwgU0RIMiwgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19jbGtfb3BzKTsK
K3N0YXRpYyBBUE1VX0NMS19PUFMoc2RoMywgU0RIMywgMHgxYiwgMjAwMDAwMDAwLCAmc2RoY19j
bGtfb3BzKTsKIAogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIG1tcDJfY2xrcmVnc1tdID0gewog
CUlOSVRfQ0xLUkVHKCZjbGtfdWFydDEsICJweGEyeHgtdWFydC4wIiwgTlVMTCksCkBAIC0xNDEs
NiArMTY4LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBtbXAyX2Nsa3JlZ3NbXSA9IHsK
IAlJTklUX0NMS1JFRygmY2xrX3R3c2k1LCAicHhhMnh4LWkyYy40IiwgTlVMTCksCiAJSU5JVF9D
TEtSRUcoJmNsa190d3NpNiwgInB4YTJ4eC1pMmMuNSIsIE5VTEwpLAogCUlOSVRfQ0xLUkVHKCZj
bGtfbmFuZCwgInB4YTN4eC1uYW5kIiwgTlVMTCksCisJSU5JVF9DTEtSRUcoJmNsa19zZGgwLCAi
c2RoY2ktcHhhLjAiLCAiUFhBLVNESENMSyIpLAorCUlOSVRfQ0xLUkVHKCZjbGtfc2RoMSwgInNk
aGNpLXB4YS4xIiwgIlBYQS1TREhDTEsiKSwKKwlJTklUX0NMS1JFRygmY2xrX3NkaDIsICJzZGhj
aS1weGEuMiIsICJQWEEtU0RIQ0xLIiksCisJSU5JVF9DTEtSRUcoJmNsa19zZGgzLCAic2RoY2kt
cHhhLjMiLCAiUFhBLVNESENMSyIpLAogfTsKIAogc3RhdGljIGludCBfX2luaXQgbW1wMl9pbml0
KHZvaWQpCkBAIC0xOTEsNCArMjIyLDggQEAgTU1QMl9ERVZJQ0UodHdzaTQsICJweGEyeHgtaTJj
IiwgMywgVFdTSTQsIDB4ZDQwMzMwMDAsIDB4NzApOwogTU1QMl9ERVZJQ0UodHdzaTUsICJweGEy
eHgtaTJjIiwgNCwgVFdTSTUsIDB4ZDQwMzM4MDAsIDB4NzApOwogTU1QMl9ERVZJQ0UodHdzaTYs
ICJweGEyeHgtaTJjIiwgNSwgVFdTSTYsIDB4ZDQwMzQwMDAsIDB4NzApOwogTU1QMl9ERVZJQ0Uo
bmFuZCwgInB4YTN4eC1uYW5kIiwgLTEsIE5BTkQsIDB4ZDQyODMwMDAsIDB4MTAwLCAyOCwgMjkp
OworTU1QMl9ERVZJQ0Uoc2RoMCwgInNkaGNpLXB4YSIsIDAsIE1NQywgMHhkNDI4MDAwMCwgMHgx
MjApOworTU1QMl9ERVZJQ0Uoc2RoMSwgInNkaGNpLXB4YSIsIDEsIE1NQzIsIDB4ZDQyODA4MDAs
IDB4MTIwKTsKK01NUDJfREVWSUNFKHNkaDIsICJzZGhjaS1weGEiLCAyLCBNTUMzLCAweGQ0Mjgx
MDAwLCAweDEyMCk7CitNTVAyX0RFVklDRShzZGgzLCAic2RoY2ktcHhhIiwgMywgTU1DNCwgMHhk
NDI4MTgwMCwgMHgxMjApOwogCi0tIAoxLjYuMC40Cgo=

--_002_661A407B80734B51AE40E3BA6D0B5C42marvellcom_--
