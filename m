From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Thu, 27 Oct 2011 08:02:13 +0200
Message-ID: <20111027060213.GB28387@pengutronix.de>
References: <20111027041851.GA18442@gmail.com>
 <20111027051532.GA28387@pengutronix.de>
 <20111027050939.GA27531@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52601 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1J0GCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 02:02:14 -0400
Content-Disposition: inline
In-Reply-To: <20111027050939.GA27531@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Cc: linux-mmc@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Even there are some SDHCI hardwares cannot be stable in microseconds, I
> think this is also OK since they just need to wait for a few more loops. =
The
> total waiting time is the same as before.

Well, I still think this is curing the symptoms not the cause. But will talk
with Chris about it since we are both in Prague at the moment...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6o8+UACgkQD27XaX1/VRtVPQCeJdy+B6J1NWZjBgb2OH63ksbl
V2kAoJ20UqLYH0J/NTGZjtpExjUxpRsn
=Vtqa
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
