From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Sun, 3 Jan 2016 00:03:54 +0100
Message-ID: <201601030003.54168@pali>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <201601021622.03763@pali> <9361696.ohU1ACX8N1@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6211051.GSrE4TRUkX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33598 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcABXD6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2016 18:03:58 -0500
In-Reply-To: <9361696.ohU1ACX8N1@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

--nextPart6211051.GSrE4TRUkX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 02 January 2016 23:57:47 Arnd Bergmann wrote:
> On Saturday 02 January 2016 16:22:03 Pali Roh=C3=A1r wrote:
> > On Monday 28 December 2015 15:55:28 Arnd Bergmann wrote:
> > > On Monday 28 December 2015 15:54:35 Pali Roh=C3=A1r wrote:
> > > > > I mean you can add the platform data to the
> > > > > omap_auxdata_lookup[] table for this board.
> > > >=20
> > > > But can I mix data from omap3-n900.dts and
> > > > omap_auxdata_lookup[]?
> >=20
> > Hm... looks like it is not possible. omap_hsmmc driver ignores any
> > supplied platform data if there are device tree data. So array
> > omap_auxdata_lookup[] does not help.
>=20
> Obviously you need to the driver to work with that setting. Maybe
> something as simple as
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c index e06b1881b6a1..4fa35fc84b8b
> 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2006,7 +2006,7 @@ static int omap_hsmmc_probe(struct
> platform_device *pdev) void __iomem *base;
>=20
>  	match =3D of_match_device(of_match_ptr(omap_mmc_of_match),
> &pdev->dev); -	if (match) {
> +	if (!pdata && match) {
>  		pdata =3D of_get_hsmmc_pdata(&pdev->dev);
>=20
>  		if (IS_ERR(pdata))
>=20
>=20
> 	Arnd

But in this case I must copy mmc definition from omap3-n900.dts file=20
back to board code to omap_auxdata_lookup[]. And mmc definitions in=20
omap3-n900.dts will be ignored. This is step back.

Mixing mmc definitions from DTS file together with omap_auxdata_lookup[]=20
just will not work.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6211051.GSrE4TRUkX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaIV1oACgkQi/DJPQPkQ1KTYQCgmm8fwEg25q7O8TcoKzzYPJZL
tNUAn39iy8ebCmlANHg+t1Mz60AzP7/f
=nWvk
-----END PGP SIGNATURE-----

--nextPart6211051.GSrE4TRUkX--
