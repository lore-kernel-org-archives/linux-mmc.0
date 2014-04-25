From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
Date: Fri, 25 Apr 2014 15:08:49 +0200
Message-ID: <20140425130849.GB15179@pengutronix.de>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <20140425124945.GM26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60894 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbaDYNI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:08:59 -0400
Content-Disposition: inline
In-Reply-To: <20140425124945.GM26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2014 at 01:49:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 25, 2014 at 02:38:20PM +0200, Markus Pargmann wrote:
> > Hi,
> >=20
> > On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
> > > Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
> > > additional clock start/stop cycles during the transition to 1.8V
> > > signalling mode.
> > >=20
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >=20
> > I tested the series on imx6s with a RIoT board. With this patch applied
> > the RIoT board emmc does not work. Here is the output of the board:
>=20
> Unfortunately, I don't have any emmc sdhci using devices, so this is
> a combination I can't test myself.
>=20
> What would be useful is to find out which of the two changes in there
> is the cause - can you try with just the change to
> sdhci_do_start_signal_voltage_switch applied, iow just this change:

I just tried the different parts of the patch. Without the following
change, emmc works:

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host=
, struct mmc_ios *ios)
 			host->ops->set_clock(host, host->clock);
 		}
=20
-
-		/* Reset SD Clock Enable */
-		clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &=3D ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTWl5hAAoJEEpcgKtcEGQQo6gP/RsgW35x3EBWdNvXWL/+j7ms
N4/UFgJmyhftAP4dqZz0QvfOK82xGS5feYzJgTv9rZYKj13doOx2SQsudMyy1beP
ay/oUGBY/DsN9JCeEHIi9x3tVzygnXEh+2iADLgyq0M9+fzbnV0GLGI2atW7Lncp
nRFltJBS1JWa5eX3bAPrYYD/xPkViv9+PBo/xKPda7Xf9aaSNkRuPcyxBEJpHdvp
1H0nQx5Rf3Sa/FsjMcBGXEWVlLVxKzso0FwKt9iSBM58Pv/e9HBXDPxGa1uGtDO+
BWrIFCM5jgSARUc5BuHBHKKMnajSxcmFc1FSi6IUiMDd5c/8MZG2eZbxKwou2nOB
fuasGPQztOuWCWA2BH/8oMew+QqMp5Fi9wn7txHJRo82wjm3OwmS09jgjAKBCwP+
Bqnt8iXAGBjdkwPhw3+NBwZG2p4dk03IiPY3B+DAt3D2zTIAyrxo4JhnNpjIJG2l
4uzu7YQ2hi5ZAAJTDtgj6pUaMDF+NpdtfUTeoSXu9bIZaWOsgH6QvOmsWLo3LxSy
+YxO7mzO0OhKly0xsWSNrMRf4uJTwLjJ2Sa2kds0FXYLTgVsCCwK34W6ZYymKga0
bjU72qfR6rZ3X6ZTV3x2axs3yxSmuqZiLuaSb2V4+xV2iV9Rp12cHfHMBGSFkNR6
kz12+9/Stba+YySUhsmU
=2Dbo
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
