From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Fri, 18 Feb 2011 17:17:51 -0600
Message-ID: <AANLkTimWAnPg2sYiLbfZXAAUiu7P5T3LmNoVbPi9RTEG@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
	<201102181444.24476.arnd@arndb.de>
	<AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
	<AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec53f91392067ce049c96b970
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:59912 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab1BRXRz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 18:17:55 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1INI5Je006681
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 18:18:05 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1INI4cL006671
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 18:18:05 -0500 (EST)
Received: by vxc38 with SMTP id 38so2930883vxc.15
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 15:17:52 -0800 (PST)
In-Reply-To: <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

--bcaec53f91392067ce049c96b970
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/2/18 Andrei Warkentin <andreiw@motorola.com>:
> On Fri, Feb 18, 2011 at 1:47 PM, Andrei Warkentin <andreiw@motorola.com> =
wrote:
>> On Fri, Feb 18, 2011 at 7:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> I'm curious. Neither the manfid nor the oemid fields of either card
>>> match what I have seen on SD cards, I would expect them to be
>>>
>>> Sandisk: manfid 0x000003, oemid 0x5344
>>> Toshiba: manfid 0x000002, oemid 0x544d
>>>
>>> I have not actually seen any Toshiba SD cards, but I assume that they
>>> use the same controllers as Kingston.
>>>
>>> Does anyone know if the IDs have any correlation between MMC and SD
>>> controllers?
>>>
>>> =A0 =A0 =A0 =A0Arnd
>>>
>>
>> I'm unsure about the older scheme (assigned by MMCA), but ever since
>> MMC is now JEDEC-controlled, the IDs have changed. Sandisk's new id
>> will be 0x45, and Toshiba I guess will be 0x11.
>>
>
> Flashbench timings for both Sandisk and Toshiba cards. Attaching due to s=
ize.
>
> Some interesting things that I don't understand. For the align test, I
> extended it to do a write align test (-A). I tried two partitions that
> I could write over, and both read and writes behaved differently for
> the two partitions on same device. Odd. They are both 4MB aligned.
>
> On the sandisk it was the write align that made the page size stand
> out. =A0The read align had pretty constant results.
>
> On the toshiba the results varied wildly for the two partitions. For
> partition 6, there was a clear pattern in the diff values for read
> align. For 9, it was all over the place. For 9 with the write align,
> 8K and 16K the crossing writes took ~115ms!! Look in attached files
> for all the data.
>
> The AU tests were interesting too, especially how with several open
> AUs the throughput is higher for certain smaller sizes on sandisk, but
> if I interpret it correctly both cards have at least 4 AUs, as I
> didn't see yet a significant drop for small sizes. The larger ones I
> am running now on mmcblk0p9 which is sufficiently larger for these
> tests... (mmcblk0p6 is only 40mb, p9 is 314 mb)
>
> Thanks,
> A
>

I thought this was pretty interesting -

