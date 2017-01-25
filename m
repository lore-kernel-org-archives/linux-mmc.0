From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 1/13] mmc: sunxi: Fix clock frequency change sequence
Date: Wed, 25 Jan 2017 09:26:02 +0100
Message-ID: <20170125082602.llunpuqwsimtzkds@lukather>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <6f6b511bce9df86ee43486653ac55df0d135f198.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFp735=MMm02PKEt2iZmN0Afyp52_g-8hKxpW71hw2RyiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kwetivlh2i3v4f47"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50241 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdAYI0Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 03:26:16 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFp735=MMm02PKEt2iZmN0Afyp52_g-8hKxpW71hw2RyiQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>


--kwetivlh2i3v4f47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, Jan 24, 2017 at 09:12:07AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The MMC and SD specifications documents that the clock frequency should
> > only be changed once gated.
>=20
> Where?
>=20
> >
> > The current code first modifies the parent clock, gates it and then
> > modifies the internal divider. This means that since the parent clock r=
ate
> > might be changed, the bus clock might be changed as well before it is
> > gated, which breaks the specification.
> >
> > Move the gating before the parent rate modification.
>=20
> This all makes perfect sense to me, however I am not sure you need to
> refer to the spec to justify these changes.

I can't find it anymore :/

I'll resend that patch reworking the commit log.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--kwetivlh2i3v4f47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiGEWAAoJEBx+YmzsjxAgPMQQAK6Jv2hSrNnsIsGseMADAssc
BY6CexdjRUlnJOJSE9vV8qNc6+rBtl8u1rgTvgJykS4nGV00W7OneeqeF4iSKmO3
9Pr4HZKnpGRiuDLl13sZhs8QZDDHPItPvgguUr/2E01mJx5LOsUTomH7u0kVN3MO
EXbqKR8juIdnloHc9UBxG2yBl6WT3ImMfFcz7RlurQu/QvOi2Il0J8bNCzddfdCG
hBbt0PZ67DVOyIcQadPVXb2IjgEFYEXkz7KCs1ISykittD+gPwmZZqfbjRcpX9E4
IEQBAaThdrBHrgvS1a1wwXEGSxCY+OCXb5J9aNwVsbqtm2oVBVEG/A9ppdJ9Fj8L
0SZ1ryb9QclW/Uv2kloNvi2B3rETfpPB9SE9JpzX+o+eUqudJFiz9idE45lCWYxm
6dNeg1X1UyfCr/9tf7lvi0L9sHYoWVJUVznqlxtDlGnODVtf2Nh98UTCvGXKn5xV
/3xoZVTQHvBDSYb65mkvEEvWxB8OIALBoYTtGXrcqrsclFNNHcch6RXHYVajXZu/
ZsuW+sO4KR7rmJNFAnf4c/PoVrgls1Gzks1Wez5cVYvVBvm1eMwXDBzOnKw28gts
HtEve1SOWhssEeN0tlrfOEeQb3Bmc78sVU2zo7S/GNWIBGAxNRJn89V5YagyeAMS
VZwceo3+u10oDUfEDpX/
=nDkA
-----END PGP SIGNATURE-----

--kwetivlh2i3v4f47--
