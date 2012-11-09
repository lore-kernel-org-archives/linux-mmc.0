From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] mmc: omap_hsmmc: update error code for
 response_busy cmd
Date: Fri, 9 Nov 2012 18:40:54 +0200
Message-ID: <20121109164054.GE11417@arwen.pp.htv.fi>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
 <1352477176-6673-1-git-send-email-balajitk@ti.com>
 <1352477176-6673-4-git-send-email-balajitk@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56467 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab2KIQrF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 11:47:05 -0500
Content-Disposition: inline
In-Reply-To: <1352477176-6673-4-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, svenkatr@ti.com

--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 09, 2012 at 09:36:16PM +0530, Balaji T K wrote:
> update error code to cmd->error for commands with response_busy and no da=
ta
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>

Just one comment below, otherwise:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d931e08..1503808 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -980,8 +980,8 @@ static void hsmmc_command_incomplete(struct omap_hsmm=
c_host *host,
>  	if (host->data) {
>  		omap_hsmmc_reset_controller_fsm(host, SRD);
>  		omap_hsmmc_dma_cleanup(host, err);
> -	}
> -
> +	} else if (host->mrq && host->mrq->cmd)
> +		host->mrq->cmd->error =3D err;

if you have curly braces in one branch, you need to put in all of them,
so this should be:

+	} else if (host->mrq && host->mrq->cmd) {
+		host->mrq->cmd->error =3D err;
+	}

--=20
balbi

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnTIWAAoJEIaOsuA1yqREkawP/2dTZjf71SHECx2URYqwtM8u
E7vFjpryeAh6/o4TQrQ/2InZd1+lLvvLtLeAgBEWsaDAxNqI+FyxyS9xud+xg8YQ
ZEeXBx7lJ7YbdJ3EFgUljmmxwmr3bHKLDA+1Td5tx63bc/3xJ7ah9ZYWC6n/hyF+
kBk5eXGTWgB2Pt1IpH65EUzL/11wHdigSLjk7RY1o4cZMav+zPz0KbDBxFyUaW+h
Tz72mb9sjsvAAlMRd2oJifem4PO9enYrlA5GHP5rYP3/8hLTbjfqrgQZRm6HmGWC
bNV2M/03ScEZf06UooRKL2J36Ms/8EBx7kA9oSNwwC1A7wElVZVYv5rn1W8N0hwU
m7FHEo1+KomGw3X/n5/lMntKmBmGz+b3DtguIcdgzoLrH53RmXWL2Z0GaDiONRze
R1euS0VrJ01mTsYiYdMomaRxRsZF7UxFZPG5HTrCR1Y+tgyQazFE8JkPV8ZEx14G
MyLv0uGLVjd5Hj/XjWRMKxuRXMwN/orXBy7S/6sdqNhQTi9we4X++yk8LMQ5lBH4
38h6s3olsI6vRGJHoOObAUkL6XwK6+6pIWDh95xLkZAO88xk3Oa1NSYdRLXQxBp6
ehbJczfJDIBsgG/lUSZ0XdjkPkyv6AJEhOH/9kT2Mv+CMg7H4YVqg6m/ZTv5EBvE
ah0hxfZHtARE3QiUk0DH
=oNZF
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
