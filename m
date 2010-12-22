From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 17/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:10:28 -0800
Message-ID: <1665D066-3D31-4BA0-91FB-4A8714B12A27@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_1665D0663D314BA091FB4A8714B12A27marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57517 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752026Ab0LVHNK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:13:10 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_1665D0663D314BA091FB4A8714B12A27marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>From 190bdad2e3aff0c139016d03207b2767abf78cd0 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 08:15:01 -0800
Subject: [PATCH] mach-mmp: only show Development boards supported by CPU

Do not show boards that are not supported by the selected CPU.
Makes configuration obvious since only usaable options are shown

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/Kconfig |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 95e7c4a..13d1d44 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,46 +1,52 @@
 if ARCH_MMP
=20
-menu "Marvell PXA168/910/MMP2 Implmentations"
+menu "Marvell Development Boards"
=20
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
-	select CPU_PXA168
+	depends on CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Aspenite Development Board.
=20
 config MACH_ZYLONITE2
 	bool "Marvell's PXA168 Zylonite2 Development Board"
-	select CPU_PXA168
+	depends on CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Zylonite2 Development Board.
=20
 config MACH_AVENGERS_LITE
 	bool "Marvell's PXA168 Avengers Lite Development Board"
-	select CPU_PXA168
+	depends on CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Avengers Lite Development Board.
=20
+config MACH_TETON_BGA
+	bool "Marvell's PXA168 Teton BGA Development Board"
+	depends on CPU_PXA168
+	help
+	  Say 'Y' here if you want to support the Marvell PXA168-based
+	  Teton BGA Development Board.
+
 config MACH_TAVOREVB
 	bool "Marvell's PXA910 TavorEVB Development Board"
-	select CPU_PXA910
+	depends on CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TavorEVB Development Board.
=20
 config MACH_TTC_DKB
-	bool "Marvell's PXA910 TavorEVB Development Board"
-	select CPU_PXA910
+	bool "Marvell's PXA910 TavorTTC_DKB Development Board"
+	depends on CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.
=20
 config MACH_BROWNSTONE
 	bool "Marvell's Brownstone Development Platform"
-	depends on !CPU_MOHAWK
-	select CPU_MMP2
+	depends on CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
 	  Brown Development Platform.
@@ -50,7 +56,7 @@ config MACH_BROWNSTONE
=20
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
-	select CPU_MMP2
+	depends on CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
 	  Flint Development Platform.
@@ -60,21 +66,13 @@ config MACH_FLINT
=20
 config MACH_MARVELL_JASPER
 	bool "Marvell's Jasper Development Platform"
-	select CPU_MMP2
+	depends on CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-base
 	  Jasper Development Platform.
 	  MMP2-based board can't be co-existed with PXA168-based &
 	  PXA910-based development board. Since MMP2 is compatible to
 	  ARMv6 architecture.
-
-config MACH_TETON_BGA
-	bool "Marvell's PXA168 Teton BGA Development Board"
-	select CPU_PXA168
-	help
-	  Say 'Y' here if you want to support the Marvell PXA168-based
-	  Teton BGA Development Board.
-
 endmenu
=20
 config CPU_PXA168
--=20
1.6.0.4



--_002_1665D0663D314BA091FB4A8714B12A27marvellcom_
Content-Type: application/octet-stream;
	name="0017-mach-mmp-only-show-Development-boards-supported-by.patch"
Content-Description: 0017-mach-mmp-only-show-Development-boards-supported-by.patch
Content-Disposition: attachment;
	filename="0017-mach-mmp-only-show-Development-boards-supported-by.patch";
	size=3364; creation-date="Tue, 21 Dec 2010 23:10:29 GMT";
	modification-date="Tue, 21 Dec 2010 23:10:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxOTBiZGFkMmUzYWZmMGMxMzkwMTZkMDMyMDdiMjc2N2FiZjc4Y2QwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDA4OjE1OjAxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbWFj
