From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:07:20 -0800
Message-ID: <98992407-793C-4545-AAB3-9C80BE5BCEF5@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_98992407793C4545AAB39C80BE5BCEF5marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:48624 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868Ab0LVHLL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:11:11 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_98992407793C4545AAB39C80BE5BCEF5marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>From 14d9d5e1854684af8daef80d948107d2b59ccdd8 Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Thu, 25 Nov 2010 11:33:13 +0800
Subject: [PATCH] ARM: mmp: append brownstone support

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/Kconfig      |   11 +++
 arch/arm/mach-mmp/Makefile     |    1 +
 arch/arm/mach-mmp/brownstone.c |  166 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 178 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/brownstone.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 0711d3b..95e7c4a 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -37,6 +37,17 @@ config MACH_TTC_DKB
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.
=20
+config MACH_BROWNSTONE
+	bool "Marvell's Brownstone Development Platform"
+	depends on !CPU_MOHAWK
+	select CPU_MMP2
+	help
+	  Say 'Y' here if you want to support the Marvell MMP2-based
+	  Brown Development Platform.
+	  MMP2-based board can't be co-existed with PXA168-based &
+	  PXA910-based development board. Since MMP2 is compatible to
+	  ARMv7 architecture.
+
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
 	select CPU_MMP2
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 751cdbf..5c68382 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MACH_ZYLONITE2)	+=3D aspenite.o
 obj-$(CONFIG_MACH_AVENGERS_LITE)+=3D avengers_lite.o
 obj-$(CONFIG_MACH_TAVOREVB)	+=3D tavorevb.o
 obj-$(CONFIG_MACH_TTC_DKB)	+=3D ttc_dkb.o
