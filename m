From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Wed, 11 Aug 2010 15:44:54 +0800
Message-ID: <AANLkTinJ0hJcas5h18PGD5f8w6Jn6f6jG8D2WZHK1Amp@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
	<AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
	<AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
	<20100809101042.GA8293@console-pimps.org>
	<AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
	<20100810163244.GA12837@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f276a0ec6e23048d876cbe
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57889 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab0HKHo4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 03:44:56 -0400
Received: by wyb32 with SMTP id 32so1575563wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 00:44:54 -0700 (PDT)
In-Reply-To: <20100810163244.GA12837@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

--001485f276a0ec6e23048d876cbe
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 11, 2010 at 12:32 AM, Matt Fleming <matt@console-pimps.org> wrote:
> On Mon, Aug 09, 2010 at 08:33:16PM +0800, zhangfei gao wrote:
>>
>> Thanks for your careful review, in our platform, we use max/min for
>> the max_div, so miss this modification :(
>> Update the patch, help review again.
>
> What do you mean? Where does max/min come from? It would definitely
> be best if everybody uses the same code to calculate max_div. Have
> you tested the max_div changes? Are you now using this patch on
> your platform or are you still maintaining a patch to do it a
> different way?
>
> If you've got a separate patch and it does this things better
> than the way we currently do them, get it upstream! :-)
>

Hi, Matt