# echo 0 > /sys/block/mmcblk0/device/page_size
# ./flashbench -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 3.59ms	on 6.54ms	post 3.65ms	diff 2.92ms
write align 4194304	pre 4.13ms	on 7.37ms	post 4.27ms	diff 3.17ms
write align 2097152	pre 3.62ms	on 6.81ms	post 3.94ms	diff 3.03ms
write align 1048576	pre 3.62ms	on 6.53ms	post 3.55ms	diff 2.95ms
write align 524288	pre 3.62ms	on 6.51ms	post 3.63ms	diff 2.88ms
write align 262144	pre 3.62ms	on 6.51ms	post 3.63ms	diff 2.89ms
write align 131072	pre 3.62ms	on 6.5ms	post 3.63ms	diff 2.88ms
write align 65536	pre 3.61ms	on 6.49ms	post 3.62ms	diff 2.88ms
write align 32768	pre 3.61ms	on 6.49ms	post 3.61ms	diff 2.88ms
write align 16384	pre 3.68ms	on 107ms	post 3.51ms	diff 103ms
write align 8192	pre 3.74ms	on 121ms	post 3.91ms	diff 117ms
write align 4096	pre 3.88ms	on 3.87ms	post 3.87ms	diff -2937ns
write align 2048	pre 3.89ms	on 3.88ms	post 3.88ms	diff -8734ns
# fjnh84@fjnh84-desktop:~/src/n/src/flash$ adb -s 17006185428011d7 shell
# echo 8192 > /sys/block/mmcblk0/device/page_size
# cd data
# ./flashbench -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 3.33ms	on 6.8ms	post 3.65ms	diff 3.31ms
write align 4194304	pre 4.34ms	on 8.14ms	post 4.53ms	diff 3.71ms
write align 2097152	pre 3.64ms	on 7.31ms	post 4.09ms	diff 3.44ms
write align 1048576	pre 3.65ms	on 7.52ms	post 3.65ms	diff 3.87ms
write align 524288	pre 3.62ms	on 6.8ms	post 3.63ms	diff 3.17ms
write align 262144	pre 3.62ms	on 6.84ms	post 3.63ms	diff 3.22ms
write align 131072	pre 3.62ms	on 6.85ms	post 3.44ms	diff 3.32ms
write align 65536	pre 3.39ms	on 6.8ms	post 3.66ms	diff 3.28ms
write align 32768	pre 3.64ms	on 6.86ms	post 3.66ms	diff 3.21ms
write align 16384	pre 3.67ms	on 6.86ms	post 3.65ms	diff 3.2ms
write align 8192	pre 3.66ms	on 6.84ms	post 3.64ms	diff 3.19ms
write align 4096	pre 3.71ms	on 3.71ms	post 3.64ms	diff 38.6=B5s
write align 2048	pre 3.71ms	on 3.71ms	post 3.72ms	diff -656ns

This was with the split unaligned accesses patch... Which I am
attaching for comments.

Thanks,
A

--bcaec53f91392067ce049c96b970
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-MMC-Split-non-page-size-aligned-accesses.patch"
Content-Disposition: attachment;
	filename="0001-MMC-Split-non-page-size-aligned-accesses.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkbrn4f80

