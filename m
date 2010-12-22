From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 15/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:09:58 -0800
Message-ID: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_22DA8CC38CB24EEEAAD88599BD589CCEmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49732 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752412Ab0LVHMy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:12:54 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_22DA8CC38CB24EEEAAD88599BD589CCEmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 09a87e2cbf0e58e3c864406fe09cee8ec1024f91 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 11:41:07 -0800
Subject: [PATCH] arch-arm: allow PXA168/PXA910/MMP2 SoC to be selected - no=
t same

The PXA168, PXA910, and MMP2 are not the same SOC.  The family
of embedded processors have slightly different internal blocks
for SD, I2C, etc.  Sometimes it is important to know which SOC
is being used due to differences in the silicon.  Sometimes it
is important to know evaluation boards should be selected based
on the SOC on the board.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark. F. Brown <markb@marvell.com>
Tested-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/Kconfig |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index efe07d4..b6edd4f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -516,18 +516,28 @@ config ARCH_ORION5X
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
 	  Orion-2 (5281), Orion-1-90 (6183).
=20
-config ARCH_MMP
-	bool "Marvell PXA168/910/MMP2"
+config ARCH_PXA168
+	bool "Marvell PXA168"
+	select ARCH_MMP
+	select CPU_PXA168
+	help
+	  Support for Marvell PXA168 processor line.
+
+config ARCH_PXA910
+	bool "Marvell PXA910"
 	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select GENERIC_CLOCKEVENTS
-	select HAVE_SCHED_CLOCK
-	select TICK_ONESHOT
-	select PLAT_PXA
-	select SPARSE_IRQ
+	select ARCH_MMP
+	select CPU_PXA910
 	help
-	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
+	  Support for Marvell PXA910 processor line.
+
+config ARCH_MMP2
+	bool "Marvell MMP2"
+	depends on MMU
+	select ARCH_MMP
+	select CPU_MMP2
+	help
+	  Support for Marvell MMP2 processor line.
=20
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
@@ -948,6 +958,16 @@ source "arch/arm/mach-orion5x/Kconfig"
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
=20
+config ARCH_MMP
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
+	select TICK_ONESHOT
+	select PLAT_PXA
+	select SPARSE_IRQ
+
 source "arch/arm/mach-mmp/Kconfig"
=20
 source "arch/arm/mach-realview/Kconfig"
--=20
1.6.0.4

--_002_22DA8CC38CB24EEEAAD88599BD589CCEmarvellcom_
Content-Type: application/octet-stream;
	name="0015-arch-arm-allow-PXA168-PXA910-MMP2-SoC-to-be-selecte.patch"
Content-Description: 0015-arch-arm-allow-PXA168-PXA910-MMP2-SoC-to-be-selecte.patch
Content-Disposition: attachment;
	filename="0015-arch-arm-allow-PXA168-PXA910-MMP2-SoC-to-be-selecte.patch";
	size=2311; creation-date="Tue, 21 Dec 2010 23:09:58 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOWE4N2UyY2JmMGU1OGUzYzg2NDQwNmZlMDljZWU4ZWMxMDI0ZjkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDExOjQxOjA3IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gYXJj
