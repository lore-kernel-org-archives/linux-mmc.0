From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change
 Kconfig
Date: Wed, 17 Nov 2010 18:56:58 -0800
Message-ID: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_3E707E2391F24BA1A74BC8EE2E8EAF31marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49037 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750850Ab0KRDDd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 22:03:33 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

--_002_3E707E2391F24BA1A74BC8EE2E8EAF31marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 9de09a0575163c223f0aed0842daec9161b2f72e Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 17 Nov 2010 18:52:16 -0800
Subject: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change K=
config

sdhci-pxa.c currently only supports mmp2.  pxa168 and pxa9xx
controllers are not quite compatible with this code.

Disable the ability to select them until sdhci-pxa is changes
to support these systems.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark Brown <markb@marvell.com>
---
 drivers/mmc/host/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f8fa9ef..de138de 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -168,12 +168,12 @@ config MMC_SDHCI_S3C
=20
 config MMC_SDHCI_PXA
 	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_JASPER || MACH_FLINT)
 	select MMC_SDHCI
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
-	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+	  This selects the Marvell(R) MMP2 SD Host Controller.
+	  If you have a MMP2 platform with SD Host Controller
 	  and a card slot, say Y or M here.
=20
 	  If unsure, say N.
--=20
1.6.0.4

--_002_3E707E2391F24BA1A74BC8EE2E8EAF31marvellcom_
Content-Type: application/octet-stream;
	name="0001-sdhci-sdhci-pxa-only-supports-mmp2-at-this-time.-Ch.patch"
Content-Description: 0001-sdhci-sdhci-pxa-only-supports-mmp2-at-this-time.-Ch.patch
Content-Disposition: attachment;
	filename="0001-sdhci-sdhci-pxa-only-supports-mmp2-at-this-time.-Ch.patch";
	size=1417; creation-date="Wed, 17 Nov 2010 18:56:58 GMT";
	modification-date="Wed, 17 Nov 2010 18:56:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZGUwOWEwNTc1MTYzYzIyM2YwYWVkMDg0MmRhZWM5MTYxYjJmNzJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBXZWQsIDE3IE5vdiAyMDEwIDE4OjUyOjE2IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IHNkaGNpLXB4YSBvbmx5IHN1cHBvcnRzIG1tcDIgYXQgdGhpcyB0aW1lLiBDaGFuZ2UgS2Nv
bmZpZwoKc2RoY2ktcHhhLmMgY3VycmVudGx5IG9ubHkgc3VwcG9ydHMgbW1wMi4gIHB4YTE2OCBh
bmQgcHhhOXh4CmNvbnRyb2xsZXJzIGFyZSBub3QgcXVpdGUgY29tcGF0aWJsZSB3aXRoIHRoaXMg
Y29kZS4KCkRpc2FibGUgdGhlIGFiaWxpdHkgdG8gc2VsZWN0IHRoZW0gdW50aWwgc2RoY2ktcHhh
IGlzIGNoYW5nZXMKdG8gc3VwcG9ydCB0aGVzZSBzeXN0ZW1zLgoKU2lnbmVkLW9mZi1ieTogUGhp
bGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KU2lnbmVkLW9mZi1ieTogTWFyayBCcm93
biA8bWFya2JAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnIHwgICAg
NiArKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hv
c3QvS2NvbmZpZwppbmRleCBmOGZhOWVmLi5kZTEzOGRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L0tjb25maWcKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCkBAIC0xNjgsMTIg
KzE2OCwxMiBAQCBjb25maWcgTU1DX1NESENJX1MzQwogCiBjb25maWcgTU1DX1NESENJX1BYQQog
CXRyaXN0YXRlICJNYXJ2ZWxsIFBYQTE2OC9QWEE5MTAvTU1QMiBTRCBIb3N0IENvbnRyb2xsZXIg
c3VwcG9ydCIKLQlkZXBlbmRzIG9uIEFSQ0hfUFhBIHx8IEFSQ0hfTU1QCisJZGVwZW5kcyBvbiAo
QVJDSF9QWEEgfHwgQVJDSF9NTVApICYmIChNQUNIX01BUlZFTExfSkFTUEVSIHx8IE1BQ0hfRkxJ
TlQpCiAJc2VsZWN0IE1NQ19TREhDSQogCXNlbGVjdCBNTUNfU0RIQ0lfSU9fQUNDRVNTT1JTCiAJ
aGVscAotCSAgVGhpcyBzZWxlY3RzIHRoZSBNYXJ2ZWxsKFIpIFBYQTE2OC9QWEE5MTAvTU1QMiBT
RCBIb3N0IENvbnRyb2xsZXIuCi0JICBJZiB5b3UgaGF2ZSBhIFBYQTE2OC9QWEE5MTAvTU1QMiBw
bGF0Zm9ybSB3aXRoIFNEIEhvc3QgQ29udHJvbGxlcgorCSAgVGhpcyBzZWxlY3RzIHRoZSBNYXJ2
ZWxsKFIpIE1NUDIgU0QgSG9zdCBDb250cm9sbGVyLgorCSAgSWYgeW91IGhhdmUgYSBNTVAyIHBs
YXRmb3JtIHdpdGggU0QgSG9zdCBDb250cm9sbGVyCiAJICBhbmQgYSBjYXJkIHNsb3QsIHNheSBZ
IG9yIE0gaGVyZS4KIAogCSAgSWYgdW5zdXJlLCBzYXkgTi4KLS0gCjEuNi4wLjQKCg==

--_002_3E707E2391F24BA1A74BC8EE2E8EAF31marvellcom_--
