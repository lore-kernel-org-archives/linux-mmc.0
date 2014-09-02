From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 10/12] clk: sunxi: mod0: Introduce MMC proper phase
 handling
Date: Tue, 2 Sep 2014 09:52:34 +0200
Message-ID: <20140902075234.GO15297@lukather>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-11-git-send-email-maxime.ripard@free-electrons.com>
 <20140901213945.5251.37105@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMUnVF4nlYq3B90P"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35706 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750903AbaIBHzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 03:55:03 -0400
Content-Disposition: inline
In-Reply-To: <20140901213945.5251.37105@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com, zhuzhenhua@allwinnertech.com


--dMUnVF4nlYq3B90P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 01, 2014 at 02:39:45PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-08-30 13:03:09)
> > The MMC clock we thought we had until now are actually not one but three
> > different clocks.
> >=20
> > The main one is unchanged, and will have three outputs:
> >   - The clock fed into the MMC
> >   - a sample and output clocks, to deal with when should we output/samp=
le data
> >     to/from the MMC bus
> >=20
> > The phase control we had are actually controlling the two latter clocks=
, but
> > the main MMC one is unchanged.
> >=20
> > We can adjust the phase with a 3 bits value, from 0 to 7, 0 meaning a 1=
80 phase
> > shift, and the other values being the number of periods from the MMC pa=
rent
> > clock to outphase the clock of.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Looks good. Thanks a lot for revisiting this after talking to your
> hardware team!

It's not *our* hardware team, but I'll let them know :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--dMUnVF4nlYq3B90P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBXdCAAoJEBx+YmzsjxAgfMQP/RN3s/DNUsrNwryKlgk8GVDj
pPXo+F8A6IZtVXrXQUZbBeYE08HD889WKzvB8YwWAbHehEOLTan1TALOb7i20Pmc
WPGSiy106Z4oeRnRwuMzhJjF/h4Jl7/eRerSHbdjrp3OC2ebK6VQlhUHpP4K/LD5
W7MVTorHrnCuOfMGZYDcqrxDyHDy5SzPAu28+Zgl4FN3hNnPr8TIMQTZT7C08NmK
oT+xyK9xoUPpw+XokpIHpocNnPk37cjPzdMvbKYwTzmUmn5pa18pfgHlJRxDtZtf
wzh7+Uq3cdacc77R/bXB+rmNoG8eLWsawHQITE0/uX3pl99gN8VdKWjPq9gH8ZQN
Acr7MAdBCbPOn9ZVG7g7alEEiq0vwSHYTChUSfSzQ0KDtG0MDCbQH6khZS5PZhXj
u2ew72Yx9ZTAtvElVW4dR5Fx1LKkPfDmGJgA3SKq5o++/4ayctt2o1ucrtiUfVe/
NXNUx8vfA2orW/M2oCQ3OpOltx1k5ML4m4cacTgmeyTyNftYlD6HcGl8Avy+2yS+
8o5ieRPt1dA4wPFnpePzHcsauLxTfhMxmW2kA2HUNV2GAu70vO1n7ZTkzkyZrGoo
hHTODrWau08cbEonUFCnUQ13f0WIl/t8PWafzqxZoMZpgqnN0MKhAnoVmpLkULzW
M6ZYtDGjp4fQUSAmlany
=04mW
-----END PGP SIGNATURE-----

--dMUnVF4nlYq3B90P--
