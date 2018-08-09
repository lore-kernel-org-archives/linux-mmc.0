From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/8] mmc: tegra: Parse and program DQS trim value
Date: Thu, 9 Aug 2018 13:42:14 +0200
Message-ID: <20180809114214.GK21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Two more comments...

On Tue, Aug 07, 2018 at 04:59:58PM +0300, Aapo Vienamo wrote:
> Parse and program the HS400 DQS trim value from dt. Program a fallback
> value in case the property is missing.

"dt" -> "DT" because it is an abbreviation.

>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
[...]
> @@ -545,20 +555,33 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
>  	return clk_round_rate(pltfm_host->clk, UINT_MAX);
>  }
> =20
> +static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> +{
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +	reg &=3D ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
> +	reg |=3D val<<SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;

Also, you should add spaces around '<<'.

Thierry

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKJYACgkQ3SOs138+
s6Ev6Q//THUoH4xdLk+zBGfsqxPr0KD3y5bVYew9QJz50OLbSpcXVGOk4ecz19WO
huaVBr8RTts6DzR6/bg7ppX4nM9t28LRt6LZW7PRZ61tewOFWwlnlhu8JR92HJRS
ipdW9g3uSLWhdQ3hkS74b5NdnQc/rU25Csj3S2sW9LkdG2D+VoC1zgLQOzYrUM6u
FbxYvDvfdZM6Lha8n99WV3heAnVD8ypaFNZ0hB8O6lZrrV/Qm70ETdXV/p82+Xgg
5f76xwTmm8CMIhZr2cG/gFYOBn9/vwJ1SwjaswX9ktnTSsDtpt8mQorsKs6R1yWY
kqXSpj0E9VHAdwVKeufet93xql0DKVA+WOr2XxHs1HpGFMR2ajTVck+j1zL7qn0W
VJl7BFJHahyPX+eXTUpudL+41WO0DzZIwU34m4jjC+iBpPTTyQ2qNrSo0cMADjIc
0BHrr39CJMQKrh1j4kXqj9YsJ7pprxCrmNnDd/uWBvsCs5ri6Fn1ABk40L0k377s
tUsbmYMg/t4tnG0Jaf1FW0r1pyDpz1yvacb9OPakzOMVyCDATzoCjsSyk15egkMU
u6E5MYgNZZUGQAeY/kOXeek8Fad6VGXGn0ZSpeWNts7E9DJHyXlkAmr8aQB4FPNL
BErjA8MxbEAxCcqB4AmroWyX7vu40EudIIaxCFPSz4f+idoULG0=
=g9ok
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
