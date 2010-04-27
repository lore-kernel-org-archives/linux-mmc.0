From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdhci.h compile error
Date: Tue, 27 Apr 2010 14:54:03 +0800
Message-ID: <q2h309424b61004262354heec04b53xc87e6c37046c6e77@mail.gmail.com>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
	 <87zl0rb20u.fsf@linux-g6p1.site>
	 <g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
	 <87mxwqzcl6.fsf@linux-g6p1.site>
	 <s2x309424b61004262045q2cf453bay7b2fa62571947e5a@mail.gmail.com>
	 <87k4rtzbjg.fsf@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6480624e474900485325ba8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:54748 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0D0GyF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2010 02:54:05 -0400
Received: by iwn40 with SMTP id 40so3909027iwn.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2010 23:54:03 -0700 (PDT)
In-Reply-To: <87k4rtzbjg.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

--0016e6480624e474900485325ba8
Content-Type: text/plain; charset=ISO-8859-1

Hi, Matt

On Tue, Apr 27, 2010 at 1:53 PM, Matt Fleming <matt@console-pimps.org> wrote:
> On Tue, 27 Apr 2010 11:45:28 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>>
>> Fortunately, the typo does not impact the stability.
>> We found the typo when debugging our silicon issue, however, nothing
>> impove after the fix :)
>
> OK, thanks. In that case it probably doesn't need to go to -stable. You
> can add Reviewed-by: Matt Fleming <matt@console-pimps.org> to your
> patch.
>

Thanks for the review, patch is updated.

>From 1fbcb05dbab2e5e5de72060f0481a279fa3eda18 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Thu, 22 Apr 2010 11:25:17 +0800
Subject: [PATCH] mmc: SDHCI_INT_DATA_MASK typo error

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/sdhci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..9ba4268 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -127,7 +127,7 @@
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
-		SDHCI_INT_DATA_END_BIT | SDHCI_ADMA_ERROR)
+		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)

 #define SDHCI_ACMD12_ERR	0x3C
-- 
1.6.0.4

--0016e6480624e474900485325ba8
Content-Type: application/octet-stream;
	name="0001-mmc-SDHCI_INT_DATA_MASK-typo-error.patch"
Content-Disposition: attachment;
	filename="0001-mmc-SDHCI_INT_DATA_MASK-typo-error.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8icxpi90

RnJvbSAxZmJjYjA1ZGJhYjJlNWU1ZGU3MjA2MGYwNDgxYTI3OWZhM2VkYTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBUaHUsIDIyIEFwciAyMDEwIDExOjI1OjE3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW1jOiBT
REhDSV9JTlRfREFUQV9NQVNLIHR5cG8gZXJyb3IKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdh
byA8emdhbzZAbWFydmVsbC5jb20+ClJldmlld2VkLWJ5OiBNYXR0IEZsZW1pbmcgPG1hdHRAY29u
c29sZS1waW1wcy5vcmc+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIHwgICAgMiArLQog
MSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5o
CmluZGV4IDg0MmY0NmYuLjliYTQyNjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTEyNyw3ICsxMjcsNyBAQAog
I2RlZmluZSAgU0RIQ0lfSU5UX0RBVEFfTUFTSwkoU0RIQ0lfSU5UX0RBVEFfRU5EIHwgU0RIQ0lf
SU5UX0RNQV9FTkQgfCBcCiAJCVNESENJX0lOVF9EQVRBX0FWQUlMIHwgU0RIQ0lfSU5UX1NQQUNF
X0FWQUlMIHwgXAogCQlTREhDSV9JTlRfREFUQV9USU1FT1VUIHwgU0RIQ0lfSU5UX0RBVEFfQ1JD
IHwgXAotCQlTREhDSV9JTlRfREFUQV9FTkRfQklUIHwgU0RIQ0lfQURNQV9FUlJPUikKKwkJU0RI
Q0lfSU5UX0RBVEFfRU5EX0JJVCB8IFNESENJX0lOVF9BRE1BX0VSUk9SKQogI2RlZmluZSBTREhD
SV9JTlRfQUxMX01BU0sJKCh1bnNpZ25lZCBpbnQpLTEpCiAKICNkZWZpbmUgU0RIQ0lfQUNNRDEy
X0VSUgkweDNDCi0tIAoxLjYuMC40Cgo=
--0016e6480624e474900485325ba8--
