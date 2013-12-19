From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH REPOST2] mmc: tegra: add support for Tegra124
Date: Thu, 19 Dec 2013 16:44:24 +0100
Message-ID: <20131219154423.GA12500@ulmo.nvidia.com>
References: <1387215563-20425-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:35864 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab3LSPpz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 10:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1387215563-20425-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 10:39:23AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra124's MMC controller is very similar to earlier SoC generations,
> and can be supported by the same driver.
>=20
> However, there are some non-backwards-compatible HW differences, and
> hence a new DT compatible value must be used to describe the HW. This
> patch updates the driver to support that new compatible value.
>=20
> That said, the HW differences are only relevant when enabling certain
> high-performance transfer modes. Since the driver is currently very
> simple and doesn't enable those modes, we don't actually need to address
> any of these HW differences in the code yet, hence the simple nature of
> this patch.
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)

Hi Chris,

Could you pick this up for 3.14, please?

Thierry

>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 5b7b2eba8a54..a835898a68dd 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -198,6 +198,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra114 =
=3D {
>  };
> =20
>  static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra124-sdhci", .data =3D &soc_data_tegra114=
 },
>  	{ .compatible =3D "nvidia,tegra114-sdhci", .data =3D &soc_data_tegra114=
 },
>  	{ .compatible =3D "nvidia,tegra30-sdhci", .data =3D &soc_data_tegra30 },
>  	{ .compatible =3D "nvidia,tegra20-sdhci", .data =3D &soc_data_tegra20 },
> --=20
> 1.8.1.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsxRXAAoJEN0jrNd/PrOhzMEQAIQO0uY/0IJ8vt8RPx8e0D+l
0bFkiWNyqy94cVVhIPLDqFql+qjjlhIe4VOdabhFndkCaaBYPQsX0WhZs41ya9P6
/u9TOVANSFnBVgKRA/zAPWWt9lE/vC05A6kMafZn3GnLjXllgEhp3eWHssQlVFO6
t0rw023ZzlTDxnBn0bCNWo1DcdGBR6NvVk0ZIwHk/gQyuVkzPD94V7cIqwzr3P+b
bqSaUxcmgtqB84YoTlU0MIv//gYWLxH6OztRFIbgBobGvJnxyOq1AWWx5IYvIdMq
7z2X8gh4TbBXXGtVlHwSP1HJ6ImluYCirz8PorW14XmcQh8CSEwovbpS+T2JArNW
MXdLzgHuX+lq2193hppK4wzpi9nc0dD3zwFZ9XWmWNtXba6DqxKCkw9Tcelx1Nsh
zW5l7cOJtrrVNchKIixbLR+8AhC840/PIylKeTnga1LrQeuaRMyVdlPVpHwCKI9T
flkvbKGx6HdCJXVs19tUQafs3iR5Rr3VM7+SGulG0giQgqAj+9bBL7cgxJc7fiu2
/0ofBW3yQ7PWZuqo/xM1zYf6poox0X5otz12OeeX+cpFPvX1/BMA4qwPa1KqSBCs
sQNCG8n7G0+MZf1jmF/Hhvvr2ZTBqQw2OtyH8hRbm9eL621G3nZwN39rhI770/no
WjQe+MmeuaA5oKfkTc69
=Ccig
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
