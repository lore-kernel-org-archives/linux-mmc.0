From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Tue, 4 Jan 2011 15:24:33 +0100
Message-ID: <20110104142432.GB2609@pengutronix.de>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
 <1293096828-19985-1-git-send-email-olof@lixom.net>
 <20101223112346.GA5044@pengutronix.de>
 <AANLkTimdB+kXKX7sJK4sVZuvmX=Zj=kW5asJzyZXoURL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1ADOYi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 09:24:38 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimdB+kXKX7sJK4sVZuvmX=Zj=kW5asJzyZXoURL@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 01, 2011 at 04:28:46PM -0800, Olof Johansson wrote:
> On Thu, Dec 23, 2010 at 3:23 AM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> >
> >> Changes since v2:
> >> =A0 =A0 =A0 * Whitespace fixes
> >> =A0 =A0 =A0 * Changed order of test in get_ro
> >
> > What benefit has the reordering? (And just to make sure: You still
> > return -1 meaning "read-only". I assume this is intentional)
>=20
> Looking at drivers/mmc/core/sd.c:mmc_sd_setup_card(), returning <0
> means no RO detection, and will print a warning to that effect. If no
> other RO-related quirks are included (i.e. such as
> SDHCI_QUIRK_INVERTED_WRITE_PROTECT), the value will be passed up
> through sdhci_get_ro and thus handled appropriately.
>=20
> So on second look the code as it is seems correct to me.

ACK. I misread the code before :( No wonder my comment seemed vague to
you, sorry for that. I agree that the code is correct and the reordering
helps readability. The only nitpick I'd have now is to return
-ESOMETHING (-EINVAL?) instead of -1 to make the fault more obvious.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0jLaAACgkQD27XaX1/VRuOdwCcCLaJw/WP1D1a7CY0G1HUwx2u
5PwAoIb+6MoLq1+JwMXWGD96Ta21B4F4
=pVtE
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
