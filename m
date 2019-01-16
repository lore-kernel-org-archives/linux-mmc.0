From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date: Wed, 16 Jan 2019 13:32:16 +0100
Message-ID: <20190116123216.GC30993@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
List-Id: linux-mmc@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:35PM +0100, Thomas Petazzoni wrote:
> Even though SDHCI controllers may have a dedicated WP pin that can be
> queried using the SDHCI_PRESENT_STATE register, some platforms may
> chose to use a separate regular GPIO to route the WP signal. Such a
> GPIO is typically represented using the wp-gpios property in the
> Device Tree.
>=20
> Unfortunately, the current sdhci_check_ro() function does not make use
> of such GPIO when available: it either uses a host controller specific
> ->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
> controller specific ->get_ro() functions are implemented just to use
> check a WP GPIO state.

"use check" was probably meant to be just "check"?

>=20
> Instead of pushing this to more controller-specific implementations,
> let's handle this in the core SDHCI code, just like it is already done
> for the CD GPIO in sdhci_get_cd().
>=20
> The below patch simply changes sdhci_check_ro() to use the value of
> the WP GPIO if available. We need to adjust the prototype of the
> function to use a mmc_host* as argument instead of sdhci_host*, since
> the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Other than the typo in the commit message, this looks fine:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/JFAACgkQ3SOs138+
s6GeDhAAwsNmmLpq9tvuMI4JohtkuLt6RUH4Gr+hsYPGSzqqZrIa0GtmelLT6Orf
omnjgIpNq+dGJIXlH+LmHjGmDdQiMs3Q/TeORrMjXvHryoWGbXFRqNgoCanM+UvT
TbcDMMGvjkLNTJ4ra0gwJzSB4us+atleiCYn00ed+oz9Hzz3QZ5ncOK6E+JULwKn
shVzMM2O84za0wt3hTG7vKpA18VJg5zVaJGVsPPNvUOHYtoCDFD0JN/Uf13yU7rA
jVv+an0THTk0Lz82mBMLl4jZaRV2npKwvznzgnae85iflV61RFnkvQ13uXuEg1C5
LmNSBSO3YE7kxmfaRaUgQ1G8wB42/nHNxizE8+09ET9bRjUGsy5cybC/05WihEgo
UPZtqr66dN899Zp1NaBugD1M0NKPj9ZbQIsZ6yjRICPxIAE/2cYIM4Kq8JrpYC0s
JqC5t0KjRCM7W4IY7ImG8rgT26VwSoXNm2xaan7T7D/t2divLQsNBXK+QiZRPooA
ggFnnJTz4Sm5h8GD79RWGfnh1jJ+oXIyhOOTWXlVHNhXFiOoKf8fymUPv2mU5cym
w2M1ZraTqC6Rn3EG0FzIJq2jXmgiEsZod8B7jVJyTFJEJCbkTIRQfy93Hw/KNu6k
XCfm3V4pXTxWAViZ5/3pmaVKsDduXLRzCKofuKXA9CS0QhYMYZw=
=i3+o
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
