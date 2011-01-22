From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Sat, 22 Jan 2011 15:21:12 +0100
Message-ID: <20110122142112.GC15620@pengutronix.de>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
 <20101116150022.GA27726@void.printf.net>
 <27884BED0E3C489C8849EE12A803F536@AN00536>
 <m3oc9pnt6g.fsf@pullcord.laptop.org>
 <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org>
 <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44400 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab1AVOVT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 09:21:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2011 at 04:14:46PM -0500, Nicolas Pitre wrote:
> On Fri, 21 Jan 2011, Tony Olech wrote:
>=20
> > Add a driver for Elan Digital System's VUB300 chip
> > which is a USB connected SDIO/SDmem/MMC host controller.
> > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > computer to use SDIO/SD/MMC cards without the need for
> > a directly connected, for example via PCI, SDIO host
> > controller.
> >=20
> > Signed-off-by: Anthony F Olech <tony.olech@elandigitalsystems.com>
> > ---
> > This is the second submission attempt.
> > There are 5 "do not initialise statics" errors reported by scripts/chec=
kpatch.pl
>=20
> you probably should fix those.  They are due to lines such as:
>=20
> static int pad_input_to_usb_pkt =3D 0;
> static int disable_offload_processing =3D 0;
> static int force_1_bit_data_xfers =3D 0;
> static int force_polling_for_irqs =3D 0;

Should those be static anyhow? Being USB, you could probably hook up two of
those and want to operate one of them in this and the other one in another
mode?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0659gACgkQD27XaX1/VRt6nwCeKcgGGHlRzQimRgtkzm1o4Cz0
bjoAnRrwjKSDhvNQjNRTFV1FHBG5PAeu
=CnTb
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
