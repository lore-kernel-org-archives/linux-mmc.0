From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec 3.0
Date: Tue, 17 Aug 2010 07:08:57 -0400
Message-ID: <AANLkTinxtxAMVe+LY_W_JU558XuG_+ea3HNU8Xr0thja@mail.gmail.com>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
	<4C696233.6000408@csr.com>
	<20100816182710.GA6338@console-pimps.org>
	<4C698956.101@csr.com>
	<20100816192748.GC6263@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64f51a4bc0e5b048e02f919
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61401 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0HQLI6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 07:08:58 -0400
Received: by ywh1 with SMTP id 1so2375132ywh.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2010 04:08:57 -0700 (PDT)
In-Reply-To: <20100816192748.GC6263@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: David Vrabel <david.vrabel@csr.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

--0016e64f51a4bc0e5b048e02f919
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 16, 2010 at 3:27 PM, Matt Fleming <matt@console-pimps.org> wrot=
e:
> On Mon, Aug 16, 2010 at 07:54:14PM +0100, David Vrabel wrote:
>> Matt Fleming wrote:
>> >
>> > Sorry, I did mean to reply to this sooner but I've been travelling. Ye=
ah
>> > David, you're right. Zhangfei, have you confused the Programmable Cloc=
k
>> > Mode in the 3.00 spec here with 10-bit Divided Clock Mode?
>> >
>> > Both 8-bit Divided Clock Mode and 10-bit Divided Clock Mode require th=
e
>> > divisor to be a power of two.
>>
>> The power-of-two requirement only applies to 2.00 controller. =A0From
>> section 2.2.14 of the spec.
>>
>> =A0 =A0"(2) 10-bit Divided Clock Mode
>> =A0 =A0Host Controller Version 3.00 supports this mandatory mode instead=
 of
>> =A0 =A0the 8-bit Divided Clock Mode. The length of divider is extended t=
o
>> =A0 =A010bits and all divider values shall be supported."
>>
>> 3.00 dividers can be any multiple of two.
>
> Yep, you're right. I misread the spec. My bad.
>

David

Thanks for your carefully review, my mistake.
update the patch to distinguish spec 2.0 and 3.0, help review again.

>From 9701da8440b847d8e061107fa6d25bd77698e577 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhci: support 10-bit divided clock Mode
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Cc: Matt Fleming <matt@console-pimps.org>
Cc: Micha=B3 Miros=B3aw <mirqus@gmail.com>
Cc: David Vrabel <david.vrabel@csr.com>
Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |   22 +++++++++++++++++-----
 drivers/mmc/host/sdhci.h |    5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 913555e..7ed6f1c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1001,13 +1001,25 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	if (clock =3D=3D 0)
 		goto out;

