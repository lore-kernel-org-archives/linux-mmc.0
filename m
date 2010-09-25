From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] sdhci: correct f_min in sd 3.0
Date: Sat, 25 Sep 2010 00:23:33 -0400
Message-ID: <AANLkTikeu8pBLSuHQwrrREBRS=NNe9qeRP11oob31SNf@mail.gmail.com>
References: <AANLkTimp+4V9zvQtOqHoVmpH-+Vmb+0Sr1MzM-cNHAiC@mail.gmail.com>
	<20100924032401.GA10294@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=005045015751bf079604910ddb30
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60607 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0IYEXf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Sep 2010 00:23:35 -0400
Received: by iwn5 with SMTP id 5so2924752iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 21:23:34 -0700 (PDT)
In-Reply-To: <20100924032401.GA10294@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

--005045015751bf079604910ddb30
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 11:24 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Sep 20, 2010 at 03:32:58AM -0400, zhangfei gao wrote:
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Mon, 20 Sep 2010 15:15:18 -0400
>> Subject: [PATCH 4/4] sdhci: correct f_min in sd 3.0
>>
>> Change-Id: Ie8604dbb5296b15da67071164564f21c60652b60
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index f980fb7..5346803 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1835,6 +1835,8 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 mmc->ops =3D &sdhci_ops;
>> =A0 =A0 =A0 if (host->ops->get_min_clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->ops->get_min_clock(host=
);
>> + =A0 =A0 else if (host->version >=3D SDHCI_SPEC_300)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / 2046;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / 256;
>> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
>
> Oh, right -- it would be good to #define symbols for 256 and 2046,
> since we're inserting them into sdhci.c for the second time.
> Perhaps SDHCI_MAX_DIV_SPEC_{200,300}?
>
> I can do that in a separate patch if you prefer, or you could roll
> it into this one.
>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

Thanks for your suggestion, here is updated patch.

>From dc098c73df0872269b3d364462672664450d1df4 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Mon, 20 Sep 2010 15:15:18 -0400
Subject: [PATCH] sdhci: correct f_min in sd 3.0

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 +++++---
 drivers/mmc/host/sdhci.h |    3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5928b0a..829e78a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1007,14 +1007,14 @@ static void sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
 		if (host->max_clk <=3D clock)
 			div =3D 1;
 		else {
-			for (div =3D 2; div < 2046; div +=3D 2) {
+			for (div =3D 2; div < SDHCI_MAX_DIV_SPEC_300; div +=3D 2) {
 				if ((host->max_clk / div) <=3D clock)
 					break;
 			}
 		}
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-		for (div =3D 1; div < 256; div *=3D 2) {
+		for (div =3D 1; div < SDHCI_MAX_DIV_SPEC_200; div *=3D 2) {
 			if ((host->max_clk / div) <=3D clock)
 				break;
 		}
@@ -1836,8 +1836,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->ops =3D &sdhci_ops;
 	if (host->ops->get_min_clock)
 		mmc->f_min =3D host->ops->get_min_clock(host);
+	else if (host->version >=3D SDHCI_SPEC_300)
+		mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	else
-		mmc->f_min =3D host->max_clk / 256;
+		mmc->f_min =3D host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 	mmc->f_max =3D host->max_clk;
 	mmc->caps |=3D MMC_CAP_SDIO_IRQ;

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index ae28a31..d35fb3d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -185,6 +185,9 @@
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2

+#define	SDHCI_MAX_DIV_SPEC_200	256
+#define	SDHCI_MAX_DIV_SPEC_300	2046
+
 struct sdhci_ops;

 struct sdhci_host {
--=20
1.7.0.4

--005045015751bf079604910ddb30
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-correct-f_min-in-sd-3.0.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-correct-f_min-in-sd-3.0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geiosgz80

RnJvbSBkYzA5OGM3M2RmMDg3MjI2OWIzZDM2NDQ2MjY3MjY2NDQ1MGQxZGY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogTW9uLCAyMCBTZXAgMjAxMCAxNToxNToxOCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IHNkaGNpOiBjb3JyZWN0IGZfbWluIGluIHNkIDMuMAoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkg
R2FvIDx6aGFuZ2ZlaS5nYW9AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jIHwgICAgOCArKysrKy0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAgMyArKysK
IDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
YwppbmRleCA1OTI4YjBhLi44MjllNzhhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC0xMDA3LDE0ICsxMDA3LDE0
IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwg
dW5zaWduZWQgaW50IGNsb2NrKQogCQlpZiAoaG9zdC0+bWF4X2NsayA8PSBjbG9jaykKIAkJCWRp
diA9IDE7CiAJCWVsc2UgewotCQkJZm9yIChkaXYgPSAyOyBkaXYgPCAyMDQ2OyBkaXYgKz0gMikg
eworCQkJZm9yIChkaXYgPSAyOyBkaXYgPCBTREhDSV9NQVhfRElWX1NQRUNfMzAwOyBkaXYgKz0g
MikgewogCQkJCWlmICgoaG9zdC0+bWF4X2NsayAvIGRpdikgPD0gY2xvY2spCiAJCQkJCWJyZWFr
OwogCQkJfQogCQl9CiAJfSBlbHNlIHsKIAkJLyogVmVyc2lvbiAyLjAwIGRpdmlzb3JzIG11c3Qg
YmUgYSBwb3dlciBvZiAyLiAqLwotCQlmb3IgKGRpdiA9IDE7IGRpdiA8IDI1NjsgZGl2ICo9IDIp
IHsKKwkJZm9yIChkaXYgPSAxOyBkaXYgPCBTREhDSV9NQVhfRElWX1NQRUNfMjAwOyBkaXYgKj0g
MikgewogCQkJaWYgKChob3N0LT5tYXhfY2xrIC8gZGl2KSA8PSBjbG9jaykKIAkJCQlicmVhazsK
IAkJfQpAQCAtMTgzNiw4ICsxODM2LDEwIEBAIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2Ro
Y2lfaG9zdCAqaG9zdCkKIAltbWMtPm9wcyA9ICZzZGhjaV9vcHM7CiAJaWYgKGhvc3QtPm9wcy0+
Z2V0X21pbl9jbG9jaykKIAkJbW1jLT5mX21pbiA9IGhvc3QtPm9wcy0+Z2V0X21pbl9jbG9jayho
b3N0KTsKKwllbHNlIGlmIChob3N0LT52ZXJzaW9uID49IFNESENJX1NQRUNfMzAwKQorCQltbWMt
PmZfbWluID0gaG9zdC0+bWF4X2NsayAvIFNESENJX01BWF9ESVZfU1BFQ18zMDA7CiAJZWxzZQot
CQltbWMtPmZfbWluID0gaG9zdC0+bWF4X2NsayAvIDI1NjsKKwkJbW1jLT5mX21pbiA9IGhvc3Qt
Pm1heF9jbGsgLyBTREhDSV9NQVhfRElWX1NQRUNfMjAwOwogCW1tYy0+Zl9tYXggPSBob3N0LT5t
YXhfY2xrOwogCW1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1NESU9fSVJROwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKaW5kZXgg
YWUyOGEzMS4uZDM1ZmIzZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMTg1LDYgKzE4NSw5IEBACiAjZGVmaW5l
ICAgU0RIQ0lfU1BFQ18yMDAJMQogI2RlZmluZSAgIFNESENJX1NQRUNfMzAwCTIKIAorI2RlZmlu
ZQlTREhDSV9NQVhfRElWX1NQRUNfMjAwCTI1NgorI2RlZmluZQlTREhDSV9NQVhfRElWX1NQRUNf
MzAwCTIwNDYKKwogc3RydWN0IHNkaGNpX29wczsKIAogc3RydWN0IHNkaGNpX2hvc3QgewotLSAK
MS43LjAuNAoK
--005045015751bf079604910ddb30--
