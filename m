From: Mark Brown <broonie@kernel.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Mon, 26 May 2014 17:14:26 +0100
Message-ID: <20140526161426.GK22111@sirena.org.uk>
References: <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+kGj9HXVJb05GbxD"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43458 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaEZQPT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 12:15:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>


--+kGj9HXVJb05GbxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 06:07:18PM +0200, Ulf Hansson wrote:

> >> I'm not sure I'm buying the idea that we have a powerup driver that's
> >> meaningfully not part of the main device driver.

> I am having a bit hard to follow the terminology here. :-) What is a
> "powerup driver" and what is a "main device driver" in this context?

Yes, that's mostly what I'm saying as well.  The main device driver is
the driver that will bind to the SDIO device and control it, the powerup
driver is the separate bit of code which will ensure that device is
powered up - calling it a device driver seems a bit of a misnomer to me.

--+kGj9HXVJb05GbxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg2heAAoJELSic+t+oim9i7UQAJPUKc4cGtxVxoB+IbJcb7hH
4XBusNOIOknawRboPeP4vGakfrsd4t+p6s2SKPV9eBUQ2sk1qbuLzlF5QGbnLqpB
GBplrintaru2i9/OaPWrrLQyAJ9P6OTr60jFec1Pu5Mbhvfrnibxwtbf2hZVYVqM
ihLiiAy1Auy/eBjv7eM2QnyCqAnU8+6m4rBw73Tu91LylxDdmDCQb+cgtqRT3hZZ
zMnxUFsUmUZpHSM/G5k4XVGDTbDuBTj4PkaPNx+wZ7Mzd7ixqM0hrq/LuJjAeghG
A/BKaA/mMydnP4hunfWyQINTjdi8Um0B7I9TPvyivEyq/M1WTpULabyuNMzF/4QX
zx94fde1F8YWVNVs1YfCAd7sBkj09fpRQsefPWhlxPM85Lnb/ziTgRNseoXhLzys
t6doswi15vwZuOY3Kp2wF+uwF0D1PT0F+U/dTE2cokYh3TlEHY7vQ2XrkFO8Tdp8
8v+PSL93U1BkMKVAWL8cyex422ZMZUjVYz3a3qQsAmWbpAZpq0x6I2chKeMt+d63
AG/ci4sGRcf1d7qljOKKEYWKMZZs5LyXczN2C9jbwYgr7KA+6RsmeTiLAeUNE2pM
2jLNgtEGr+PTgxjHIGTbB1XB+Hpc6VcjW1YyON3JLhHUw29XNCTmwhGnX0I4wIS5
bnBFu4sOK/5fh2oYuT9Q
=5JOB
-----END PGP SIGNATURE-----

--+kGj9HXVJb05GbxD--
