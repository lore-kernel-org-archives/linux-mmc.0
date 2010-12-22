From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 10/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:09:11 -0800
Message-ID: <4CEDD9CD-9D40-47A2-8F6D-A546BA3DD675@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_4CEDD9CD9D4047A28F6DA546BA3DD675marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37107 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752490Ab0LVHOa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:14:30 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_4CEDD9CD9D4047A28F6DA546BA3DD675marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From cc32b29e540d0f53a5badb0ec27a6f9252bb0648 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Dec 2010 20:18:29 -0800
Subject: [PATCH] plat-pxa: add infrastructure support for multiple sd card =
slots

enable mmc1, 2, and 3.  eMMC and Wifi are marked PERMANENT
eMMC is enabled as a 8 bit device

Note: eMMC is set to boot first to workaround problem where
booting in logical order requires mmc create work queue
to be multi-threaded.

Signed-off-by: Mark F. Brown <markb@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c         |   13 ++++++++++++-
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 +
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
index 635c400..1f11744 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -145,6 +145,15 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc=
0 =3D {
 	.max_speed	=3D 25000000,
 };
=20
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
+	.flags		=3D PXA_FLAG_CARD_PERMANENT,
+};
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
+	.flags		=3D PXA_FLAG_CARD_PERMANENT |
+				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
+};
+
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
@@ -153,7 +162,9 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD Slot */
+	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
 }
=20
 MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/inc=
lude/plat/sdhci.h
index 224e28c..2762f99 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -16,6 +16,7 @@
 /* pxa specific flag */
 /* Require clock free running */
=20
+#define PXA_FLAG_CARD_PERMANENT		(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
=20
--=20
1.6.0.4

--_002_4CEDD9CD9D4047A28F6DA546BA3DD675marvellcom_
Content-Type: application/octet-stream;
	name="0010-plat-pxa-add-infrastructure-support-for-multiple-sd.patch"
Content-Description: 0010-plat-pxa-add-infrastructure-support-for-multiple-sd.patch
Content-Disposition: attachment;
	filename="0010-plat-pxa-add-infrastructure-support-for-multiple-sd.patch";
	size=2289; creation-date="Tue, 21 Dec 2010 23:09:12 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjYzMyYjI5ZTU0MGQwZjUzYTViYWRiMGVjMjdhNmY5MjUyYmIwNjQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDIwOjE4OjI5IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gcGxh
dC1weGE6IGFkZCBpbmZyYXN0cnVjdHVyZSBzdXBwb3J0IGZvciBtdWx0aXBsZSBzZCBjYXJkIHNs
b3RzCgplbmFibGUgbW1jMSwgMiwgYW5kIDMuICBlTU1DIGFuZCBXaWZpIGFyZSBtYXJrZWQgUEVS
TUFORU5UCmVNTUMgaXMgZW5hYmxlZCBhcyBhIDggYml0IGRldmljZQoKTm90ZTogZU1NQyBpcyBz
ZXQgdG8gYm9vdCBmaXJzdCB0byB3b3JrYXJvdW5kIHByb2JsZW0gd2hlcmUKYm9vdGluZyBpbiBs
b2dpY2FsIG9yZGVyIHJlcXVpcmVzIG1tYyBjcmVhdGUgd29yayBxdWV1ZQp0byBiZSBtdWx0aS10
aHJlYWRlZC4KClNpZ25lZC1vZmYtYnk6IE1hcmsgRi4gQnJvd24gPG1hcmtiQG1hcnZlbGwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0K
IGFyY2gvYXJtL21hY2gtbW1wL2Jyb3duc3RvbmUuYyAgICAgICAgIHwgICAxMyArKysrKysrKysr
KystCiBhcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCB8ICAgIDEgKwogMiBm
aWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtbW1wL2Jyb3duc3RvbmUuYyBiL2FyY2gvYXJtL21hY2gtbW1wL2Jy
b3duc3RvbmUuYwppbmRleCA2MzVjNDAwLi4xZjExNzQ0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW1tcC9icm93bnN0b25lLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25zdG9uZS5j
CkBAIC0xNDUsNiArMTQ1LDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhIG1t
cDJfc2RoX3BsYXRkYXRhX21tYzAgPSB7CiAJLm1heF9zcGVlZAk9IDI1MDAwMDAwLAogfTsKIAor
c3RhdGljIHN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgbW1wMl9zZGhfcGxhdGRhdGFfbW1jMSA9
IHsKKwkuZmxhZ3MJCT0gUFhBX0ZMQUdfQ0FSRF9QRVJNQU5FTlQsCit9OworCitzdGF0aWMgc3Ry
dWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSBtbXAyX3NkaF9wbGF0ZGF0YV9tbWMyID0geworCS5mbGFn
cwkJPSBQWEFfRkxBR19DQVJEX1BFUk1BTkVOVCB8CisJCQkJUFhBX0ZMQUdfU0RfOF9CSVRfQ0FQ
QUJMRV9TTE9ULAorfTsKKwogc3RhdGljIHZvaWQgX19pbml0IGJyb3duc3RvbmVfaW5pdCh2b2lk
KQogewogCW1mcF9jb25maWcoQVJSQVlfQU5EX1NJWkUoYnJvd25zdG9uZV9waW5fY29uZmlnKSk7
CkBAIC0xNTMsNyArMTYyLDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGJyb3duc3RvbmVfaW5pdCh2
b2lkKQogCW1tcDJfYWRkX3VhcnQoMSk7CiAJbW1wMl9hZGRfdWFydCgzKTsKIAltbXAyX2FkZF90
d3NpKDEsIE5VTEwsIEFSUkFZX0FORF9TSVpFKGJyb3duc3RvbmVfdHdzaTFfaW5mbykpOwotCW1t
cDJfYWRkX3NkaG9zdCgwLCAmbW1wMl9zZGhfcGxhdGRhdGFfbW1jMCk7IC8qIFNEL01NQyAqLwor
CW1tcDJfYWRkX3NkaG9zdCgyLCAmbW1wMl9zZGhfcGxhdGRhdGFfbW1jMik7IC8qIGVNTUMgKi8K
KwltbXAyX2FkZF9zZGhvc3QoMCwgJm1tcDJfc2RoX3BsYXRkYXRhX21tYzApOyAvKiBTRCBTbG90
ICovCisJbW1wMl9hZGRfc2Rob3N0KDEsICZtbXAyX3NkaF9wbGF0ZGF0YV9tbWMxKTsgLyogV2lm
aSAqLwogfQogCiBNQUNISU5FX1NUQVJUKEJST1dOU1RPTkUsICJCcm93bnN0b25lIERldmVsb3Bt
ZW50IFBsYXRmb3JtIikKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxh
dC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKaW5kZXgg
MjI0ZTI4Yy4uMjc2MmY5OSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9w
bGF0L3NkaGNpLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgK
QEAgLTE2LDYgKzE2LDcgQEAKIC8qIHB4YSBzcGVjaWZpYyBmbGFnICovCiAvKiBSZXF1aXJlIGNs
b2NrIGZyZWUgcnVubmluZyAqLwogCisjZGVmaW5lIFBYQV9GTEFHX0NBUkRfUEVSTUFORU5UCQko
MTw8MSkKIC8qIEJvYXJkIGRlc2lnbiBzdXBwb3J0cyA4LWJpdCBkYXRhIG9uIFNEL1NESU8gQlVT
ICovCiAjZGVmaW5lIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCAoMTw8MikKIAotLSAK
MS42LjAuNAoK

--_002_4CEDD9CD9D4047A28F6DA546BA3DD675marvellcom_--
