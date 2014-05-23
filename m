From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Fri, 23 May 2014 12:22:39 +0100
Message-ID: <20140523112239.GB12304@sirena.org.uk>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com>
 <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LNlQs39W5m9ZWtI7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40048 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbaEWLXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 07:23:16 -0400
Content-Disposition: inline
In-Reply-To: <537F1148.3010102@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--LNlQs39W5m9ZWtI7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 11:13:44AM +0200, Hans de Goede wrote:

> Thinking more about this, I would like to make one change to my
> proposal, the mmc-core should only do power up of child-nodes if
> they have a compatible of: "simple-sdio-powerup". This way
> when we add something more complex, we can keep the simple powerup
> code in the mmc core, keeping what we've already using this working
> and the mmc core won't respond to the child nodes for more complex
> devices, so it won't conflict with more complex power-up handling
> handled by some other driver.

Would it not be better to have this be something in the driver struct
rather than in the device tree?  Putting a compatible in there would be
encoding details of the Linux implementation in the DT which doesn't
seem right especially since these are details we're thinking of changing
later on.  Something like have the driver set flags saying if it wants
to do complicated things.

> FWIW if we ever get truely complex cases I think modeling the
> power-up hardware as a pmic platform device is not a bad idea,
> we would then need to have a generic mmc-host pmic property, which
> would be used both to do the initial powerup before scanning, as
> well as for the sdio device driver to get a handle to the pmic,
> for run time power-management (if desired).

I don't know if this will ever apply to SDIO but with other buses the
complicated bits come when the driver wants to take over some of the
power management do things like turn some of the supplies or clocks on
and off independently at runtime for low power modes.

--LNlQs39W5m9ZWtI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfy98AAoJELSic+t+oim994EP/1DO5pPeY5X7JsQofQTdfgfi
c7shdnCJ50ZGUTspeEUisQWc/8R5nky2FV/GYlbuexm2bB1MBk+2dsYXMWi8Cva8
ZB1b+fdQNA83o9ZodWMio7RDP4NzyKC+JZjIpMZr1k34V9ls3620zCeOjG+uyfff
ckVcbMo0aHfsS29o5NH0U+mZRbLJwLXTT+WQmkLIBCYPqEMqFEH5aAAfFXon+8ul
R2STYUogal4myl83tI1yXO5sNIqJnCZ001ketOjvdW1KPYzBbDIGCrtDEE4MW5RW
HRI6XXdLwHUGMVSlpYbhgy9VeRveID6r7P1WaA6uKiOqaYLyNog45pRUYdyoq2cS
3F/NylbpyKgxGn6ji4uyJwdMbBjn/f09AFQpWKSNYbweloM/z0cQ6dDLJYM6gpiC
mrX06oK1SHhm5TW3GL2awEhMWM8O13IFgNeI4Gb1X8gyXhi9K78bDwCfacbrV++L
Uxx0WNv2hpkVxpI7S1GacaXvBSNcBbYltt5lnd05LhJyfrQKWnXea3sN5Edd1zt/
hS7f36tQegeWw2OdjIq/FUsTkCOVk2osuuHi563I6YAHrBqG64bwKvcNWI3d5iBw
M9krdJfEStuTPlvkMLZEbJd2w18ZjcUI2wRUv0NrZb2tSqurUaRVDNiOudqxJ9dq
GznQor991yHaujuDGAGX
=GQ8C
-----END PGP SIGNATURE-----

--LNlQs39W5m9ZWtI7--
