From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec 3.0
Date: Mon, 16 Aug 2010 09:41:54 -0400
Message-ID: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e645b816dc3653048df0fe83
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56692 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0HPNl4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 09:41:56 -0400
Received: by gwj17 with SMTP id 17so904778gwj.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 06:41:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

--0016e645b816dc3653048df0fe83
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>From fd40adef6ce474d5323edcaa833f675b0eb649cb Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhci: support 10-bit divided clock Mode
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Cc: Matt Fleming <matt@console-pimps.org>
Cc: Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>
Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++++------
 drivers/mmc/host/sdhci.h |    5 +++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 913555e..32dcac9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -983,7 +983,7 @@ static void sdhci_finish_command(struct sdhci_host *hos=
t)

 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
+	int div, max_div;
 	u16 clk;
 	unsigned long timeout;

@@ -1001,13 +1001,23 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	if (clock =3D=3D 0)
 		goto out;

-	for (div =3D 1;div < 256;div *=3D 2) {
-		if ((host->max_clk / div) <=3D clock)
-			break;
+	if (host->version >=3D SDHCI_SPEC_300)
+		max_div =3D 2046;
+	else
+		max_div =3D 256;
+
+	if(host->max_clk <=3D clock)
+		div =3D 1;
+	else {
+		for (div =3D 2; div < max_div; div +=3D 2) {
+			if ((host->max_clk / div) <=3D clock)
+				break;
+		}
 	}
 	div >>=3D 1;

-	clk =3D div << SDHCI_DIVIDER_SHIFT;
+	clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) <<
SDHCI_DIVIDER_HI_SHIFT;
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

