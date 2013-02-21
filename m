From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 0/2] mmc: tegra: use mmc_of_parse to get support of
 standard MMC DT binding
Date: Thu, 21 Feb 2013 09:24:41 +0100
Message-ID: <20130221082441.GC7718@avionic-0098.mockup.avionic-design.de>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1361343902-15223-1-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 03:05:00PM +0800, Joseph Lo wrote:
> The 2nd patch of this series depends on two patches below.
>=20
> "mmc: provide a standard MMC device-tree binding parser centrally"
> (available on next-20130219)
> mmc: tegra: assume CONFIG_OF, remove platform data
> (https://patchwork.kernel.org/patch/2150351/)
>=20
> Verified on Seaboard and Cardhu.
>=20
> Joseph Lo (2):
>   ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host
>   mmc: tegra: use mmc_of_parse to get the support of standard MMC DT
>     bindings
>=20
>  arch/arm/boot/dts/tegra20-harmony.dts   |  4 +-
>  arch/arm/boot/dts/tegra20-paz00.dts     |  2 +-
>  arch/arm/boot/dts/tegra20-seaboard.dts  |  2 +-
>  arch/arm/boot/dts/tegra20-trimslice.dts |  2 +-
>  arch/arm/boot/dts/tegra20-ventana.dts   |  2 +-
>  arch/arm/boot/dts/tegra20-whistler.dts  |  1 +
>  arch/arm/boot/dts/tegra30-beaver.dts    |  2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi   |  2 +-
>  drivers/mmc/host/sdhci-tegra.c          | 85 +++------------------------=
------
>  9 files changed, 16 insertions(+), 86 deletions(-)

With the same DTS change for Tamonten, the series:

Tested-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRJdnJAAoJEN0jrNd/PrOhjKUP/2cgIDAtmHq2jw+8GFVbRggO
TWz2LEu37l4Fa8+EGFh7QlABB+LMgKPHiLEmFKkU3E4dlBdCmj4Xn6BI0/EknarB
IWa3/0h7/5bGruIDGdK3PfSm5LZ1rflh9K6lX6OEaJRxjG4USn1lK8PJgzxCPd3j
a5AZfa5M6Lso+wB51mfsVxk8JAegoFxez/O905TY+Bibh/DQJ40D1KyT3Kw38Yhv
pr6z1iMTAFazw/33kRpL7nwQKV73BDyZbBO9GhOi7rKP3clN9ucvL0n1LxYxDfHM
KDKosbzn6TBoqbrwZcSeQZCgAssypL6j1hJAXtfNXy2hYIYgGgubCC6vSejQhy3q
c8vLOM7rkL2kFrConcpq4Bg01S+el1g7+WP7/ped3oAMTj09Fz8fe4nvP03HhzwF
9Plp3GmnU8okqoCQJfPla4o0ZAiEpgkChQbcxKGWGnjbrW2qYcQkggdCkm5MuqWD
/lcp43XZv2NzckmSgBNuJxjOllIHwW3JSOehwbqZTAj3e/FCCAoEKzLWNyI4w3Yf
6V8hnBmRHXLPB4Ti2/YTJRcPWoq+93p2d17xgcPpQvfRRcjOuqG274VYxwyYW+qS
RSVCGePsRHtD/E4+UQdLiDgRo+tJ+d1TQVg/rYCc0S3yI7yB33UM+QzlLHk68e6G
Wz6GZ31V7WIbkxiy82SG
=25/v
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
