From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support for mx5
Date: Tue, 14 Jun 2011 15:55:20 +0200
Message-ID: <20110614135520.GH5043@pengutronix.de>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
 <1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
 <20110614095129.GD5043@pengutronix.de>
 <20110614130610.GH30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab1FNNz1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 09:55:27 -0400
Content-Disposition: inline
In-Reply-To: <20110614130610.GH30295@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> important issue needs to be fixed in the release.  Please find some
> time to do a full review, if possible.  We need your ack to know if
> the patch stands :) =20

Huh, my ack is needed for the linaro-kernel? :) Isn't it possible to
replace a V1 patch with a V2 patch in later kernels?

> > > diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-m=
xc/include/mach/esdhc.h
> > > index 86003f4..fced348 100644
> > > --- a/arch/arm/plat-mxc/include/mach/esdhc.h
> > > +++ b/arch/arm/plat-mxc/include/mach/esdhc.h
> > > @@ -10,17 +10,32 @@
> > >  #ifndef __ASM_ARCH_IMX_ESDHC_H
> > >  #define __ASM_ARCH_IMX_ESDHC_H
> > > =20
> > > +enum wp_types {
> > > +	ESDHC_WP_NONE,		/* no WP, neither signal nor gpio */
> > > +	ESDHC_WP_SIGNAL,	/* mmc internal WP signal */
> >=20
> > I think SIGNAL is not descriptive enough. Maybe
> >=20
> We have the document telling it's internal.
>=20
> > ESDHC_WP_INTERNAL		/* WP routed directly to mmc controller */
> >=20
> I thought about that.  If we use ESDHC_WP_INTERNAL, ESDHC_WP_GPIO
> should probably be the ESDHC_WP_EXTERNAL for the couple naming.  But
> I like ESDHC_WP_GPIO over ESDHC_WP_EXTERNAL, so chose the couple
> naming of ESDHC_WP_GPIO vs. ESDHC_WP_SIGNAL.

ESDHC_WP_CONTROLLER? Or ESDHC_WP_CORE?

> > ? It should be mentioned on which SoCs this is not available?
> >=20
> From SoC/controller POV, it's all available.  It's really a board
> design choice to connect card CD/WP to the pads or not, which the
> controller CD/WP signal/function is available on.

For mx25/35, I tried to find muxer settings but couldn't find them. It
seemed to me, GPIO is the only option there (I think I even asked
Richard). Can you route them on mx25/35, too?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk33aEgACgkQD27XaX1/VRuOHgCbBKaGRPbt/rVvDqK3tDk85FTJ
/UoAoKD1wPz+/6MEx6NbWP3fDY1Qp2MI
=mk0k
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--
