From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Date: Tue, 5 Jun 2018 11:28:01 +0200
Message-ID: <20180605092801.GC20649@ulmo>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 06:35:40PM +0300, Aapo Vienamo wrote:
> The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
> and tegra_sdhci_get_max_clock is removed. It appears that the
> shdci-tegra specific callback was originally introduced due to the
> requirement that the host clock has to be twice the bus clock on DDR50
> mode. As far as I can tell the only effect the removal has on DDR50 mode
> is in cases where the parent clock is unable to supply the requested
> clock rate, causing the DDR50 mode to run at a lower frequency.
> Currently the DDR50 mode isn't enabled on any of the SoCs and would also
> require configuring the SDHCI clock divider register to function
> properly.
>=20
> The problem with tegra_sdhci_get_max_clock is that it divides the clock
> rate by two and thus artificially limits the maximum frequency of faster
> signaling modes which don't have the host-bus frequency ratio requirement
> of DDR50 such as SDR104 and HS200. Furthermore, the call to
> clk_round_rate() may return an error which isn't handled by
> tegra_sdhci_get_max_clock.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 970d38f6..c8745b5 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdh=
ci_host *host,
>  	sdhci_set_uhs_signaling(host, timing);
>  }
> =20
> -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> -
> -	/*
> -	 * DDR modes require the host to run at double the card frequency, so
> -	 * the maximum rate we can support is half of the module input clock.
> -	 */
> -	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> -}

sdhci_pltfm_clk_get_max_clock() returns the current frequency of the
clock, which may not be an accurate maximum.

Also, even if we don't support DDR modes now, we may want to enable them
in the future, at which point we'll need to move to something similar to
the above again, albeit maybe with some of the issues that you mentioned
fixed.

I wonder if we have access to the target mode in this function, because
it seems to me like we'd need to take that into account when determining
the maximum clock rate. Or perhaps the double-rate aspect is already
dealt with in other parts of the MMC subsystem, so the value we should
return here may not even need to take the mode into account.

All of the above said, it is true that we don't enable DDR modes as of
now, and this patch seems like it shouldn't break anything either, so:

Acked-by: Thierry Reding <treding@nvidia.com>

I also gave this a brief run on Jetson TK1 and things seem to work fine,
so:

Tested-by: Thierry Reding <treding@nvidia.com>

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsWV54ACgkQ3SOs138+
s6HoVBAAuvqCXzBhxeGOSFkxq1u7Ieicvxs2P3mW6fTgcVl9AeQU8lGxzG3OaF7r
1dM/xq3lH7HvVWILUG2XIyH48Bvk9aFvVnIo1iZHkIsGdx5Nl4ecVhAeNapsWG3k
7LpOoU/dQ9blcyTCUAWfTpJDaAojaVpQ+HGZ9ttALzC67aUjmDHE1fg4RZXZcmId
/2R9TWa0EVrPNvgqjuSawgXkriLwz75oAHtpTch+1XnCBAEGkgcUNMTkQmXulpyG
/FUm/WxChXColO0F7J3lBGTkpCYiddyQ4QMt7R6aX7CpPdhpBvy5UNl4HRwpjL85
HTOhp1yC5x367h4ekVJtcspttRMJzZUbw86C7/pwa5m4Ok30Ga6zJegRodljnttT
0u44+qL3q0CyPiQ+Hl9YDrDngrD4ZFjXQ9fEl9nkJMqn97WCN90PWlw1ueKGh1aL
mois1ut6lz717zbCn6og8U9gHydcpkU45YM5Ug6hcurgc8EWMug25KKxq++AX7AI
6OkTColPrLdTn1CjTJc85JLTvvRCWirtjS3nxqiezhSBr6HnNsDJ6o3bES3HcyB5
i/Q6w8IpDJDEwt/qqy9jqCtmwJP00hZHypECO9SnS8UC0Vptvw3dSJu23cEnyLe7
Cv+B3doRkF0DXMn7jSS+gJOidVO/hrRxuzWkKjkhFh+w1o5JV4I=
=wHuu
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
