From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra124
Date: Wed, 13 Apr 2016 17:24:40 +0200
Message-ID: <20160413152440.GD29509@ulmo.ba.sec>
References: <1460558156-10407-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460558156-10407-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 03:35:56PM +0100, Jon Hunter wrote:
> Tegra124 has been randomly hanging during system suspend when entering
> the Tegra LP1 low power state. The hang is caused by the tegra SDHCI
> driver and linked to the UHS-I tuning sequence. Disabling the UHS-I
> modes for Tegra124 prevents any hangs from occurring when entering
> system suspend.
>=20
> Unfortunately, the tuning sequence described in the public Tegra
> documentation is incomplete and on inspection of the current tuning
> sequence that has been implemented is also incomplete and may cause
> problems. In the short-term it is safer to disable UHS-I modes for now
> and fix later because it would be too large of a change to simply patch
> now. Therefore, disable UHS-I modes for Tegra124.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>=20
> I previously brought up this issue in this thread [0], but there has
> been no resolution and so I think that for v4.6 we need to disable this
> for now. I also pointered out that there is a complete implementation
> available in the v3.18 kernel used by chromeos products [1]. We do plan
> to get better support for UHS-I modes for Tegra it is just a matter of
> bandwidth at the moment :-(
>=20
> [0] http://marc.info/?l=3Dlinux-tegra&m=3D145926947408663&w=3D2
> [1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chr=
omeos-3.10/drivers/mmc/host/sdhci-tegra.c
>=20
>  drivers/mmc/host/sdhci-tegra.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Other than a couple of cases of inconsistent capitalization (tegra vs.
Tegra, the latter being correct, of course), this looks fine to me:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDmS4AAoJEN0jrNd/PrOhvgUP/2e4Qj2QbBsLOsCECPhIOYTy
8O/OmwgJ4IMVvDeEBdJx50PXvK9Pmc/1iGA8F45SjIrtn9AbVRJqWWTSkSLdcNII
t5DXQzlBnolld1kEkc/caiW//7Bnu9prD3JR/ciETJ6PVThXgy15Cv/tTFN18AoZ
UYhANotraa/PAoM5emUgyp/hTgXIC4R7dOOYRog9lkXB9GX1GlTSBsFMvnTJlrik
X5h7Or3BDr6c0XUmEmwwGdWmIE32bk4CjZ+y+5zGtli2FLNEmrk1DQ+2Kg01kdHX
gP+MXeLfYCkYXPQyt+Vr71z3a+XI02nBDmAItYQiPw2ewPxS4nbyXgbfsCGoPzmZ
79KoWj8k3nlljPhbBefIzY/jHAG80TWOgYOaM/rwQjD4Ootg6ist9BPlg6v5SqMU
belT49f3wWQzeXo5knEgItITEc1lnzC2Gs8sjml4eqU3fowugV061Zir8s5EnJCZ
lxiBD/KQ74uzMb+SBd6pVKyMDXo51AqRj1V+PCLTahviZk1cs1b28KDOT7B3C8Os
+57bkcVHQbOYq9suvjt29bDa4HE27F2POmF2Wja5zlsX8Fy5hwSISt7uTR1rfJ47
PQ8ChvXH3C9JRJ3uRxQoFN7RGeedwqBWFO2LnGEP6DaBFcMEniVaQuo3IG7wIAHI
hkCK9ck/biUv83cLz4pi
=DEpY
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
