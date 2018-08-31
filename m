From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
Date: Fri, 31 Aug 2018 16:00:17 +0200
Message-ID: <20180831140017.GB7926@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 12:23:33PM +0300, Aapo Vienamo wrote:
> Rerun the pad calibration procedure before sdhci_request() if
> the 100 ms recalibration interval has been exceeded.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSfEACgkQ3SOs138+
s6HAYBAAuHulah5onbx62mnNjNsUcRcCcb40PdwDXoX1ePa1D5y/wCg2y6oFGYK8
fArz8gAteh2LI6BN+po8zN7DRRkflZh8l7bsEr1ITXQ7UaeqbisXiA02RCnxiv/v
8JSmuS2T51Pvy8z4vEYCvHzUSvsP05VJ+I4sGFfY19y2QPyO5R934dlFZhA+SYck
3U4L9IRZg8/WIi2M+uBhwM0c9ZafcgIM1gHTyLAgr72+DmaXxsye/KNTgAn8h/Y0
qWqC3+4xCHN/IhXj5/bJcqTwW2X6OeZOziBZLW6HUzU3ezCPxd8vRD9W1OcmBc5W
m0RBg7Z5wxXfPpvag7tCwmexJUAlDl7AoH9xThfM8gY3svtvW5D4uFIvvDepvcD4
18iEP6RmHSYrW4e2bf1PXReBxQ1N+qfPjT9tNoM+sAGxr+B8b5mUdZCGMuGrCdxo
gLR40YMB/dqIEQe38c3kcefdzhkffb/0MEK6e/xnb7MJhTKhB9jUTRks1jykJhVB
WFaOrVnC8EWm7IZZutV3wDsdzrsvcNAMNCrwh/az2dy0+WKDfeITIzk8t+TMCgJh
fb0UC0N8knjzbnWfojjbJtzoS9CyVFh9BVlaM5sOauJ95Sd6V0iQyd8yao6U67le
MAPlGP5K9fKkSkWeVULqvnxXdemF1HkLLnNqoGw7/OYr5CCc2E8=
=j8Gh
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