@@ -1707,7 +1717,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version =3D (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..50860dc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -86,6 +86,10 @@

 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_HI_SHIFT	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK_LEN	8
+#define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -178,6 +182,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2

 struct sdhci_ops;

--=20
1.7.0.4

--0016e645b816dc3653048df0fe83
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-sdhci-support-10-bit-divided-clock-Mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-support-10-bit-divided-clock-Mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcy37uf80

RnJvbSBmZDQwYWRlZjZjZTQ3NGQ1MzIzZWRjYWE4MzNmNjc1YjBlYjY0OWNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDYgQXVnIDIwMTAgMDc6MTA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZGhjaTog
c3VwcG9ydCAxMC1iaXQgZGl2aWRlZCBjbG9jayBNb2RlCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpDYzogTWF0dCBGbGVtaW5nIDxtYXR0QGNvbnNvbGUtcGltcHMub3JnPgpDYzog
TWljaGHFgiBNaXJvc8WCYXcgPG1pcnF1c0BnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFpoYW5n
ZmVpIEdhbyA8emdhbzZAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
IHwgICAyMiArKysrKysrKysrKysrKysrLS0tLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgg
fCAgICA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5jCmluZGV4IDkxMzU1NWUuLjMyZGNhYzkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTk4
Myw3ICs5ODMsNyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9maW5pc2hfY29tbWFuZChzdHJ1Y3Qgc2Ro
Y2lfaG9zdCAqaG9zdCkKIAogc3RhdGljIHZvaWQgc2RoY2lfc2V0X2Nsb2NrKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xvY2spCiB7Ci0JaW50IGRpdjsKKwlpbnQgZGl2
LCBtYXhfZGl2OwogCXUxNiBjbGs7CiAJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwogCkBAIC0xMDAx
LDEzICsxMDAxLDIzIEBAIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQogCWlmIChjbG9jayA9PSAwKQogCQlnb3Rv
IG91dDsKIAotCWZvciAoZGl2ID0gMTtkaXYgPCAyNTY7ZGl2ICo9IDIpIHsKLQkJaWYgKChob3N0
LT5tYXhfY2xrIC8gZGl2KSA8PSBjbG9jaykKLQkJCWJyZWFrOworCWlmIChob3N0LT52ZXJzaW9u
ID49IFNESENJX1NQRUNfMzAwKQorCQltYXhfZGl2ID0gMjA0NjsKKwllbHNlCisJCW1heF9kaXYg
PSAyNTY7CisKKwlpZihob3N0LT5tYXhfY2xrIDw9IGNsb2NrKQorCQlkaXYgPSAxOworCWVsc2Ug
eworCQlmb3IgKGRpdiA9IDI7IGRpdiA8IG1heF9kaXY7IGRpdiArPSAyKSB7CisJCQlpZiAoKGhv
c3QtPm1heF9jbGsgLyBkaXYpIDw9IGNsb2NrKQorCQkJCWJyZWFrOworCQl9CiAJfQogCWRpdiA+
Pj0gMTsKIAotCWNsayA9IGRpdiA8PCBTREhDSV9ESVZJREVSX1NISUZUOworCWNsayA9IChkaXYg
JiBTREhDSV9ESVZfTUFTSykgPDwgU0RIQ0lfRElWSURFUl9TSElGVDsKKwljbGsgfD0gKChkaXYg
JiBTREhDSV9ESVZfSElfTUFTSykgPj4gU0RIQ0lfRElWX01BU0tfTEVOKSA8PCBTREhDSV9ESVZJ
REVSX0hJX1NISUZUOwogCWNsayB8PSBTREhDSV9DTE9DS19JTlRfRU47CiAJc2RoY2lfd3JpdGV3
KGhvc3QsIGNsaywgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7CiAKQEAgLTE3MDcsNyArMTcxNyw3IEBA
IGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAlob3N0LT52ZXJz
aW9uID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9WRVJTSU9OKTsKIAlob3N0LT52ZXJz
aW9uID0gKGhvc3QtPnZlcnNpb24gJiBTREhDSV9TUEVDX1ZFUl9NQVNLKQogCQkJCT4+IFNESENJ
X1NQRUNfVkVSX1NISUZUOwotCWlmIChob3N0LT52ZXJzaW9uID4gU0RIQ0lfU1BFQ18yMDApIHsK
KwlpZiAoaG9zdC0+dmVyc2lvbiA+IFNESENJX1NQRUNfMzAwKSB7CiAJCXByaW50ayhLRVJOX0VS
UiAiJXM6IFVua25vd24gY29udHJvbGxlciB2ZXJzaW9uICglZCkuICIKIAkJCSJZb3UgbWF5IGV4
cGVyaWVuY2UgcHJvYmxlbXMuXG4iLCBtbWNfaG9zdG5hbWUobW1jKSwKIAkJCWhvc3QtPnZlcnNp
b24pOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5oCmluZGV4IDAzNmNmYWUuLjUwODYwZGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTg2LDYg
Kzg2LDEwIEBACiAKICNkZWZpbmUgU0RIQ0lfQ0xPQ0tfQ09OVFJPTAkweDJDCiAjZGVmaW5lICBT
REhDSV9ESVZJREVSX1NISUZUCTgKKyNkZWZpbmUgIFNESENJX0RJVklERVJfSElfU0hJRlQJNgor
I2RlZmluZSAgU0RIQ0lfRElWX01BU0sJMHhGRgorI2RlZmluZSAgU0RIQ0lfRElWX01BU0tfTEVO
CTgKKyNkZWZpbmUgIFNESENJX0RJVl9ISV9NQVNLCTB4MzAwCiAjZGVmaW5lICBTREhDSV9DTE9D
S19DQVJEX0VOCTB4MDAwNAogI2RlZmluZSAgU0RIQ0lfQ0xPQ0tfSU5UX1NUQUJMRQkweDAwMDIK
ICNkZWZpbmUgIFNESENJX0NMT0NLX0lOVF9FTgkweDAwMDEKQEAgLTE3OCw2ICsxODIsNyBAQAog
I2RlZmluZSAgU0RIQ0lfU1BFQ19WRVJfU0hJRlQJMAogI2RlZmluZSAgIFNESENJX1NQRUNfMTAw
CTAKICNkZWZpbmUgICBTREhDSV9TUEVDXzIwMAkxCisjZGVmaW5lICAgU0RIQ0lfU1BFQ18zMDAJ
MgogCiBzdHJ1Y3Qgc2RoY2lfb3BzOwogCi0tIAoxLjcuMC40Cgo=
--0016e645b816dc3653048df0fe83--
