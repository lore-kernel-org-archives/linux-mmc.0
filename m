From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: A serial patchs that support FSL's eSDHC
Date: Mon, 6 Sep 2010 12:30:26 +0200
Message-ID: <20100906103026.GA2617@pengutronix.de>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
 <20100901101500.GE11407@pengutronix.de>
 <A88EF4D64D8447468743DC1503C0B6CA078545@zch01exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43347 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0IFKab (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:30:31 -0400
Content-Disposition: inline
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA078545@zch01exm22.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

(going back to the list. A few more eyes during the process will surely
help :))

On Fri, Sep 03, 2010 at 06:26:05PM +0800, Zhu Richard-R65037 wrote:

> I encounter some problems when I merge my eSDHC driver into
> sdhci-pltfm.c driver.
> In the eSDHC solution there is a little complex in the driver
> implementation refer to the HW/IC design.
> One private struct such as sdhci_fsl_host in my original codes is
> needed, and the board specified platform data (such
>  as imxmmc_platform_data struct) is mandatory required too.
>=20
> sdhci-pltfm.c driver can't provide such kinds of APIs.
> Do you have any suggestions?

Well, I think we can do without. In a few minutes, I will post an RFC
which I just hacked. Please have a look at it, and say if you have
comments or suggestions. Hopefully you'll agree that this approach is a
lot less intrusive. I will mainly concentrate on the driver. For the
platform part, Uwe already gave a few comments. I will also reply to
some of your patches to clarify some issues.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyEwsIACgkQD27XaX1/VRveDQCfTzYBw8Y3qLAfzSCNNmZzpFDh
8cUAnRDwgd2XEEI9gy97ZIHeDW/Fa9Se
=M1Yz
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
