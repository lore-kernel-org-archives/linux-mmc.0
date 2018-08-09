From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Date: Thu, 9 Aug 2018 14:27:06 +0200
Message-ID: <20180809122706.GT21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> Register a pinctrl device and implement get and set functions for
> PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 187 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 185 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
[...]
> @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] =3D {
>  		.name	=3D (_name),			\
>  	})
> =20
> +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> +	((struct pinctrl_pin_desc) {			\
> +		.number =3D (_id),			\
> +		.name	=3D (_name)			\
> +	})
> +

Do we really need the explicit cast to struct pinctrl_pin_desc here?

Thierry

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMxoACgkQ3SOs138+
s6G7Rg/7B8Fm6KFvtD0N3miwZP45DmwbCTXTCEWTPZTYnII1X5RaNv1dM7ayNm7P
qZRHNilYwChe/O+5h9CsWLbR4TaTqQSVwd+hMJ8GAmgerwrChVuSsN/q77Z1DHG7
7Vy+uwQL0Dwqw9C4en61SHAuUhJuuDYtPtY3UikfZ2M/TDd8zcplGzdL3SonrHGj
t6T0AItW+EXMFEr6oI/4aYdGgPPjrapMeaU3ir4vwO440HXWWIrm9ymAPVMjt2ym
xhUTzJqI7qLrFYj78jdmUQTwQDnfLSqY07jwslGH9firpIAW7goSvy72899lggng
4qVAKqClYSGI1ADlDaX9drkL4WcLwTSymHCj1Rh7MoHgbPFxAC1+VmpvkEqhhvE4
6KHfOW34WzdPkyf/ZX4Kslveg7S8xTuif78Ws3kGOus/wlTdkT1SBBZGJUr9wybM
zKMlP0Nyp0JISmzyprFEd4ZoOmT1oraAG6DudSBYra6xNRByI9W7wAj7obFCAp8B
8t7bO1T3TcL9IAjfUzDsM4IghokQn1BZZh7vkfsyphsVwOeLMLlej05EaQrVduS0
wOgbmECGbBa5468PlIyiurjEJXaKWcKjubs/+rWEoDgKCry68+hzq09OgG2rlvU9
u0MfxFJnD9uenTQY6pJfSNlmtKTeHZwLIHfX5aM3gBW7KkxwBG8=
=teHV
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
