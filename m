From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 4/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:07:56 -0800
Message-ID: <31543444-2B86-44CC-AC89-44755BFE2E79@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_315434442B8644CCAC8944755BFE2E79marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53334 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751962Ab0LVHMi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:12:38 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_315434442B8644CCAC8944755BFE2E79marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 5afd59eb5994bef259e327c0cdd1ee8f130f5f70 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Dec 2010 19:12:39 -0800
Subject: [PATCH] sdhci: remove support for quirks in sdhci-pxa.c -- not use=
d

remove support for platform specific quirks in arch files
new method coming in future patch

Signed-off-by: Mark F. Brown <markb@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    2 --
 drivers/mmc/host/sdhci-pxa.c           |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/inc=
lude/plat/sdhci.h
index 270fb2b..224e28c 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -22,12 +22,10 @@
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
  * @max_speed: the maximum speed supported
- * @quirks: quirks of specific device
  * @flags: flags for platform requirement
  */
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
-	unsigned int	quirks;
 	unsigned int	flags;
 };
=20
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 4713238..13395d2 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -129,9 +129,6 @@ static int __devinit sdhci_pxa_probe(struct platform_de=
vice *pdev)
 	host->irq =3D irq;
 	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL=
;
=20
-	if (pdata->quirks)
-		host->quirks |=3D pdata->quirks;
-
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
--=20
1.6.0.4

--_002_315434442B8644CCAC8944755BFE2E79marvellcom_
Content-Type: application/octet-stream;
	name="0004-sdhci-remove-support-for-quirks-in-sdhci-pxa.c-n.patch"
Content-Description: 0004-sdhci-remove-support-for-quirks-in-sdhci-pxa.c-n.patch
Content-Disposition: attachment;
	filename="0004-sdhci-remove-support-for-quirks-in-sdhci-pxa.c-n.patch";
	size=1708; creation-date="Tue, 21 Dec 2010 23:07:57 GMT";
	modification-date="Tue, 21 Dec 2010 23:07:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YWZkNTllYjU5OTRiZWYyNTllMzI3YzBjZGQxZWU4ZjEzMGY1ZjcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDE5OjEyOjM5IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IHJlbW92ZSBzdXBwb3J0IGZvciBxdWlya3MgaW4gc2RoY2ktcHhhLmMgLS0gbm90IHVzZWQK
CnJlbW92ZSBzdXBwb3J0IGZvciBwbGF0Zm9ybSBzcGVjaWZpYyBxdWlya3MgaW4gYXJjaCBmaWxl
cwpuZXcgbWV0aG9kIGNvbWluZyBpbiBmdXR1cmUgcGF0Y2gKClNpZ25lZC1vZmYtYnk6IE1hcmsg
Ri4gQnJvd24gPG1hcmtiQG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5
IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxh
dC9zZGhjaS5oIHwgICAgMiAtLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAg
ICAgfCAgICAzIC0tLQogMiBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNp
LmggYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaAppbmRleCAyNzBmYjJi
Li4yMjRlMjhjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2Ro
Y2kuaAorKysgYi9hcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaApAQCAtMjIs
MTIgKzIyLDEwIEBACiAvKgogICogc3RydWN0IHB4YV9zZGhjaV9wbGF0ZGF0YSgpIC0gUGxhdGZv
cm0gZGV2aWNlIGRhdGEgZm9yIFBYQSBTREhDSQogICogQG1heF9zcGVlZDogdGhlIG1heGltdW0g
c3BlZWQgc3VwcG9ydGVkCi0gKiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2aWNlCiAg
KiBAZmxhZ3M6IGZsYWdzIGZvciBwbGF0Zm9ybSByZXF1aXJlbWVudAogICovCiBzdHJ1Y3Qgc2Ro
Y2lfcHhhX3BsYXRkYXRhIHsKIAl1bnNpZ25lZCBpbnQJbWF4X3NwZWVkOwotCXVuc2lnbmVkIGlu
dAlxdWlya3M7CiAJdW5zaWduZWQgaW50CWZsYWdzOwogfTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1weGEuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKaW5k
ZXggNDcxMzIzOC4uMTMzOTVkMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
eGEuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCkBAIC0xMjksOSArMTI5LDYg
QEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCiAJaG9zdC0+aXJxID0gaXJxOwogCWhvc3QtPnF1aXJrcyA9IFNESENJX1FV
SVJLX0JST0tFTl9BRE1BIHwgU0RIQ0lfUVVJUktfQlJPS0VOX1RJTUVPVVRfVkFMOwogCi0JaWYg
KHBkYXRhLT5xdWlya3MpCi0JCWhvc3QtPnF1aXJrcyB8PSBwZGF0YS0+cXVpcmtzOwotCiAJLyog
SWYgc2xvdCBkZXNpZ24gc3VwcG9ydHMgOCBiaXQgZGF0YSwgaW5kaWNhdGUgdGhpcyB0byBNTUMu
ICovCiAJaWYgKHBkYXRhLT5mbGFncyAmIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCkK
IAkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfOF9CSVRfREFUQTsKLS0gCjEuNi4wLjQKCg==

--_002_315434442B8644CCAC8944755BFE2E79marvellcom_--
