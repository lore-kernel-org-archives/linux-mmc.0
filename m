From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 4/6] mmc: tmio: add eMMC support
Date: Wed, 21 Sep 2016 08:07:26 +0200
Message-ID: <20160921060726.GF1484@katana>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919210038epcas1p1e9339bd774291e7131c270ca130056ab@epcas1p1.samsung.com>
 <20160919205750.4766-5-wsa+renesas@sang-engineering.com>
 <e13ee5da-ad48-703a-5220-089f1f1ca0e0@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44066 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754783AbcIUGHg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Sep 2016 02:07:36 -0400
Content-Disposition: inline
In-Reply-To: <e13ee5da-ad48-703a-5220-089f1f1ca0e0@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 06:35:00PM +0900, Jaehoon Chung wrote:
> On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> > We need to add R1 without CRC support, refactor the bus width routine a
> > little and extend a quirk check. To support "non-removable;" we need a
> > workaround which will be hopefully removed when reworking PM soon.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/mmc/host/tmio_mmc.h     |  3 +++
> >  drivers/mmc/host/tmio_mmc_pio.c | 38 ++++++++++++++++++++++++++-------=
-----
> >  2 files changed, 29 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 4b501f2d529f6e..637581faf756b1 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -79,6 +79,9 @@
> >  #define	CLK_CTL_DIV_MASK	0xff
> >  #define	CLK_CTL_SCLKEN		BIT(8)
> > =20
> > +#define CARD_OPT_WIDTH8		BIT(13)
> > +#define CARD_OPT_WIDTH		BIT(15)
>=20
> Just confusing whether CARD_OPT_WIDTH is 4bit or 1bit?

The HW is confusing. Setting the bit sets 1-bit mode. This is why I put
the comment below in the code:

> > +	u16 reg =3D sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
> > +				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
> > +
> > +	/* reg now applies to MMC_BUS_WIDTH_4 */

This comment I meant ^^^

> > +	if (bus_width =3D=3D MMC_BUS_WIDTH_1)
> > +		reg |=3D CARD_OPT_WIDTH;

=2E..

> >  	switch (mmc_resp_type(cmd)) {
> >  	case MMC_RSP_NONE: c |=3D RESP_NONE; break;
> > -	case MMC_RSP_R1:   c |=3D RESP_R1;   break;
> > +	case MMC_RSP_R1:
> > +	case MMC_RSP_R1_NO_CRC:
> > +			   c |=3D RESP_R1;   break;
>=20
> Just wonder..It there case that hit "case MMC_RSP_R1_NO_CRC" ?

Yes, as described in my response to patch 1. It doesn't work without.


--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4iOeAAoJEBQN5MwUoCm2GJQP/3H0UVeN2xPyN1j8SiKe8HoC
wg/C8dNfi1LcI7AiIzuJ9tpgTH+eOY8jK6i7MCBo+4j9gVExOXhGGi9Y7dGmpyeS
iaqWK7XRyXh6hEfIYBAAGLu772cO2bDgNrXeFRmNGF1xF3LgW23as0gzpvRQvkmf
ym9EdCEnSk8GCelpcC3nKPW5WNfIhRKD50im2HKgCmhJCov8rYydIU8tF5yy4eGs
rmfBrBByKr1I0Pxv1J9G+Y4N5zj6HICejNU8Bbqh73sYymQdmwXXXZRtIXc9FWP/
xAgLCGjV2+gihzYd5qYPvUofNJaiSyIz6sEU0raRaFvJ3DR5UeiO3nbErgaH5EDB
RGWF2n113Zi8ybH22WtBz5RyD2wcsWEeNhg4s/R1sMq9a88/JBcB+NuDsD9ODvXV
NjPo6FGJ8INDbKEW4Hnub2dYR9np61zjOdPyCn+oJdQYluK+6vW5b3y9RtwDDYUs
osW6baQJVCpPvOQtRJ7nudQV/buRBok4THIPMzDT5UfOdJqjK9FFcbaeqqVw36Kt
8BuEV/OVXKiOYq1lKELQHE+vzid1kzSeKx/BWyc36K0NI/QnkOE9bbWbfMZn+ajP
01KZbwstlvJvh2MjL97h/8GASn3ni70XXARFcPIKkkxyu75aaaeFMFo75WY1+lk2
8SXkDmufeE9xEsvK96/Y
=DiEH
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
