From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] mxs-mmc: fix clock rate setting
Date: Mon, 11 Jul 2011 22:26:21 +0200
Message-ID: <20110711202621.GA5811@pengutronix.de>
References: <CAHMSPgNWherMTU9kLDH7zLQL0N_er5SpLz2v1xjzXvgckv+C2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33616 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1GKU01 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 16:26:27 -0400
Content-Disposition: inline
In-Reply-To: <CAHMSPgNWherMTU9kLDH7zLQL0N_er5SpLz2v1xjzXvgckv+C2g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>, Chris Ball <cjb@laptop.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Koen,

thanks for v2.

On Mon, Jul 11, 2011 at 09:52:01PM +0200, Koen Beel wrote:

> (Sorry, patch in attachment as I still don't have a decent mail setup
> at my company)

That's bad :(

=3D=3D=3D=3D

> Fix clock rate setting on mxs-mmc driver.
> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
> have been 255 instead of 0.
> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
> (TIMING_CLOCK_RATE + 1) where not correctly defined.

Very minor nit: No paragraphs I'd say.

> Can easily be reproduced on mx23evk: default clock for high speed sdio
> cards is 50 MHz. With a SSP_CLK of 28.8 MHz default), this resulted in
> an actual clock rate of about 56 kHz.
> Tested on mx23evk.
>=20
> Changes in V2 patch:
> - use DIV_ROUND_UP to make sure the actual clock rate is not higher
> then the requested clock rate.
> - rename variables to reflect naming in datasheet and to make things
> more clear

Changelogs are good, but should go below "---"

>=20
> Signed-off-by: Koen Beel <koen.beel@barco.com>
> ---
>  drivers/mmc/host/mxs-mmc.c |   30 ++++++++++++++----------------
>  1 files changed, 14 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 99d39a6..d513d47 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -564,40 +564,38 @@ static void mxs_mmc_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
> =20
>  static void mxs_mmc_set_clk_rate(struct mxs_mmc_host *host, unsigned int=
 rate)
>  {
> -	unsigned int ssp_rate, bit_rate;
> -	u32 div1, div2;
> +	unsigned int ssp_clk, ssp_sck;

ssp_sck is not really needed? Value could directly go to host->clk_rate.

> +	u32 clock_divide, clock_rate;
>  	u32 val;
> =20
> -	ssp_rate =3D clk_get_rate(host->clk);
> +	ssp_clk =3D clk_get_rate(host->clk);
> =20
> -	for (div1 =3D 2; div1 < 254; div1 +=3D 2) {
> -		div2 =3D ssp_rate / rate / div1;
> -		if (div2 < 0x100)
> +	for (clock_divide =3D 2; clock_divide <=3D 254; clock_divide +=3D 2) {
> +		clock_rate =3D DIV_ROUND_UP(ssp_clk, rate * clock_divide);
> +		clock_rate =3D (clock_rate > 0) ? clock_rate - 1 : 0;
> +		if (clock_rate <=3D 255)
>  			break;
>  	}
> =20
> -	if (div1 >=3D 254) {
> +	if (clock_divide > 254) {
>  		dev_err(mmc_dev(host->mmc),
>  			"%s: cannot set clock to %d\n", __func__, rate);

Didn't you want to set some minimal values instead of just returning?
Just wondering, could be a seperate patch in my book...

>  		return;
>  	}
> =20
> -	if (div2 =3D=3D 0)
> -		bit_rate =3D ssp_rate / div1;
> -	else
> -		bit_rate =3D ssp_rate / div1 / div2;
> +	ssp_sck =3D ssp_clk / clock_divide / (1 + clock_rate);
> =20
>  	val =3D readl(host->base + HW_SSP_TIMING);
>  	val &=3D ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
> -	val |=3D BF_SSP(div1, TIMING_CLOCK_DIVIDE);
> -	val |=3D BF_SSP(div2 - 1, TIMING_CLOCK_RATE);
> +	val |=3D BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
> +	val |=3D BF_SSP(clock_rate, TIMING_CLOCK_RATE);
>  	writel(val, host->base + HW_SSP_TIMING);
> =20
> -	host->clk_rate =3D bit_rate;
> +	host->clk_rate =3D ssp_sck;
> =20
>  	dev_dbg(mmc_dev(host->mmc),
> -		"%s: div1 %d, div2 %d, ssp %d, bit %d, rate %d\n",
> -		__func__, div1, div2, ssp_rate, bit_rate, rate);
> +		"%s: clock_divide %d, clock_rate %d, ssp_clk %d, rate_actual %d, rate_=
requested %d\n",
> +		__func__, clock_divide, clock_rate, ssp_clk, ssp_sck, rate);
>  }
> =20

Rest looks good to me, and test was also successful.

Chris, if you want to take this version already:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4bXG0ACgkQD27XaX1/VRsXHACbB7G4eR7g1azSE6XyZWUwh8v7
EzQAoJAnxf87l7SHDkqo6IO17kNoXrHG
=Bv/B
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
