From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/9] mmc: omap_hsmmc: use devm_request_mem_region
Date: Fri, 21 Mar 2014 11:18:44 -0500
Message-ID: <20140321161844.GK12310@saruman.home>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
 <1395418658-2375-5-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47009 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbaCUQUk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Mar 2014 12:20:40 -0400
Content-Disposition: inline
In-Reply-To: <1395418658-2375-5-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, linux-omap@vger.kernel.org

--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 09:47:33PM +0530, Balaji T K wrote:
> With devm_request_mem_region conversion release_mem_region can be
> removed in clean up path
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 8e35a6e..9952673 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1881,7 +1881,8 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>  	if (res =3D=3D NULL || irq < 0)
>  		return -ENXIO;
> =20
> -	res =3D request_mem_region(res->start, resource_size(res), pdev->name);
> +	res =3D devm_request_mem_region(&pdev->dev, res->start,
> +					resource_size(res), pdev->name);

while at that, why don't you switch over to devm_ioremap_resource()
already ?

--=20
balbi

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTLGZkAAoJEIaOsuA1yqREFmEP/1xyplwSxqTNgZwOx5HYgdK5
Q3gBY6z7Ai6GKZFwa9DY3BWPg6/9WPwSMTRPl9VmSbU9IVk+MGq7NdfR68YNyKEu
B1MgjyOgSzznMNFxvxeVUY4D+GpTQk79JEu2mEItqK14NsWXMRo6ERkWzygkpfYb
xAT/zHk1UNdBWn5RvRAs0ZEiNnmfexEYob4K1FWbTCkti1kc7Phj566XUCipyUYG
yNUX24esSEMaa/cgW0J3QpCM9nDCJSHQR6JXjnA8rgsH/ckZpGR2wSyqrM59jWD4
sUjRrp58lDAzj/FjWfiJFs0ExjBgT8C+EbDOaHilMmMSi57stut1eVh8Ljidy5ko
w2MkhUVzyxwSS0ZzXBE/WWIXbkgEeYS9xvpbhWpPaxYZETvDIw+MhbOVAM3cc/of
zkH8S6KsD1Zvk+MVt85aHGSBUaL3wbX9AzvbYct31hPWXhIkwmG/y78hFm9PHwc/
t9Mlj2BGtESJkb5uXZ35cmN05KefhDihPRrQUQ+dnOnPN1yF84pFBqNoRBi6HCdJ
T4VPaC5M8Ny695GDwvI31e9+Iq+QRX1AMk456wOG6OxkeNLvGbEMCz2wGdioBm1x
0nnhZimHMN/vtgDmfopQCtKPX3UMPyXYIEA+xJbD/M/mRIX4IFWUz7eCk4eN3TQu
LpMr4ZwmpIB5u52GqG2m
=NQpS
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
