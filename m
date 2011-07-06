From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-esdhc-imx: add device tree probe
 support
Date: Wed, 6 Jul 2011 15:05:18 -0600
Message-ID: <20110706210518.GD5371@ponder.secretlab.ca>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <1309970870-13336-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62917 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab1GFVFV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 17:05:21 -0400
Received: by pzk9 with SMTP id 9so285990pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 14:05:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309970870-13336-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>

On Thu, Jul 07, 2011 at 12:47:50AM +0800, Shawn Guo wrote:
> The patch adds device tree probe support for sdhci-esdhc-imx driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   34 +++++++++
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |   77 +++++++++++++++++---
>  2 files changed, 102 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> new file mode 100644
> index 0000000..ab22fe6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -0,0 +1,34 @@
> +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> +
> +The Enhanced Secure Digital Host Controller on Freescale i.MX family
> +provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-esdhc"
> +- reg : Should contain eSDHC registers location and length
> +- interrupts : Should contain eSDHC interrupt
> +
> +Optional properties:
> +- fsl,card-wired : Indicate the card is wired to host permanently
> +- fsl,cd-internal : Indicate to use controller internal card detection
> +- fsl,wp-internal : Indicate to use controller internal write protection
> +- cd-gpios : Specify GPIOs for card detection
> +- wp-gpios : Specify GPIOs for write protection
> +
> +Examples:
> +
> +esdhc@70004000 {
> +	compatible = "fsl,imx51-esdhc";
> +	reg = <0x70004000 0x4000>;
> +	interrupts = <1>;
> +	fsl,cd-internal;
> +	fsl,wp-internal;
> +};
> +
> +esdhc@70008000 {
> +	compatible = "fsl,imx51-esdhc";
> +	reg = <0x70008000 0x4000>;
> +	interrupts = <2>;
> +	cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
> +	wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
> +};
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f3efb3b..cbdd91f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -20,6 +20,9 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sdio.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <mach/esdhc.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -73,6 +76,14 @@ static struct platform_device_id imx_esdhc_devtype[] = {
>  	}
>  };
>  
> +static const struct of_device_id imx_esdhc_dt_ids[] = {
> +	{ .compatible = "fsl,imx25-esdhc", .data = &imx_esdhc_devtype[IMX25_ESDHC], },
> +	{ .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
> +	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
> +	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
> +	{ /* sentinel */ }
> +};
> +
>  static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
>  {
>  	return data->devtype == IMX25_ESDHC;
> @@ -307,8 +318,48 @@ static irqreturn_t cd_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  };
>  
> +#ifdef CONFIG_OF
> +static int __devinit
> +sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> +			 struct esdhc_platform_data *boarddata)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	if (of_get_property(np, "fsl,card-wired", NULL))
> +		boarddata->cd_type = ESDHC_CD_PERMANENT;
> +
> +	if (of_get_property(np, "fsl,cd-controller", NULL))
> +		boarddata->cd_type = ESDHC_CD_CONTROLLER;
> +
> +	if (of_get_property(np, "fsl,wp-controller", NULL))
> +		boarddata->wp_type = ESDHC_WP_CONTROLLER;
> +
> +	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
> +	if (gpio_is_valid(boarddata->cd_gpio))
> +		boarddata->cd_type = ESDHC_CD_GPIO;
> +
> +	boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
> +	if (gpio_is_valid(boarddata->wp_gpio))
> +		boarddata->wp_type = ESDHC_WP_GPIO;
> +
> +	return 0;
> +}
> +#else
> +static inline int
> +sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> +			 struct esdhc_platform_data *boarddata)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id =
> +			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct esdhc_platform_data *boarddata;
> @@ -323,9 +374,13 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  
>  	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
> -	if (!imx_data)
> -		return -ENOMEM;
> +	if (!imx_data) {
> +		err = -ENOMEM;
> +		goto err_imx_data;
> +	}
>  
> +	if (of_id)
> +		pdev->id_entry = of_id->data;
>  	imx_data->devtype = pdev->id_entry->driver_data;
>  	pltfm_host->priv = imx_data;
>  
> @@ -344,14 +399,16 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (is_imx53_esdhc(imx_data))
>  		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
>  
> -	if (!host->mmc->parent->platform_data) {
> -		dev_err(mmc_dev(host->mmc), "no board data!\n");
> -		err = -EINVAL;
> -		goto no_board_data;
> -	}
> -	imx_data->boarddata = *((struct esdhc_platform_data *)
> -				host->mmc->parent->platform_data);
>  	boarddata = &imx_data->boarddata;
> +	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
> +		if (!host->mmc->parent->platform_data) {
> +			dev_err(mmc_dev(host->mmc), "no board data!\n");
> +			err = -EINVAL;
> +			goto no_board_data;
> +		}
> +		imx_data->boarddata = *((struct esdhc_platform_data *)
> +					host->mmc->parent->platform_data);
> +	}
>  
>  	/* write_protect */
>  	if (boarddata->wp_type == ESDHC_WP_GPIO) {
> @@ -420,6 +477,7 @@ no_board_data:
>  	clk_put(pltfm_host->clk);
>  err_clk_get:
>  	kfree(imx_data);
> +err_imx_data:
>  	sdhci_pltfm_free(pdev);
>  	return err;
>  }
> @@ -455,6 +513,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>  	.driver		= {
>  		.name	= "sdhci-esdhc-imx",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = imx_esdhc_dt_ids,
>  	},
>  	.id_table	= imx_esdhc_devtype,
>  	.probe		= sdhci_esdhc_imx_probe,
> -- 
> 1.7.4.1
> 
> 
