From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date: Wed, 3 Oct 2018 01:01:15 +0200
Message-ID: <20181002230115.GB812@kunai>
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
 <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yamada-san,

On Mon, Oct 01, 2018 at 09:31:01PM +0900, Masahiro Yamada wrote:
> CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
>=20
> Add a new hook host->reset for performing a platform-specific reset
> sequence, and move CTL_RESET_SDIO over there.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I like it in general.

> +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> +{
> +	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> +	usleep_range(10000, 11000);
> +	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> +	usleep_range(10000, 11000);
> +}
> +

Are you sure resetting SDIO works independently of resetting SD? Maybe
we should add resetting SD here, too, to keep the pattern...

> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -164,14 +164,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *ho=
st)
>  {
>  	/* FIXME - should we set stop clock reg here */
>  	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> -	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> -		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
>  	usleep_range(10000, 11000);
>  	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> -	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> -		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
>  	usleep_range(10000, 11000);

=2E.. and have this simplified reset pattern either also in a seperate
function, or doing...

> =20
> +	if (host->reset)
> +		host->reset(host);
	else
		simplified_reset_pattern

?

What's your opinion?

Regards,

   Wolfram


--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluz+LsACgkQFA3kzBSg
KbZjpg//SLluqM1Huz74ZSqUTGeIfpin4OLgALKBMIcZCrX51riSpKsHhuLyYWqs
AgZGDET8Ye5AlC5E3bPvY4rWXG2c3t55VbNt5hGcqvU78xekqGwSMjUBGrD0grs5
eYUvReRihz4oGOqDIp2cu9Jjy4nM78FYTVMV6RjVMXWGaeuob9UWxip1S7L8acNd
+bsWcaApoqfDh6Rt4HhighW94OxGTx38Io+LcbwUFOV4gMlGo0GzPvcelNvS3CJ0
TeQwuscF5txjLfyVbz+pcPARKyDun1xjYekOGKr97Kp+8dQbQwPlSiqSq9oPrf/S
N4bDNGREifbY50FU2mtQbEfrF48NJ3F6x1pLUDXICMTrp260K5XFEiPNjXScZLch
zT2OUyf8QuCjsl1PsaM/DJFjiPcy1v9R2PYYLls3dS4PiVT8w07jV6xCbOX3pw+n
zECu9zPBJE2X/tSrZQqtCl7MNjem+AIbUrAtGotBPlGXjoOzzlPKlu9LxRMzEx8h
5sqC5dQh36zX/ShkKllHiuhB0aIs+dNLzcT/gZbJJidONHOd6fpmIKegLJJEA7kF
2cA2zqSSTS3uI3fpwCuWU+BACiMrBBAwYPRNdCAtwWqdcdZyby/KATPCQG/HLW39
yW9WfRLACN5HhwUTFWvRiLuV+cM7aN4EfbPHcBsW8XUCz0WOUv0=
=fc5y
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
