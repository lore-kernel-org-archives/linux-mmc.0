From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/2] Add GPIO WP and HW bus-width caps when support
 i.MX51 BBG board
Date: Wed, 3 Nov 2010 15:06:04 +0100
Message-ID: <20101103140604.GD4167@pengutronix.de>
References: <1287568828-22563-1-git-send-email-r65037@freescale.com>
 <010C9052C42A00499CE76D637FA5EE90A516@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0KCOGG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 10:06:06 -0400
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE90A516@039-SN1MPN1-002.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

> Do you have any comments about the following patches?
> These patches add the GPIO write protection, and add the HW bus-width
> caps limitation.

First patch: The sdhci-part is okay (it's trivial enough), did not check
the iomux-stuff, but I assume it works for you :) If you are basing your
patch on my RFC-patches, it would be better for the process if you'd a)
note the dependency in your patch and b) add some Acked-by or Tested-by
to my original series.

Second patch: There is some discussion about the bus width currently
going on. I'd suggest you join it.

BTW did you try adding regulator support yet?

Best regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAkzRbEwACgkQD27XaX1/VRuuDgCYmUSsexX4WFsEt9GGhuCkxLLj
CACgkG3a0OKPneappNAihTbXB/2JdDM=
=1wQR
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