RnJvbSBiM2U2YTU1NmE3MTZlN2NlYzg2MDcxMzQyMTk3ZTc5OGIzOGMzY2JmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgV2Fya2VudGluIDxhbmRyZWl3QG1vdG9yb2xhLmNv
bT4KRGF0ZTogRnJpLCAxOCBGZWIgMjAxMSAxNzo0NjowMCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hd
IE1NQzogU3BsaXQgbm9uLXBhZ2Utc2l6ZSBhbGlnbmVkIGFjY2Vzc2VzLgoKSWYgdGhlIGNhcmQg
cGFnZSBzaXplIGlzIGtub3duLCBzcGxpdHMgdGhlIGFjY2VzcyBpbnRvIGFuIHVuYWxpZ25lZAph
bmQgYW4gYWxpZ25lZCBwb3J0aW9uLCB3aGljaCBoZWxwcyB3aXRoIHRoZSBwZXJmb3JtYW5jZS4K
CkNoYW5nZS1JZDogSTRhZDc1ODhkNjEzZDc3NTIxMmZhYzg3NDM2ZTQxODU3NzkwOWEyMmIKU2ln
bmVkLW9mZi1ieTogQW5kcmVpIFdhcmtlbnRpbiA8YW5kcmVpd0Btb3Rvcm9sYS5jb20+Ci0tLQog
ZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jIHwgIDExMSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggfCAgICAxICsK
IDIgZmlsZXMgY2hhbmdlZCwgMTEyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jIGIvZHJpdmVycy9tbWMvY2FyZC9ibG9j
ay5jCmluZGV4IDcwNTRmZDUuLmJlN2Q3MzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NhcmQv
YmxvY2suYworKysgYi9kcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMKQEAgLTIyLDYgKzIyLDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAKICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNp
bmNsdWRlIDxsaW51eC9jdHlwZS5oPgogI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+CkBAIC02Nyw2ICs2OCw3NCBA
QCBzdHJ1Y3QgbW1jX2Jsa19kYXRhIHsKIAogc3RhdGljIERFRklORV9NVVRFWChvcGVuX2xvY2sp
OwogCitzdGF0aWMgc3NpemVfdAorc2hvd19ibG9ja19hdHRyKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCWNoYXIgKmJ1Zik7CisKK3N0YXRpYyBz
c2l6ZV90CitzZXRfYmxvY2tfYXR0cihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vf
YXR0cmlidXRlICphdHRyLAorCSAgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCk7
CisKK3N0YXRpYyBERVZJQ0VfQVRUUihwYWdlX3NpemUsIFNfSVJVR08gfCBTX0lXVVNSLCBzaG93
X2Jsb2NrX2F0dHIsIHNldF9ibG9ja19hdHRyKTsKKworc3RhdGljIHNzaXplX3QKK3Nob3dfYmxv
Y2tfYXR0cihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LAorCQljaGFyICpidWYpCit7CisJdW5zaWduZWQgaW50IHZhbDsKKwlzc2l6ZV90IHJldCA9IDA7
CisJc3RydWN0IG1tY19jYXJkICpjYXJkID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IG1tY19j
YXJkLCBkZXYpOworCW1tY19jbGFpbV9ob3N0KGNhcmQtPmhvc3QpOworCWlmIChhdHRyID09ICZk
ZXZfYXR0cl9wYWdlX3NpemUpCisJCXZhbCA9IGNhcmQtPnBhZ2Vfc2l6ZTsKKwllbHNlCisJCXJl
dCA9IC1FSU5WQUw7CisKKwltbWNfcmVsZWFzZV9ob3N0KGNhcmQtPmhvc3QpOworCWlmICghcmV0
KQorCQlyZXQgPSBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCB2YWwpOworCXJldHVybiByZXQ7Cit9CisK
K3N0YXRpYyBzc2l6ZV90CitzZXRfYmxvY2tfYXR0cihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAorCSAgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkKK3sKKwlzc2l6ZV90IHJldDsKKwljaGFyICphZnRlcjsKKwl1bnNpZ25lZCBpbnQg
dmFsLCAqZGVzdCA9IE5VTEw7CisJc3RydWN0IG1tY19jYXJkICpjYXJkID0gY29udGFpbmVyX29m
KGRldiwgc3RydWN0IG1tY19jYXJkLCBkZXYpOworCXZhbCA9IHNpbXBsZV9zdHJ0b3VsKGJ1Ziwg
JmFmdGVyLCAxMCk7CisJcmV0ID0gYWZ0ZXIgLSBidWY7CisKKwl3aGlsZSAoaXNzcGFjZSgqYWZ0
ZXIrKykpCisJCXJldCsrOworCisJaWYgKHJldCAhPSBjb3VudCkKKwkJcmV0dXJuIC1FSU5WQUw7
CisKKwlpZiAoYXR0ciA9PSAmZGV2X2F0dHJfcGFnZV9zaXplKQorCQlkZXN0ID0gJmNhcmQtPnBh
Z2Vfc2l6ZTsKKwllbHNlCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKGRlc3QpIHsKKwkJbW1j
X2NsYWltX2hvc3QoY2FyZC0+aG9zdCk7CisJCSpkZXN0ID0gdmFsOworCQltbWNfcmVsZWFzZV9o
b3N0KGNhcmQtPmhvc3QpOworCX0KKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgc3RydWN0IGF0
dHJpYnV0ZSAqY2FwYWJpbGl0eV9hdHRyc1tdID0geworCSZkZXZfYXR0cl9wYWdlX3NpemUuYXR0
ciwKKwlOVUxMLAorfTsKKworc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgYXR0cl9ncm91
cCA9IHsKKyAgICAgICAgLmF0dHJzID0gY2FwYWJpbGl0eV9hdHRycywKK307CisKIHN0YXRpYyBz
dHJ1Y3QgbW1jX2Jsa19kYXRhICptbWNfYmxrX2dldChzdHJ1Y3QgZ2VuZGlzayAqZGlzaykKIHsK
IAlzdHJ1Y3QgbW1jX2Jsa19kYXRhICptZDsKQEAgLTMxMiw2ICszODEsMzggQEAgb3V0OgogCXJl
dHVybiBlcnIgPyAwIDogMTsKIH0KIAorCisvKgorICogSWYgdGhlIHJlcXVlc3QgaXMgbm90IGFs
aWduZWQsIHNwbGl0IGl0IGludG8gYW4gdW5hbGlnbmVkCisgKiBhbmQgYW4gYWxpZ25lZCBwb3J0
aW9uLiBIZXJlIHdlIGNhbiBhZGp1c3QKKyAqIHRoZSBzaXplIG9mIHRoZSBNTUMgcmVxdWVzdCBh
bmQgbGV0IHRoZSBibG9jayBsYXllciByZXF1ZXN0IGhhbmRsZQorICogZGVhbCB3aXRoIGdlbmVy
YXRpbmcgYW5vdGhlciBNTUMgcmVxdWVzdC4KKyAqLworc3RhdGljIGJvb2wgbW1jX2FkanVzdF93
cml0ZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsCisJCQkgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCAq
bXJxKQoreworCXVuc2lnbmVkIGludCBsZWZ0X2luX3BhZ2U7CisJdW5zaWduZWQgaW50IHBhZ2Vf
c2l6ZV9ibG9ja3M7CisKKwlpZiAoIWNhcmQtPnBhZ2Vfc2l6ZSkKKwkJcmV0dXJuIGZhbHNlOwor
CisJcGFnZV9zaXplX2Jsb2NrcyA9IGNhcmQtPnBhZ2Vfc2l6ZSAvIG1ycS0+ZGF0YS0+Ymxrc3o7
CisJbGVmdF9pbl9wYWdlID0gcGFnZV9zaXplX2Jsb2NrcyAtCisJCShtcnEtPmNtZC0+YXJnICUg
cGFnZV9zaXplX2Jsb2Nrcyk7CisKKwkvKiBBbGlnbmVkIGFjY2Vzcy4gKi8KKwlpZiAobGVmdF9p
bl9wYWdlID09IHBhZ2Vfc2l6ZV9ibG9ja3MpCisJCXJldHVybiBmYWxzZTsKKworCS8qIE5vdCBz
dHJhZGRsaW5nIHBhZ2UgYm91bmRhcnkuICovCisJaWYgKG1ycS0+ZGF0YS0+YmxvY2tzIDw9IGxl
ZnRfaW5fcGFnZSkKKwkJcmV0dXJuIGZhbHNlOworCisJbXJxLT5kYXRhLT5ibG9ja3MgPSBsZWZ0
X2luX3BhZ2U7CisJcmV0dXJuIHRydWU7Cit9CisKIHN0YXRpYyBpbnQgbW1jX2Jsa19pc3N1ZV9y
d19ycShzdHJ1Y3QgbW1jX3F1ZXVlICptcSwgc3RydWN0IHJlcXVlc3QgKnJlcSkKIHsKIAlzdHJ1
Y3QgbW1jX2Jsa19kYXRhICptZCA9IG1xLT5kYXRhOwpAQCAtMzM5LDYgKzQ0MCwxMCBAQCBzdGF0
aWMgaW50IG1tY19ibGtfaXNzdWVfcndfcnEoc3RydWN0IG1tY19xdWV1ZSAqbXEsIHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpCiAJCWJycS5zdG9wLmZsYWdzID0gTU1DX1JTUF9TUElfUjFCIHwgTU1DX1JT
UF9SMUIgfCBNTUNfQ01EX0FDOwogCQlicnEuZGF0YS5ibG9ja3MgPSBibGtfcnFfc2VjdG9ycyhy
ZXEpOwogCisJCS8qIENoZWNrIGZvciB1bmFsaWduZWQgYWNjZXNzZXMgc3RyYWRkbGluZyBwYWdl
cy4gKi8KKwkJaWYgKHJxX2RhdGFfZGlyKHJlcSkgPT0gV1JJVEUpCisJCQltbWNfYWRqdXN0X3dy
aXRlKGNhcmQsICZicnEubXJxKTsKKwogCQkvKgogCQkgKiBUaGUgYmxvY2sgbGF5ZXIgZG9lc24n
dCBzdXBwb3J0IGFsbCBzZWN0b3IgY291bnQKIAkJICogcmVzdHJpY3Rpb25zLCBzbyB3ZSBuZWVk
IHRvIGJlIHByZXBhcmVkIGZvciB0b28gYmlnCkBAIC03MDcsNiArODEyLDEwIEBAIHN0YXRpYyBp
bnQgbW1jX2Jsa19wcm9iZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpCiAJaWYgKGVycikKIAkJZ290
byBvdXQ7CiAKKwllcnIgPSBzeXNmc19jcmVhdGVfZ3JvdXAoJmNhcmQtPmRldi5rb2JqLCAmYXR0
cl9ncm91cCk7CisJaWYgKGVycikKKwkJZ290byBvdXQ7CisKIAlzdHJpbmdfZ2V0X3NpemUoKHU2
NClnZXRfY2FwYWNpdHkobWQtPmRpc2spIDw8IDksIFNUUklOR19VTklUU18yLAogCQkJY2FwX3N0
ciwgc2l6ZW9mKGNhcF9zdHIpKTsKIAlwcmludGsoS0VSTl9JTkZPICIlczogJXMgJXMgJXMgJXNc
biIsCkBAIC03MzUsNiArODQ0LDggQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19yZW1vdmUoc3RydWN0
IG1tY19jYXJkICpjYXJkKQogCQkvKiBTdG9wIG5ldyByZXF1ZXN0cyBmcm9tIGdldHRpbmcgaW50
byB0aGUgcXVldWUgKi8KIAkJZGVsX2dlbmRpc2sobWQtPmRpc2spOwogCisJCXN5c2ZzX3JlbW92
ZV9ncm91cCgmY2FyZC0+ZGV2LmtvYmosICZhdHRyX2dyb3VwKTsKKwogCQkvKiBUaGVuIGZsdXNo
IG91dCBhbnkgYWxyZWFkeSBpbiB0aGVyZSAqLwogCQltbWNfY2xlYW51cF9xdWV1ZSgmbWQtPnF1
ZXVlKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIvaW5jbHVkZS9s
aW51eC9tbWMvY2FyZC5oCmluZGV4IDZiNzUyNTAuLmQ1Mjc2OGEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvbW1jL2NhcmQuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgKQEAgLTEy
Myw3ICsxMjMsNyBAQCBzdHJ1Y3QgbW1jX2NhcmQgewogCXVuc2lnbmVkIGludAkJZXJhc2Vfc2l6
ZTsJLyogZXJhc2Ugc2l6ZSBpbiBzZWN0b3JzICovCiAgCXVuc2lnbmVkIGludAkJZXJhc2Vfc2hp
ZnQ7CS8qIGlmIGVyYXNlIHVuaXQgaXMgcG93ZXIgMiAqLwogIAl1bnNpZ25lZCBpbnQJCXByZWZf
ZXJhc2U7CS8qIGluIHNlY3RvcnMgKi8KKyAJdW5zaWduZWQgaW50CQlwYWdlX3NpemU7CS8qIHBh
Z2Ugc2l6ZSBpbiBieXRlcyAqLwogIAl1OAkJCWVyYXNlZF9ieXRlOwkvKiB2YWx1ZSBvZiBlcmFz
ZWQgYnl0ZXMgKi8KIAogCXUzMgkJCXJhd19jaWRbNF07CS8qIHJhdyBjYXJkIENJRCAqLwotLSAK
MS43LjAuNAoK
--bcaec53f91392067ce049c96b970--
