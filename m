From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Thu, 12 Aug 2010 02:46:02 -0400
Message-ID: <AANLkTi=zvsWHmLqWMnssgZTXd6XDSCzuJ3j8ZiQfdp9z@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
	<AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
	<AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
	<20100809101042.GA8293@console-pimps.org>
	<AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
	<20100810163244.GA12837@console-pimps.org>
	<AANLkTinJ0hJcas5h18PGD5f8w6Jn6f6jG8D2WZHK1Amp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd4d9c03d6380048d9ab8b1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0HLGqE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2010 02:46:04 -0400
Received: by wyb32 with SMTP id 32so1037348wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 23:46:02 -0700 (PDT)
In-Reply-To: <AANLkTinJ0hJcas5h18PGD5f8w6Jn6f6jG8D2WZHK1Amp@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

--000e0cd4d9c03d6380048d9ab8b1
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 11, 2010 at 3:44 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> On Wed, Aug 11, 2010 at 12:32 AM, Matt Fleming <matt@console-pimps.org> wrote:
>> On Mon, Aug 09, 2010 at 08:33:16PM +0800, zhangfei gao wrote:
>>>
>>> Thanks for your careful review, in our platform, we use max/min for
>>> the max_div, so miss this modification :(
>>> Update the patch, help review again.
>>
>> What do you mean? Where does max/min come from? It would definitely
>> be best if everybody uses the same code to calculate max_div. Have
>> you tested the max_div changes? Are you now using this patch on
>> your platform or are you still maintaining a patch to do it a
>> different way?
>>
>> If you've got a separate patch and it does this things better
>> than the way we currently do them, get it upstream! :-)
>>

Hi,  Matt

Originally, the div step by *2, and in fact the step should be +2.
However in such case, div start from 2 would be more accurate, so
modify to the following.
Though start from 1 is also OK, since >>2  would get the same result.