aC1hcm06IGFsbG93IFBYQTE2OC9QWEE5MTAvTU1QMiBTb0MgdG8gYmUgc2VsZWN0ZWQgLSBub3Qg
c2FtZQoKVGhlIFBYQTE2OCwgUFhBOTEwLCBhbmQgTU1QMiBhcmUgbm90IHRoZSBzYW1lIFNPQy4g
IFRoZSBmYW1pbHkKb2YgZW1iZWRkZWQgcHJvY2Vzc29ycyBoYXZlIHNsaWdodGx5IGRpZmZlcmVu
dCBpbnRlcm5hbCBibG9ja3MKZm9yIFNELCBJMkMsIGV0Yy4gIFNvbWV0aW1lcyBpdCBpcyBpbXBv
cnRhbnQgdG8ga25vdyB3aGljaCBTT0MKaXMgYmVpbmcgdXNlZCBkdWUgdG8gZGlmZmVyZW5jZXMg
aW4gdGhlIHNpbGljb24uICBTb21ldGltZXMgaXQKaXMgaW1wb3J0YW50IHRvIGtub3cgZXZhbHVh
dGlvbiBib2FyZHMgc2hvdWxkIGJlIHNlbGVjdGVkIGJhc2VkCm9uIHRoZSBTT0Mgb24gdGhlIGJv
YXJkLgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4K
U2lnbmVkLW9mZi1ieTogTWFyay4gRi4gQnJvd24gPG1hcmtiQG1hcnZlbGwuY29tPgpUZXN0ZWQt
Ynk6IFBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vS2Nv
bmZpZyB8ICAgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9LY29uZmlnIGIvYXJjaC9hcm0vS2NvbmZpZwppbmRleCBlZmUwN2Q0Li5i
NmVkZDRmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9LY29uZmlnCisrKyBiL2FyY2gvYXJtL0tjb25m
aWcKQEAgLTUxNiwxOCArNTE2LDI4IEBAIGNvbmZpZyBBUkNIX09SSU9ONVgKIAkgIE9yaW9uLTEg
KDUxODEpLCBPcmlvbi1Wb0lQICg1MTgxTCksIE9yaW9uLU5BUyAoNTE4MiksCiAJICBPcmlvbi0y
ICg1MjgxKSwgT3Jpb24tMS05MCAoNjE4MykuCiAKLWNvbmZpZyBBUkNIX01NUAotCWJvb2wgIk1h
cnZlbGwgUFhBMTY4LzkxMC9NTVAyIgorY29uZmlnIEFSQ0hfUFhBMTY4CisJYm9vbCAiTWFydmVs
bCBQWEExNjgiCisJc2VsZWN0IEFSQ0hfTU1QCisJc2VsZWN0IENQVV9QWEExNjgKKwloZWxwCisJ
ICBTdXBwb3J0IGZvciBNYXJ2ZWxsIFBYQTE2OCBwcm9jZXNzb3IgbGluZS4KKworY29uZmlnIEFS
Q0hfUFhBOTEwCisJYm9vbCAiTWFydmVsbCBQWEE5MTAiCiAJZGVwZW5kcyBvbiBNTVUKLQlzZWxl
Y3QgQVJDSF9SRVFVSVJFX0dQSU9MSUIKLQlzZWxlY3QgQ0xLREVWX0xPT0tVUAotCXNlbGVjdCBH
RU5FUklDX0NMT0NLRVZFTlRTCi0Jc2VsZWN0IEhBVkVfU0NIRURfQ0xPQ0sKLQlzZWxlY3QgVElD
S19PTkVTSE9UCi0Jc2VsZWN0IFBMQVRfUFhBCi0Jc2VsZWN0IFNQQVJTRV9JUlEKKwlzZWxlY3Qg
QVJDSF9NTVAKKwlzZWxlY3QgQ1BVX1BYQTkxMAogCWhlbHAKLQkgIFN1cHBvcnQgZm9yIE1hcnZl
bGwncyBQWEExNjgvUFhBOTEwKE1NUCkgYW5kIE1NUDIgcHJvY2Vzc29yIGxpbmUuCisJICBTdXBw
b3J0IGZvciBNYXJ2ZWxsIFBYQTkxMCBwcm9jZXNzb3IgbGluZS4KKworY29uZmlnIEFSQ0hfTU1Q
MgorCWJvb2wgIk1hcnZlbGwgTU1QMiIKKwlkZXBlbmRzIG9uIE1NVQorCXNlbGVjdCBBUkNIX01N
UAorCXNlbGVjdCBDUFVfTU1QMgorCWhlbHAKKwkgIFN1cHBvcnQgZm9yIE1hcnZlbGwgTU1QMiBw
cm9jZXNzb3IgbGluZS4KIAogY29uZmlnIEFSQ0hfS1M4Njk1CiAJYm9vbCAiTWljcmVsL0tlbmRp
biBLUzg2OTUiCkBAIC05NDgsNiArOTU4LDE2IEBAIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1vcmlv
bjV4L0tjb25maWciCiBzb3VyY2UgImFyY2gvYXJtL21hY2gtcHhhL0tjb25maWciCiBzb3VyY2Ug
ImFyY2gvYXJtL3BsYXQtcHhhL0tjb25maWciCiAKK2NvbmZpZyBBUkNIX01NUAorCWJvb2wKKwlz
ZWxlY3QgQVJDSF9SRVFVSVJFX0dQSU9MSUIKKwlzZWxlY3QgQ0xLREVWX0xPT0tVUAorCXNlbGVj
dCBHRU5FUklDX0NMT0NLRVZFTlRTCisJc2VsZWN0IEhBVkVfU0NIRURfQ0xPQ0sKKwlzZWxlY3Qg
VElDS19PTkVTSE9UCisJc2VsZWN0IFBMQVRfUFhBCisJc2VsZWN0IFNQQVJTRV9JUlEKKwogc291
cmNlICJhcmNoL2FybS9tYWNoLW1tcC9LY29uZmlnIgogCiBzb3VyY2UgImFyY2gvYXJtL21hY2gt
cmVhbHZpZXcvS2NvbmZpZyIKLS0gCjEuNi4wLjQKCg==

--_002_22DA8CC38CB24EEEAAD88599BD589CCEmarvellcom_--
