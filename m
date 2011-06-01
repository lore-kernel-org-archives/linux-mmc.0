From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048
 with a pklatform hook.
Date: Wed, 1 Jun 2011 06:00:50 +0200
Message-ID: <20110601040050.GA24330@pengutronix.de>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
 <m3mxi6p7fm.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53245 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1FAEAx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 00:00:53 -0400
Content-Disposition: inline
In-Reply-To: <m3mxi6p7fm.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2011 at 10:27:41PM -0400, Chris Ball wrote:
> Hi,
>=20
> On Sun, Feb 06 2011, Chris Ball wrote:
> > Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
> > This patch is untested.
> >
> > Signed-off-by: Chris Ball <cjb@laptop.org>
> > Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
>=20
> I've queued this patch now, since we're out of quirk bits and didn't come
> up with any alternative patches.  (Feel free to improve on it later.)

:( I still like the io-accessor-method a lot better. I would have created a
patch if I had got some feedback on my suggestion[1] (and will still do).

Regards,

   Wolfram

[1] http://thread.gmane.org/gmane.linux.kernel.mmc/5742/focus=3D5768

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3luXIACgkQD27XaX1/VRsfywCfYsjGJNBXPNmp179nWPM/7SeH
IvMAnj4U4PiFGMILj5kgmbM60V18qut+
=BRA3
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
