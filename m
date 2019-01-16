From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-tegra: drop ->get_ro() implementation
Date: Wed, 16 Jan 2019 14:22:21 +0100
Message-ID: <20190116132221.GA11050@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-4-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-4-thomas.petazzoni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
List-Id: linux-mmc@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:37PM +0100, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,
> so there is no longer any need for the sdhci-tegra code to implement
> ->get_ro() using mmc_gpio_get_ro().
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 ---------
>  1 file changed, 9 deletions(-)

So, if I apply this on top of next-20180116 I do get a BUG from
bio_split() on line 1833 in block/bio.c. However, that BUG also exists
without these patches.

More importantly, read-only detection with this applied still works on
for example Jetson TK1:

	[   28.547261] mmc1: new high speed SDHC card at address 59b4
	[   28.558814] mmcblk1: mmc1:59b4 SDC   14.7 GiB (ro)

So:

Tested-by: Thierry Reding <treding@nvidia.com>

and:

Acked-by: Thierry Reding <treding@nvidia.com>

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/MAkACgkQ3SOs138+
s6HgOg/9EJguIr3+CPkDImyXcLEzTTvJelPHUixE4x937+wH9whe3D0vbI3anIsl
u7LclTY1qgNStdqzUpj8MVTTgPa0Y1dlQY/npJxzf1YECnLgsL0U6KUKWH/AmDlS
XEtb9h4iyCKUGXgjUmKVtXV7ljNW1ZzydCaX+CD523zbd+uAzj/kDys64Y/owvnk
2PhScdYXLH9L2+b0vNSTL/R9EaY/RZumucpRwhsPaiOZSEHkKeYmbpsUMUrMz4re
PFjz62HG4kYJ4a5fO3S+kxIcCZtqHEsFM2CpDlu+hUx1JrPw66VdOD2ECog2Sta1
p+NIVLv6TgUfjTvyn5g0yanJoIzDbKJeYp2btY5ENPx5mtqTiEm1OI/954N2EUAm
S+wyHP/UkxKhu9+iZRpFYHULREMfceYH0UFtv3Wc8S511TON+6jmEVxPI3SxAj1k
8I02iXMvWpzw8UIhbdinCX8o5N9ln4MYJRoiQ8tCF903L3hzI9YFAqCl2JvgaUgo
hjWpjifabP+agFNOnaSteXzEVjWPFZJI0MNOlAlosVdkKdFsOlX/LIfFoVrZjR90
fKs6USdx/TqHpICf/dlg47UwEqi5z9QuzUKNSvmxrl6/SsoGfqPbWHEZbwNOb47z
z/Cbb0h9+5PictazpRr9XwCpqDmVGCZXiLLtvVV9l15q/ItNV6k=
=JB/h
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
