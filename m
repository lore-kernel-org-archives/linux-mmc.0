From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 10/13] arm64: allwinner: a64: Increase the MMC max
 frequency
Date: Fri, 27 Jan 2017 22:26:11 +0100
Message-ID: <20170127212611.rn2nr4fihshud2qg@lukather>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
 <dee0dc8e1d98698231738b10fbe79cdf6d5e4c36.1485421557.git-series.maxime.ripard@free-electrons.com>
 <6c6bf169-4b2e-6b55-54db-d21da73a8f6e@heig-vd.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3893174917174731709=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6c6bf169-4b2e-6b55-54db-d21da73a8f6e@heig-vd.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Vaussard <florian.vaussard@heig-vd.ch>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============3893174917174731709==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5423czn5p4zwsaa"
Content-Disposition: inline


--t5423czn5p4zwsaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 11:29:53AM +0100, Florian Vaussard wrote:
> Hi Maxime,
>=20
> On 01/26/2017 10:06 AM, Maxime Ripard wrote:
> > The eMMC controller seem to have a maximum frequency of 200MHz, while t=
he
> > regular MMC controllers are capped at 150MHz.
> >=20
> > Since older SoCs cannot go that high, we cannot change the default maxi=
mum
> > frequency, but fortunately for us we have a property for that in the DT.
> >=20
> > This also has the side effect of allowing to use the MMC HS200 and SD
> > SDR104 modes for the boards that support it (with either 1.2v or 1.8v I=
Os).
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >=20
> > arm64: allwinner: a64: Limit MMC0 and MMC1 rates to 150MHz
> >=20
> > Trying to set the bus to 200MHz on MMC1 when doing SDIO is failing.
> > Allwinner sets the maximum for this bus to 150MHz, so enforce that limi=
t.
> >=20
> > This hasn't been tested with MMC0, but the documented limit is the same,
> > and I expect the behaviour to be the same.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> I suspect that you are trying to increase your number of Signed-off-by ta=
gs by
> using unfair means :) Otherwise the squashed commit message is probably w=
orth
> some cleaning.

/me hides in a corner...

The first commit log is the right one, I'll remove the second.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--t5423czn5p4zwsaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYi7ruAAoJEBx+YmzsjxAgpnsP/AoyyT0CGp7QhGPXcNzl3euw
TPJIFAmnm1ejtCHKUViGbr6cv4FfLzc6CrYwWnAFQOjSqzqh+wktOyULmO15RsfR
v75sFR9CTP0HUntCUuSnXN9Bzn4ls5/+m8lYDiViPAKt6Vp7oN4g8DGEPVQLYoN0
4CBRhHOtrY8cofNOu/zGJLaccYxRpaNVQV2d+QJPxss12e8sJyr6HAH8Vtew/YaC
Dm/s219N+QgRDSaVDZ6Q6+7gOo9/mDL3lt1jcgg0JLCYSZW1gvIg0xQ/SGDLiEsz
nXSpshsLBPWKha9cXXtSKPns7s0PYepNLQPSzEn3EezxQLnJ4OgswTX/b485uxBT
dmGFmDOe6sRIgojyRO7Uq7EKDA01/vbi6H4LjIt0hCdTICI9Lr3t3+xOPfO1pG93
dgqL2DncWowx0lRSkoVo0//GN6RZ2rH0Zs+Vi1Qi95mcdvU9kb4EV6cFGM58wF7L
QmvcOmV2DLCBiGIxMys43wpNUQYyU1G1n6rGmOgz42u7vZicbhVbwJb1ixUgyjD+
ROZAB9FrReZXAgWmwFxCAx6GVV7EAf0xPWAk6Oym5x6aLnwgVRxZRq/uv2QF9bDn
PmKtykRhiU4ZD1zvY4e1Y5uXgWqzzbTfeSErcOR0IMRUeMLFLKUKJL9LHxXIX72L
zIDYNTprd4NrfFNtG2YO
=Jnh2
-----END PGP SIGNATURE-----

--t5423czn5p4zwsaa--


--===============3893174917174731709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3893174917174731709==--
