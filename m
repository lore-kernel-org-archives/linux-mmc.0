From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Sun, 15 Aug 2010 23:09:48 -0400
Message-ID: <AANLkTimWaA2x3o60G+cSeAkFhFfLe4YbCVmHZGFy-Zn8@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
	<AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
	<AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
	<20100809101042.GA8293@console-pimps.org>
	<AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
	<20100810163244.GA12837@console-pimps.org>
	<AANLkTinJ0hJcas5h18PGD5f8w6Jn6f6jG8D2WZHK1Amp@mail.gmail.com>
	<AANLkTi=zvsWHmLqWMnssgZTXd6XDSCzuJ3j8ZiQfdp9z@mail.gmail.com>
	<AANLkTimXNGLC9u+EVoOUurUY08icZpYycECsPf0RGYVh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6469b0c4ff62e048de82ad8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53525 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab0HPDJt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Aug 2010 23:09:49 -0400
Received: by iwn7 with SMTP id 7so1209987iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 15 Aug 2010 20:09:48 -0700 (PDT)
In-Reply-To: <AANLkTimXNGLC9u+EVoOUurUY08icZpYycECsPf0RGYVh@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: Matt Fleming <matt@console-pimps.org>, Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

--0016e6469b0c4ff62e048de82ad8
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

