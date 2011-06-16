From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
Date: Thu, 16 Jun 2011 14:19:42 +0200
Message-ID: <20110616121942.GD23579@pengutronix.de>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
 <20110616115133.GC31375@pma.sysgo.com>
 <20110616120009.GA23579@pengutronix.de>
 <20110616120629.GD31375@pma.sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51883 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab1FPMTy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2011 08:19:54 -0400
Content-Disposition: inline
In-Reply-To: <20110616120629.GD31375@pma.sysgo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pma@sysgo.com>
Cc: Richard Zhu <richard.zhu@linaro.org>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, linux-mmc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, pba@sysgo.com


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 02:06:29PM +0200, Pavel Machek wrote:
> On Thu 2011-06-16 14:00:09, Wolfram Sang wrote:
> >=20
> > > Unfortunately register differences are common. Is there better
> > > approach than patching it in low level functions like this?
> >=20
> > I am all ears for suggestions...
>=20
> One way would be to move functions such as=20
>=20
> sdhci_activate_led()
>=20
> to the low level driver,

There is no "low level driver" if the controller is done right.

> and introduce functions such as write_host_control() -- with no
> corresponding read_host_control, so that translation is easy to do...

So, a seperate function for every register which differs from the
standard? There are a lot of SoCs out there, and even more to come...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk359N4ACgkQD27XaX1/VRuIRgCfd0tlPumJeur7981y7DE1H9n3
XwEAoMrUmdFKr5cs3cdrt5hXSKl24oWU
=XnHO
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
