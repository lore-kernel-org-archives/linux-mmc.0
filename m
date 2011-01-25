From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Resubmission
Date: Tue, 25 Jan 2011 10:13:17 +0100
Message-ID: <20110125091317.GB2703@pengutronix.de>
References: <m3oc9pnt6g.fsf@pullcord.laptop.org>
 <4CE41BE3.1060806@elandigitalsystems.com>
 <m3oc9n241c.fsf@pullcord.laptop.org>
 <4CEA86D4.9050109@elandigitalsystems.com>
 <1295607004.1816.6.camel@apple-mac>
 <alpine.LFD.2.00.1101211608330.8580@xanadu.home>
 <20110122142112.GC15620@pengutronix.de>
 <alpine.LFD.2.00.1101221405110.8580@xanadu.home>
 <20110123100917.GB32578@pengutronix.de>
 <1295886085.1677.32.camel@apple-mac>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57924 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab1AYJNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2011 04:13:24 -0500
Content-Disposition: inline
In-Reply-To: <1295886085.1677.32.camel@apple-mac>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The intended use of the read-only sysfs file is to enable first-line
> support staff to determine quickly what actual firmware file is being
> used.

You have that in the driver (and similar ones):

+	dev_info(&vub300->udev->dev, "requesting offload firmware %s\n",
+		 vub300->vub_name);

Won't checking the logs do?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0+lC0ACgkQD27XaX1/VRtmvwCgqU7z71m8vMkVcRuBk2Jo8ROp
fFsAn3pXDMDJYaBnd/la57hDTm96J5XD
=vq7M
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
