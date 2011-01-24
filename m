From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Mon, 24 Jan 2011 16:35:37 +0100
Message-ID: <20110124153537.GA20736@pengutronix.de>
References: <m3oc9pnt6g.fsf@pullcord.laptop.org>
 <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org>
 <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
 <20110122142112.GC15620@pengutronix.de>
 <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
 <20110123100917.GB32578@pengutronix.de>
 <alpine.LFD.2.00.1101230854430.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56653 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1AXPfn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 10:35:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101230854430.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > Should those be static anyhow? Being USB, you could probably hook u=
p two of
> > > > those and want to operate one of them in this and the other one in =
another
> > > > mode?
> > >=20
> > > You could.  Whether or not you would is another question.  Until then=
 I=20
> > > don't think it is worth bothering with such corner cases for the init=
ial=20
> > > merging of this driver.
> >=20
> > A static variable which should be per-device is a corner-case? Frankly,=
 I'd
> > think it is a flaw. Unless, of course, these module_params are only rar=
ely
> > used. Which would lead to the question if they are really needed. There=
 are
> > quite a lot.
>=20
> Given their name, I'd say they are there only for debugging purposes. =20
> So yes, they probably are rarely used, which doesn't mean they're=20
> useless.  Same thing goes for maxfreq and nodma in mvsdio.c for example.

OK, I still wonder if all eight of these debugging-aids really need exposur=
e to all
users. There is no documentation how and when to use them. But well...

About the "static" thing: Yes, there are already drivers having one or more
quirk parameters. That probably justifies it (personal taste aside).

>=20
> > Also, I am not convinced of the need of a custom sysfs-file. Seeing its=
 use
> > cases might help to identify a need which is probably better solved
> > generically.
>=20
> I'm sure the author of this driver would be eager to hear from you with=
=20
> a concrete suggestion.

? This is exactly why I asked for a use case? To see if something should be
exposed from the core and not the driver?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk09nEkACgkQD27XaX1/VRtdHgCeJ+p7w/o5LEIdyR9ojpOI05G/
DuQAnizW/zS222+IrPM5ugBhLyKKbFVa
=IWLb
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