-       for (div = 1;div < 256;div *= 2) {
+       if (host->version >= SDHCI_SPEC_300)
+               max_div = 2046;
+       else
+               max_div = 256;
+
+       if(host->max_clk <= clock)
+               div = 1;
+       for (div = 2; div < max_div; div += 2) {

Thanks

updated patch:
>From b17eb3ca9dd23af63ada240e8f77bdd873e853a7 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhc: support 10-bit divided clock Mode

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/sdhci.c |   16 ++++++++++++----
 drivers/mmc/host/sdhci.h |    4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..ccfbc40 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -983,7 +983,7 @@ static void sdhci_finish_command(struct sdhci_host *host)

 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
+	int div, max_div;
 	u16 clk;
 	unsigned long timeout;

@@ -1001,13 +1001,21 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	if (clock == 0)
 		goto out;

-	for (div = 1;div < 256;div *= 2) {
+	if (host->version >= SDHCI_SPEC_300)
+		max_div = 2046;
+	else
+		max_div = 256;
+
+	if(host->max_clk <= clock)
+		div = 1;
+	for (div = 2; div < max_div; div += 2) {
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

@@ -1707,7 +1715,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..d7ef7e4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -86,6 +86,9 @@

 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_SHIFT_HI	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -178,6 +181,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2

 struct sdhci_ops;

-- 
1.7.0.4

--000e0cd4d9c03d6380048d9ab8b1
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcryipfq1

RnJvbSBiMTdlYjNjYTlkZDIzYWY2M2FkYTI0MGU4Zjc3YmRkODczZTg1M2E3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDYgQXVnIDIwMTAgMDc6MTA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZGhjOiBz
dXBwb3J0IDEwLWJpdCBkaXZpZGVkIGNsb2NrIE1vZGUKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emdhbzZAbWFydmVsbC5jb20+ClJldmlld2VkLWJ5OiBNYXR0IEZsZW1pbmcgPG1hdHRA
Y29uc29sZS1waW1wcy5vcmc+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgICAxNiAr
KysrKysrKysrKystLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggfCAgICA0ICsrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMK
aW5kZXggNzg1NTEyMS4uY2NmYmM0MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtOTgzLDcgKzk4Myw3IEBAIHN0
YXRpYyB2b2lkIHNkaGNpX2ZpbmlzaF9jb21tYW5kKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQog
CiBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHVu
c2lnbmVkIGludCBjbG9jaykKIHsKLQlpbnQgZGl2OworCWludCBkaXYsIG1heF9kaXY7CiAJdTE2
IGNsazsKIAl1bnNpZ25lZCBsb25nIHRpbWVvdXQ7CiAKQEAgLTEwMDEsMTMgKzEwMDEsMjEgQEAg
c3RhdGljIHZvaWQgc2RoY2lfc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNp
Z25lZCBpbnQgY2xvY2spCiAJaWYgKGNsb2NrID09IDApCiAJCWdvdG8gb3V0OwogCi0JZm9yIChk
aXYgPSAxO2RpdiA8IDI1NjtkaXYgKj0gMikgeworCWlmIChob3N0LT52ZXJzaW9uID49IFNESENJ
X1NQRUNfMzAwKQorCQltYXhfZGl2ID0gMjA0NjsKKwllbHNlCisJCW1heF9kaXYgPSAyNTY7CisK
KwlpZihob3N0LT5tYXhfY2xrIDw9IGNsb2NrKQorCQlkaXYgPSAxOworCWZvciAoZGl2ID0gMjsg
ZGl2IDwgbWF4X2RpdjsgZGl2ICs9IDIpIHsKIAkJaWYgKChob3N0LT5tYXhfY2xrIC8gZGl2KSA8
PSBjbG9jaykKIAkJCWJyZWFrOwogCX0KIAlkaXYgPj49IDE7CiAKLQljbGsgPSBkaXYgPDwgU0RI
Q0lfRElWSURFUl9TSElGVDsKKwljbGsgPSAoZGl2ICYgU0RIQ0lfRElWX01BU0spIDw8IFNESENJ
X0RJVklERVJfU0hJRlQ7CisJY2xrIHw9ICgoZGl2ICYgU0RIQ0lfRElWX0hJX01BU0spID4+IFNE
SENJX0RJVklERVJfU0hJRlQpIDw8IFNESENJX0RJVklERVJfU0hJRlRfSEk7CiAJY2xrIHw9IFNE
SENJX0NMT0NLX0lOVF9FTjsKIAlzZGhjaV93cml0ZXcoaG9zdCwgY2xrLCBTREhDSV9DTE9DS19D
T05UUk9MKTsKIApAQCAtMTcwNyw3ICsxNzE1LDcgQEAgaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0KQogCWhvc3QtPnZlcnNpb24gPSBzZGhjaV9yZWFkdyhob3N0LCBT
REhDSV9IT1NUX1ZFUlNJT04pOwogCWhvc3QtPnZlcnNpb24gPSAoaG9zdC0+dmVyc2lvbiAmIFNE
SENJX1NQRUNfVkVSX01BU0spCiAJCQkJPj4gU0RIQ0lfU1BFQ19WRVJfU0hJRlQ7Ci0JaWYgKGhv
c3QtPnZlcnNpb24gPiBTREhDSV9TUEVDXzIwMCkgeworCWlmIChob3N0LT52ZXJzaW9uID4gU0RI
Q0lfU1BFQ18zMDApIHsKIAkJcHJpbnRrKEtFUk5fRVJSICIlczogVW5rbm93biBjb250cm9sbGVy
IHZlcnNpb24gKCVkKS4gIgogCQkJIllvdSBtYXkgZXhwZXJpZW5jZSBwcm9ibGVtcy5cbiIsIG1t
Y19ob3N0bmFtZShtbWMpLAogCQkJaG9zdC0+dmVyc2lvbik7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKaW5kZXggMDM2Y2Zh
ZS4uZDdlZjdlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtODYsNiArODYsOSBAQAogCiAjZGVmaW5lIFNESENJ
X0NMT0NLX0NPTlRST0wJMHgyQwogI2RlZmluZSAgU0RIQ0lfRElWSURFUl9TSElGVAk4CisjZGVm
aW5lICBTREhDSV9ESVZJREVSX1NISUZUX0hJCTYKKyNkZWZpbmUgIFNESENJX0RJVl9NQVNLCTB4
RkYKKyNkZWZpbmUgIFNESENJX0RJVl9ISV9NQVNLCTB4MzAwCiAjZGVmaW5lICBTREhDSV9DTE9D
S19DQVJEX0VOCTB4MDAwNAogI2RlZmluZSAgU0RIQ0lfQ0xPQ0tfSU5UX1NUQUJMRQkweDAwMDIK
ICNkZWZpbmUgIFNESENJX0NMT0NLX0lOVF9FTgkweDAwMDEKQEAgLTE3OCw2ICsxODEsNyBAQAog
I2RlZmluZSAgU0RIQ0lfU1BFQ19WRVJfU0hJRlQJMAogI2RlZmluZSAgIFNESENJX1NQRUNfMTAw
CTAKICNkZWZpbmUgICBTREhDSV9TUEVDXzIwMAkxCisjZGVmaW5lICAgU0RIQ0lfU1BFQ18zMDAJ
MgogCiBzdHJ1Y3Qgc2RoY2lfb3BzOwogCi0tIAoxLjcuMC40Cgo=
--000e0cd4d9c03d6380048d9ab8b1--
