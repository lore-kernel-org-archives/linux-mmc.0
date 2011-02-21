From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 21 Feb 2011 18:40:16 +0100
Message-ID: <20110221174016.GN2616@pengutronix.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSMU0HVueUMCAvn0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48753 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1BURkR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 12:40:17 -0500
Content-Disposition: inline
In-Reply-To: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, arnd@arndb.de, linux@arm.linux.org.uk


--oSMU0HVueUMCAvn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shawn,

On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.
>=20
> Thanks Chris Ball for the indentation patch.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

What throughput rates do you get on a mx28-regulated slot serving a card
at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
board issue though (or we can fix it later), rest works fine, thus:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oSMU0HVueUMCAvn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1io4AACgkQD27XaX1/VRsXtwCeNzVrt9Qh2qY3fDTR7Nk5CCnm
rsIAoItDRtPF34qQqgbJK/YOftYpoAVc
=Ud0C
-----END PGP SIGNATURE-----

--oSMU0HVueUMCAvn0--
