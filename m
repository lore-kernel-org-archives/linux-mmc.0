From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mmc: tegra: remove redundant return statement
Date: Fri, 4 May 2018 11:27:16 +0200
Message-ID: <20180504092716.GA13459@ulmo>
References: <20180504092053.GA20277@orion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504092053.GA20277@orion>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <aapo.vienamo@iki.fi>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 12:20:53PM +0300, Aapo Vienamo wrote:
> A redundant return statement is removed from
> tegra_sdhci_set_uhs_signaling(). The function returns void and the
> return does not affect the control flow of the function.
>=20
> Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index b877c13184c2..970d38f68939 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -231,7 +231,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhc=
i_host *host,
>  	if (timing =3D=3D MMC_TIMING_UHS_DDR50)
>  		tegra_host->ddr_signaling =3D true;
> =20
> -	return sdhci_set_uhs_signaling(host, timing);
> +	sdhci_set_uhs_signaling(host, timing);
>  }
> =20
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)

Good catch!

Acked-by: Thierry Reding <treding@nvidia.com>

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsJ3EACgkQ3SOs138+
s6EWqRAAg1ponv3piQ857cxYBQQbZK32PMk75V3QJweCt1oq8eDdM2YhRvljDFJJ
jkXFhAqBUyeH5Yq6nkfbfnKkV0EqPHrS9YTzwssmiQCZYP5geEtYy+UcNzV75PBD
NnEqt5eG8aWsZd+HvBscFyPU6tlEFFxXWNRKFHkAOVOi/RTEeQhmuZHG46FlyT5C
GGa/KowfdWp+zNGwSVM+IAdiETfWuH6nqVxtfcANXJP00qJ1thP3zoOl7JDHNCUA
oQ3rRopy5Gd8IYvKJRNDxrZqhti7iK1V1Oklu4ixBiKvxAxzHIu8JdHP/vJcvoDY
Dr/cfbCzGij3ILkqwrDkmlYgYhL1nICAiZrimo2EED3tGOLSaPXo3vb0mNDoWJKy
TeNzghkTwWdvveEeS1S1BPFxw2Fp9+4eqwOaOCrTCf4PXN16CrHbuJK7U/L2+sCm
uk13lrkXKFTXS8GUXktZSHIx7ojFuLE6pFr/fumjgV0ZhfuFzgxspGVBq9244fii
uFkQaJtYmbsOpT9EcVBSbBn0CxJEMsjcuzk2zlDroRc4ZNM89L4uqOwp6SubAyZD
QFLH5ipoBhJdKmJ0qoJGR/RUXq614fCjU7OWOhq4nvSIABBJUP5jLhwc/Uav0zA8
gHVBb6MTGku22iq6Mhbz2TcINmKnYky4UTZr4B/nL1AISnBhLQA=
=/CUS
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
