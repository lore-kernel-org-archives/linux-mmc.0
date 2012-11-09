From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/3] mmc: omap_hsmmc: no reset of cmd state machine
 for DCRC
Date: Fri, 9 Nov 2012 18:39:39 +0200
Message-ID: <20121109163939.GD11417@arwen.pp.htv.fi>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
 <1352477176-6673-1-git-send-email-balajitk@ti.com>
 <1352477176-6673-3-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab2KIQpu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Nov 2012 11:45:50 -0500
Content-Disposition: inline
In-Reply-To: <1352477176-6673-3-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, svenkatr@ti.com

--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 09:36:15PM +0530, Balaji T K wrote:
> Avoid soft reset of command internal state machine on data errors.
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 245d7b5..d931e08 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -971,8 +971,8 @@ static inline void omap_hsmmc_reset_controller_fsm(st=
ruct omap_hsmmc_host *host,
>  static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
>  					int err, int end_cmd)
>  {
> -	omap_hsmmc_reset_controller_fsm(host, SRC);
>  	if (end_cmd) {
> +		omap_hsmmc_reset_controller_fsm(host, SRC);
>  		if (host->cmd)
>  			host->cmd->error =3D err;
>  	}
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnTHLAAoJEIaOsuA1yqREiCIP/itWKqdOYDl3xC5u86B7ZjqK
k9PxP/r6CUi8g0T2Fn3FVDVCW0URUAo5HGmWScDc6NWntkL7oRGGEkNq9+mzw61U
v+vlloRKpDaLhe3NqHNDAvDLEL9KMqCjGYfd3PYovss1UOJ+B6NEoZJsdzxGEeQR
r64KRlltGA2xI2tQ+QExbMkjr8QH9NoVGOUlFpOvnZdxQzK9Rk+giYhT/WmcNclb
gjOCJt4oGqj8S7+acXCawwZ1dM53SUqvxbMMzGh/xzpP0FkXo13b5M/QDCTC4j36
7A7x9qi+pV9Y0xBcw1/2XFO7spZ+MMnSnSnioTLFFPZUh/eIBv8SHk/3aeBhvvQ6
VYT67iA6H/68F1kohKz/Sc/x/IShHjJauNpxE6rQIorSVJlOQPFT70WdMPe/dHgB
XCAdl+9HNgxpsFuADClUTjOC+LaHKAgAAtW8tLrjPWziu7X0/zNBuNFDC5ITH1Ky
oBu/n2Rgozdmvo+0mSUoJ1ygObcpyuRi4CetrzJy98B1cvSbco1UDEJdJRk/uSi+
8HNRCIFshU4nWtOihl6cIxYfZe2ijZRl4x1iO1KRKy4/oT8NYst/vO4ZJPZA6Ip4
kBTYQ+hmV/ZUgYJrG28ICTFVLRbxpTAz7DAzWxv9OPTbSFP54IDogJqWHDeZAZG/
8GiDmpZUJpW81H43TsAH
=MgA1
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
