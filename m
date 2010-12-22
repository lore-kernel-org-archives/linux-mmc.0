From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/3] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 22 Dec 2010 17:22:31 +0100
Message-ID: <20101222162231.GC30951@pengutronix.de>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
 <1293004871-1918-4-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47350 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab0LVQWf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 11:22:35 -0500
Content-Disposition: inline
In-Reply-To: <1293004871-1918-4-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Mike Rapoport <mike@compulab.co.il>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

looks good to me. Just some minor comments, but in general

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

On Wed, Dec 22, 2010 at 02:01:11AM -0600, Olof Johansson wrote:
> SDHCI driver for Tegra. Pretty straight forward, a few pieces of
> functionality left to fill in but nothing that stops it from going
> upstream. Board enablement submitted separately.

I'd think this can go below the "---" line?

=2E..
> This driver plugs in as a new variant of sdhci-pltfm, using the platform
> data structure passed in to specify the GPIOs to use for card detect,
> write protect and card power enablement.
>=20
> Original driver (of which only the header file is left):
> Signed-off-by: Yvonne Yip <y@palm.com>
>=20
> The rest, which has been rewritten by now:
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Mike Rapoport <mike@compulab.co.il>
> +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
> +{
> +	struct platform_device *pdev =3D to_platform_device(mmc_dev(sdhci->mmc)=
);
> +	struct tegra_sdhci_platform_data *plat;
> +
> +	plat =3D pdev->dev.platform_data;
> +
> +	if (gpio_is_valid(plat->wp_gpio))
> +		return gpio_get_value(plat->wp_gpio);
> +
> +	return -1;

So, read_only is the default case? I would have gone for returning 0.
Well, safety vs. convenience...

=2E..
> +		if (rc) {
> +			dev_err(mmc_dev(host->mmc),=20

Trailing white space

> +				"failed to allocate power gpio\n");
> +			goto out;
> +		}
> +		tegra_gpio_enable(plat->power_gpio);
> +		gpio_direction_output(plat->power_gpio, 1);
> +	}
> +
> +	if (gpio_is_valid(plat->cd_gpio)) {
> +		rc =3D gpio_request(plat->cd_gpio, "sdhci_cd");
> +		if (rc) {
> +			dev_err(mmc_dev(host->mmc),=20

ditto

> +				"failed to allocate cd gpio\n");
> +			goto out_power;
> +		}
> +		tegra_gpio_enable(plat->cd_gpio);
> +
> +		rc =3D request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
> +				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +				 mmc_hostname(host->mmc), host);
> +
> +		if (rc)	{
> +			dev_err(mmc_dev(host->mmc), "request irq error\n");
> +			goto out_cd;
> +		}
> +
> +	}
> +
> +	if (gpio_is_valid(plat->wp_gpio)) {
> +		rc =3D gpio_request(plat->wp_gpio, "sdhci_wp");
> +		if (rc) {
> +			dev_err(mmc_dev(host->mmc),=20

ditto

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0SJccACgkQD27XaX1/VRtnbgCdH8+R7hjsq4YjJIjvQgtkwOrF
GHwAoJBRrdEv6+5d2sxZ5J/AqWsTXLb4
=RLqI
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
