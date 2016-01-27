From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 11/13] mmc: sdhci-tegra: use sdhci_pltfm_init for
 private allocation
Date: Wed, 27 Jan 2016 16:14:38 +0100
Message-ID: <20160127151438.GA28536@ulmo.nvidia.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
 <1453803353-6266-12-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35462 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677AbcA0POn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 10:14:43 -0500
Content-Disposition: inline
In-Reply-To: <1453803353-6266-12-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 06:15:51PM +0800, Jisheng Zhang wrote:
> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-tegra
> to this allocation.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWqN7ZAAoJEN0jrNd/PrOhboYP/0YNRhsdaelGM030XBZjdap3
P3xxjKeuHNOCaCQWdUM2f7df5iRpesIuNSJcrpzvhmgp6aQ3nxg5wr/OLprqa09o
NH/UaA88Er8bTjRRUhjR+XZ2TIGEpli0hMjT2AWnmKpzWET0R9Z5i5kwKnd419dd
NDevSrkcaqLKSTyVpYHcmj9lNKufSnHfUwD/yXWRmtlzoFnTPOhRSw1C6Hh+Ggbu
IxQS51f27aL0MeMB4JNoXa5TwVb0lib7+l+pbY1UnxWGolpqVcNIeSj3TWVdWR3s
NWj7EYOlWQ7k/pQjJaQmvfooMPjxwRGRW8mYZLb7v5Sxn0RllVtgA/rXrGXkagFz
8xdKd3GDxNeSvDkXpRpxpleJxtqypkl17s4xrcARrdfvaMRaLXGrhVyobqXFtFfI
8uIRi9At6sGDORvsEU4I81eU2mihEJuIaqSAy3UGO2jDXL/VoIOm0rswPClne1e0
JaqHsc96bm5/fBWKuQowEiRziGgFsvEbXIhqQB+U4ijd5NHNXqqFVwVFVLaGdxBD
p0DfT/Kmywu1CD3Ps/Ke20Lyu3DG57fxCQ/M9fk4SLSZkU1bFGFO3oOM47G0H5jf
lAhESzP4dcNlgQ5QPaD/2VXVGloyLGSPCAcr86azSi2RapTbK03Lkof9Oh9ZKh+B
Z3APcDi04TB5O3EQqiJS
=qqmp
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
