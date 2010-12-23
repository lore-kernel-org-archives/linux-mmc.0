From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 3/3] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Thu, 23 Dec 2010 08:20:58 +0200
Message-ID: <4D12EA4A.4000906@compulab.co.il>
References: <1293004871-1918-1-git-send-email-olof@lixom.net> <1293004871-1918-4-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56902 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab0LWGVt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Dec 2010 01:21:49 -0500
In-Reply-To: <1293004871-1918-4-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

On 12/22/10 10:01, Olof Johansson wrote:
> SDHCI driver for Tegra. Pretty straight forward, a few pieces of
> functionality left to fill in but nothing that stops it from going
> upstream. Board enablement submitted separately.
> 
> This driver plugs in as a new variant of sdhci-pltfm, using the platform
> data structure passed in to specify the GPIOs to use for card detect,
> write protect and card power enablement.
> 
> Original driver (of which only the header file is left):
> Signed-off-by: Yvonne Yip <y@palm.com>
> 
> The rest, which has been rewritten by now:
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Mike Rapoport <mike@compulab.co.il>

Only one comment below, otherwise feel free to add
Acked-by: Mike Rapoport <mike@compulab.co.il>

> ---
> 
>  arch/arm/mach-tegra/include/mach/sdhci.h |   28 ++++
>  drivers/mmc/host/Kconfig                 |   10 ++
>  drivers/mmc/host/Makefile                |    1 +
>  drivers/mmc/host/sdhci-pltfm.c           |    3 +
>  drivers/mmc/host/sdhci-pltfm.h           |    1 +
>  drivers/mmc/host/sdhci-tegra.c           |  219 ++++++++++++++++++++++++++++++
>  6 files changed, 262 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/include/mach/sdhci.h
>  create mode 100644 drivers/mmc/host/sdhci-tegra.c
> 

[ snip ]

> +	if (gpio_is_valid(plat->wp_gpio)) {
> +		rc = gpio_request(plat->wp_gpio, "sdhci_wp");
> +		if (rc) {
> +			dev_err(mmc_dev(host->mmc), 
> +				"failed to allocate wp gpio\n");
> +			goto out_cd;
> +		}
> +		tegra_gpio_enable(plat->wp_gpio);

gpio_direction_input?

> +	}
> +
> +	clk = clk_get(mmc_dev(host->mmc), NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(mmc_dev(host->mmc), "clk err\n");
> +		rc = PTR_ERR(clk);
> +		goto out_wp;
> +	}
> +	clk_enable(clk);
> +	pltfm_host->clk = clk;
> +
> +	return 0;
> +
> +out_wp:
> +	if (gpio_is_valid(plat->wp_gpio)) {
> +		tegra_gpio_disable(plat->wp_gpio);
> +		gpio_free(plat->wp_gpio);
> +	}
> +
> +out_cd:
> +	if (gpio_is_valid(plat->cd_gpio)) {
> +		tegra_gpio_disable(plat->cd_gpio);
> +		gpio_free(plat->cd_gpio);
> +	}
> +
> +out_power:
> +	if (gpio_is_valid(plat->power_gpio)) {
> +		tegra_gpio_disable(plat->power_gpio);
> +		gpio_free(plat->power_gpio);
> +	}
> +
> +out:
> +	return rc;
> +}
> +
> +static void tegra_sdhci_pltfm_exit(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +	struct tegra_sdhci_platform_data *plat;
> +
> +	plat = pdev->dev.platform_data;
> +
> +	if (gpio_is_valid(plat->wp_gpio)) {
> +		tegra_gpio_disable(plat->wp_gpio);
> +		gpio_free(plat->wp_gpio);
> +	}
> +
> +	if (gpio_is_valid(plat->cd_gpio)) {
> +		tegra_gpio_disable(plat->cd_gpio);
> +		gpio_free(plat->cd_gpio);
> +	}
> +
> +	if (gpio_is_valid(plat->power_gpio)) {
> +		tegra_gpio_disable(plat->power_gpio);
> +		gpio_free(plat->power_gpio);
> +	}
> +
> +	clk_disable(pltfm_host->clk);
> +	clk_put(pltfm_host->clk);
> +}
> +
> +static struct sdhci_ops tegra_sdhci_ops = {
> +	.get_ro     = tegra_sdhci_get_ro,
> +	.read_l     = tegra_sdhci_readl,
> +	.read_w     = tegra_sdhci_readw,
> +	.write_l    = tegra_sdhci_writel,
> +};
> +
> +struct sdhci_pltfm_data sdhci_tegra_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_NO_HISPD_BIT |
> +		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
> +	.ops  = &tegra_sdhci_ops,
> +	.init = tegra_sdhci_pltfm_init,
> +	.exit = tegra_sdhci_pltfm_exit,
> +};


-- 
Sincerely yours,
Mike.
