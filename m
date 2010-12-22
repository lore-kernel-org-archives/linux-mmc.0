From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 5/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:08:09 -0800
Message-ID: <2A545D39-99AB-4EC5-BA93-643CF18B4D7D@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2A545D3999AB4EC5BA93643CF18B4D7Dmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49608 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751962Ab0LVHM2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:12:28 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_2A545D3999AB4EC5BA93643CF18B4D7Dmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 65e7787bb1ea0bc5bf2efe1d1f2fc43efdf21d10 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Dec 2010 19:23:31 -0800
Subject: [PATCH] Enable BUS WIDTH testing for MMC/eMMC cards

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 13395d2..5686ca3 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -129,6 +129,9 @@ static int __devinit sdhci_pxa_probe(struct platform_de=
vice *pdev)
 	host->irq =3D irq;
 	host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL=
;
=20
+	/* enable mmc bus width testing */
+	host->mmc->caps |=3D MMC_CAP_BUS_WIDTH_TEST;
+
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
--=20
1.6.0.4

--_002_2A545D3999AB4EC5BA93643CF18B4D7Dmarvellcom_
Content-Type: application/octet-stream;
	name="0005-Enable-BUS-WIDTH-testing-for-MMC-eMMC-cards.patch"
Content-Description: 0005-Enable-BUS-WIDTH-testing-for-MMC-eMMC-cards.patch
Content-Disposition: attachment;
	filename="0005-Enable-BUS-WIDTH-testing-for-MMC-eMMC-cards.patch"; size=974;
	creation-date="Tue, 21 Dec 2010 23:08:10 GMT";
	modification-date="Tue, 21 Dec 2010 23:08:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2NWU3Nzg3YmIxZWEwYmM1YmYyZWZlMWQxZjJmYzQzZWZkZjIxZDEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDE5OjIzOjMxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gRW5h
YmxlIEJVUyBXSURUSCB0ZXN0aW5nIGZvciBNTUMvZU1NQyBjYXJkcwoKU2lnbmVkLW9mZi1ieTog
UGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLXB4YS5jIHwgICAgMyArKysKIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhh
LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCmluZGV4IDEzMzk1ZDIuLjU2ODZjYTMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1weGEuYwpAQCAtMTI5LDYgKzEyOSw5IEBAIHN0YXRpYyBpbnQgX19kZXZp
bml0IHNkaGNpX3B4YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWhvc3Qt
PmlycSA9IGlycTsKIAlob3N0LT5xdWlya3MgPSBTREhDSV9RVUlSS19CUk9LRU5fQURNQSB8IFNE
SENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsKIAorCS8qIGVuYWJsZSBtbWMgYnVzIHdpZHRo
IHRlc3RpbmcgKi8KKwlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9CVVNfV0lEVEhfVEVTVDsK
KwogCS8qIElmIHNsb3QgZGVzaWduIHN1cHBvcnRzIDggYml0IGRhdGEsIGluZGljYXRlIHRoaXMg
dG8gTU1DLiAqLwogCWlmIChwZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19TRF84X0JJVF9DQVBBQkxF
X1NMT1QpCiAJCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQXzhfQklUX0RBVEE7Ci0tIAoxLjYu
MC40Cgo=

--_002_2A545D3999AB4EC5BA93643CF18B4D7Dmarvellcom_--
