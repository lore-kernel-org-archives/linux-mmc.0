From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
 and card detection
Date: Thu, 24 Feb 2011 20:45:57 +0100
Message-ID: <20110224194557.GA20877@pengutronix.de>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
 <20110224081803.GA29530@S2100-06.ap.freescale.net>
 <20110224155126.GA1466@S2100-06.ap.freescale.net>
 <20110224160300.GA1483@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47429 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182Ab1BXTqB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 14:46:01 -0500
Content-Disposition: inline
In-Reply-To: <20110224160300.GA1483@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2011 at 12:03:01AM +0800, Shawn Guo wrote:
> On Thu, Feb 24, 2011 at 11:51:28PM +0800, Shawn Guo wrote:
> > On Thu, Feb 24, 2011 at 04:18:05PM +0800, Shawn Guo wrote:
> > > Hi Wolfram,
> > >=20
> > > On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> > > > Take #3, changes:
> > > >=20
> > > > * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> > > > * remove unconditional BROKEN_CARD_DETECTION (leftover)
> > > > * improved kernel-doc about unused GPIO
> > > > * added tags from Eric
> > > >=20
> > > > Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did =
you have a
> > > > chance to retest on mx51? What about the FSL guys? :)
> > > >=20
> > > I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
> > > write-protect are working on mx25 3ds, but write-protect has some
> > > problem on babbage, and I need some time to figure it out.
> > >=20
> > I just figured out why wp_gpio does not work on mx51.
> >=20
> > +       if (cpu_is_mx25() || cpu_is_mx35()) {
> > +               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> >                 host->quirks |=3D SDHCI_QUIRK_NO_MULTIBLOCK;
> > +               /* write_protect can't be routed to controller, use gpi=
o */
> > +               sdhci_esdhc_ops.get_ro =3D esdhc_pltfm_get_ro;
> > +       }
> >=20
> > Would it make sense to do the same for mx51?  On babbage board,
> > SD1_WP is routed to controller, but SD2_WP is not, so we have to use
> > gpio for SD2 write_protect.
> >=20
> We should probably have esdhc_pltfm_get_ro whenever platform provides
> a wp_gpio, and fall on controller SD_WP only when platform does not
> provide the wp_gpio.

OK, will think about it. Thanks for testing!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1mtXUACgkQD27XaX1/VRvTJACfYOkR/wgbQ0uaorHqYpuw3Fn8
vegAoIMpwbgih48O6WwtsWwO7VG5uXin
=T+/v
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