2010/8/13 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
> 2010/8/12 zhangfei gao <zhangfei.gao@gmail.com>:
> [...]
>> updated patch:
>> From b17eb3ca9dd23af63ada240e8f77bdd873e853a7 Mon Sep 17 00:00:00 2001
>> From: Zhangfei Gao <zgao6@marvell.com>
>> Date: Fri, 6 Aug 2010 07:10:01 +0800
>> Subject: [PATCH] sdhc: support 10-bit divided clock Mode
>>
>> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 16 ++++++++++++----
>> =A0drivers/mmc/host/sdhci.h | =A0 =A04 ++++
>> =A02 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7855121..ccfbc40 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -983,7 +983,7 @@ static void sdhci_finish_command(struct sdhci_host *=
host)
>>
>> =A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int clo=
ck)
>> =A0{
>> - =A0 =A0 =A0 int div;
>> + =A0 =A0 =A0 int div, max_div;
>> =A0 =A0 =A0 =A0u16 clk;
>> =A0 =A0 =A0 =A0unsigned long timeout;
>>
>> @@ -1001,13 +1001,21 @@ static void sdhci_set_clock(struct sdhci_host
>> *host, unsigned int clock)
>> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>
>> - =A0 =A0 =A0 for (div =3D 1;div < 256;div *=3D 2) {
>> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_div =3D 2046;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_div =3D 256;
>> +
>> + =A0 =A0 =A0 if(host->max_clk <=3D clock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D 1;
>> + =A0 =A0 =A0 for (div =3D 2; div < max_div; div +=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->max_clk / div) <=3D clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0div >>=3D 1;
>>
>> - =A0 =A0 =A0 clk =3D div << SDHCI_DIVIDER_SHIFT;
>> + =A0 =A0 =A0 clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>
>> + =A0 =A0 =A0 clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SHIFT=
) << SDHCI_DIVIDER_SHIFT_HI;
>
> I think the right shift is using wrong #define, SDHCI_DIVIDER_SHIFT
> (position of the bitfield in the register). It has a correct value of
> 8, though. This could be something like the following to reduce
> confusion.

agree though it would introduce new define
>
> clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) <<
> SDHCI_DIVIDER_SHIFT_HI;
> ...
> #define SDHCI_DIV_MASK 0xFF
> #define SDHCI_DIV_MASK_LEN 8
> #define =A0SDHCI_DIV_HI_MASK 0x300
>
> or maybe:
>
> clk |=3D ((div >> SDHCI_DIV_MASK_LEN) & SDHCI_DIV_HI_MASK) <<
> SDHCI_DIVIDER_SHIFT_HI;
> ...
> #define SDHCI_DIV_MASK 0xFF
> #define SDHCI_DIV_MASK_LEN 8
> #define =A0SDHCI_DIV_HI_MASK 0x03
>
>> =A0 =A0 =A0 =A0clk |=3D SDHCI_CLOCK_INT_EN;
>> =A0 =A0 =A0 =A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>
> [...]
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -86,6 +86,9 @@
>>
>> =A0#define SDHCI_CLOCK_CONTROL =A0 =A00x2C
>> =A0#define =A0SDHCI_DIVIDER_SHIFT =A0 8
>> +#define =A0SDHCI_DIVIDER_SHIFT_HI =A0 =A0 =A0 =A06
>> +#define =A0SDHCI_DIV_MASK =A0 =A0 =A0 =A00xFF
>> +#define =A0SDHCI_DIV_HI_MASK =A0 =A0 0x300
>> =A0#define =A0SDHCI_CLOCK_CARD_EN =A0 0x0004
>> =A0#define =A0SDHCI_CLOCK_INT_STABLE =A0 =A0 =A0 =A00x0002
>> =A0#define =A0SDHCI_CLOCK_INT_EN =A0 =A00x0001
> [...]
>
> SDHCI_DIVIDER_SHIFT_HI -> SDHCI_DIVIDER_HI_SHIFT

agree
>
> Best Regards,
> Micha=B3 Miros=B3aw
>

Update the patch;

>From c0d23113e5056c9313407ac22d93349501b0b9b2 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 6 Aug 2010 07:10:01 +0800
Subject: [PATCH] sdhc: support 10-bit divided clock Mode

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/sdhci.c |   16 ++++++++++++----
 drivers/mmc/host/sdhci.h |    5 +++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..768fdc9 100644
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

@@ -1001,13 +1001,21 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 	if (clock =3D=3D 0)
 		goto out;

-	for (div =3D 1;div < 256;div *=3D 2) {
+	if (host->version >=3D SDHCI_SPEC_300)
+		max_div =3D 2046;
+	else
+		max_div =3D 256;
+
+	if(host->max_clk <=3D clock)
+		div =3D 1;
+	for (div =3D 2; div < max_div; div +=3D 2) {
 		if ((host->max_clk / div) <=3D clock)
 			break;
 	}
 	div >>=3D 1;

-	clk =3D div << SDHCI_DIVIDER_SHIFT;
+	clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) <<
SDHCI_DIVIDER_HI_SHIFT;
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

@@ -1707,7 +1715,7 @@ int sdhci_add_host(struct sdhci_host *host)
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

--0016e6469b0c4ff62e048de82ad8
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Disposition: attachment;
	filename="0001-sdhc-support-10-bit-divided-clock-Mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcxgndo40

RnJvbSBjMGQyMzExM2U1MDU2YzkzMTM0MDdhYzIyZDkzMzQ5NTAxYjBiOWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDYgQXVnIDIwMTAgMDc6MTA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBzZGhjOiBz
dXBwb3J0IDEwLWJpdCBkaXZpZGVkIGNsb2NrIE1vZGUKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVp
IEdhbyA8emdhbzZAbWFydmVsbC5jb20+ClJldmlld2VkLWJ5OiBNYXR0IEZsZW1pbmcgPG1hdHRA
Y29uc29sZS1waW1wcy5vcmc+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgICAxNiAr
KysrKysrKysrKystLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggfCAgICA1ICsrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
CmluZGV4IDc4NTUxMjEuLjc2OGZkYzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTk4Myw3ICs5ODMsNyBAQCBz
dGF0aWMgdm9pZCBzZGhjaV9maW5pc2hfY29tbWFuZChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkK
IAogc3RhdGljIHZvaWQgc2RoY2lfc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1
bnNpZ25lZCBpbnQgY2xvY2spCiB7Ci0JaW50IGRpdjsKKwlpbnQgZGl2LCBtYXhfZGl2OwogCXUx
NiBjbGs7CiAJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwogCkBAIC0xMDAxLDEzICsxMDAxLDIxIEBA
IHN0YXRpYyB2b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5z
aWduZWQgaW50IGNsb2NrKQogCWlmIChjbG9jayA9PSAwKQogCQlnb3RvIG91dDsKIAotCWZvciAo
ZGl2ID0gMTtkaXYgPCAyNTY7ZGl2ICo9IDIpIHsKKwlpZiAoaG9zdC0+dmVyc2lvbiA+PSBTREhD
SV9TUEVDXzMwMCkKKwkJbWF4X2RpdiA9IDIwNDY7CisJZWxzZQorCQltYXhfZGl2ID0gMjU2Owor
CisJaWYoaG9zdC0+bWF4X2NsayA8PSBjbG9jaykKKwkJZGl2ID0gMTsKKwlmb3IgKGRpdiA9IDI7
IGRpdiA8IG1heF9kaXY7IGRpdiArPSAyKSB7CiAJCWlmICgoaG9zdC0+bWF4X2NsayAvIGRpdikg
PD0gY2xvY2spCiAJCQlicmVhazsKIAl9CiAJZGl2ID4+PSAxOwogCi0JY2xrID0gZGl2IDw8IFNE
SENJX0RJVklERVJfU0hJRlQ7CisJY2xrID0gKGRpdiAmIFNESENJX0RJVl9NQVNLKSA8PCBTREhD
SV9ESVZJREVSX1NISUZUOworCWNsayB8PSAoKGRpdiAmIFNESENJX0RJVl9ISV9NQVNLKSA+PiBT
REhDSV9ESVZfTUFTS19MRU4pIDw8IFNESENJX0RJVklERVJfSElfU0hJRlQ7CiAJY2xrIHw9IFNE
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
ZS4uNTA4NjBkYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtODYsNiArODYsMTAgQEAKIAogI2RlZmluZSBTREhD
SV9DTE9DS19DT05UUk9MCTB4MkMKICNkZWZpbmUgIFNESENJX0RJVklERVJfU0hJRlQJOAorI2Rl
ZmluZSAgU0RIQ0lfRElWSURFUl9ISV9TSElGVAk2CisjZGVmaW5lICBTREhDSV9ESVZfTUFTSwkw
eEZGCisjZGVmaW5lICBTREhDSV9ESVZfTUFTS19MRU4JOAorI2RlZmluZSAgU0RIQ0lfRElWX0hJ
X01BU0sJMHgzMDAKICNkZWZpbmUgIFNESENJX0NMT0NLX0NBUkRfRU4JMHgwMDA0CiAjZGVmaW5l
ICBTREhDSV9DTE9DS19JTlRfU1RBQkxFCTB4MDAwMgogI2RlZmluZSAgU0RIQ0lfQ0xPQ0tfSU5U
X0VOCTB4MDAwMQpAQCAtMTc4LDYgKzE4Miw3IEBACiAjZGVmaW5lICBTREhDSV9TUEVDX1ZFUl9T
SElGVAkwCiAjZGVmaW5lICAgU0RIQ0lfU1BFQ18xMDAJMAogI2RlZmluZSAgIFNESENJX1NQRUNf
MjAwCTEKKyNkZWZpbmUgICBTREhDSV9TUEVDXzMwMAkyCiAKIHN0cnVjdCBzZGhjaV9vcHM7CiAK
LS0gCjEuNy4wLjQKCg==
--0016e6469b0c4ff62e048de82ad8--