aC1tbXA6IG9ubHkgc2hvdyBEZXZlbG9wbWVudCBib2FyZHMgc3VwcG9ydGVkIGJ5IENQVQoKRG8g
bm90IHNob3cgYm9hcmRzIHRoYXQgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIHNlbGVjdGVkIENQ
VS4KTWFrZXMgY29uZmlndXJhdGlvbiBvYnZpb3VzIHNpbmNlIG9ubHkgdXNhYWJsZSBvcHRpb25z
IGFyZSBzaG93bgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxs
LmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW1tcC9LY29uZmlnIHwgICAzNiArKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvS2NvbmZp
ZyBiL2FyY2gvYXJtL21hY2gtbW1wL0tjb25maWcKaW5kZXggOTVlN2M0YS4uMTNkMWQ0NCAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvS2NvbmZpZworKysgYi9hcmNoL2FybS9tYWNoLW1t
cC9LY29uZmlnCkBAIC0xLDQ2ICsxLDUyIEBACiBpZiBBUkNIX01NUAogCi1tZW51ICJNYXJ2ZWxs
IFBYQTE2OC85MTAvTU1QMiBJbXBsbWVudGF0aW9ucyIKK21lbnUgIk1hcnZlbGwgRGV2ZWxvcG1l
bnQgQm9hcmRzIgogCiBjb25maWcgTUFDSF9BU1BFTklURQogCWJvb2wgIk1hcnZlbGwncyBQWEEx
NjggQXNwZW5pdGUgRGV2ZWxvcG1lbnQgQm9hcmQiCi0Jc2VsZWN0IENQVV9QWEExNjgKKwlkZXBl
bmRzIG9uIENQVV9QWEExNjgKIAloZWxwCiAJICBTYXkgJ1knIGhlcmUgaWYgeW91IHdhbnQgdG8g
c3VwcG9ydCB0aGUgTWFydmVsbCBQWEExNjgtYmFzZWQKIAkgIEFzcGVuaXRlIERldmVsb3BtZW50
IEJvYXJkLgogCiBjb25maWcgTUFDSF9aWUxPTklURTIKIAlib29sICJNYXJ2ZWxsJ3MgUFhBMTY4
IFp5bG9uaXRlMiBEZXZlbG9wbWVudCBCb2FyZCIKLQlzZWxlY3QgQ1BVX1BYQTE2OAorCWRlcGVu
ZHMgb24gQ1BVX1BYQTE2OAogCWhlbHAKIAkgIFNheSAnWScgaGVyZSBpZiB5b3Ugd2FudCB0byBz
dXBwb3J0IHRoZSBNYXJ2ZWxsIFBYQTE2OC1iYXNlZAogCSAgWnlsb25pdGUyIERldmVsb3BtZW50
IEJvYXJkLgogCiBjb25maWcgTUFDSF9BVkVOR0VSU19MSVRFCiAJYm9vbCAiTWFydmVsbCdzIFBY
QTE2OCBBdmVuZ2VycyBMaXRlIERldmVsb3BtZW50IEJvYXJkIgotCXNlbGVjdCBDUFVfUFhBMTY4
CisJZGVwZW5kcyBvbiBDUFVfUFhBMTY4CiAJaGVscAogCSAgU2F5ICdZJyBoZXJlIGlmIHlvdSB3
YW50IHRvIHN1cHBvcnQgdGhlIE1hcnZlbGwgUFhBMTY4LWJhc2VkCiAJICBBdmVuZ2VycyBMaXRl
IERldmVsb3BtZW50IEJvYXJkLgogCitjb25maWcgTUFDSF9URVRPTl9CR0EKKwlib29sICJNYXJ2
ZWxsJ3MgUFhBMTY4IFRldG9uIEJHQSBEZXZlbG9wbWVudCBCb2FyZCIKKwlkZXBlbmRzIG9uIENQ
VV9QWEExNjgKKwloZWxwCisJICBTYXkgJ1knIGhlcmUgaWYgeW91IHdhbnQgdG8gc3VwcG9ydCB0
aGUgTWFydmVsbCBQWEExNjgtYmFzZWQKKwkgIFRldG9uIEJHQSBEZXZlbG9wbWVudCBCb2FyZC4K
KwogY29uZmlnIE1BQ0hfVEFWT1JFVkIKIAlib29sICJNYXJ2ZWxsJ3MgUFhBOTEwIFRhdm9yRVZC
IERldmVsb3BtZW50IEJvYXJkIgotCXNlbGVjdCBDUFVfUFhBOTEwCisJZGVwZW5kcyBvbiBDUFVf
UFhBOTEwCiAJaGVscAogCSAgU2F5ICdZJyBoZXJlIGlmIHlvdSB3YW50IHRvIHN1cHBvcnQgdGhl
IE1hcnZlbGwgUFhBOTEwLWJhc2VkCiAJICBUYXZvckVWQiBEZXZlbG9wbWVudCBCb2FyZC4KIAog
Y29uZmlnIE1BQ0hfVFRDX0RLQgotCWJvb2wgIk1hcnZlbGwncyBQWEE5MTAgVGF2b3JFVkIgRGV2
ZWxvcG1lbnQgQm9hcmQiCi0Jc2VsZWN0IENQVV9QWEE5MTAKKwlib29sICJNYXJ2ZWxsJ3MgUFhB
OTEwIFRhdm9yVFRDX0RLQiBEZXZlbG9wbWVudCBCb2FyZCIKKwlkZXBlbmRzIG9uIENQVV9QWEE5
MTAKIAloZWxwCiAJICBTYXkgJ1knIGhlcmUgaWYgeW91IHdhbnQgdG8gc3VwcG9ydCB0aGUgTWFy
dmVsbCBQWEE5MTAtYmFzZWQKIAkgIFRUQ19ES0IgRGV2ZWxvcG1lbnQgQm9hcmQuCiAKIGNvbmZp
ZyBNQUNIX0JST1dOU1RPTkUKIAlib29sICJNYXJ2ZWxsJ3MgQnJvd25zdG9uZSBEZXZlbG9wbWVu
dCBQbGF0Zm9ybSIKLQlkZXBlbmRzIG9uICFDUFVfTU9IQVdLCi0Jc2VsZWN0IENQVV9NTVAyCisJ
ZGVwZW5kcyBvbiBDUFVfTU1QMgogCWhlbHAKIAkgIFNheSAnWScgaGVyZSBpZiB5b3Ugd2FudCB0
byBzdXBwb3J0IHRoZSBNYXJ2ZWxsIE1NUDItYmFzZWQKIAkgIEJyb3duIERldmVsb3BtZW50IFBs
YXRmb3JtLgpAQCAtNTAsNyArNTYsNyBAQCBjb25maWcgTUFDSF9CUk9XTlNUT05FCiAKIGNvbmZp
ZyBNQUNIX0ZMSU5UCiAJYm9vbCAiTWFydmVsbCdzIEZsaW50IERldmVsb3BtZW50IFBsYXRmb3Jt
IgotCXNlbGVjdCBDUFVfTU1QMgorCWRlcGVuZHMgb24gQ1BVX01NUDIKIAloZWxwCiAJICBTYXkg
J1knIGhlcmUgaWYgeW91IHdhbnQgdG8gc3VwcG9ydCB0aGUgTWFydmVsbCBNTVAyLWJhc2VkCiAJ
ICBGbGludCBEZXZlbG9wbWVudCBQbGF0Zm9ybS4KQEAgLTYwLDIxICs2NiwxMyBAQCBjb25maWcg
TUFDSF9GTElOVAogCiBjb25maWcgTUFDSF9NQVJWRUxMX0pBU1BFUgogCWJvb2wgIk1hcnZlbGwn
cyBKYXNwZXIgRGV2ZWxvcG1lbnQgUGxhdGZvcm0iCi0Jc2VsZWN0IENQVV9NTVAyCisJZGVwZW5k
cyBvbiBDUFVfTU1QMgogCWhlbHAKIAkgIFNheSAnWScgaGVyZSBpZiB5b3Ugd2FudCB0byBzdXBw
b3J0IHRoZSBNYXJ2ZWxsIE1NUDItYmFzZQogCSAgSmFzcGVyIERldmVsb3BtZW50IFBsYXRmb3Jt
LgogCSAgTU1QMi1iYXNlZCBib2FyZCBjYW4ndCBiZSBjby1leGlzdGVkIHdpdGggUFhBMTY4LWJh
c2VkICYKIAkgIFBYQTkxMC1iYXNlZCBkZXZlbG9wbWVudCBib2FyZC4gU2luY2UgTU1QMiBpcyBj
b21wYXRpYmxlIHRvCiAJICBBUk12NiBhcmNoaXRlY3R1cmUuCi0KLWNvbmZpZyBNQUNIX1RFVE9O
X0JHQQotCWJvb2wgIk1hcnZlbGwncyBQWEExNjggVGV0b24gQkdBIERldmVsb3BtZW50IEJvYXJk
IgotCXNlbGVjdCBDUFVfUFhBMTY4Ci0JaGVscAotCSAgU2F5ICdZJyBoZXJlIGlmIHlvdSB3YW50
IHRvIHN1cHBvcnQgdGhlIE1hcnZlbGwgUFhBMTY4LWJhc2VkCi0JICBUZXRvbiBCR0EgRGV2ZWxv
cG1lbnQgQm9hcmQuCi0KIGVuZG1lbnUKIAogY29uZmlnIENQVV9QWEExNjgKLS0gCjEuNi4wLjQK
Cg==

--_002_1665D0663D314BA091FB4A8714B12A27marvellcom_--
