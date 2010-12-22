From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 8/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:08:44 -0800
Message-ID: <3DA195EF-0D31-4C76-BB61-B52BAE9D9689@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_3DA195EF0D314C76BB61B52BAE9D9689marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37875 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752418Ab0LVHOV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:14:21 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_3DA195EF0D314C76BB61B52BAE9D9689marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>From ab5cfb88aab633ef448749531a0b9ddb99a4ee1f Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 14 Dec 2010 16:56:41 -0800
Subject: [PATCH] sdhci: support setting f_max clock via call back

need ability to set f_max independent of max_clk.

setting max_clk does not work since our clock speed is fixed.
adjusting max_clk lower just messes up the clock dividers.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 +++++++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f439881..6486009 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1884,7 +1884,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	else
 		mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_200;
=20
-	mmc->f_max =3D host->max_clk;
+	if (host->ops->get_f_max_clock) {
+		mmc->f_max =3D host->ops->get_f_max_clock(host);
+		if (mmc->f_max > host->max_clk)
+			mmc->f_max =3D host->max_clk;
+	} else
+		mmc->f_max =3D host->max_clk;
+
 	mmc->caps |=3D MMC_CAP_SDIO_IRQ;
=20
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9dd7bc1..a8c43c9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -224,6 +224,7 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 };
=20
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--=20
1.6.0.4

--_002_3DA195EF0D314C76BB61B52BAE9D9689marvellcom_
Content-Type: application/octet-stream;
	name="0008-sdhci-support-setting-f_max-clock-via-call-back.patch"
Content-Description: 0008-sdhci-support-setting-f_max-clock-via-call-back.patch
Content-Disposition: attachment;
	filename="0008-sdhci-support-setting-f_max-clock-via-call-back.patch";
	size=1626; creation-date="Tue, 21 Dec 2010 23:08:45 GMT";
	modification-date="Tue, 21 Dec 2010 23:08:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYjVjZmI4OGFhYjYzM2VmNDQ4NzQ5NTMxYTBiOWRkYjk5YTRlZTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBUdWUsIDE0IERlYyAyMDEwIDE2OjU2OjQxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IHN1cHBvcnQgc2V0dGluZyBmX21heCBjbG9jayB2aWEgY2FsbCBiYWNrCgpuZWVkIGFiaWxp
dHkgdG8gc2V0IGZfbWF4IGluZGVwZW5kZW50IG9mIG1heF9jbGsuCgpzZXR0aW5nIG1heF9jbGsg
ZG9lcyBub3Qgd29yayBzaW5jZSBvdXIgY2xvY2sgc3BlZWQgaXMgZml4ZWQuCmFkanVzdGluZyBt
YXhfY2xrIGxvd2VyIGp1c3QgbWVzc2VzIHVwIHRoZSBjbG9jayBkaXZpZGVycy4KClNpZ25lZC1v
ZmYtYnk6IFBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jIHwgICAgOCArKysrKysrLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5o
IHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLmMKaW5kZXggZjQzOTg4MS4uNjQ4NjAwOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMTg4NCw3
ICsxODg0LDEzIEBAIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkK
IAllbHNlCiAJCW1tYy0+Zl9taW4gPSBob3N0LT5tYXhfY2xrIC8gU0RIQ0lfTUFYX0RJVl9TUEVD
XzIwMDsKIAotCW1tYy0+Zl9tYXggPSBob3N0LT5tYXhfY2xrOworCWlmIChob3N0LT5vcHMtPmdl
dF9mX21heF9jbG9jaykgeworCQltbWMtPmZfbWF4ID0gaG9zdC0+b3BzLT5nZXRfZl9tYXhfY2xv
Y2soaG9zdCk7CisJCWlmIChtbWMtPmZfbWF4ID4gaG9zdC0+bWF4X2NsaykKKwkJCW1tYy0+Zl9t
YXggPSBob3N0LT5tYXhfY2xrOworCX0gZWxzZQorCQltbWMtPmZfbWF4ID0gaG9zdC0+bWF4X2Ns
azsKKwogCW1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1NESU9fSVJROwogCiAJLyoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaAppbmRl
eCA5ZGQ3YmMxLi5hOGM0M2M5IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgK
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCkBAIC0yMjQsNiArMjI0LDcgQEAgc3RydWN0
IHNkaGNpX29wcyB7CiAJdW5zaWduZWQgaW50ICAgICgqZ2V0X3JvKShzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCk7CiAJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2VudGVyKShzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCwgdTggbWFzayk7CiAJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2V4aXQpKHN0cnVjdCBz
ZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNrKTsKKwl1bnNpZ25lZCBpbnQJKCpnZXRfZl9tYXhfY2xv
Y2spKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKIH07CiAKICNpZmRlZiBDT05GSUdfTU1DX1NE
SENJX0lPX0FDQ0VTU09SUwotLSAKMS42LjAuNAoK

--_002_3DA195EF0D314C76BB61B52BAE9D9689marvellcom_--
