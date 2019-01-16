From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Date: Wed, 16 Jan 2019 14:27:47 +0100
Message-ID: <20190116132747.GB11050@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:36PM +0100, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,

"know" -> "now"

> so there is no longer any need for the sdhci-omap code to implement
> ->get_ro() using mmc_gpio_get_ro().
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-omap.c | 1 -
>  1 file changed, 1 deletion(-)

I can't runtime test this myself, but it certainly looks like this would
do the right thing because it calls the core now call the very same
function as this used to, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

Adding Tony and linux-omap for a slightly wider audience and hopefully
find someone to test this on. For reference, the whole series is here:

	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D66905

Thierry

>=20
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index d264391616f9..c2a28930086f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *p=
dev)
>  		goto err_put_sync;
>  	}
> =20
> -	host->mmc_host_ops.get_ro =3D mmc_gpio_get_ro;
>  	host->mmc_host_ops.start_signal_voltage_switch =3D
>  					sdhci_omap_start_signal_voltage_switch;
>  	host->mmc_host_ops.set_ios =3D sdhci_omap_set_ios;
> --=20
> 2.20.1
>=20

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/MVMACgkQ3SOs138+
s6HiJA/+PASp1njciDjqY+I9wKP97EQV3tpvJIzGCCFsL7iQ2O6p8f846Eo+OXBi
aJmcEhUT8URqPeRZGm83NUaqBySGLZ17XyWIAOgx+pQEPgcRSvcV4Z7fUeSxlzp1
tilRGoFwd4dgvXk/HSpYsgnWPOLBfnUuvHJZVMC31XykOiBcRNL8nNanq2tLXu5+
+7+bAw44SZbYjkMaEmkVnY1SoiaLCHXdbZekCjE205pWToOwjqy21GdZVc7hSNpG
KS72f7xL23boeJ9R5RGJl7ez+Oq2EdfUpuC9a9D6P4iFpwmAlCvX2DrxeQycmyRJ
IyFyRuvj+ucI27Oz9UQe9BDPNCy3BhaJLLrYlhMYZs0QPhE1lj6RXmmfH6yKMyRW
YYr0XzWiC6gC5XoxVdhZJ7DPzkXEWpScybITgUj/kABRy9I9e9KpRmNWDo1KGeoG
f/Cze3Q+Eg6HDotplopOhlDprFGunOSYbexvJkjyYsWw/75BzCqxIpcGSb3Dzmj+
cI4rGS+i1BWZGSN5Js4Gzf9tasHaRUD4L8ITQCzNU1FdmGAJx/OHNcgqTr/nVqs/
eqbgMf9W9Fwh5YhVc0293gTuXRrRtDGzoTXKhFuzfSKftHNR/peZQ8+zzp1iexK6
4qeLEkNxH/dT16ZRzEBhQssBMO/XByXGcuU5unkCA9l0uR69auo=
=TNNh
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
