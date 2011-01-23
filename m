From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Sun, 23 Jan 2011 11:09:17 +0100
Message-ID: <20110123100917.GB32578@pengutronix.de>
References: <20101116150022.GA27726@void.printf.net>
 <27884BED0E3C489C8849EE12A803F536@AN00536>
 <m3oc9pnt6g.fsf@pullcord.laptop.org>
 <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org>
 <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
 <20110122142112.GC15620@pengutronix.de>
 <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34124 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1AWKJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jan 2011 05:09:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 22, 2011 at 02:07:21PM -0500, Nicolas Pitre wrote:
> On Sat, 22 Jan 2011, Wolfram Sang wrote:
>=20
> > On Fri, Jan 21, 2011 at 04:14:46PM -0500, Nicolas Pitre wrote:
> > > On Fri, 21 Jan 2011, Tony Olech wrote:
> > >=20
> > > > Add a driver for Elan Digital System's VUB300 chip
> > > > which is a USB connected SDIO/SDmem/MMC host controller.
> > > > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > > > computer to use SDIO/SD/MMC cards without the need for
> > > > a directly connected, for example via PCI, SDIO host
> > > > controller.
> > > >=20
> > > > Signed-off-by: Anthony F Olech <tony.olech@elandigitalsystems.com>
> > > > ---
> > > > This is the second submission attempt.
> > > > There are 5 "do not initialise statics" errors reported by scripts/=
checkpatch.pl
> > >=20
> > > you probably should fix those.  They are due to lines such as:
> > >=20
> > > static int pad_input_to_usb_pkt =3D 0;
> > > static int disable_offload_processing =3D 0;
> > > static int force_1_bit_data_xfers =3D 0;
> > > static int force_polling_for_irqs =3D 0;
> >=20
> > Should those be static anyhow? Being USB, you could probably hook up tw=
o of
> > those and want to operate one of them in this and the other one in anot=
her
> > mode?
>=20
> You could.  Whether or not you would is another question.  Until then I=
=20
> don't think it is worth bothering with such corner cases for the initial=
=20
> merging of this driver.

A static variable which should be per-device is a corner-case? Frankly, I'd
think it is a flaw. Unless, of course, these module_params are only rarely
used. Which would lead to the question if they are really needed. There are
quite a lot.

Also, I am not convinced of the need of a custom sysfs-file. Seeing its use
cases might help to identify a need which is probably better solved
generically.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk07/k0ACgkQD27XaX1/VRsqLACePv7YPpv1w85/W+w49DyhgJXX
dCYAnAz/97bKvonHDOdl7sp1h9E8+LhM
=H4Y4
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
