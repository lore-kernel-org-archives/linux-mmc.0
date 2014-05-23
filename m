From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Fri, 23 May 2014 17:27:18 +0100
Message-ID: <20140523162718.GE22111@sirena.org.uk>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com>
 <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6/6uI2huoQv5mg2W"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40392 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaEWQ3t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 12:29:49 -0400
Content-Disposition: inline
In-Reply-To: <537F3610.3050104@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--6/6uI2huoQv5mg2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 01:50:40PM +0200, Hans de Goede wrote:
> On 05/23/2014 01:22 PM, Mark Brown wrote:

> > Would it not be better to have this be something in the driver struct
> > rather than in the device tree?  Putting a compatible in there would be
> > encoding details of the Linux implementation in the DT which doesn't
> > seem right especially since these are details we're thinking of changing
> > later on.

> The compatible is not a Linux specific thing, it is a marking saying
> that something needs to take care of enabling the clks (and whatever
> else we will make part of the binding for this compatible), before
> scanning the mmc bus.

We could just say that the mere presence of a child node with the right
properties is sufficient to trigger the bus to do the startup?

> > Something like have the driver set flags saying if it wants
> > to do complicated things.

> Chicken <-> egg, we won't know which driver to use before we've probed
> the mmc bus, and we cannot probe the bus before enabling the clks, etc.

If the device is sufficiently complicated to need a special power up
sequence I'd expect we'd be able to have a compatible string which would
provide enough information for us to figure things out.

> >> FWIW if we ever get truely complex cases I think modeling the
> >> power-up hardware as a pmic platform device is not a bad idea,
> >> we would then need to have a generic mmc-host pmic property, which
> >> would be used both to do the initial powerup before scanning, as
> >> well as for the sdio device driver to get a handle to the pmic,
> >> for run time power-management (if desired).

> > I don't know if this will ever apply to SDIO but with other buses the
> > complicated bits come when the driver wants to take over some of the
> > power management do things like turn some of the supplies or clocks on
> > and off independently at runtime for low power modes.

> Hmm, good point in that case actually having these things in the
> child node makes most sense, because then the driver can find them
> their. Note that the mmc core enabling things does not mean that
> the driver cannot later disable them if needed.

Right, that's good idea for solving the problem - the child device can
either share the reference with the bus or have some way of getting at
the object the bus requested depending on what's sensible.  Only
potentia complication I can think of with that approach is a device with
multiple bus interfaces (I'm mainly thinking of SDIO vs SPI) but it
doesn't seem to hard to deal with that in the bus adaption layers of the
drivers.

--6/6uI2huoQv5mg2W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTf3bjAAoJELSic+t+oim9UzQQAIauqh6L/Rggl3tmpNt8Exdy
u8H3YoNev8qyt9ucYuTWe+lGkIKqZccmSzMvoaheaExP8/YS0q62wk4NsSWYOcgu
v538lFdH/pXNQhqUq0SS6rb28ATtYSEpQZ+XMOuHO1WusAzf3PzCAierKZcHKfHM
/KTWKVWFHtJXLhDociANI1DEo8gYHYvrNiANkLNFPAZx/MDvKKc0Tfic9ARWA+G3
yVR1nHSTpGw31v2rBnRGMLOhiyAy/Uvt13/KcSdymdycXkMKaxeLbTqBovtLqbbc
GYBrnWmCEcGmhX2Qm8wpFKtgGpr/R+ZdeEKGR6AtxmHkBH8ACS5Mf9iQLvnjbNPf
f+d3TWrgjzs8QkGfl2aTVMDCjV+SYE5c/IT3OmGXQYDmOBSVgOlOEJ4wdT4a0lzA
+Ba3CbakJnnDgcW3OHcLh/0mYs5uwbMmZ8AOwgqC7XCo4Xn+40508nP8r6c4fr+N
KCwoF1P1mdcTsGUvWAAqINn0GBZQ0jBwA8DKqHUKqswqgAAQ74HBB7I0FMzDrYE4
ZgxnlS+c3ze23DlUYSrkweJpn7Mec8mX9Ql9LWdCFZdqGNfXMtqniB2vF7KytQNg
l4Lbr7oEDiEyriAwQygWPqrgbFG3kbGVIQf63wewp7yW5mIlelo2rbH/TDjdPuAI
nUNwr596+8D+a60RWPfL
=w41y
-----END PGP SIGNATURE-----

--6/6uI2huoQv5mg2W--
