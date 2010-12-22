From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 6/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:08:23 -0800
Message-ID: <6592E5EE-397B-4474-89FD-4C84B26F14EB@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_6592E5EE397B447489FD4C84B26F14EBmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53460 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752412Ab0LVHNB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:13:01 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_6592E5EE397B447489FD4C84B26F14EBmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>From 3e8414dcda0948450a3c8ea565de0a9e671d4610 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 12 Dec 2010 13:20:24 -0800
Subject: [PATCH] sdhci: ensure clocks are enabled on mulitple controllers

Do not rely on u-boot to do the right thing.  It does not.
Do not disable the system clock to the device.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5686ca3..0afc763 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -35,7 +35,7 @@ struct sdhci_pxa {
 	struct clk			*clk;
 	struct resource			*res;
=20
-	u8 clk_enable;
+	u8				clk_enable;
 };
=20
 /*************************************************************************=
****\
@@ -43,25 +43,17 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                   =
   *
  *                                                                        =
   *
 \*************************************************************************=
****/
-static void set_clock(struct sdhci_host *host, unsigned int clock)
+static void enable_clock(struct sdhci_host *host)
 {
 	struct sdhci_pxa *pxa =3D sdhci_priv(host);
=20
-	if (clock =3D=3D 0) {
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable =3D 0;
-		}
-	} else {
-		if (0 =3D=3D pxa->clk_enable) {
-			clk_enable(pxa->clk);
-			pxa->clk_enable =3D 1;
-		}
+	if (pxa->clk_enable =3D=3D 0) {
+		clk_enable(pxa->clk);
+		pxa->clk_enable =3D 1;
 	}
 }
=20
 static struct sdhci_ops sdhci_pxa_ops =3D {
-	.set_clock =3D set_clock,
 };
=20
 /*************************************************************************=
****\
@@ -136,6 +128,9 @@ static int __devinit sdhci_pxa_probe(struct platform_de=
vice *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
=20
+	/* do not rely on u-boot to enable the clocks */
+	enable_clock(host);
+
 	ret =3D sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
@@ -181,10 +176,6 @@ static int __devexit sdhci_pxa_remove(struct platform_=
device *pdev)
 		if (pxa->res)
 			release_mem_region(pxa->res->start,
 					   resource_size(pxa->res));
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable =3D 0;
-		}
 		clk_put(pxa->clk);
=20
 		sdhci_free_host(host);
--=20
1.6.0.4

--_002_6592E5EE397B447489FD4C84B26F14EBmarvellcom_
Content-Type: application/octet-stream;
	name="0006-sdhci-ensure-clocks-are-enabled-on-mulitple-control.patch"
Content-Description: 0006-sdhci-ensure-clocks-are-enabled-on-mulitple-control.patch
Content-Disposition: attachment;
	filename="0006-sdhci-ensure-clocks-are-enabled-on-mulitple-control.patch";
	size=2505; creation-date="Tue, 21 Dec 2010 23:08:24 GMT";
	modification-date="Tue, 21 Dec 2010 23:08:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzZTg0MTRkY2RhMDk0ODQ1MGEzYzhlYTU2NWRlMGE5ZTY3MWQ0NjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDEyIERlYyAyMDEwIDEzOjIwOjI0IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGVuc3VyZSBjbG9ja3MgYXJlIGVuYWJsZWQgb24gbXVsaXRwbGUgY29udHJvbGxlcnMKCkRv
IG5vdCByZWx5IG9uIHUtYm9vdCB0byBkbyB0aGUgcmlnaHQgdGhpbmcuICBJdCBkb2VzIG5vdC4K
RG8gbm90IGRpc2FibGUgdGhlIHN5c3RlbSBjbG9jayB0byB0aGUgZGV2aWNlLgoKU2lnbmVkLW9m
Zi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KU2lnbmVkLW9mZi1ieTog
TWFyayBGLiBCcm93biA8bWFya2JAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1weGEuYyB8ICAgMjUgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCmlu
ZGV4IDU2ODZjYTMuLjBhZmM3NjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
cHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAtMzUsNyArMzUsNyBA
QCBzdHJ1Y3Qgc2RoY2lfcHhhIHsKIAlzdHJ1Y3QgY2xrCQkJKmNsazsKIAlzdHJ1Y3QgcmVzb3Vy
Y2UJCQkqcmVzOwogCi0JdTggY2xrX2VuYWJsZTsKKwl1OAkJCQljbGtfZW5hYmxlOwogfTsKIAog
LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqXApAQCAtNDMsMjUgKzQzLDE3IEBAIHN0cnVjdCBzZGhjaV9w
eGEgewogICogU0RIQ0kgY29yZSBjYWxsYmFja3MgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqCiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoKIFwqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KLXN0YXRpYyB2b2lkIHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQorc3RhdGljIHZvaWQgZW5hYmxlX2Nsb2NrKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogewogCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNp
X3ByaXYoaG9zdCk7CiAKLQlpZiAoY2xvY2sgPT0gMCkgewotCQlpZiAocHhhLT5jbGtfZW5hYmxl
KSB7Ci0JCQljbGtfZGlzYWJsZShweGEtPmNsayk7Ci0JCQlweGEtPmNsa19lbmFibGUgPSAwOwot
CQl9Ci0JfSBlbHNlIHsKLQkJaWYgKDAgPT0gcHhhLT5jbGtfZW5hYmxlKSB7Ci0JCQljbGtfZW5h
YmxlKHB4YS0+Y2xrKTsKLQkJCXB4YS0+Y2xrX2VuYWJsZSA9IDE7Ci0JCX0KKwlpZiAocHhhLT5j
bGtfZW5hYmxlID09IDApIHsKKwkJY2xrX2VuYWJsZShweGEtPmNsayk7CisJCXB4YS0+Y2xrX2Vu
YWJsZSA9IDE7CiAJfQogfQogCiBzdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9weGFfb3Bz
ID0gewotCS5zZXRfY2xvY2sgPSBzZXRfY2xvY2ssCiB9OwogCiAvKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KipcCkBAIC0xMzYsNiArMTI4LDkgQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcHhhX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaWYgKHBkYXRhLT5mbGFncyAmIFBY
QV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCkKIAkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19D
QVBfOF9CSVRfREFUQTsKIAorCS8qIGRvIG5vdCByZWx5IG9uIHUtYm9vdCB0byBlbmFibGUgdGhl
IGNsb2NrcyAqLworCWVuYWJsZV9jbG9jayhob3N0KTsKKwogCXJldCA9IHNkaGNpX2FkZF9ob3N0
KGhvc3QpOwogCWlmIChyZXQpIHsKIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGFk
ZCBob3N0XG4iKTsKQEAgLTE4MSwxMCArMTc2LDYgQEAgc3RhdGljIGludCBfX2RldmV4aXQgc2Ro
Y2lfcHhhX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlpZiAocHhhLT5y
ZXMpCiAJCQlyZWxlYXNlX21lbV9yZWdpb24ocHhhLT5yZXMtPnN0YXJ0LAogCQkJCQkgICByZXNv
dXJjZV9zaXplKHB4YS0+cmVzKSk7Ci0JCWlmIChweGEtPmNsa19lbmFibGUpIHsKLQkJCWNsa19k
aXNhYmxlKHB4YS0+Y2xrKTsKLQkJCXB4YS0+Y2xrX2VuYWJsZSA9IDA7Ci0JCX0KIAkJY2xrX3B1
dChweGEtPmNsayk7CiAKIAkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOwotLSAKMS42LjAuNAoK

--_002_6592E5EE397B447489FD4C84B26F14EBmarvellcom_--
