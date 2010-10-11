From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom
 init-call
Date: Mon, 11 Oct 2010 13:07:58 +0200
Message-ID: <20101011110758.GE6028@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
 <1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
 <19620.19198.88841.623775@ipc1.ka-ro>
 <20100930094202.GA581@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55775 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0JKLIC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 07:08:02 -0400
Content-Disposition: inline
In-Reply-To: <20100930094202.GA581@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-mmc@vger.kernel.org, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-arm-kernel@lists.infradead.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2010 at 01:42:02PM +0400, Anton Vorontsov wrote:
> On Thu, Sep 30, 2010 at 10:31:58AM +0200, Lothar Wa=DFmann wrote:
> > > The custom init call may need more data to perform its job, so we pass
> > > it a pointer to pdata, too. Also, always use the platform_id specific
> > > data even if platform_data is present. Doing that, platform_data can
> > > additionally be parsed by init() for board-specific information (via
> > > sdhci->mmc->parent).
> > >=20
> > Why not a pointer to the platform_device itself? Then the callback
> > function would have even more information (e.g. platform_device ID)
> > and could easily get at the platform_data too.
>=20
> dev->platform_data may not be there. There are two ways to pass
> the "platform data" to the sdhci-pltfm driver:
>=20
> a) via dev->platform_data
> b) via platform_device_id->driver_data

or c) both :)

which is the reason for the current implementation.
platform_device_id->driver_data may still need additional information
=66rom the board (e.g. a write protect pin from board pcm043) while the
larger part of the driver_data-extensions are still generic (e.g. to
imx-esdhc).

>=20
> Technically, we can do something like this in the probe():
>=20
> if (!pdev->dev.platform_data)
> 	pdev->dev.platform_data =3D platform_device_id->driver_data;
>=20
> pdata->init(dev);
>=20
> Note, in this case we must also NULLify platform_data it at remove(),
> as platform_device_release() will try to free statically allocated
> memory.
>=20
> Thanks,
>=20
> --=20
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyy8A4ACgkQD27XaX1/VRt0CACgr+oWsFv80AQ0Cx9LhDFlJE3l
A3cAn34/IHPJOd2xIQwBMvUlcbc1dS34
=Jxly
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