+obj-$(CONFIG_MACH_BROWNSTONE)	+=3D brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+=3D flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) +=3D jasper.o
 obj-$(CONFIG_MACH_TETON_BGA)	+=3D teton_bga.o
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
new file mode 100644
index 0000000..635c400
--- /dev/null
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -0,0 +1,166 @@
+/*
+ *  linux/arch/arm/mach-mmp/brownstone.c
+ *
+ *  Support for the Marvell Brownstone Development Platform.
+ *
+ *  Copyright (C) 2009-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/max8649.h>
+#include <linux/mfd/max8925.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/addr-map.h>
+#include <mach/mfp-mmp2.h>
+#include <mach/mmp2.h>
+#include <mach/irqs.h>
+
+#include "common.h"
+
+#define BROWNSTONE_NR_IRQS	(IRQ_BOARD_START + 40)
+
+static unsigned long brownstone_pin_config[] __initdata =3D {
+	/* UART1 */
+	GPIO29_UART1_RXD,
+	GPIO30_UART1_TXD,
+
+	/* UART3 */
+	GPIO51_UART3_RXD,
+	GPIO52_UART3_TXD,
+
+	/* DFI */
+	GPIO168_DFI_D0,
+	GPIO167_DFI_D1,
+	GPIO166_DFI_D2,
+	GPIO165_DFI_D3,
+	GPIO107_DFI_D4,
+	GPIO106_DFI_D5,
+	GPIO105_DFI_D6,
+	GPIO104_DFI_D7,
+	GPIO111_DFI_D8,
+	GPIO164_DFI_D9,
+	GPIO163_DFI_D10,
+	GPIO162_DFI_D11,
+	GPIO161_DFI_D12,
+	GPIO110_DFI_D13,
+	GPIO109_DFI_D14,
+	GPIO108_DFI_D15,
+	GPIO143_ND_nCS0,
+	GPIO144_ND_nCS1,
+	GPIO147_ND_nWE,
+	GPIO148_ND_nRE,
+	GPIO150_ND_ALE,
+	GPIO149_ND_CLE,
+	GPIO112_ND_RDY0,
+	GPIO160_ND_RDY1,
+
+	/* PMIC */
+	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
+
+	/* MMC0 */
+	GPIO131_MMC1_DAT3 | MFP_PULL_HIGH,
+	GPIO132_MMC1_DAT2 | MFP_PULL_HIGH,
+	GPIO133_MMC1_DAT1 | MFP_PULL_HIGH,
+	GPIO134_MMC1_DAT0 | MFP_PULL_HIGH,
+	GPIO136_MMC1_CMD | MFP_PULL_HIGH,
+	GPIO139_MMC1_CLK,
+	GPIO140_MMC1_CD | MFP_PULL_LOW,
+	GPIO141_MMC1_WP | MFP_PULL_LOW,
+
+	/* MMC1 */
+	GPIO37_MMC2_DAT3 | MFP_PULL_HIGH,
+	GPIO38_MMC2_DAT2 | MFP_PULL_HIGH,
+	GPIO39_MMC2_DAT1 | MFP_PULL_HIGH,
+	GPIO40_MMC2_DAT0 | MFP_PULL_HIGH,
+	GPIO41_MMC2_CMD | MFP_PULL_HIGH,
+	GPIO42_MMC2_CLK,
+
+	/* MMC2 */
+	GPIO165_MMC3_DAT7 | MFP_PULL_HIGH,
+	GPIO162_MMC3_DAT6 | MFP_PULL_HIGH,
+	GPIO166_MMC3_DAT5 | MFP_PULL_HIGH,
+	GPIO163_MMC3_DAT4 | MFP_PULL_HIGH,
+	GPIO167_MMC3_DAT3 | MFP_PULL_HIGH,
+	GPIO164_MMC3_DAT2 | MFP_PULL_HIGH,
+	GPIO168_MMC3_DAT1 | MFP_PULL_HIGH,
+	GPIO111_MMC3_DAT0 | MFP_PULL_HIGH,
+	GPIO112_MMC3_CMD | MFP_PULL_HIGH,
+	GPIO151_MMC3_CLK,
+};
+
+static struct regulator_consumer_supply max8649_supply[] =3D {
+	REGULATOR_SUPPLY("vcc_core", NULL),
+};
+
+static struct regulator_init_data max8649_init_data =3D {
+	.constraints	=3D {
+		.name		=3D "vcc_core range",
+		.min_uV		=3D 1150000,
+		.max_uV		=3D 1280000,
+		.always_on	=3D 1,
+		.boot_on	=3D 1,
+		.valid_ops_mask	=3D REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	=3D 1,
+	.consumer_supplies	=3D &max8649_supply[0],
+};
+
+static struct max8649_platform_data brownstone_max8649_info =3D {
+	.mode		=3D 2,	/* VID1 =3D 1, VID0 =3D 0 */
+	.extclk		=3D 0,
+	.ramp_timing	=3D MAX8649_RAMP_32MV,
+	.regulator	=3D &max8649_init_data,
+};
+
+static struct max8925_platform_data brownstone_max8925_info =3D {
+	.irq_base		=3D IRQ_BOARD_START,
+};
+
+static struct i2c_board_info brownstone_twsi1_info[] =3D {
+	[0] =3D {
+		.type		=3D "max8649",
+		.addr		=3D 0x60,
+		.platform_data	=3D &brownstone_max8649_info,
+	},
+	[1] =3D {
+		.type		=3D "max8925",
+		.addr		=3D 0x3c,
+		.irq		=3D IRQ_MMP2_PMIC,
+		.platform_data	=3D &brownstone_max8925_info,
+	},
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 =3D {
+	.max_speed	=3D 25000000,
+};
+
+static void __init brownstone_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
+
+	/* on-chip devices */
+	mmp2_add_uart(1);
+	mmp2_add_uart(3);
+	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
+	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+}
+
+MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
+	/* Maintainer: Haojian Zhuang <haojian.zhuang@marvell.com> */
+	.map_io		=3D mmp_map_io,
+	.nr_irqs	=3D BROWNSTONE_NR_IRQS,
+	.init_irq	=3D mmp2_init_irq,
+	.timer		=3D &mmp2_timer,
+	.init_machine	=3D brownstone_init,
+MACHINE_END
--=20
1.6.0.4



--_002_98992407793C4545AAB39C80BE5BCEF5marvellcom_
Content-Type: application/octet-stream;
	name="0001-ARM-mmp-append-brownstone-support.patch"
Content-Description: 0001-ARM-mmp-append-brownstone-support.patch
Content-Disposition: attachment;
	filename="0001-ARM-mmp-append-brownstone-support.patch"; size=6191;
	creation-date="Tue, 21 Dec 2010 23:07:21 GMT";
	modification-date="Tue, 21 Dec 2010 23:07:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNGQ5ZDVlMTg1NDY4NGFmOGRhZWY4MGQ5NDgxMDdkMmI1OWNjZGQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFRodSwgMjUgTm92IDIwMTAgMTE6MzM6MTMgKzA4MDAKU3ViamVjdDogW1BB
VENIXSBBUk06IG1tcDogYXBwZW5kIGJyb3duc3RvbmUgc3VwcG9ydAoKU2lnbmVkLW9mZi1ieTog
SGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBFcmljIE1pYW8gPGVyaWMueS5taWFvQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW1t
cC9LY29uZmlnICAgICAgfCAgIDExICsrKwogYXJjaC9hcm0vbWFjaC1tbXAvTWFrZWZpbGUgICAg
IHwgICAgMSArCiBhcmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMgfCAgMTY2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTc4IGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
bWFjaC1tbXAvYnJvd25zdG9uZS5jCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvS2Nv
bmZpZyBiL2FyY2gvYXJtL21hY2gtbW1wL0tjb25maWcKaW5kZXggMDcxMWQzYi4uOTVlN2M0YSAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvS2NvbmZpZworKysgYi9hcmNoL2FybS9tYWNo
LW1tcC9LY29uZmlnCkBAIC0zNyw2ICszNywxNyBAQCBjb25maWcgTUFDSF9UVENfREtCCiAJICBT
YXkgJ1knIGhlcmUgaWYgeW91IHdhbnQgdG8gc3VwcG9ydCB0aGUgTWFydmVsbCBQWEE5MTAtYmFz
ZWQKIAkgIFRUQ19ES0IgRGV2ZWxvcG1lbnQgQm9hcmQuCiAKK2NvbmZpZyBNQUNIX0JST1dOU1RP
TkUKKwlib29sICJNYXJ2ZWxsJ3MgQnJvd25zdG9uZSBEZXZlbG9wbWVudCBQbGF0Zm9ybSIKKwlk
ZXBlbmRzIG9uICFDUFVfTU9IQVdLCisJc2VsZWN0IENQVV9NTVAyCisJaGVscAorCSAgU2F5ICdZ
JyBoZXJlIGlmIHlvdSB3YW50IHRvIHN1cHBvcnQgdGhlIE1hcnZlbGwgTU1QMi1iYXNlZAorCSAg
QnJvd24gRGV2ZWxvcG1lbnQgUGxhdGZvcm0uCisJICBNTVAyLWJhc2VkIGJvYXJkIGNhbid0IGJl
IGNvLWV4aXN0ZWQgd2l0aCBQWEExNjgtYmFzZWQgJgorCSAgUFhBOTEwLWJhc2VkIGRldmVsb3Bt
ZW50IGJvYXJkLiBTaW5jZSBNTVAyIGlzIGNvbXBhdGlibGUgdG8KKwkgIEFSTXY3IGFyY2hpdGVj
dHVyZS4KKwogY29uZmlnIE1BQ0hfRkxJTlQKIAlib29sICJNYXJ2ZWxsJ3MgRmxpbnQgRGV2ZWxv
cG1lbnQgUGxhdGZvcm0iCiAJc2VsZWN0IENQVV9NTVAyCmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLW1tcC9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtbW1wL01ha2VmaWxlCmluZGV4IDc1MWNk
YmYuLjVjNjgzODIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtbW1wL01ha2VmaWxlCisrKyBi
L2FyY2gvYXJtL21hY2gtbW1wL01ha2VmaWxlCkBAIC0xNSw2ICsxNSw3IEBAIG9iai0kKENPTkZJ
R19NQUNIX1pZTE9OSVRFMikJKz0gYXNwZW5pdGUubwogb2JqLSQoQ09ORklHX01BQ0hfQVZFTkdF
UlNfTElURSkrPSBhdmVuZ2Vyc19saXRlLm8KIG9iai0kKENPTkZJR19NQUNIX1RBVk9SRVZCKQkr
PSB0YXZvcmV2Yi5vCiBvYmotJChDT05GSUdfTUFDSF9UVENfREtCKQkrPSB0dGNfZGtiLm8KK29i
ai0kKENPTkZJR19NQUNIX0JST1dOU1RPTkUpCSs9IGJyb3duc3RvbmUubwogb2JqLSQoQ09ORklH
X01BQ0hfRkxJTlQpCSs9IGZsaW50Lm8KIG9iai0kKENPTkZJR19NQUNIX01BUlZFTExfSkFTUEVS
KSArPSBqYXNwZXIubwogb2JqLSQoQ09ORklHX01BQ0hfVEVUT05fQkdBKQkrPSB0ZXRvbl9iZ2Eu
bwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25zdG9uZS5jIGIvYXJjaC9hcm0v
bWFjaC1tbXAvYnJvd25zdG9uZS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjYzNWM0MDAKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25l
LmMKQEAgLTAsMCArMSwxNjYgQEAKKy8qCisgKiAgbGludXgvYXJjaC9hcm0vbWFjaC1tbXAvYnJv
d25zdG9uZS5jCisgKgorICogIFN1cHBvcnQgZm9yIHRoZSBNYXJ2ZWxsIEJyb3duc3RvbmUgRGV2
ZWxvcG1lbnQgUGxhdGZvcm0uCisgKgorICogIENvcHlyaWdodCAoQykgMjAwOS0yMDEwIE1hcnZl
bGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMK
KyAqICBwdWJsaXNoaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8KKwor
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2dwaW8uaD4KKyNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvbWFjaGluZS5o
PgorI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9tYXg4NjQ5Lmg+CisjaW5jbHVkZSA8bGludXgv
bWZkL21heDg5MjUuaD4KKworI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CisjaW5jbHVkZSA8
YXNtL21hY2gvYXJjaC5oPgorI2luY2x1ZGUgPG1hY2gvYWRkci1tYXAuaD4KKyNpbmNsdWRlIDxt
YWNoL21mcC1tbXAyLmg+CisjaW5jbHVkZSA8bWFjaC9tbXAyLmg+CisjaW5jbHVkZSA8bWFjaC9p
cnFzLmg+CisKKyNpbmNsdWRlICJjb21tb24uaCIKKworI2RlZmluZSBCUk9XTlNUT05FX05SX0lS
UVMJKElSUV9CT0FSRF9TVEFSVCArIDQwKQorCitzdGF0aWMgdW5zaWduZWQgbG9uZyBicm93bnN0
b25lX3Bpbl9jb25maWdbXSBfX2luaXRkYXRhID0geworCS8qIFVBUlQxICovCisJR1BJTzI5X1VB
UlQxX1JYRCwKKwlHUElPMzBfVUFSVDFfVFhELAorCisJLyogVUFSVDMgKi8KKwlHUElPNTFfVUFS
VDNfUlhELAorCUdQSU81Ml9VQVJUM19UWEQsCisKKwkvKiBERkkgKi8KKwlHUElPMTY4X0RGSV9E
MCwKKwlHUElPMTY3X0RGSV9EMSwKKwlHUElPMTY2X0RGSV9EMiwKKwlHUElPMTY1X0RGSV9EMywK
KwlHUElPMTA3X0RGSV9ENCwKKwlHUElPMTA2X0RGSV9ENSwKKwlHUElPMTA1X0RGSV9ENiwKKwlH
UElPMTA0X0RGSV9ENywKKwlHUElPMTExX0RGSV9EOCwKKwlHUElPMTY0X0RGSV9EOSwKKwlHUElP
MTYzX0RGSV9EMTAsCisJR1BJTzE2Ml9ERklfRDExLAorCUdQSU8xNjFfREZJX0QxMiwKKwlHUElP
MTEwX0RGSV9EMTMsCisJR1BJTzEwOV9ERklfRDE0LAorCUdQSU8xMDhfREZJX0QxNSwKKwlHUElP
MTQzX05EX25DUzAsCisJR1BJTzE0NF9ORF9uQ1MxLAorCUdQSU8xNDdfTkRfbldFLAorCUdQSU8x
NDhfTkRfblJFLAorCUdQSU8xNTBfTkRfQUxFLAorCUdQSU8xNDlfTkRfQ0xFLAorCUdQSU8xMTJf
TkRfUkRZMCwKKwlHUElPMTYwX05EX1JEWTEsCisKKwkvKiBQTUlDICovCisJUE1JQ19QTUlDX0lO
VCB8IE1GUF9MUE1fRURHRV9GQUxMLAorCisJLyogTU1DMCAqLworCUdQSU8xMzFfTU1DMV9EQVQz
IHwgTUZQX1BVTExfSElHSCwKKwlHUElPMTMyX01NQzFfREFUMiB8IE1GUF9QVUxMX0hJR0gsCisJ
R1BJTzEzM19NTUMxX0RBVDEgfCBNRlBfUFVMTF9ISUdILAorCUdQSU8xMzRfTU1DMV9EQVQwIHwg
TUZQX1BVTExfSElHSCwKKwlHUElPMTM2X01NQzFfQ01EIHwgTUZQX1BVTExfSElHSCwKKwlHUElP
MTM5X01NQzFfQ0xLLAorCUdQSU8xNDBfTU1DMV9DRCB8IE1GUF9QVUxMX0xPVywKKwlHUElPMTQx
X01NQzFfV1AgfCBNRlBfUFVMTF9MT1csCisKKwkvKiBNTUMxICovCisJR1BJTzM3X01NQzJfREFU
MyB8IE1GUF9QVUxMX0hJR0gsCisJR1BJTzM4X01NQzJfREFUMiB8IE1GUF9QVUxMX0hJR0gsCisJ
R1BJTzM5X01NQzJfREFUMSB8IE1GUF9QVUxMX0hJR0gsCisJR1BJTzQwX01NQzJfREFUMCB8IE1G
UF9QVUxMX0hJR0gsCisJR1BJTzQxX01NQzJfQ01EIHwgTUZQX1BVTExfSElHSCwKKwlHUElPNDJf
TU1DMl9DTEssCisKKwkvKiBNTUMyICovCisJR1BJTzE2NV9NTUMzX0RBVDcgfCBNRlBfUFVMTF9I
SUdILAorCUdQSU8xNjJfTU1DM19EQVQ2IHwgTUZQX1BVTExfSElHSCwKKwlHUElPMTY2X01NQzNf
REFUNSB8IE1GUF9QVUxMX0hJR0gsCisJR1BJTzE2M19NTUMzX0RBVDQgfCBNRlBfUFVMTF9ISUdI
LAorCUdQSU8xNjdfTU1DM19EQVQzIHwgTUZQX1BVTExfSElHSCwKKwlHUElPMTY0X01NQzNfREFU
MiB8IE1GUF9QVUxMX0hJR0gsCisJR1BJTzE2OF9NTUMzX0RBVDEgfCBNRlBfUFVMTF9ISUdILAor
CUdQSU8xMTFfTU1DM19EQVQwIHwgTUZQX1BVTExfSElHSCwKKwlHUElPMTEyX01NQzNfQ01EIHwg
TUZQX1BVTExfSElHSCwKKwlHUElPMTUxX01NQzNfQ0xLLAorfTsKKworc3RhdGljIHN0cnVjdCBy
ZWd1bGF0b3JfY29uc3VtZXJfc3VwcGx5IG1heDg2NDlfc3VwcGx5W10gPSB7CisJUkVHVUxBVE9S
X1NVUFBMWSgidmNjX2NvcmUiLCBOVUxMKSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVndWxhdG9y
X2luaXRfZGF0YSBtYXg4NjQ5X2luaXRfZGF0YSA9IHsKKwkuY29uc3RyYWludHMJPSB7CisJCS5u
YW1lCQk9ICJ2Y2NfY29yZSByYW5nZSIsCisJCS5taW5fdVYJCT0gMTE1MDAwMCwKKwkJLm1heF91
VgkJPSAxMjgwMDAwLAorCQkuYWx3YXlzX29uCT0gMSwKKwkJLmJvb3Rfb24JPSAxLAorCQkudmFs
aWRfb3BzX21hc2sJPSBSRUdVTEFUT1JfQ0hBTkdFX1ZPTFRBR0UsCisJfSwKKwkubnVtX2NvbnN1
bWVyX3N1cHBsaWVzCT0gMSwKKwkuY29uc3VtZXJfc3VwcGxpZXMJPSAmbWF4ODY0OV9zdXBwbHlb
MF0sCit9OworCitzdGF0aWMgc3RydWN0IG1heDg2NDlfcGxhdGZvcm1fZGF0YSBicm93bnN0b25l
X21heDg2NDlfaW5mbyA9IHsKKwkubW9kZQkJPSAyLAkvKiBWSUQxID0gMSwgVklEMCA9IDAgKi8K
KwkuZXh0Y2xrCQk9IDAsCisJLnJhbXBfdGltaW5nCT0gTUFYODY0OV9SQU1QXzMyTVYsCisJLnJl
Z3VsYXRvcgk9ICZtYXg4NjQ5X2luaXRfZGF0YSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgbWF4ODky
NV9wbGF0Zm9ybV9kYXRhIGJyb3duc3RvbmVfbWF4ODkyNV9pbmZvID0geworCS5pcnFfYmFzZQkJ
PSBJUlFfQk9BUkRfU1RBUlQsCit9OworCitzdGF0aWMgc3RydWN0IGkyY19ib2FyZF9pbmZvIGJy
b3duc3RvbmVfdHdzaTFfaW5mb1tdID0geworCVswXSA9IHsKKwkJLnR5cGUJCT0gIm1heDg2NDki
LAorCQkuYWRkcgkJPSAweDYwLAorCQkucGxhdGZvcm1fZGF0YQk9ICZicm93bnN0b25lX21heDg2
NDlfaW5mbywKKwl9LAorCVsxXSA9IHsKKwkJLnR5cGUJCT0gIm1heDg5MjUiLAorCQkuYWRkcgkJ
PSAweDNjLAorCQkuaXJxCQk9IElSUV9NTVAyX1BNSUMsCisJCS5wbGF0Zm9ybV9kYXRhCT0gJmJy
b3duc3RvbmVfbWF4ODkyNV9pbmZvLAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IHNkaGNpX3B4
YV9wbGF0ZGF0YSBtbXAyX3NkaF9wbGF0ZGF0YV9tbWMwID0geworCS5tYXhfc3BlZWQJPSAyNTAw
MDAwMCwKK307CisKK3N0YXRpYyB2b2lkIF9faW5pdCBicm93bnN0b25lX2luaXQodm9pZCkKK3sK
KwltZnBfY29uZmlnKEFSUkFZX0FORF9TSVpFKGJyb3duc3RvbmVfcGluX2NvbmZpZykpOworCisJ
Lyogb24tY2hpcCBkZXZpY2VzICovCisJbW1wMl9hZGRfdWFydCgxKTsKKwltbXAyX2FkZF91YXJ0
KDMpOworCW1tcDJfYWRkX3R3c2koMSwgTlVMTCwgQVJSQVlfQU5EX1NJWkUoYnJvd25zdG9uZV90
d3NpMV9pbmZvKSk7CisJbW1wMl9hZGRfc2Rob3N0KDAsICZtbXAyX3NkaF9wbGF0ZGF0YV9tbWMw
KTsgLyogU0QvTU1DICovCit9CisKK01BQ0hJTkVfU1RBUlQoQlJPV05TVE9ORSwgIkJyb3duc3Rv
bmUgRGV2ZWxvcG1lbnQgUGxhdGZvcm0iKQorCS8qIE1haW50YWluZXI6IEhhb2ppYW4gWmh1YW5n
IDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4gKi8KKwkubWFwX2lvCQk9IG1tcF9tYXBfaW8s
CisJLm5yX2lycXMJPSBCUk9XTlNUT05FX05SX0lSUVMsCisJLmluaXRfaXJxCT0gbW1wMl9pbml0
X2lycSwKKwkudGltZXIJCT0gJm1tcDJfdGltZXIsCisJLmluaXRfbWFjaGluZQk9IGJyb3duc3Rv
bmVfaW5pdCwKK01BQ0hJTkVfRU5ECi0tIAoxLjYuMC40Cgo=

--_002_98992407793C4545AAB39C80BE5BCEF5marvellcom_--
