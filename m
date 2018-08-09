From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 07/40] soc/tegra: pmc: Implement tegra_io_pad_is_powered()
Date: Thu, 9 Aug 2018 14:22:26 +0200
Message-ID: <20180809122226.GS21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-8-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533141150-10511-8-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:57PM +0300, Aapo Vienamo wrote:
> Implement a function to query whether a pad is in deep power down mode.
> This will is needed by the pinctrl callbacks.

"This is needed..."

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 393ca72..784c182 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -1075,6 +1075,22 @@ int tegra_io_pad_power_disable(enum tegra_io_pad i=
d)
>  }
>  EXPORT_SYMBOL(tegra_io_pad_power_disable);
> =20
> +static int tegra_io_pad_is_powered(enum tegra_io_pad id)
> +{
> +	unsigned long request, status;
> +	u32 mask;
> +	u32 value;

These can go on a single line.

Thierry

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMgIACgkQ3SOs138+
s6HcZxAAqCg/j/84XaWdFZuexhsITHhgWr2RXdBAqYHGBTA8sLTPH8pyJW/S3mD6
ke/0fdpETpE8jtqJdWaWytiaycw4aLmwcWz/QMozEJ6SY4IBUKBBiPYKrNzhWTHO
Av/l1sBGyQ0zN2SeoJjHttsykzRis1k/9ATv0whkJdUytTuPkpf4X2o142rGYsuV
NpUkVoDYIHzI7YrHTfppWCpqiEFv4zEm/qCGJxkCNAlDU7xI48+WbGQjIaTmyoxD
XVEVpaEi8GEU1vkgyQtY8l3PS2ywJ7OaH1naRTUs8BtkobxnYqpjRpJFNs8TQp+A
ZHf/xKZXPAu0j/RkbFnu576Mujde0r+W0zVWRHXRA4dEmQnZJeGxon97S1qNo5LG
N7ibgxCoPhumQvCkqyhEPW82CpfUpTI/yDbLd0aXXr1AQV/AvMH/KkxIST44JnyH
DtQBt2OVeG8cYzonDXdXV5ZUGQyNPhPLwoxAgrQSSF45GUC/caxN1sy0ZchgZ+J2
gO2S5qQCBCNTojn7lK9oY7geKG3/ZX4Ci1HY50qi03pxO8xRDBfTN+B4x4Snw+zR
excumyHUyrvVKR/CsUDMmG7wVCfGS9ruh5+g8lXLxH4iwEwZ1nE0bXttm6+8Yeoa
1sB+B/adpqEUdp/YeR/Qns3DJGXMw1jnychvgfu2Y8GlFW2Wu7s=
=WfhN
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
