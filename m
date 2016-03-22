From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/10] pinctrl: sh-pfc: r8a7790: Implement voltage
 switching for SDHI
Date: Tue, 22 Mar 2016 09:35:20 +0100
Message-ID: <20160322083520.GB1475@katana>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
 <1457774112-16958-2-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXhw6bPBruU8CLXm72mq6_c6a_8ZPGukdyuMi=HQ4eACA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXhw6bPBruU8CLXm72mq6_c6a_8ZPGukdyuMi=HQ4eACA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2016 at 10:47:23AM +0100, Geert Uytterhoeven wrote:
> On Sat, Mar 12, 2016 at 10:15 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> > on negotiation with the card.
> >
> > Implement the {get,set}_io_voltage operations and set the related
> > capability flag for the associated pins.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: linux-gpio@vger.kernel.org
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

So, can this be picked up already?


--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8QPIAAoJEBQN5MwUoCm25OEP/isZug+FhRoUnFMosk2DFHDX
nu3OhlK5Alam5kb6Oij2E+onS6CmeKyNoZJSooEeKwS9MUBm9UW1njLZE/bVfYcX
TExIyZGjv1FekmA/Yp/z2L/3Gg33iQ1zXMmlooG8MU5C/2HGhF/ZkECYiLIiiaG2
88zZyzhaCWi3B0in086Bkckr4nmIvFOpwTln7i4vIl/2/OXqLWm2U4sGPXm3QM2g
6cO90JClw7L/41Nc8gtohcKr+i9dOHAseSv7HvPFa7CAXBL+ftR0EkJf+c68xXjD
/GqSfwlbKuGs0M58FWG7r0+SbBh9T3q08PBoAGgEVp+AhHqM99tF2L4MkJHXQYw2
yW0CnJyowjtNEau/CkwdL/Ps5tNBR6Ei9iUigvZfWhsikjAKERiaw6aEDhZ9/XHR
h+ENBuU9DERxroe3dNS+AifwIGOFhhrmqNiFFRsSRj+JI/+JbZbFFu8Qtvbrh8AT
Wo5WyKKU7MTpZ312VNlXCS6TFChXezw2ZI1jjnMHh5FWNIMkjDA3WO5ll3yXL12O
yilWVp14HGE4qToq0D18+FLgz1hw+rXwegNV2ya5VuEn5C7YoPZAJGB6J40gxMNZ
VbmQuGKGocpMoGjNvoWLEvn4x+Sp1tpqi/QE4+Nbh26GqtBSLZXUdniuLvChBE9z
XsTwz+AJ0YiB66WQGKbc
=YW19
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
