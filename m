From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Wed, 4 Jun 2014 16:55:29 +0100
Message-ID: <20140604155529.GP2520@sirena.org.uk>
References: <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
 <20140527175326.GZ12304@sirena.org.uk>
 <CAPDyKFqCwSfnbXJffQeMUMLEgZPcqjEMhbTXxi4HKOKqExQ70g@mail.gmail.com>
 <20140528110351.GI12304@sirena.org.uk>
 <CAPDyKFo_xHSKzoeKJb5sh+O3cMGsnqx_yVivpw8Tk72whPHGLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53355 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaFDP4P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 11:56:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFo_xHSKzoeKJb5sh+O3cMGsnqx_yVivpw8Tk72whPHGLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 12:57:52PM +0200, Ulf Hansson wrote:
> On 28 May 2014 13:03, Mark Brown <broonie@kernel.org> wrote:

> > No, runtime PM isn't really fine grained - I'm talking about things
> > like starting and stopping individual resources or configuring them.

> Are you saying that you have several levels of quiescent mode of your
> external chip?

Partly, but also there can be active modes that don't use all
functionality and hence can leave some of the inputs powered down (for
example if a reference clock is used for some feature that isn't used
all the time then that reference clock may be able to be powered down
when the function is not in use).  The device isn't suspended but it can
do without some of the resources it has.

> I am a bit puzzled of how such library should look like, but I suppose
> we need to be able to go to different power states through it.
> Typically the library may be invoked both from the mmc core to do
> power up/off and from the sdio func driver to handle power save.

> Does it make sense to you as well?

Yes, certainly for the power up/down and runtime PM type operations.

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTj0FuAAoJELSic+t+oim9tDsP/3r+e6X2v9xsKO3k+gEPP5++
T5YY0uAjILgLnSdH1GKPLD/PuUxbGuyA8FO/3IZrV3FN8G1+GcIdz1e2GRiAUOiz
wVwWvBCxoUvSoZ3u3Oh2ArnW6lZBTNebFYZgemLj77isCiyDL+O/aNMtueNYDG6u
olNlAM3LQuPRmoYtfegV+gjt6/S8It/liyzwMGMN4v09/TB5bd7DsnlG7ACrLgp9
Cua2wKGESk/fBwkRLYb4C8EPMDap5UwP5yv7UnkJqiU5othy5XS+C0GlMvdK5UCG
SLJNBmv5i8As/IUePsy2ghmRBV6kfM48iDEhfPRc6Q3S4PEY7Mq+NlhdaYnmsOzR
bHil1inaQJ4O8rRpomSXWK857JvcQDR7Q29AJ/BWJKIqjeSz2m1aFY5G0dhlxrxq
tkySuG/0AZi2vP3/bGL8VtxWvEekbmBm+VUxKOMr188KauCPdvG6GkWlbYZpmuH6
mbPP0EvhMJzcDWsUjHjoU5YVI32PVFMa5Hi+xOzVIdJSJ8p4dCfc+Lq2DTVo+NGT
2PJTysDfHO1x4TuHmWyWgqeqW1HjZOsHELoX7Ln4YCKCplQGJLl6oha2A4yOky7P
1j+rm0ZuPYxoNiqexn3VdUkYfF6hdtbfGR1OxYOK/V6/LpBJ9B+S70wsoCnWLkta
XaZ7lxoVP8W8r33TKBql
=D6Rf
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--
