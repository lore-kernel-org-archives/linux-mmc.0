From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Fri, 9 Nov 2012 16:52:18 +0200
Message-ID: <20121109145218.GA10873@arwen.pp.htv.fi>
References: <1352472079-1512-1-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352472079-1512-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, svenkatr@ti.com
List-Id: linux-mmc@vger.kernel.org

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 08:11:19PM +0530, Balaji T K wrote:
> Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereferen=
ce of
> host->cmd as the command complete has previously been handled.
> Set end_cmd only in case of Data Timeout/CRC.

this comment doesnt match code as code is setting end_cmd for cmd
timeout and cmd crc, not data timeout/crc.

> While at it restore error handling behaviour as was before the
> "commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
> mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"
>=20
> host->cmd->error should not be updated on data error case, only
> host->data->error needs to be updated.
> end_trans and end_crc should not to be set together, to avoid
> mmc_request_done being called twice in case of Command CRC or command
> Timeout.
> Avoid soft reset of command internal state machine on data errors.

looks to me you're doing to many changes in a single patch. Perhaps it
deserves some splitting...

>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> based on mmc-fixes-for-3.7-rc5 in mmc_next
>=20
>  drivers/mmc/host/omap_hsmmc.c |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index fedd258..6ea1da3 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -968,15 +968,20 @@ static inline void omap_hsmmc_reset_controller_fsm(=
struct omap_hsmmc_host *host,
>  			__func__);
>  }
> =20
> -static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int e=
rr)
> +static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
> +					int err, int end_cmd)
>  {
> -	omap_hsmmc_reset_controller_fsm(host, SRC);
> -	host->cmd->error =3D err;
> +	if (end_cmd) {
> +		omap_hsmmc_reset_controller_fsm(host, SRC);
> +		if (host->cmd)
> +			host->cmd->error =3D err;
> +	}
> =20
>  	if (host->data) {
>  		omap_hsmmc_reset_controller_fsm(host, SRD);
>  		omap_hsmmc_dma_cleanup(host, err);
> -	}
> +	} else if (host->mrq && host->mrq->cmd)
> +		host->mrq->cmd->error =3D err;
> =20
>  }
> =20
> @@ -990,14 +995,16 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_hos=
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

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnRiiAAoJEIaOsuA1yqREaXoP/RWhxjBIQXskkYoJxJoPdh3u
/466KkcYDBcQeOhuxlKU8taTIRLhf26MJJA1Z+4LmK2JdmSExdtflpuNx4f2Pv88
HKknKIQEUxceGFVF0ef559F3alK71gIA8NiHO1D49i+8uHpI9Wd8yUy/kL2UqYcW
GZ/plXSlaiMmY/5Iv3IcZ9Sp/rzekdXd6ILm6SaqRYcvlQHocbIrO7Vdr/Dv6Cpo
+FZgA/PcsE3EhtpJuV6SsxLe1qcmd+2lfR59yORbslPeCGt6RzdsXFvP6KSDDBiS
hfjvpT5Wytq6c9OGNS7T32J0S0GRCl3B+Aw1/DT2t5rvXcEE44DhLF75oXo9WR4D
5RheL8tEEdM80L6G2TiGWBqvcx0R+y6Gp/Pvk2EV2LI+ZDkhP9Ypx2utrUN7ImDH
1795ABD2AhaWAlV8p3DO5l6bBr9bqx3XIlk3Z5/inzapK254+NqoyBnf+X8jfZ46
QqcfzPbpwB+vWTgYSHkJofvhFgCRutRYnixa5qpsH3Cd9XRThFKevW1cEAaOO/UD
YpZnAqfie6nTstnwY1ZQm6sDElKkOwyPZiZ4n3AHtJv9L7koFTdr8JaxeBmUb1xk
huEwrjS31EM5mNTA4eax9KOT6vI12kP0i1/pZzG6ZeWjR4HAhi8iUpuDxuzT1+1i
eD7XTQqYwD/SpC/PUS5y
=GD+z
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
