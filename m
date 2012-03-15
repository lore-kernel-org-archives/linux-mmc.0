From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 1/8] mmc: omap: Enable Auto CMD12
Date: Thu, 15 Mar 2012 16:54:03 +0200
Message-ID: <20120315145402.GP28447@arwen.pp.htv.fi>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-2-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:40581 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030463Ab2COOyR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 10:54:17 -0400
Received: by lbbgn12 with SMTP id gn12so1881025lbb.24
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 07:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331822022-26714-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 15, 2012 at 08:03:35PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
> @@ -766,6 +769,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host=
, struct mmc_command *cmd,
>  		cmdtype =3D 0x3;
> =20
>  	cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
> +	if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode))

This should have braces too.

> @@ -837,11 +842,16 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, =
struct mmc_data *data)
>  	else
>  		data->bytes_xfered =3D 0;
> =20
> -	if (!data->stop) {
> +	if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->error))
> +		omap_hsmmc_start_command(host, data->stop, NULL);
> +	else {
> +		if (data->stop)
> +			data->stop->resp[0] =3D OMAP_HSMMC_READ(host->base,
> +							RSP76);
>  		omap_hsmmc_request_done(host, data->mrq);
> -		return;
>  	}
> -	omap_hsmmc_start_command(host, data->stop, NULL);
> +
> +	return;

return is unnecessary.

--=20
balbi

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgKKAAoJEIaOsuA1yqRE9uMP/0y4VpsET+tvqrgsKPKLu+EH
HEBQTrZm3sldz7fs/vAaXG7po76zBGi9UP8KGbHO4qwOda+XPFXKgt1dlSuYumrx
i/Ldw/4bdqW70PL3rgaOhd2ExEOHmAh9dE+eg17SB+t2ME5U/dwO8bGwWa+O9e+q
8clXvY+RQpg22MMy6GfQCCGCb+B/UUmMVvty2jzMwNw35MbniRK5sukTbtL8nOm4
icRxbz7NYDCScUkOeHFpi8FCxvz9vPcjS4bcCbVM39lEZW0uVVyi5yUQxcyCbdeu
CyiniKQguy2F+RDs19Cz1wi7YdrtFvL2tOISx6mDpjP1SvEVsfTJn5fj0KzcCsLb
IjNGyjrbCAh3oklkrEzEdTymfOvbl07Mb57DsQ00qY0g4oiYTn6hwebpEyaRHoFa
74mY/PKE8B3D3o0JOLKOM1xjxh5fPInNZeW8pdHjIASgObgAh2NtbrKXsur42C4v
PZ1r0Syjg6XwDKez65RhwAOD29KOiYeXbKXhzC9cXYXMf0QplqOMpB8kCE/GosIU
wHxSJEWqXN4k+Nc631O90P6dxxg8Sfc9UwFBncJ6WBOcSNnQajDBrwRLVWtiDkDt
0DZmxGSBPfqTlSFoGs42ccFJv0w1nMZa244HsL1mhxc6UYKqzS0XiYq3Ggi0YfUy
5kCcQhvLPJkZWoFAHP6U
=qhs0
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--