-	for (div =3D 1;div < 256;div *=3D 2) {
-		if ((host->max_clk / div) <=3D clock)
-			break;
+	if (host->version >=3D SDHCI_SPEC_300) {
+		if(host->max_clk <=3D clock)
+			div =3D 1;
+		else {
+			for (div =3D 2; div < 2046; div +=3D 2) {
+				if ((host->max_clk / div) <=3D clock)
+					break;
+			}
+		}
+	} else {
+		for (div =3D 1;div < 256;div *=3D 2) {
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

@@ -1707,7 +1719,7 @@ int sdhci_add_host(struct sdhci_host *host)
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

--0016e64f51a4bc0e5b048e02f919
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-sdhci-support-10-bit-divided-clock-Mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-support-10-bit-divided-clock-Mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gczd7aw10

RnJvbSA5NzAxZGE4NDQwYjg0N2Q4ZTA2MTEwN2ZhNmQyNWJkNzc2OThlNTc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDYgQXVnIDIwMTAgMDc6MTA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZGhjaTog
c3VwcG9ydCAxMC1iaXQgZGl2aWRlZCBjbG9jayBNb2RlCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpDYzogTWF0dCBGbGVtaW5nIDxtYXR0QGNvbnNvbGUtcGltcHMub3JnPgpDYzog
TWljaGHFgiBNaXJvc8WCYXcgPG1pcnF1c0BnbWFpbC5jb20+CkNjOiBEYXZpZCBWcmFiZWwgPGRh
dmlkLnZyYWJlbEBjc3IuY29tPgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1h
cnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8ICAgMjIgKysrKysrKysr
KysrKysrKystLS0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAgNSArKysrKwogMiBm
aWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpp
bmRleCA5MTM1NTVlLi43ZWQ2ZjFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC0xMDAxLDEzICsxMDAxLDI1IEBA
IHN0YXRpYyB2b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5z
aWduZWQgaW50IGNsb2NrKQogCWlmIChjbG9jayA9PSAwKQogCQlnb3RvIG91dDsKIAotCWZvciAo
ZGl2ID0gMTtkaXYgPCAyNTY7ZGl2ICo9IDIpIHsKLQkJaWYgKChob3N0LT5tYXhfY2xrIC8gZGl2
KSA8PSBjbG9jaykKLQkJCWJyZWFrOworCWlmIChob3N0LT52ZXJzaW9uID49IFNESENJX1NQRUNf
MzAwKSB7CisJCWlmKGhvc3QtPm1heF9jbGsgPD0gY2xvY2spCisJCQlkaXYgPSAxOworCQllbHNl
IHsKKwkJCWZvciAoZGl2ID0gMjsgZGl2IDwgMjA0NjsgZGl2ICs9IDIpIHsKKwkJCQlpZiAoKGhv
c3QtPm1heF9jbGsgLyBkaXYpIDw9IGNsb2NrKQorCQkJCQlicmVhazsKKwkJCX0KKwkJfQorCX0g
ZWxzZSB7CisJCWZvciAoZGl2ID0gMTtkaXYgPCAyNTY7ZGl2ICo9IDIpIHsKKwkJCWlmICgoaG9z
dC0+bWF4X2NsayAvIGRpdikgPD0gY2xvY2spCisJCQkJYnJlYWs7CisJCX0KIAl9CiAJZGl2ID4+
PSAxOwogCi0JY2xrID0gZGl2IDw8IFNESENJX0RJVklERVJfU0hJRlQ7CisJY2xrID0gKGRpdiAm
IFNESENJX0RJVl9NQVNLKSA8PCBTREhDSV9ESVZJREVSX1NISUZUOworCWNsayB8PSAoKGRpdiAm
IFNESENJX0RJVl9ISV9NQVNLKSA+PiBTREhDSV9ESVZfTUFTS19MRU4pIDw8IFNESENJX0RJVklE
RVJfSElfU0hJRlQ7CiAJY2xrIHw9IFNESENJX0NMT0NLX0lOVF9FTjsKIAlzZGhjaV93cml0ZXco
aG9zdCwgY2xrLCBTREhDSV9DTE9DS19DT05UUk9MKTsKIApAQCAtMTcwNyw3ICsxNzE5LDcgQEAg
aW50IHNkaGNpX2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogCWhvc3QtPnZlcnNp
b24gPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9IT1NUX1ZFUlNJT04pOwogCWhvc3QtPnZlcnNp
b24gPSAoaG9zdC0+dmVyc2lvbiAmIFNESENJX1NQRUNfVkVSX01BU0spCiAJCQkJPj4gU0RIQ0lf
U1BFQ19WRVJfU0hJRlQ7Ci0JaWYgKGhvc3QtPnZlcnNpb24gPiBTREhDSV9TUEVDXzIwMCkgewor
CWlmIChob3N0LT52ZXJzaW9uID4gU0RIQ0lfU1BFQ18zMDApIHsKIAkJcHJpbnRrKEtFUk5fRVJS
ICIlczogVW5rbm93biBjb250cm9sbGVyIHZlcnNpb24gKCVkKS4gIgogCQkJIllvdSBtYXkgZXhw
ZXJpZW5jZSBwcm9ibGVtcy5cbiIsIG1tY19ob3N0bmFtZShtbWMpLAogCQkJaG9zdC0+dmVyc2lv
bik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLmgKaW5kZXggMDM2Y2ZhZS4uNTA4NjBkYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5oCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtODYsNiAr
ODYsMTAgQEAKIAogI2RlZmluZSBTREhDSV9DTE9DS19DT05UUk9MCTB4MkMKICNkZWZpbmUgIFNE
SENJX0RJVklERVJfU0hJRlQJOAorI2RlZmluZSAgU0RIQ0lfRElWSURFUl9ISV9TSElGVAk2Cisj
ZGVmaW5lICBTREhDSV9ESVZfTUFTSwkweEZGCisjZGVmaW5lICBTREhDSV9ESVZfTUFTS19MRU4J
OAorI2RlZmluZSAgU0RIQ0lfRElWX0hJX01BU0sJMHgzMDAKICNkZWZpbmUgIFNESENJX0NMT0NL
X0NBUkRfRU4JMHgwMDA0CiAjZGVmaW5lICBTREhDSV9DTE9DS19JTlRfU1RBQkxFCTB4MDAwMgog
I2RlZmluZSAgU0RIQ0lfQ0xPQ0tfSU5UX0VOCTB4MDAwMQpAQCAtMTc4LDYgKzE4Miw3IEBACiAj
ZGVmaW5lICBTREhDSV9TUEVDX1ZFUl9TSElGVAkwCiAjZGVmaW5lICAgU0RIQ0lfU1BFQ18xMDAJ
MAogI2RlZmluZSAgIFNESENJX1NQRUNfMjAwCTEKKyNkZWZpbmUgICBTREhDSV9TUEVDXzMwMAky
CiAKIHN0cnVjdCBzZGhjaV9vcHM7CiAKLS0gCjEuNy4wLjQKCg==
--0016e64f51a4bc0e5b048e02f919--
