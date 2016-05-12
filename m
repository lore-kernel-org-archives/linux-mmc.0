From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 2/3] mmc: sh_mobile_sdhi: Add tuning support
Date: Thu, 12 May 2016 18:50:13 +0200
Message-ID: <20160512165013.GD13121@katana>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462859524-28522-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +struct sh_mobile_sdhi_scc {
> +	unsigned long clk;	/* clock for SDR104 */

'clk_rate' please. clk is too often used with struct clk *.

> +static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int=
 state)
> +{
> +	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> +	struct tmio_mmc_host *host =3D mmc_priv(mmc);
> +
> +	if (state) {
> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
> +				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x00ff);
> +	}
> +}

Left over? Doesn't seemt to get used in patch 1?

> +static inline u32 sd_scc_read32(struct tmio_mmc_host *host, int addr)
> +{
> +	struct platform_device *pdev =3D host->pdev;
> +	const struct of_device_id *of_id =3D
> +		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
> +	const struct sh_mobile_sdhi_of_data *of_data =3D of_id->data;
> +
> +	return readl(host->ctl + of_data->scc_offset +
> +		     (addr << host->bus_shift));
> +}
> +
> +static inline void sd_scc_write32(struct tmio_mmc_host *host, int addr,
> +				  u32 val)
> +{
> +	struct platform_device *pdev =3D host->pdev;
> +	const struct of_device_id *of_id =3D
> +		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
> +	const struct sh_mobile_sdhi_of_data *of_data =3D of_id->data;
> +
> +	writel(val, host->ctl + of_data->scc_offset +
> +	       (addr << host->bus_shift));

It probably makes sense to store the SCC base pointer somewhere to
prevent all these lookups with every read/write.

> +static bool sh_mobile_sdhi_inquiry_tuning(struct tmio_mmc_host *host)
> +{
> +	/* SDHI should be tuning only SDR104 */
> +	if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS_SDR104)
> +		return true;
> +	else
> +		return false;
> +}

Really needed? See patch 1.

>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -357,6 +588,7 @@ static int sh_mobile_sdhi_probe(struct platform_devic=
e *pdev)
>  		host->bus_shift =3D of_data->bus_shift;
>  	}
> =20
> +	host->set_clk_div	=3D sh_mobile_sdhi_set_clk_div;

Left over?


--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNLRFAAoJEBQN5MwUoCm26HkP/A4FSJZzL57zp3FM6k4qw6Dh
ChtFUJd8Sc4cXWfOvJ1HfmyQYUKaVvUt5LVpKFaYgorsh2ZGkhhw8sFTWpWtiJq5
QO3w4wyfaAryH1S9oR2Ca2K4SHdj8ClTBalNM8OxoHHJpqWehuMHQM4LF00p3zOn
xm2Ra7L1dLcmpOJuu32vQsjUyFE1hh3FdVU3ngC9wSGFsD94W/YSetqzqGtgOTzp
T2HQLwYAssF5sbaZVaCzJ3DkcfytPGzBIGZUM2oXBIx/9a76XZM1+EWZWe4Eg3t6
SlE9WnLi4t6tgfMlSvfT4bzbGdqneQcg8DSCErITzTllJaMP7VNPb78juvmv6iqY
LMPSIqUKtx36oxhv9XVIw/6VlyTjlpRVxackI6lrhvpnEkOqCkSL3FpaGLkAxC+d
qUr2HMtDE6OvC2XTF4QTMrecoxyCL8aZb2iyzfRxD/pKTID+ht90/aWp2rzjXIo1
RJIzd1AFBPh+UYL1J0hiynTFKEgXtv5+GGV0OEYC50JAZLbC1zZfU4gQQkG9e7Tp
v9jP4CRHJaO3+D1xXCUnwKfOiqFuazstZDLQQVGPCkb7xcvz6/CAnk2kofwDSAfa
VwaLl79Vl5G3OWl22VLoTx7l5xdBvg08CFrD5BsWNr3CbmJJQfnG4+cMjLzqsBOU
KiSIyh61b16A32iK+klv
=qocS
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
