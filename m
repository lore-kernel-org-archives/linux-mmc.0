From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC
Date: Sat, 04 Jul 2015 22:06:49 +0200
Message-ID: <8304633.2ajieYmcMU@wuerfel>
References: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com> <1435933037-12889-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62755 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbbGEJkR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jul 2015 05:40:17 -0400
In-Reply-To: <1435933037-12889-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com

On Friday 03 July 2015 16:17:16 Ludovic Desroches wrote:
> Introduce driver for he Atmel SDMMC available on sama5d2. It is a sdhci
> compliant controller.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-atmel.txt        |  21 +++
>  drivers/mmc/host/Kconfig                           |   8 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-at91.c                   | 188 +++++++++++++++++++++
>  4 files changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-at91.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> new file mode 100644
> index 0000000..1b662d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -0,0 +1,21 @@
> +* Atmel SDHCI controller
> +
> +This file documents the differences between the core properties in
> +Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
> +sdhci-of-at91 driver.
> +
> +Required properties:
> +- compatible:		Must be "atmel,sama5d2-sdhci".
> +- clocks:		Phandlers to the clocks.
> +- clock-names:		Must be "hclock", "multclk", "baseclk";
> +

Are you sure that these are all new clocks that are unrelated to the "core",
"mmc", and "iface" clocks that are used in other drivers?

> +
> +	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
> +	if (IS_ERR(priv->mainck)) {
> +		dev_err(&pdev->dev, "failed to get baseclk\n");
> +		return PTR_ERR(priv->mainck);
> +	}
> +
> +	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
> +	if (IS_ERR(priv->hclock)) {
> +		dev_err(&pdev->dev, "failed to get hclock\n");
> +		return PTR_ERR(priv->hclock);
> +	}
> +
> +	priv->gck = devm_clk_get(&pdev->dev, "multclk");
> +	if (IS_ERR(priv->gck)) {
> +		dev_err(&pdev->dev, "failed to get multclk\n");
> +		return PTR_ERR(priv->gck);
> +	}
> +
> +	host = sdhci_pltfm_init(pdev, soc_data, 0);
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/*
> +	 * The mult clock is provided by as a generated clock by the PMC
> +	 * controller. In order to set the rate of gck, we have to get the
> +	 * base clock rate and the clock mult from capabilities.
> +	 */
> +	clk_prepare_enable(priv->hclock);
> +	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
> +	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> +	clk_base = (caps0 & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
> +	clk_mul = (caps1 & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;
> +	gck_rate = clk_base * 1000000 * (clk_mul + 1);
> +	ret = clk_set_rate(priv->gck, gck_rate);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to set gck");
> +		goto hclock_disable_unprepare;
> +		return -EINVAL;
> +	}

Could this be shared with other drivers?

	Arnd
