From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Tue, 26 Apr 2011 11:50:48 +0800
Message-ID: <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com> <m3d3k9u0yy.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b9ce0f3c28c04a1ca3b9c
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58216 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab1DZDvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2011 23:51:09 -0400
Received: by qyg14 with SMTP id 14so109546qyg.19
        for <linux-mmc@vger.kernel.org>; Mon, 25 Apr 2011 20:51:08 -0700 (PDT)
In-Reply-To: <m3d3k9u0yy.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com

--0016363b9ce0f3c28c04a1ca3b9c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/4/26 Chris Ball <cjb@laptop.org>:
> Hi Barry,
>
> On Mon, Apr 25 2011, Barry Song wrote:
>> From: Bin Shi <bin.shi@csr.com>
>>
>> some controllers share data bus or other pins between
>> multi-controllers and need to switch the functions of shared pins
>> runtime.
>> this patch requested those shared pins before actual hardware access
>> and release them after access
>>
>> Signed-off-by: Bin Shi <bin.shi@csr.com>
>> Cc: Binghua Duan <binghua.duan@csr.com>
>> Cc: Andrei Warkentin <andreiw@motorola.com>
>> Cc: Philip Rakity <prakity@marvell.com>
>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>
> * The patch is corrupt:
> =C2=A0 =C2=A0fatal: corrupt patch at line 11
> =C2=A0You can check whether the patch is okay by first e-mailing it to
> =C2=A0yourself and checking that git can apply it.

Hi Chris,
I am deeply sorry for our firewall still stops me to send email by
git. I post it in web and this patch should be not able to be applied.
Then i attatched the origianl patch as an attachment.
Our IT will open related ports. Then we can send formated patches later.
>
> * Where is the patch that implements the get_shared_pins() hook in
> =C2=A0your driver?
We send the common level patch ahead to get the upstream agreement so
that we can maintain our bottom level sdhci codes better. We will send
the special driver patch after some time.
Basically, the driver get a mutex and set hardware registers to make
the related pin switch roles.

>
> Thanks,
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

--0016363b9ce0f3c28c04a1ca3b9c
Content-Type: application/octet-stream;
	name="0001-mmc-sdhci-add-support-to-request-free-pins-for-contr.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-add-support-to-request-free-pins-for-contr.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmyat0jz0

