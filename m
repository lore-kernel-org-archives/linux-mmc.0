From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
Date: Mon, 28 Apr 2014 15:10:43 +0200
Message-ID: <20140428131043.GD15179@pengutronix.de>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <20140425124945.GM26756@n2100.arm.linux.org.uk>
 <20140425130849.GB15179@pengutronix.de>
 <20140425131529.GN26756@n2100.arm.linux.org.uk>
 <20140425132245.GO26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbaD1NKp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 09:10:45 -0400
Content-Disposition: inline
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-arm-kernel@lists.infradead.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 25, 2014 at 02:22:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 25, 2014 at 02:15:30PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 25, 2014 at 03:08:49PM +0200, Markus Pargmann wrote:
> > > I just tried the different parts of the patch. Without the following
> > > change, emmc works:
> > >=20
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host=
 *host, struct mmc_ios *ios)
> > >  			host->ops->set_clock(host, host->clock);
> > >  		}
> > > =20
> > > -
> > > -		/* Reset SD Clock Enable */
> > > -		clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > -		clk &=3D ~SDHCI_CLOCK_CARD_EN;
> > > -		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > -
> >=20
> > So the bit which stops us violating the SD spec stops eMMC from working=
=2E..
> > that's... just great.
> >=20
> > Okay, I'll look deeper at this and see what can be done, but I suspect =
it
> > will turn out to require more patches and be more invasive.
>=20
> In the mean time, here's the remainder (to patch 33) of the series with
> this commit omitted.

I tested the whole series again, from 1 to patch 32 and it is working
correctly now on the RIoT board (imx6s) with emmc and sd-card. You can
add my tested-by tag for all core and imx related patches if you want to.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTXlNSAAoJEEpcgKtcEGQQ2XoP/1WltveUNA5YoSV0AOg7gXrV
uS2lcfiru61osdFgpw9VyNys6jyEmNM3uL+O3llcJI2SsJ/p0FtPAeLJrWLlcT9H
pmAcf0SaEhZ4Xhw1ivBkKtVytRbzJm1EiS51jHWsSaN9XI6nhYXNZVbVfErsX73b
tjPHUdKQrxzDzvvTQxQzrYSIZsCMDvjMyafiCsDJyJWi+rfSh2vCqeIxijulcJIA
WtlPwtClv3l87FcFZeRengR7Pqep8Zf9LqTaXa1ZKh+ZlyRSUb0cnyudGF4IbBEr
5xTWLx2yNPQNPufp2LLlEN//SG7EGlCCBZKaKexwp+mNyqC5k+RV5CIkLiniUIRw
BN9Td0hBiTrxLWOrWmgzePED/+c6zKB0Fi2HVCTZU2n8rzWFj9hkb+5xWHKwHeQj
kp/xinKISwCZhcmLIxCk9rbNrITX9qZmfpNAFj1Q9frp0XpbULkoFPKKD5syffDN
yZasr27b+ZxkI9TljR3nP68XTRGs5bOWWnw+caJ/lmRZnYAaHEdvuQpLwQHHDuds
KB9m1OzESLy96GRPtSaSnSgNk4a1ePEP+Su3gBeKowwiZuAA7IheN+zwLgYpEMwG
lwZ+h+DOadFo7iR6JXg7lmHd8YQsdwc8cvDwFczc2LfCRpWsNR0KjLSNTrw6+awv
wKdedv+VN70FJrNfsdBe
=BSz5
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