Thanks for your reminder, totally agree with you.
We also use this patch in our platform, and find another issue, div
should +=2 instead of *=2.
-	for (div = 1;div < 256;div *= 2) {
+	for (div = 1;div < max_div;div += 2) {

Update patch, help review.

>From 517077ffae66dd12c409b7c6b41a7014db66a3cc Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhc: support 10-bit divided clock Mode

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/sdhci.c |   14 ++++++++++----
 drivers/mmc/host/sdhci.h |    4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..b2d5e5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -978,7 +978,7 @@ static void sdhci_finish_command(struct sdhci_host *host)

 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
+	int div, max_div;
 	u16 clk;
 	unsigned long timeout;

@@ -996,13 +996,19 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	if (clock == 0)
 		goto out;

-	for (div = 1;div < 256;div *= 2) {
+	if (host->version >= SDHCI_SPEC_300)
+		max_div = 2046;
+	else
+		max_div = 256;
+
+	for (div = 1;div < max_div;div += 2) {
 		if ((host->max_clk / div) <= clock)
 			break;
 	}
 	div >>= 1;

-	clk = div << SDHCI_DIVIDER_SHIFT;
+	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SHIFT) <<
SDHCI_DIVIDER_SHIFT_HI;
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

@@ -1681,7 +1687,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..7c09b4f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -85,6 +85,9 @@

 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_SHIFT_HI	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -177,6 +180,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2

 struct sdhci_ops;

-- 
1.6.0.4

--001485f276a0ec6e23048d876cbe
Content-Type: application/octet-stream;
	name="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcpvd9900

RnJvbSA1MTcwNzdmZmFlNjZkZDEyYzQwOWI3YzZiNDFhNzAxNGRiNjZhM2NjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDYgQXVnIDIwMTAgMDc6MTA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZGhjOiBz
dXBwb3J0IDEwLWJpdCBkaXZpZGVkIGNsb2NrIE1vZGUKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emdhbzZAbWFydmVsbC5jb20+ClJldmlld2VkLWJ5OiBNYXR0IEZsZW1pbmcgPG1hdHRA
Y29uc29sZS1waW1wcy5vcmc+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgICAxNCAr
KysrKysrKysrLS0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAgNCArKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmlu
ZGV4IGM2ZDFiZDguLmIyZDVlNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
YworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTk3OCw3ICs5NzgsNyBAQCBzdGF0
aWMgdm9pZCBzZGhjaV9maW5pc2hfY29tbWFuZChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAog
c3RhdGljIHZvaWQgc2RoY2lfc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNp
Z25lZCBpbnQgY2xvY2spCiB7Ci0JaW50IGRpdjsKKwlpbnQgZGl2LCBtYXhfZGl2OwogCXUxNiBj
bGs7CiAJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwogCkBAIC05OTYsMTMgKzk5NiwxOSBAQCBzdGF0
aWMgdm9pZCBzZGhjaV9zZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVk
IGludCBjbG9jaykKIAlpZiAoY2xvY2sgPT0gMCkKIAkJZ290byBvdXQ7CiAKLQlmb3IgKGRpdiA9
IDE7ZGl2IDwgMjU2O2RpdiAqPSAyKSB7CisJaWYgKGhvc3QtPnZlcnNpb24gPj0gU0RIQ0lfU1BF
Q18zMDApCisJCW1heF9kaXYgPSAyMDQ2OworCWVsc2UKKwkJbWF4X2RpdiA9IDI1NjsKKworCWZv
ciAoZGl2ID0gMTtkaXYgPCBtYXhfZGl2O2RpdiArPSAyKSB7CiAJCWlmICgoaG9zdC0+bWF4X2Ns
ayAvIGRpdikgPD0gY2xvY2spCiAJCQlicmVhazsKIAl9CiAJZGl2ID4+PSAxOwogCi0JY2xrID0g
ZGl2IDw8IFNESENJX0RJVklERVJfU0hJRlQ7CisJY2xrID0gKGRpdiAmIFNESENJX0RJVl9NQVNL
KSA8PCBTREhDSV9ESVZJREVSX1NISUZUOworCWNsayB8PSAoKGRpdiAmIFNESENJX0RJVl9ISV9N
QVNLKSA+PiBTREhDSV9ESVZJREVSX1NISUZUKSA8PCBTREhDSV9ESVZJREVSX1NISUZUX0hJOwog
CWNsayB8PSBTREhDSV9DTE9DS19JTlRfRU47CiAJc2RoY2lfd3JpdGV3KGhvc3QsIGNsaywgU0RI
Q0lfQ0xPQ0tfQ09OVFJPTCk7CiAKQEAgLTE2ODEsNyArMTY4Nyw3IEBAIGludCBzZGhjaV9hZGRf
aG9zdChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAlob3N0LT52ZXJzaW9uID0gc2RoY2lfcmVh
ZHcoaG9zdCwgU0RIQ0lfSE9TVF9WRVJTSU9OKTsKIAlob3N0LT52ZXJzaW9uID0gKGhvc3QtPnZl
cnNpb24gJiBTREhDSV9TUEVDX1ZFUl9NQVNLKQogCQkJCT4+IFNESENJX1NQRUNfVkVSX1NISUZU
OwotCWlmIChob3N0LT52ZXJzaW9uID4gU0RIQ0lfU1BFQ18yMDApIHsKKwlpZiAoaG9zdC0+dmVy
c2lvbiA+IFNESENJX1NQRUNfMzAwKSB7CiAJCXByaW50ayhLRVJOX0VSUiAiJXM6IFVua25vd24g
Y29udHJvbGxlciB2ZXJzaW9uICglZCkuICIKIAkJCSJZb3UgbWF5IGV4cGVyaWVuY2UgcHJvYmxl
bXMuXG4iLCBtbWNfaG9zdG5hbWUobW1jKSwKIAkJCWhvc3QtPnZlcnNpb24pOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCmlu
ZGV4IGM4NDY4MTMuLjdjMDliNGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
aAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTg1LDYgKzg1LDkgQEAKIAogI2Rl
ZmluZSBTREhDSV9DTE9DS19DT05UUk9MCTB4MkMKICNkZWZpbmUgIFNESENJX0RJVklERVJfU0hJ
RlQJOAorI2RlZmluZSAgU0RIQ0lfRElWSURFUl9TSElGVF9ISQk2CisjZGVmaW5lICBTREhDSV9E
SVZfTUFTSwkweEZGCisjZGVmaW5lICBTREhDSV9ESVZfSElfTUFTSwkweDMwMAogI2RlZmluZSAg
U0RIQ0lfQ0xPQ0tfQ0FSRF9FTgkweDAwMDQKICNkZWZpbmUgIFNESENJX0NMT0NLX0lOVF9TVEFC
TEUJMHgwMDAyCiAjZGVmaW5lICBTREhDSV9DTE9DS19JTlRfRU4JMHgwMDAxCkBAIC0xNzcsNiAr
MTgwLDcgQEAKICNkZWZpbmUgIFNESENJX1NQRUNfVkVSX1NISUZUCTAKICNkZWZpbmUgICBTREhD
SV9TUEVDXzEwMAkwCiAjZGVmaW5lICAgU0RIQ0lfU1BFQ18yMDAJMQorI2RlZmluZSAgIFNESENJ
X1NQRUNfMzAwCTIKIAogc3RydWN0IHNkaGNpX29wczsKIAotLSAKMS42LjAuNAoK
--001485f276a0ec6e23048d876cbe--
