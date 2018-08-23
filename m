From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] Tegra SDHCI rerun pad calibration periodically
Date: Thu, 23 Aug 2018 10:50:14 +0200
Message-ID: <20180823085014.GB28696@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 12:23:31PM +0300, Aapo Vienamo wrote:
> Hi all,
>=20
> This series implements pad drive strength recalibration. The calibration
> is rerun to compensate possible changes in temperature. The calibration
> procedure is rerun as part of mmc_host_ops.request before
> sdhci_request() is run. The calibration is executed only if the 100 ms
> recalibration interval has passed.
>=20
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>=20
> Aapo Vienamo (2):
>   mmc: sdhci: Export sdhci_request()
>   mmc: tegra: Implement periodic pad calibration
>=20
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c       |  3 ++-
>  drivers/mmc/host/sdhci.h       |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)

Adrian, Ulf,

Since this depends on the earlier, fairly large series, I could throw
these on top of the branch I already have. That way you don't have to
worry about the dependency yourself. Of course it's also fine if you
want to apply this yourselves, in which case the series is:

Acked-by: Thierry Reding <treding@nvidia.com>

Thanks,
Thierry

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt+dUYACgkQ3SOs138+
s6FUeQ/8DBmee+PNuEJrukSN9i3dR+SQm2XnEmAZee0pF8AXqaxAh6JRRA/KDnUB
zXnBedB+hTAPdYP276VlKtojS8dugoPSc7qDvX1ASBucmxD/4HGGRT1ZufDK1CRH
/HLjXT9Pz5MyK4oRHoYDHNF+lqF1B12WjSy5IgXTYc33Fdqgr7Zxt6RMNcOhZOmD
Lt4ufJ6IfztxAoQuhNWwHgshqiCns1Kgt2tGV0DZImBm81fNmkM+2vqD1gJ0XNC8
Eh5FZZxAR66U9tGXskBLln1k8+bP9kkA2+IJXueMce+/R/j2Xb0J0no7Ncz8QkQe
lQl4KP1qc6E3cyz/0g6QVQSvHekGSA1wonwr+MtfuUQf8/nh8gQ54fYV3xqdBbHC
dtI/F50tVNAIeR92LQYiJF8otVmRu8Vge80HnhW3vM6fUxqAPwZTdtdXLE9fhWl1
w7TeptCNOF+bgThNqEjsJs4AkXj2XkU8ekNOF1jHj6OqQnHyjqVt1WUE5k4txW7H
d88ncgQ28+GZj/d/0hBFBZl+aoY4bUBIWVJcxEK6Xops8hBEvWHPFCDBL2ORL02F
+mJymd4vbLgULQ+nVo+1U4xHe66gYFf+SDHrpa//Oc/O0DxulUU90xHcu7FSHPGO
jsxj6iCdG5IwU/yD9Sl+lGMhOlanB7RWabe++SNms+3ckIHrRS4=
=Ae4E
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
