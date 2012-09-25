From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 15:15:08 +0800
Message-ID: <20120925071505.GG27291@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63598 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab2IYHO4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:14:56 -0400
Received: by pbbrr4 with SMTP id rr4so8577783pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 00:14:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Mon, Sep 24, 2012 at 09:22:25AM +0200, Sascha Hauer wrote:
> The i.MX esdhc has a nonstandard bit layout for the SDHCI_HOST_CONTROL
> register. To support 8bit bus width on i.MX populate the platform_bus_width
> callback. This is tested on an i.MX25, but should according to the datasheets
> work on the other i.MX using this hardware aswell. The i.MX6, while having
> a SDHCI_SPEC_300 controller, still uses the same nonstandard register layout.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
>  arch/arm/plat-mxc/include/mach/esdhc.h             |    1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |   56 ++++++++++++++++++--
>  3 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 1dd6225..c989994 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -12,6 +12,7 @@ Required properties:
>  Optional properties:
>  - fsl,cd-controller : Indicate to use controller internal card detection
>  - fsl,wp-controller : Indicate to use controller internal write protection
> +- bus-width : Maximum supported bus width. Defaults to 4 if omitted
>
This is a common mmc property documented in bindings/mmc/mmc.txt.
Instead of duplicating the documentation, we should try to make our
implementation conform to the common definition of the property.

>  Examples:
>  
> diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
> index aaf9748..b4a0521 100644
> --- a/arch/arm/plat-mxc/include/mach/esdhc.h
> +++ b/arch/arm/plat-mxc/include/mach/esdhc.h
> @@ -39,5 +39,6 @@ struct esdhc_platform_data {
>  	unsigned int cd_gpio;
>  	enum wp_types wp_type;
>  	enum cd_types cd_type;
> +	int max_bus_width;
>  };
>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 4fe7312..b205fe9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -57,6 +57,13 @@
>   */
>  #define ESDHC_FLAG_MULTIBLK_NO_INT	(1 << 1)
>  
> +/*
> + * Freescale interpretation of the SDHCI_HOST_CONTROL register
> + */
#define FSL_SDHCI_CTRL_1BITBUS			(0x0 << 1)
...

> +#define FSL_SDHCI_CTRL_4BITBUS			(0x1 << 1)
> +#define FSL_SDHCI_CTRL_8BITBUS			(0x2 << 1)
> +#define FSL_SDHCI_CTRL_BUSWIDTH_MASK		(0x3 << 1)
> +
>  enum imx_esdhc_type {
>  	IMX25_ESDHC,
>  	IMX35_ESDHC,
> @@ -307,6 +314,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  	u32 new_val;
> +	u32 mask;
>  
>  	switch (reg) {
>  	case SDHCI_POWER_CONTROL:
> @@ -318,7 +326,6 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  	case SDHCI_HOST_CONTROL:
>  		/* FSL messed up here, so we can just keep those three */
>  		new_val = val & (SDHCI_CTRL_LED | \
> -				SDHCI_CTRL_4BITBUS | \
>  				SDHCI_CTRL_D3CD);
>  		/* ensure the endianess */
>  		new_val |= ESDHC_HOST_CONTROL_LE;
> @@ -328,7 +335,13 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
>  		}
>  
> -		esdhc_clrset_le(host, 0xffff, new_val, reg);
> +		/*
> +		 * Do not touch buswidth bits here. This is done in
> +		 * esdhc_pltfm_buswidth.
> +		 */
> +		mask = 0xffff & ~FSL_SDHCI_CTRL_BUSWIDTH_MASK;
> +
> +		esdhc_clrset_le(host, mask, new_val, reg);
>  		return;
>  	}
>  	esdhc_clrset_le(host, 0xff, val, reg);
> @@ -379,6 +392,27 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
>  	return -ENOSYS;
>  }
>  
> +static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
> +{
> +	u32 ctrl;
> +
> +	switch (width) {
> +	case MMC_BUS_WIDTH_8:
> +		ctrl = FSL_SDHCI_CTRL_8BITBUS;
> +		break;
> +	case MMC_BUS_WIDTH_4:
> +		ctrl = FSL_SDHCI_CTRL_4BITBUS;
> +		break;
> +	default:
> +		ctrl = 0;

... 
		ctrl = FSL_SDHCI_CTRL_1BITBUS;

Any better?

> +		break;
> +	}
> +
> +	esdhc_clrset_le(host, FSL_SDHCI_CTRL_BUSWIDTH_MASK, ctrl, SDHCI_HOST_CONTROL);
> +
> +	return 0;
> +}
> +
>  static struct sdhci_ops sdhci_esdhc_ops = {
>  	.read_l = esdhc_readl_le,
>  	.read_w = esdhc_readw_le,
> @@ -389,6 +423,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.get_max_clock = esdhc_pltfm_get_max_clock,
>  	.get_min_clock = esdhc_pltfm_get_min_clock,
>  	.get_ro = esdhc_pltfm_get_ro,
> +	.platform_bus_width = esdhc_pltfm_bus_width,
>  };
>  
>  static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> @@ -434,6 +469,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (gpio_is_valid(boarddata->wp_gpio))
>  		boarddata->wp_type = ESDHC_WP_GPIO;
>  
> +	of_property_read_u32(np, "bus-width", &boarddata->max_bus_width);
> +
>  	return 0;
>  }
>  #else
> @@ -507,7 +544,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> -			| SDHCI_QUIRK_BROKEN_ADMA;
> +			 | SDHCI_QUIRK_BROKEN_ADMA;
>  

Why this change?

Shawn

>  	if (is_imx53_esdhc(imx_data))
>  		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
> @@ -577,6 +614,19 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> +	switch (boarddata->max_bus_width) {
> +	case 8:
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
> +		break;
> +	case 4:
> +	default:
> +		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		break;
> +	case 1:
> +		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> +		break;
> +	}
> +
>  	err = sdhci_add_host(host);
>  	if (err)
>  		goto err_add_host;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
