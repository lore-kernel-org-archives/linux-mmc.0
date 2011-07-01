From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 15:26:39 +0200
Message-ID: <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
	<BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
	<20110630145507.GG1997@pengutronix.de>
	<20110701091753.GE1922@pengutronix.de>
	<BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
	<20110701122709.GJ1922@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0ce049e4aeba7f04a701f7e6
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64730 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab1GAN0k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 09:26:40 -0400
Received: by wwe5 with SMTP id 5so3238702wwe.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jul 2011 06:26:39 -0700 (PDT)
In-Reply-To: <20110701122709.GJ1922@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com

--000e0ce049e4aeba7f04a701f7e6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I send the patch as attachment for now.

But I'll have to look into another way of doing this. Corporate mail
system is adding stupid disclaimers, gmail web ui is not working ok
and corporate firewalls avoid using a different smtp server...



On Fri, Jul 1, 2011 at 2:27 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> Think the tabs problem was due to the gmail web ui.
>> Hope it's better now.
>
> No 0xa0 anymore, but still no tabs. Oh, and lines are wrapped.
>
> Documentation/email-clients.txt says
>
> =3D=3D=3D
>
> Gmail (Web GUI)
>
> Does not work for sending patches.
>
> Gmail web client converts tabs to spaces automatically.
>
> At the same time it wraps lines every 78 chars with CRLF style line
> breaks although tab2space problem can be solved with external editor.
>
> Another problem is that Gmail will base64-encode any message that has a
> non-ASCII character. That includes things like European names.
>
> =3D=3D=3D
>
> I don't know if git-send-email can work directly with gmail, but it
> seems you need some kind of alternative approach.
>
> Regards,
>
> =C2=A0 Wolfram
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk4NvR0ACgkQD27XaX1/VRtjmACfQzU2j5+awQ78Ey7Ir+39uhxn
> j70AoJQG0D6tK3rYh4YeYsiyFAsLieC5
> =3DDqDV
> -----END PGP SIGNATURE-----
>
>

--000e0ce049e4aeba7f04a701f7e6
Content-Type: text/x-patch; charset=US-ASCII; name="mxs-mmc-fix-clock-rate-setting.patch"
Content-Disposition: attachment;
	filename="mxs-mmc-fix-clock-rate-setting.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpl650o01

RnJvbSBhYjYxMDQzN2ZhZGU1YjMwZmRlYWNkOWU5NTlkZGY5NWJjNDI1ODdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLb2VuIEJlZWwgPGtvZW4uYmVlbEBiYXJjby5jb20+CkRhdGU6
IFRodSwgMzAgSnVuIDIwMTEgMTI6MDA6MTkgKzAyMDAKU3ViamVjdDogW1BBVENIXSBteHMtbW1j
OiBmaXggY2xvY2sgcmF0ZSBzZXR0aW5nCgpGaXggY2xvY2sgcmF0ZSBzZXR0aW5nIG9uIG14cy1t
bWMgZHJpdmVyLgpQcmV2aW91c2x5LCBpZiBkaXYyIHdhcyB6ZXJvIHRoZSB2YWx1ZSBmb3IgVElN
SU5HX0NMT0NLX1JBVEUgd291bGQgaGF2ZSBiZWVuIDI1NSBpbnN0ZWFkIG9mIDAuCkFsc28gdGhl
IGxpbWl0cyBmb3IgZGl2MSAoVElNSU5HX0NMT0NLX0RJVklERSkgYW5kIGRpdjIgKFRJTUlOR19D
TE9DS19SQVRFICsgMSkgd2hlcmUgbm90IGNvcnJlY3RseSBkZWZpbmVkLgoKQ2FuIGVhc2lseSBi
ZSByZXByb2R1Y2VkIG9uIG14MjNldms6IGRlZmF1bHQgY2xvY2sgZm9yIGhpZ2ggc3BlZWQgc2Rp
byBjYXJkcyBpcyA1MCBNSHouCldpdGggYSBTU1BfQ0xLIG9mIDI4LjggTUh6IChkZWZhdWx0KSwg
dGhpcyByZXN1bHRlZCBpbiBhbiBhY3R1YWwgY2xvY2sgcmF0ZSBvZiBhYm91dCA1NiBrSHouCgpT
aWduZWQtb2ZmLWJ5OiBLb2VuIGJlZWwgPGtvZW4uYmVlbEBiYXJjby5jb20+Ci0tLQogZHJpdmVy
cy9tbWMvaG9zdC9teHMtbW1jLmMgfCAgIDEyICsrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9teHMtbW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L214cy1tbWMuYwppbmRleCA5OWQz
OWE2Li4zNTc1MzMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L214cy1tbWMuYworKysg
Yi9kcml2ZXJzL21tYy9ob3N0L214cy1tbWMuYwpAQCAtNTcwLDIyICs1NzAsMjIgQEAgc3RhdGlj
IHZvaWQgbXhzX21tY19zZXRfY2xrX3JhdGUoc3RydWN0IG14c19tbWNfaG9zdCAqaG9zdCwgdW5z
aWduZWQgaW50IHJhdGUpCiAKIAlzc3BfcmF0ZSA9IGNsa19nZXRfcmF0ZShob3N0LT5jbGspOwog
Ci0JZm9yIChkaXYxID0gMjsgZGl2MSA8IDI1NDsgZGl2MSArPSAyKSB7CisJZm9yIChkaXYxID0g
MjsgZGl2MSA8PSAyNTQ7IGRpdjEgKz0gMikgewogCQlkaXYyID0gc3NwX3JhdGUgLyByYXRlIC8g
ZGl2MTsKLQkJaWYgKGRpdjIgPCAweDEwMCkKKwkJaWYgKGRpdjIgPD0gMjU2KQogCQkJYnJlYWs7
CiAJfQogCi0JaWYgKGRpdjEgPj0gMjU0KSB7CisJaWYgKGRpdjEgPiAyNTQpIHsKIAkJZGV2X2Vy
cihtbWNfZGV2KGhvc3QtPm1tYyksCiAJCQkiJXM6IGNhbm5vdCBzZXQgY2xvY2sgdG8gJWRcbiIs
IF9fZnVuY19fLCByYXRlKTsKIAkJcmV0dXJuOwogCX0KIAogCWlmIChkaXYyID09IDApCi0JCWJp
dF9yYXRlID0gc3NwX3JhdGUgLyBkaXYxOwotCWVsc2UKLQkJYml0X3JhdGUgPSBzc3BfcmF0ZSAv
IGRpdjEgLyBkaXYyOworCQlkaXYyID0gMTsKKworCWJpdF9yYXRlID0gc3NwX3JhdGUgLyBkaXYx
IC8gZGl2MjsKIAogCXZhbCA9IHJlYWRsKGhvc3QtPmJhc2UgKyBIV19TU1BfVElNSU5HKTsKIAl2
YWwgJj0gfihCTV9TU1BfVElNSU5HX0NMT0NLX0RJVklERSB8IEJNX1NTUF9USU1JTkdfQ0xPQ0tf
UkFURSk7Ci0tIAoxLjcuNC4xCgo=
--000e0ce049e4aeba7f04a701f7e6--
