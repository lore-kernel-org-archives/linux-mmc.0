From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro()
 implementation"
Date: Mon, 12 Aug 2019 11:06:59 +0200
Message-ID: <20190812090659.GB8903@ulmo>
References: <20190808222430.28477-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808222430.28477-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 01:24:30AM +0300, Dmitry Osipenko wrote:
> The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
> WP-GPIO state need to be used instead. In a case of the GPIO absence,
> write-enable should be assumed. External SD is writable once again as
> a result of this patch because the offending commit changed behaviour for
> the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
> which is incorrect for Tegra.
>=20
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RLDMACgkQ3SOs138+
s6H/bxAAqFkZoITao90AFM94NfokMprlU0+LtNV+socSWBzYJzTPeGoAvHvaVn22
qqg8sUervEonzshVlyUr4+bTty5QfMhtn6LVPQN2nxCFz7GTiGR5ZM4sLqV+xlMu
SekWpTgeQIFeyFx/k/ZL4UUzbgAZx4BXy2VMdZmqh+ZLU5Ou3rkmhf8lUU2JxJtY
wtbFhopsxovlRE6ElAuwraN8Sqd3RepRQKBxHZJxazXY6Nvn1Ni+KUVaWow0lb1w
jL9lAgAVoDI8CfH8OemxOTKMB7BvJLAJ1VmniZuwTqpQqlrhLnCkb/Bw29jjmToj
wLVr7+m+96CQvpqgrcTg13QAZyH2gwr1DjJTH6u1XoOij0fezLmADg4eETgUxCjb
BSdPRqnH9uQq79szJ42464aRyF8Lcu+yIGT7x7F/WX5AVU0Jjtmk9khvGQOsVEvp
fv1r7GzsiQy1RyH2fyjRj9yuiyHwVAvdVupHhkcLz3lLGFBnImwM2KOO+LjJQPFq
9i11pbwAFkZbUo/mBY5Ar0nBigu7eIZ6gtk6vIF0pi5WrQDqj0EpY0M72TvbwQfh
Nlo/MNJqtQcsO7FT2uYWKHLZ/9VvONkK44tS5KGbceCGXeAaL1vrxDnZ761lc5ga
c4xiuv+/CputZ4qYunS0qDbSdpJ86SfDODhghzbdM1TaOx6JuyQ=
=5Rj9
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
