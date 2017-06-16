From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 1/2] mmc: tmio: improve checkpatch cleanness
Date: Fri, 16 Jun 2017 10:14:45 +0200
Message-ID: <20170616081445.tqlhod5znrqnxtc3@ninjato>
References: <1497553214-12914-1-git-send-email-horms+renesas@verge.net.au>
 <1497553214-12914-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6mgtk2wxmvph6al"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497553214-12914-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--b6mgtk2wxmvph6al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> * Don't add bogus ',' after KERN_DEBUG

Well...

> @@ -127,16 +127,17 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *h=
ost)
> =20
>  #define STATUS_TO_TEXT(a, status, i) \
>  	do { \
> -		if (status & TMIO_STAT_##a) { \
> -			if (i++) \
> -				printk(" | "); \
> -			printk(#a); \
> +		if ((status) & TMIO_STAT_##a) { \
> +			if ((i)++) \
> +				printk(KERN_DEBUG " | "); \
> +			printk(KERN_DEBUG, #a); \

=2E..still there.

> @@ -349,13 +350,22 @@ static int tmio_mmc_start_command(struct tmio_mmc_h=
ost *host, struct mmc_command
>  	}
> =20
>  	switch (mmc_resp_type(cmd)) {
> -	case MMC_RSP_NONE: c |=3D RESP_NONE; break;
> +	case MMC_RSP_NONE:
> +		c |=3D RESP_NONE;
> +		break;
>  	case MMC_RSP_R1:
>  	case MMC_RSP_R1_NO_CRC:
> -			   c |=3D RESP_R1;   break;
> -	case MMC_RSP_R1B:  c |=3D RESP_R1B;  break;
> -	case MMC_RSP_R2:   c |=3D RESP_R2;   break;
> -	case MMC_RSP_R3:   c |=3D RESP_R3;   break;
> +		c |=3D RESP_R1;
> +		break;
> +	case MMC_RSP_R1B:
> +		c |=3D RESP_R1B;
> +		break;
> +	case MMC_RSP_R2:
> +		c |=3D RESP_R2;
> +		break;
> +	case MMC_RSP_R3:
> +		c |=3D RESP_R3;
> +		break;

Very personal, I'd prefer the old way but I don't insist.

> -			 * Disable auto CMD12 at IO_RW_EXTENDED and SET_BLOCK_COUNT
> -			 * when doing multiple block transfer
> +			 * Disable auto CMD12 at IO_RW_EXTENDED and
> +			 * SET_BLOCK_COUNT when doing multiple block
> +			 * transfer

I'd think 'transfer' can go to the previous line?

>  			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
> -			    (cmd->opcode =3D=3D SD_IO_RW_EXTENDED || host->mrq->sbc))
> +			    (cmd->opcode =3D=3D SD_IO_RW_EXTENDED ||
> +			     host->mrq->sbc))

Another subjective taste thingie ;)

> -		dev_warn_once(&host->pdev->dev,
> -		      "Too many taps, skipping tuning. Please consider updating size o=
f taps field of tmio_mmc_host\n");
> +		dev_warn_once(&host->pdev->dev, "Too many taps, skipping tuning. Pleas=
e consider updating size of taps field of tmio_mmc_host\n");

Dito.

What kind of tests did you run with these?

Thanks,

   Wolfram


--b6mgtk2wxmvph6al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllDk3EACgkQFA3kzBSg
KbZ8gg//S8nz4vtCf51NwrHXbN3aTTKQg7fH+nO6yjBJCLyHxn6pddeqPfvrMFXv
LgttaPrcDM+PBkBRj49RbbMYFwIkmOHp+09MM/+DeMAFlZaBJRNzrdmZ31+h3UNo
7jLGtxK2Vav4IWeCzay21nbs5EVqz6oJGguIUycgC8nUMwt2ioM1TpEUJVfo9V8A
6XObudeNMtnpgll+sC20U9Dmy9HxKeo+q+Wrj7niKpcdDLudwroHwDPWlOltIquc
PiAS4hXDnyy9T54Sz6R4aoQlAVhklK96eil+ajS6dONfEgsFYzLtAWJ7bA8ohgzp
bJnVPLlp+5ZoY0h+0Kuv8QOkqvtSuSzZkDEA0wo4MD2kVv0euqYO66m4lInJ72CP
HUOrKolLjdk3MwF3qb3HW0E2hN9WvYZDzeKfmcDtME5ZB7aae3nwEbDZgwhw/GZS
2pSeqOhEIFdDTUstvAEBK/Ic+F5emAU3sjVS/aeA88VXJavA0kpBV+R4bW76GxqQ
vijtt0DFw4j6BhnQbGpO3vjvDMzCW/tDTPSrTpdZ0yIrFCkrpdUzgtb9qZ2PNjwK
s56g9O1uvMc8FbGZiTit5MXtzDN233fLm/YZY+IOKTUkA1sfDUa61phVHh4GZ1Wj
POA/PJrF/ZyHsk/NRm1uQKDvCI6nDsONMUNkrtl/xjMdSkE1yYw=
=QY1o
-----END PGP SIGNATURE-----

--b6mgtk2wxmvph6al--
