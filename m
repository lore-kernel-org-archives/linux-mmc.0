From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform
 sdhci api
Date: Thu, 9 Sep 2010 18:39:53 +0200
Message-ID: <20100909163952.GI3773@pengutronix.de>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com>
 <20100906104729.GB2617@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net>
 <20100907102817.GA7534@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48351 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab0IIQj4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 12:39:56 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

> BTW, Do you know that how to define and pass the kinds of
> platform_data-struct special to the board to the sdhci_pltfm.c layer
> platform-data struct?

I think we should extend the pdata->init call to also have the
platform_data as an argument. Then, the platform-specific init routine
should have all it needs. Will update that tomorrow.

> [<Zhu Richard-r65037>] The one used in sdhci-of-esdhc.c is better than
> the one listed abov; it's more logical and clear. :)

Good, it seems to be complete, too :)

> > I find that the sdhci.c had been support the 8bits bus_width.
>=20
> Yes, it was added recently, but it might have issues. See here:
>=20
> http://thread.gmane.org/gmane.linux.kernel.mmc/3370
> [<Zhu Richard-r65037>] Different IC design may have the different
> definitions of the bus width configuration in the HOST_CONTROL register.
> This is not a big issue; we can handle these differences in the SW.

Yes, my point is that we don't handle this at the generic
sdhci-core, but at the parts which deal with the platform-specific
faul^H^H^H^H... differences ;)

> About the 8bits supports, I had been verified this feature on i.MX
> platforms for a while.
> The MMC cards 8bits mode can work well on some i.MX eSDHC platforms.

Why only some? Are the others not working or not tested?

> One more suggestion, the caps should be handled carefully, because not
> only the caps of the IC design, but also the caps of the board HW design
> should be taken care,

Could you give an example when it is board-dependent?

> [<Zhu Richard-r65037>] I'm checking it, and still trying finding a way
> to pass the board related info (such as the WP pins, and bus width to
> sdhci-platfm.c layer)

See above. And here is my current WIP. I factored out the common stuff
=66rom of and pltfm. Furthermore, I addressed Uwe's comments about adding
MX35-devices. Expect a few updates (platform-data) tomorrow.

http://git.pengutronix.de/?p=3Dwsa/linux-2.6.git;a=3Dshortlog;h=3Drefs/head=
s/pcm043-wip

(The old branch is still there, just in case you are working with it)

> The host->ops->get_ro should be added into the sdhci.c file although
> following the method provided in the RFC patches. How do you think about
> that?

I agree, that one seems needed. Shall I integrate this into my series
or do you want to place this patch ontop of my series?

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyJDdgACgkQD27XaX1/VRs52wCglGH6TwIK7C4kwlbIgdp0JIzc
WnQAoMJsuXaUqor9RMT4l399QPsBPR7Q
=tyMO
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--