RnJvbSBkZjYxN2Y1OGE0OWYxNjJkMzE5ZTU5ODJmZWE4NDNjODZhOGU1MWIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCaW4gU2hpIDxiaW4uc2hpQGNzci5jb20+CkRhdGU6IE1vbiwg
MjUgQXByIDIwMTEgMjA6MjM6MzAgLTA3MDAKU3ViamVjdDogW1BBVENIXSBtbWM6c2RoY2k6YWRk
IHN1cHBvcnQgdG8gcmVxdWVzdC9mcmVlIHBpbnMgZm9yIGNvbnRyb2xsZXJzIHNoYXJpbmcgaGFy
ZHdhcmUgYnVzCgpzb21lIGNvbnRyb2xsZXJzIHNoYXJlIGRhdGEgYnVzIG9yIG90aGVyIHBpbnMg
YmV0d2VlbiBtdWx0aS1jb250cm9sbGVycyBhbmQgbmVlZCB0byBzd2l0Y2ggdGhlIGZ1bmN0aW9u
cyBvZiBzaGFyZWQgcGlucyBydW50aW1lLgp0aGlzIHBhdGNoIHJlcXVlc3RlZCB0aG9zZSBzaGFy
ZWQgcGlucyBiZWZvcmUgYWN0dWFsIGhhcmR3YXJlIGFjY2VzcyBhbmQgcmVsZWFzZSB0aGVtIGFm
dGVyIGFjY2VzcwoKU2lnbmVkLW9mZi1ieTogQmluIFNoaSA8YmluLnNoaUBjc3IuY29tPgpDYzog
QmluZ2h1YSBEdWFuIDxiaW5naHVhLmR1YW5AY3NyLmNvbT4KQ2M6IEFuZHJlaSBXYXJrZW50aW4g
PGFuZHJlaXdAbW90b3JvbGEuY29tPgpDYzogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxs
LmNvbT4KU2lnbmVkLW9mZi1ieTogQmFycnkgU29uZyA8MjFjbmJhb0BnbWFpbC5jb20+Ci0tLQog
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgICAxMyArKysrKysrKysrKysrCiBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmggfCAgICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IGY3MGUyMWUuLjkyYWU5ZjcgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKQEAgLTExNDMsNiArMTE0MywxMyBAQCBzdGF0aWMgdm9pZCBzZGhjaV9yZXF1ZXN0KHN0
cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1jX3JlcXVlc3QgKm1ycSkKIAogCWhvc3QgPSBt
bWNfcHJpdihtbWMpOwogCisJLyoKKwkgKiBzb21lIGNvbnRyb2xsZXJzIHNoYXJlIGRhdGEgYnVz
IG9yIG90aGVyIHBpbnMgYmV0d2VlbiBtdWx0aS1jb250cm9sbGVyCisJICogYW5kIG5lZWQgdG8g
c3dpdGNoIHRoZSBmdW5jdGlvbiBvZiBwaW5zIHJ1bnRpbWUKKwkgKi8KKwlpZiAoaG9zdC0+b3Bz
LT5nZXRfc2hhcmVkX3BpbnMpCisJCWhvc3QtPm9wcy0+Z2V0X3NoYXJlZF9waW5zKGhvc3QpOwor
CiAJc3Bpbl9sb2NrX2lycXNhdmUoJmhvc3QtPmxvY2ssIGZsYWdzKTsKIAogCVdBUk5fT04oaG9z
dC0+bXJxICE9IE5VTEwpOwpAQCAtMTQxNyw2ICsxNDI0LDEyIEBAIHN0YXRpYyB2b2lkIHNkaGNp
X3Rhc2tsZXRfZmluaXNoKHVuc2lnbmVkIGxvbmcgcGFyYW0pCiAJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmaG9zdC0+bG9jaywgZmxhZ3MpOwogCiAJbW1jX3JlcXVlc3RfZG9uZShob3N0LT5tbWMs
IG1ycSk7CisKKwkvKgorCSAqIHJlbGVhc2Ugc2hhcmVkIHBpbnMgc28gdGhhdCBvdGhlciBjb250
cm9sbGVycyBjYW4gdXNlIHRoZW0KKwkgKi8KKwlpZiAoaG9zdC0+b3BzLT5wdXRfc2hhcmVkX3Bp
bnMpCisJCWhvc3QtPm9wcy0+cHV0X3NoYXJlZF9waW5zKGhvc3QpOwogfQogCiBzdGF0aWMgdm9p
ZCBzZGhjaV90aW1lb3V0X3RpbWVyKHVuc2lnbmVkIGxvbmcgZGF0YSkKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaAppbmRleCBj
NmUyNWE3Li41YTI2Y2ZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCkBAIC0yMzEsNiArMjMxLDggQEAgc3RydWN0IHNk
aGNpX29wcyB7CiAJdW5zaWduZWQgaW50ICAgICgqZ2V0X3JvKShzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCk7CiAJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2VudGVyKShzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCwgdTggbWFzayk7CiAJdm9pZAkoKnBsYXRmb3JtX3Jlc2V0X2V4aXQpKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0LCB1OCBtYXNrKTsKKwl1bnNpZ25lZCBpbnQgICAgKCpnZXRfc2hhcmVkX3Bp
bnMpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKKwl1bnNpZ25lZCBpbnQgICAgKCpwdXRfc2hh
cmVkX3BpbnMpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KTsKIH07CiAKICNpZmRlZiBDT05GSUdf
TU1DX1NESENJX0lPX0FDQ0VTU09SUwotLSAKMS43LjEKCg==
--0016363b9ce0f3c28c04a1ca3b9c--
