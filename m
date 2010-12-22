From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 7/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:08:35 -0800
Message-ID: <C8F2F5E1-E72D-4679-AB8F-748CBE736262@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_C8F2F5E1E72D4679AB8F748CBE736262marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53589 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752412Ab0LVHNJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:13:09 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_C8F2F5E1E72D4679AB8F748CBE736262marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 499888df1a52491c201077c8a0f8310b70583290 Mon Sep 17 00:00:00 2001
From: philip <philip@philip-laptop.(none)>
Date: Sat, 11 Dec 2010 16:58:59 -0800
Subject: [PATCH] sdhci: Add pre and post reset processing for chip specific=
 reset

Marvell pxa controllers have private registers that need to be
touched before and after a reset is done.  Implement hooks
to allow this to happen.

Signed-off-by: philip <philip@philip-laptop.(none)>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..f439881 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -157,6 +157,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mas=
k)
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);
=20
+	if (host->ops->platform_reset_enter)
+		host->ops->platform_reset_enter(host, mask);
+
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
=20
 	if (mask & SDHCI_RESET_ALL)
@@ -177,6 +180,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mas=
k)
 		mdelay(1);
 	}
=20
+	if (host->ops->platform_reset_exit)
+		host->ops->platform_reset_exit(host, mask);
+
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..9dd7bc1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -222,6 +222,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
+	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 };
=20
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--=20
1.6.0.4

--_002_C8F2F5E1E72D4679AB8F748CBE736262marvellcom_
Content-Type: application/octet-stream;
	name="0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch"
Content-Description: 0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch
Content-Disposition: attachment;
	filename="0007-sdhci-Add-pre-and-post-reset-processing-for-chip-sp.patch";
	size=1911; creation-date="Tue, 21 Dec 2010 23:08:36 GMT";
	modification-date="Tue, 21 Dec 2010 23:08:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OTk4ODhkZjFhNTI0OTFjMjAxMDc3YzhhMGY4MzEwYjcwNTgzMjkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBwaGlsaXAgPHBoaWxpcEBwaGlsaXAtbGFwdG9wLihub25lKT4K
RGF0ZTogU2F0LCAxMSBEZWMgMjAxMCAxNjo1ODo1OSAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHNk
aGNpOiBBZGQgcHJlIGFuZCBwb3N0IHJlc2V0IHByb2Nlc3NpbmcgZm9yIGNoaXAgc3BlY2lmaWMg
cmVzZXQKCk1hcnZlbGwgcHhhIGNvbnRyb2xsZXJzIGhhdmUgcHJpdmF0ZSByZWdpc3RlcnMgdGhh
dCBuZWVkIHRvIGJlCnRvdWNoZWQgYmVmb3JlIGFuZCBhZnRlciBhIHJlc2V0IGlzIGRvbmUuICBJ
bXBsZW1lbnQgaG9va3MKdG8gYWxsb3cgdGhpcyB0byBoYXBwZW4uCgpTaWduZWQtb2ZmLWJ5OiBw
aGlsaXAgPHBoaWxpcEBwaGlsaXAtbGFwdG9wLihub25lKT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLmMgfCAgICA2ICsrKysrKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAgMiAr
KwogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jCmluZGV4IGQ1ZmViZTUuLmY0Mzk4ODEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTE1Nyw2ICsxNTcsOSBA
QCBzdGF0aWMgdm9pZCBzZGhjaV9yZXNldChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFz
aykKIAlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfUkVTVE9SRV9JUlFTX0FGVEVSX1JF
U0VUKQogCQlpZXIgPSBzZGhjaV9yZWFkbChob3N0LCBTREhDSV9JTlRfRU5BQkxFKTsKIAorCWlm
IChob3N0LT5vcHMtPnBsYXRmb3JtX3Jlc2V0X2VudGVyKQorCQlob3N0LT5vcHMtPnBsYXRmb3Jt
X3Jlc2V0X2VudGVyKGhvc3QsIG1hc2spOworCiAJc2RoY2lfd3JpdGViKGhvc3QsIG1hc2ssIFNE
SENJX1NPRlRXQVJFX1JFU0VUKTsKIAogCWlmIChtYXNrICYgU0RIQ0lfUkVTRVRfQUxMKQpAQCAt
MTc3LDYgKzE4MCw5IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3Jlc2V0KHN0cnVjdCBzZGhjaV9ob3N0
ICpob3N0LCB1OCBtYXNrKQogCQltZGVsYXkoMSk7CiAJfQogCisJaWYgKGhvc3QtPm9wcy0+cGxh
dGZvcm1fcmVzZXRfZXhpdCkKKwkJaG9zdC0+b3BzLT5wbGF0Zm9ybV9yZXNldF9leGl0KGhvc3Qs
IG1hc2spOworCiAJaWYgKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJLX1JFU1RPUkVfSVJRU19B
RlRFUl9SRVNFVCkKIAkJc2RoY2lfY2xlYXJfc2V0X2lycXMoaG9zdCwgU0RIQ0lfSU5UX0FMTF9N
QVNLLCBpZXIpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS5oCmluZGV4IDZlMDk2OWUuLjlkZDdiYzEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgK
QEAgLTIyMiw2ICsyMjIsOCBAQCBzdHJ1Y3Qgc2RoY2lfb3BzIHsKIAl2b2lkICgqcGxhdGZvcm1f
c2VuZF9pbml0Xzc0X2Nsb2Nrcykoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsCiAJCQkJCSAgICAg
dTggcG93ZXJfbW9kZSk7CiAJdW5zaWduZWQgaW50ICAgICgqZ2V0X3JvKShzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCk7CisJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2VudGVyKShzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCwgdTggbWFzayk7CisJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2V4aXQpKHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNrKTsKIH07CiAKICNpZmRlZiBDT05GSUdfTU1DX1NE
SENJX0lPX0FDQ0VTU09SUwotLSAKMS42LjAuNAoK

--_002_C8F2F5E1E72D4679AB8F748CBE736262marvellcom_--
