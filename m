From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] mmc: sdhci-esdhc-imx: add device tree probe support
Date: Mon, 4 Jul 2011 00:25:48 -0600
Message-ID: <20110704062548.GI15152@ponder.secretlab.ca>
References: <1309681851-23052-1-git-send-email-shawn.guo@linaro.org>
 <1309681851-23052-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61214 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab1GDGZv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 02:25:51 -0400
Received: by pzk9 with SMTP id 9so1415041pzk.19
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2011 23:25:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309681851-23052-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>

On Sun, Jul 03, 2011 at 04:30:51PM +0800, Shawn Guo wrote:
> The patch adds device tree probe support for sdhci-esdhc-imx driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   40 ++++++++
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |   99 +++++++++++++++++++-
>  2 files changed, 134 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> new file mode 100644
> index 0000000..e182e7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -0,0 +1,40 @@
> +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> +
> +The Enhanced Secure Digital Host Controller on Freescale i.MX family
> +provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-esdhc"
> +- reg : Should contain eSDHC registers location and length
> +- interrupts : Should contain eSDHC interrupt
> +- cd-type : String, card detection (CD) method.  Supported values are:

Similar to previous comments, use the "fsl," prefix to this property name.

> +    "none" : No CD
> +    "controller" : Uses eSDHC controller internal CD signal
> +    "gpio" : Uses GPIO pin for CD

I would say the presence of a "cd-gpios" property would implicitly
mean gpio is to be used for the CD pin.

> +    "permanent" : No CD because card is permanently wired to host
> +- wp-type : String, write protection (WP) method.  Supported values are:
> +    "none" : No WP
> +    "controller" : Uses eSDHC controller internal WP signal 
> +    "gpio" : Uses GPIO pin for WP

Ditto comments here.

> +- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, if
> +  properties cd-type and wp-type are "gpio".

The gpios binding has been extended to allow named gpios now.  You can
uses something like "cd-gpios" and "wp-gpios".

> +
> +Examples:
> +
> +esdhc@70004000 {
> +	compatible = "fsl,imx51-esdhc";
> +	reg = <0x70004000 0x4000>;
> +	interrupts = <1>;
> +	cd-type = "controller";
> +	wp-type = "controller";
> +};
> +
> +esdhc@70008000 {
> +	compatible = "fsl,imx51-esdhc";
> +	reg = <0x70008000 0x4000>;
> +	interrupts = <2>;
> +	cd-type = "gpio";
> +	wp-type = "gpio";
> +	gpios = <&gpio0 6 0>, /* CD, GPIO1_6 */
> +		<&gpio0 5 0>; /* WP, GPIO1_5 */
> +};
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 705d670..57793e3 100644
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
> @@ -78,6 +81,14 @@ static struct platform_device_id imx_esdhc_devtype[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
>  
> +static const struct of_device_id imx_esdhc_dt_ids[] = {
> +	{ .compatible = "fsl,imx25-esdhc", .data = &imx_esdhc_devtype[IMX25_ESDHC], },
> +	{ .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
> +	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
> +	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
> +	{ /* sentinel */ },
> +};
> +
>  static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
>  {
>  	/* Force 2048 bytes, which is the maximum supported size in SDHCI. */
> @@ -290,24 +301,93 @@ static irqreturn_t cd_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  };
>  
> +#ifdef CONFIG_OF
> +static int __devinit sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =
> +			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	struct esdhc_platform_data *boarddata;
> +	int err, i;
> +	const char *cd, *cd_types[] = {
> +		[ESDHC_CD_NONE]		= "none",
> +		[ESDHC_CD_CONTROLLER]	= "controller",
> +		[ESDHC_CD_GPIO]		= "gpio",
> +		[ESDHC_CD_PERMANENT]	= "permanent",
> +	};
> +	const char *wp, *wp_types[] = {
> +		[ESDHC_WP_NONE]		= "none",
> +		[ESDHC_WP_CONTROLLER]	= "controller",
> +		[ESDHC_WP_GPIO]		= "gpio",
> +	};
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	boarddata = kzalloc(sizeof(*boarddata), GFP_KERNEL);
> +	if (!boarddata)
> +		return -ENOMEM;
> +	pdev->dev.platform_data = boarddata;
> +
> +	err = of_property_read_string(np, "cd-type", &cd);
> +	if (err)
> +		return err;
> +	for (i = 0; i < ARRAY_SIZE(cd_types); i++)
> +		if (!strcasecmp(cd, cd_types[i])) {
> +			boarddata->cd_type = i;
> +			break;
> +		}
> +
> +	err = of_property_read_string(np, "wp-type", &wp);
> +	if (err)
> +		return err;
> +	for (i = 0; i < ARRAY_SIZE(wp_types); i++)
> +		if (!strcasecmp(wp, wp_types[i])) {
> +			boarddata->wp_type = i;
> +			break;
> +		}
> +
> +	boarddata->cd_gpio = of_get_gpio(np, 0);
> +	boarddata->wp_gpio = of_get_gpio(np, 1);
> +
> +	pdev->id_entry = (struct platform_device_id *) of_id->data;
> +
> +	return 0;
> +}
> +#else
> +static inline int sdhci_esdhc_imx_probe_dt(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> -	struct esdhc_platform_data *boarddata;
> +	struct esdhc_platform_data *boarddata = NULL;
>  	struct clk *clk;
>  	int err;
>  	struct pltfm_imx_data *imx_data;
>  
> +	err = sdhci_esdhc_imx_probe_dt(pdev);
> +	if (err)
> +		return err;
> +
>  	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
> -	if (IS_ERR(host))
> -		return PTR_ERR(host);
> +	if (IS_ERR(host)) {
> +		err = PTR_ERR(host);
> +		goto err_sdhci_pltfm;
> +	}
>  
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
>  	imx_data->devtype = pdev->id_entry->driver_data;
>  	pltfm_host->priv = imx_data;
> @@ -401,12 +481,17 @@ no_board_data:
>  	clk_put(pltfm_host->clk);
>  err_clk_get:
>  	kfree(imx_data);
> +err_imx_data:
>  	sdhci_pltfm_free(pdev);
> +err_sdhci_pltfm:
> +	if (np)
> +		kfree(boarddata);
>  	return err;
>  }
>  
>  static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
> @@ -429,6 +514,9 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  
>  	sdhci_pltfm_free(pdev);
>  
> +	if (np)
> +		kfree(boarddata);
> +
>  	return 0;
>  }
>  
> @@ -436,6 +524,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
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
