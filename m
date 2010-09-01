From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: A serial patchs that support FSL's eSDHC
Date: Wed, 1 Sep 2010 12:15:00 +0200
Message-ID: <20100901101500.GE11407@pengutronix.de>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59722 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab0IAKPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 06:15:10 -0400
Content-Disposition: inline
In-Reply-To: <1283334305-12453-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2010 at 05:45:04PM +0800, Richard Zhu wrote:

> Can you help me to review the following serial patchs, that enable the sd=
hci=20
> driver to support FSL's eSDHC on i.MX family.

I see two major problems: First, you often modify sdhci.c to work around
the hardware-quirks. See sdhci-of-esdhc.c how it can be handled in a
seperate source-file and keep sdhci.c clean. (While at it, what is
common between the of-driver and the platform-driver should be shared).
Second, your platform-driver is a complete one, but we have a platform
core meanwhile (sdhci-pltfm.c). Please use that.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkx+J6QACgkQD27XaX1/VRs0yQCff4kEjRBM8QalIq1ItVdtbsny
am8AoL+aJckY1jhITIbGX8CMInClFvGr
=g7aL
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
