From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/8] mmc: omap: Enable Auto CMD12
Date: Fri, 16 Mar 2012 15:51:14 +0200
Message-ID: <20120316135113.GM24651@arwen.pp.htv.fi>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
 <1331905144-31655-2-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RXc6EO4W1yUvSQ0X"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:45915 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1031636Ab2CPNv0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 09:51:26 -0400
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so7722442lah.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Mar 2012 06:51:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331905144-31655-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com


--RXc6EO4W1yUvSQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 07:08:57PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>=20
> Enable Auto-CMD12 for multi block read/write on HSMMC
> Tested on OMAP4430, OMAP3430 and OMAP2430 SDP
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f29e1a2..a9ffd70 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -85,6 +85,7 @@
>  #define BRR_ENABLE		(1 << 5)
>  #define DTO_ENABLE		(1 << 20)
>  #define INIT_STREAM		(1 << 1)
> +#define ACEN_ACMD12		(1 << 2)
>  #define DP_SELECT		(1 << 21)
>  #define DDIR			(1 << 4)
>  #define DMA_EN			0x1
> @@ -115,6 +116,7 @@
>  #define OMAP_MMC_MAX_CLOCK	52000000
>  #define DRIVER_NAME		"omap_hsmmc"
> =20
> +#define AUTO_CMD12		(1 << 0)	/* Auto CMD12 support */
>  /*
>   * One controller can have multiple slots, like on some omap boards using
>   * omap.c controller driver. Luckily this is not currently done on any k=
nown
> @@ -175,6 +177,7 @@ struct omap_hsmmc_host {
>  	int			reqs_blocked;
>  	int			use_reg;
>  	int			req_in_progress;
> +	unsigned int		flags;
>  	struct omap_hsmmc_next	next_data;
> =20
>  	struct	omap_mmc_platform_data	*pdata;
> @@ -766,6 +769,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host=
, struct mmc_command *cmd,
>  		cmdtype =3D 0x3;
> =20
>  	cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
> +	if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode))
> +		cmdreg |=3D ACEN_ACMD12;
> =20
>  	if (data) {
>  		cmdreg |=3D DP_SELECT | MSBS | BCE;
> @@ -837,11 +842,15 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, =
struct mmc_data *data)
>  	else
>  		data->bytes_xfered =3D 0;
> =20
> -	if (!data->stop) {
> +	if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->error)) {
> +		omap_hsmmc_start_command(host, data->stop, NULL);
> +	}
> +	else {

while adding the braces, you broke the coding style. Please fix.

--=20
balbi

--RXc6EO4W1yUvSQ0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY0VRAAoJEIaOsuA1yqREuDQP/R85lWNhY/E0AFo5L8+x2sba
fheb47Jvay40UN83QyYreycCUz8xMKVh4ikn7OaKXgcBFBfnGq2gqRg5k6DwBYBY
e5X+7E0o01HPdLJQTZl4IRtcdu8tLIdfU6Jy4J+RYab8I8KbSEgOfBptqrriBTru
JqyDjaQ0rPgkZ2xITJwpkwbjK1lfsDgarWMySCparTGbhVeGUVv0X8UBTXY+G071
KTyFi2rnajeyXe0rq0nk+/+ZSzxgiQBJ2f8yOZV8bgnjAEA5HnYGxo5TIFw3M1AM
LtavBBaZCuqM1qUycUtbihIDwRJEsLernowzzYswvoapl4MP4KT/XuJYzjTxsOOz
EXlicVFqPPeOOnnd/BzETMLkxv9GAgyUG864q4aIMItcMjpYRzpCTIuZtYPkbFoG
U0UOb0stivhOgdW8RIdRxyEp+NWx+XtRmYoL3+blIXjSQqy1Ccs+Re3eUqTAnxBy
ctV2+69hdnpBF3tRO/I9dt40CA1+mLjrxy6KrVVTfWJrKskhYHmxUmcqmtSn/2mu
Tj0YZ1k1Qz7e/ympku8qvtlRqd54x5UUR26RHr+6BUn2RVZ8WGeebPlBRlxCKqwo
bxgnGcJtTwuIJeGR0vuolhMfbq6QJwxLAd99H5l/2UlS8Mw3cNTU2f82qnLz30ml
DY/Pa+iBj827gBoFpyhs
=NcZP
-----END PGP SIGNATURE-----

--RXc6EO4W1yUvSQ0X--
