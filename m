From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and
 cleanups
Date: Mon, 5 Mar 2018 10:39:59 +0100
Message-ID: <20180305093959.gaxl74rplmh5er7x@katana>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <20180304224248.mzhsvl4ccmtzg5am@ninjato>
 <CAPDyKFq_1mR=b3iu6o4ZJQeAjRnWf_tzb=__7SxvZYqDNCo2bg@mail.gmail.com>
 <20180305092259.bcpfbzvvoqxsfomf@katana>
 <CAK7LNATrq11iaa=uTuJx8Z9XMDg9CA8Nf0jdU3GkLKFH5fH9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fftsvgsxzyx4czcr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATrq11iaa=uTuJx8Z9XMDg9CA8Nf0jdU3GkLKFH5fH9Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org


--fftsvgsxzyx4czcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> They are all present in my next branch. The fix that Wolfram sent on
> >> top, is added immediately after the commit it fixes.
> >
> > Could we also squash it, then?
> >
>=20
> If Wolfram is fine with squashing,
> that would be cleaner.
>=20
> In that case, can you add Tested-by
> to patch 12?

Yup, sounds best to me.


--fftsvgsxzyx4czcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdEG8ACgkQFA3kzBSg
Kbbdrw/9FS5fg7H/KFEoJl7C1DXVOVzIORnhYtPHmGYptzEYy1ruDWBEKxP7EcdU
qhVrpVpQlcbYpIEBYnMEXIUtKKeAyLHdu0vDpfxNCbatYLv53J/Q3Bgpx9bJ4Si2
ZmBkBV8zlzZQcClbEuUJbjWj/1NdGe5IQRbhnoMiyaqItpP/4e+8HgAZJ9TZDjvK
+Butc3IKriFvGXUoTEaL0ItUCxLWV8l3O2seyKyQtVmbzTOb63FF6D6hXv79GjcH
dfDNAM/r7zzw7cfpFi6/mOn1iQYyXCQhqhbJpmYKxpsx0e25TCfctAP0bi04dubO
DnDPuAVPwJl9oVGsTWC0Z5MEYwDMfRR9fGYWB04Vw/fMIUa+3TnXeOoulde0jLpE
P+9Lc/rOgBnRsKDx+BsYxZALvPzO2E6fNkVWe6/M3TTHyAHl3cOipbRzGENdFf9w
mOjfpMtjYZTW5WimA92zjfhrMZ/+KYKJe8jNgZTrD3qMip1OqnETHz5r0inXu06n
RPdhlJJYERapMb2Uf2wbUBoNapQgArvgBvpjM+usL6K2zKLNv2yp7o2lusWwzOOj
tggXakq8E6mB6y1wrSzXOvGsOaBkMULg4401NlQcfiEVWIF826/KH9nkNkIBLobI
KE92OgornpnD/xXYykDarpuHaJrbs07CpT0Qf4baNWp/bs74uow=
=YD3V
-----END PGP SIGNATURE-----

--fftsvgsxzyx4czcr--
