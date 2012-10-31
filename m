From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Wed, 31 Oct 2012 22:16:26 +0200
Message-ID: <20121031201626.GA28784@arwen.pp.htv.fi>
References: <1351684656-30275-1-git-send-email-gururaja.hebbar@ti.com>
 <20121031122639.GA10998@arwen.pp.htv.fi>
 <CAOyx1LrKBE+xzSRN4F=+e1DuMJL+5SAv-YkJWJdDw8p=kDojmw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760652Ab2JaUWa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 31 Oct 2012 16:22:30 -0400
Content-Disposition: inline
In-Reply-To: <CAOyx1LrKBE+xzSRN4F=+e1DuMJL+5SAv-YkJWJdDw8p=kDojmw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: balbi@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 01, 2012 at 01:21:36AM +0530, Venkatraman S wrote:
> On Wed, Oct 31, 2012 at 5:56 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Wed, Oct 31, 2012 at 05:27:36PM +0530, Hebbar, Gururaja wrote:
> >> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> >> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> >> on the HSMMC IP timing closure done for the high speed cards.
> >>
> >> From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
> >>
> >> The MMC/SD/SDIO output signals can be driven on either falling edge or
> >> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> >> to reach better timing performance, and thus to increase data transfer
> >> frequency.
> >>
> >> There are few pre-requisites for enabling the HSPE bit
> >> - Controller should support High-Speed-Enable Bit and
> >> - Controller should not be using DDR Mode and
> >> - Controller should advertise that it supports High Speed in
> >>   capabilities register and
> >> - MMC/SD clock coming out of controller > 25MHz
> >>
> >> Note:
> >> The implementation reuses the output of calc_divisor() so as to reduce
> >> code addition.
> >>
> >> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> >
> > this looks good to my eyes, hopefully I haven't missed anything:
> >
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> >
>=20
> Except for the excessively verbose comments which are just duplicating th=
e code,
> <Quote>
> >> +      * Enable High-Speed Support
> >> +      * Pre-Requisites
> >> +      *      - Controller should support High-Speed-Enable Bit
> >> +      *      - Controller should not be using DDR Mode
> >> +      *      - Controller should advertise that it supports High Speed
> >> +      *        in capabilities register
> >> +      *      - MMC/SD clock coming out of controller > 25MHz
> >> +      */
> </Quote>
>=20
> I'm ok with this patch as well. I'm putting a few patches under test
> including this one,
> and will send it to Chris as part of that series.
> I'll strip out the above mentioned comments, unless there are any
> objections.

please don't. Detailing the pre-requisites for getting HSP mode working
isn't bad at all. Should someone decide to change the behavior and ends
up breaking it, the comment will help putting things back together.

my 2 cents, you've got the final decision though.

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkYcaAAoJEIaOsuA1yqRE+iUP/RHTNhUlndpVvGiedfuSlYjl
33HSSXBgyl+Pu9INdGHf79rbX2y4hpKtOcrMCafG72UPqJXsr4m4vs93yY/RXm5i
Sz+w9JmlkE7rmO2RKmOyL4faEXf64fGMCvHg6sP7nxcQJk8m350FnZqWYwoi2Ho1
8M1v4ls3I+7nl+aU2cOUwYLijorKRgU2l3/xqlh5Dj8RSpcQny/Iu1N7VbdhDQuO
UuxvN2D0Xa5goLxkw5DcluikyfOY0iak2okApBDwsfYYzlQqI/K1XjjO/G30TJoG
OAiHEopcaH2KJNa2zPyus0w91JJkw0MXV2EP5yS2N3VLzKW/TfD71//q+X330f3m
sm6fskFR/2j98jW/I7s0hrlwQmepwPKxUAYUfuNiEwitSZgYTBuy9rTuBTrq5zhl
XKAYN8XMEWH4wM3ReyGgs7UKhplAEVnCgwH9ZWTSQmOa2PBj5yOaVZahA4XPccZx
6V9iyugmSQB/kBHZ7ua3XWiEExuMqw/bkxaW7k6k2URsU8cbFltVde1D3rPN2RCS
F9yJo/4Fo/UPmc4BcPj+USl/OWOLxB+qbToq7vZW+KJ8S6rA7R/MidxcLUtZ/+jc
1GUai4q8ypKOegSSMcepUxQkMDVj5lP2hd9z3YysMnoKTxf24DkyI1UbvRhukE9Z
4u1yhR3SU6uZX7/5ipT0
=D5yN
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
