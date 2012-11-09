From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/3] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Fri, 9 Nov 2012 18:39:17 +0200
Message-ID: <20121109163916.GC11417@arwen.pp.htv.fi>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
 <1352477176-6673-1-git-send-email-balajitk@ti.com>
 <1352477176-6673-2-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55158 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab2KIQp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Nov 2012 11:45:27 -0500
Content-Disposition: inline
In-Reply-To: <1352477176-6673-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, svenkatr@ti.com

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 09:36:14PM +0530, Balaji T K wrote:
> "commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
> mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"
> sets both end_cmd and end_trans to 1.
>=20
> Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereferen=
ce of
> host->cmd as the command complete has previously been handled.
> Set end_cmd only in case of command Timeout/CRC.
>=20
> Moreover host->cmd->error should not be updated on data error case, only
> host->data->error needs to be updated.
>=20
> Avoid soft reset of command internal state machine on data errors.
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>

this looks a lot better to me.

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> based on mmc-fixes-for-3.7-rc5 in mmc_next
> Since v1: split into 3 patches
>=20
>  drivers/mmc/host/omap_hsmmc.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index fedd258..245d7b5 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -968,10 +968,14 @@ static inline void omap_hsmmc_reset_controller_fsm(=
struct omap_hsmmc_host *host,
>  			__func__);
>  }
> =20
> -static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int e=
rr)
> +static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
> +					int err, int end_cmd)
>  {
>  	omap_hsmmc_reset_controller_fsm(host, SRC);
> -	host->cmd->error =3D err;
> +	if (end_cmd) {
> +		if (host->cmd)
> +			host->cmd->error =3D err;
> +	}
> =20
>  	if (host->data) {
>  		omap_hsmmc_reset_controller_fsm(host, SRD);
> @@ -990,14 +994,16 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_hos=
t *host, int status)
> =20
>  	if (status & ERR) {
>  		omap_hsmmc_dbg_report_irq(host, status);
> +
> +		if (status & (CMD_TIMEOUT | CMD_CRC))
> +			end_cmd =3D 1;
>  		if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
> -			hsmmc_command_incomplete(host, -ETIMEDOUT);
> +			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
>  		else if (status & (CMD_CRC | DATA_CRC))
> -			hsmmc_command_incomplete(host, -EILSEQ);
> +			hsmmc_command_incomplete(host, -EILSEQ, end_cmd);
> =20
> -		end_cmd =3D 1;
>  		if (host->data || host->response_busy) {
> -			end_trans =3D 1;
> +			end_trans =3D !end_cmd;
>  			host->response_busy =3D 0;
>  		}
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

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnTG0AAoJEIaOsuA1yqREMwYP+gJmFDq7E3xDMEwUmmNh6oT4
2uHSKzjXZwLKE5vxqEXjEpZWTb7QwOtmdpD8mW1B/d2BTxo/jmy7ncOSqc+gnDjo
htk8d1w7EQ5QT7+poTfFrRcFYpeLdNTEaTUEl72XxsUf5AGJKPa2osnZlKcbZKuN
gL7WNE5UmRcydUjEsQCxO18qJb/s/oiixK5j1jaBPsOjpSgtn5eNYxJFbg9TmD7H
Hd87u1m0YDg10FZ2yWLaulQXyQRHk/qgws+HDGmYkaqB+ygP+t85Y4Uu33BZSXik
lScNYvqiM2/jcOmNur25v95IOgDfbnroof5Q/miVd3ZllATAEqxIXh5PU2XrTN3Q
k4Lv+AMzL54olk9iZ7GR95fyBIi2kvO3OoyZX8FxMMgiN+3vD+jgl3Ys91/sBoLb
XidpseAVti/LSfXZovCefjw9pyz2FMS8mwXkBwoEgXl0JR+H5sU5NaWCRcN2bdUK
2J3byVwVUbyHBq7swHzyw8afmcSrFS+PSzaWHCD7VqgB9WQxzAWsWQZmJp2nbJpJ
A2GC5VZyRn8o1MONIATcu6KVu+y95hT6PdnDXCCKBlY6k5OB42R7N+ak1RTSUmzr
WUW+YRLVmWmu+7EjF2Mp5TEghyyM9aoM1E1jfAVgSFlA4b0tlQrSUoTPMQjt/bkK
1ZjKCE/fbhFufoWSwHME
=AUd0
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
