From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Tue, 27 May 2014 18:53:26 +0100
Message-ID: <20140527175326.GZ12304@sirena.org.uk>
References: <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HRNDPvX8vGqmvZQF"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44616 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaE0RyC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 13:54:02 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>


--HRNDPvX8vGqmvZQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 03:50:33PM +0200, Ulf Hansson wrote:

> To describe the HW in DT, the embedded SDIO card (actually it could be
> any type of embedded card) shall be modelled as a child node to the
> mmc host in DT. Similar to what you have proposed, but with the
> difference that the child node _must_ contain a DT compatible string,
> which means a "powerup-driver" can be probed.

> Yes, I understand we might need one DT compatible string per board,
> but that's because we need to model the hardware - and it differs.

> To clarify my view, we do need a "powerup-driver" and the primary
> reason is that we must not model "power up sequences" within DT.
> Typically I see the "powerup-driver" as a simple platform driver
> attached to the platform bus, but I that could of course differ.

This then either conflicts with cases where we need to describe the
actual contents of the slot with a compatible string or means that the
SDIO driver needs to handle powerup sequencing since we should be
binding to the first compatible we find.  If the host controller driver
and/or subsystem is going to deal with the powering up it's not clear
that it specifically needs to be the compatible property that's used
to determine the powerup method, it could just be a boolean or a
'power-method = blah' property (where blah is one of a series of strings
defining methods).  Alternatively we could have separate nodes for the
slot and SDIO device but that feels meh.  What's the hard requirement
for it to specifically be a compatible property?

> The slot will be the first level of child node under the mmc host,
> then each slot may have a child node which models the embedded card.
> But, let's leave that discussion for now. :-)

OK, that's the separate node for the slot and device.

> Powerup driver's ->probe():
> Typically the "powerup driver" will need to register a few callback
> functions towards the mmc core. Typically at mmc_of_parse(), those
> callbacks will have to be connected to a particular mmc host.

> I would like to see three different callbacks, mirroring each of the
> mmc_ios power_mode states MMC_POWER_OFF|UP|ON.

> The power up sequence, performed by the mmc core:
> The mmc_power_up|off functions, will invoke the registered "powerup
> driver's" callbacks if they exists for the particular host it operates
> on.

There's also the need for the SDIO device to be able to get at the
resources provided and actively work with them at runtime if it wants to
manage things more actively (partial poweroff for low power states or
managing clock rates for example).

--HRNDPvX8vGqmvZQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThNETAAoJELSic+t+oim98RoP/RXF4ifRgUISRLjjeAkbAvzu
9h4eIYx8+XqsJg8NSD1oPPUz1IFd21TVB7pLLme+Z4tCU6+rk3RDRoDXegcHO651
xjxIjUptV73G+5Y7dfKWIa2YjrtWHT9r6fIFgmTp+P75QJFWWf3F+jVH4FUagrhN
9diMdZUbJdx6M1Tb2Oq02IJRkJb087vUi5QK7Pr8TPoCkBYShBv9rhs/zXpKnwRc
M+iGqQe2k4IWCR1q8GS0M+P1weBQQO/10cycaGfDvWj4gNFiSGuSwL4mNp75ew7B
HIDAWgiVQrEas8oy+NbSooNHLK1/bVfyw4tfWvKERDsWGiBLnwi/CsCJzbzrkgEp
y5xQkut0q1i26vVm+XnRez19TqtsnmPTq+MDPjBjGKdmlyq5qIJo/fMyjWN9/r3v
rEkGy8rhrx7p9ltUeH7u9rBgawtXix5pGv4RDZOK0PpsTk7mg1QDpoy7I2wi49A9
nE43u34zivKICNv0MsUCTPXoHLkkpXQwudkxGLGW1kexCXDjJ+b5IWxeD9HDDEk6
pPOq+S5jM1lVM0fyGhH4Njbx0pk1XGayEYOqEZNbc/7xbKTPN8wLkPxfCuo4mHTi
TGqBeeClaxL95kZgUnSeQx9b9r7nMlGwTUoydhAdwMRLN7vpAbmb/I3UOyQJi6Pq
9Ldbv22YoqssNKpH01VR
=0eXA
-----END PGP SIGNATURE-----

--HRNDPvX8vGqmvZQF--
