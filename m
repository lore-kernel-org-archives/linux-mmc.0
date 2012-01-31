From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Tue, 31 Jan 2012 13:08:17 -0700
Message-ID: <20120131200817.GB22611@ponder.secretlab.ca>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45563 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab2AaUIZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 15:08:25 -0500
Content-Disposition: inline
In-Reply-To: <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

On Tue, Jan 31, 2012 at 11:26:16PM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's sdhci controller
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   70 +++++++++
>  drivers/mmc/host/sdhci-s3c.c                       |  148 +++++++++++++++++++-
>  2 files changed, 212 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt

Looks okay to me on brief review.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> new file mode 100644
> index 0000000..8cbdd29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> @@ -0,0 +1,70 @@
> +* Samsung's SDHCI Controller device tree bindings
> +
> +Samsung's SDHCI controller is used as a connectivity interface with external
> +MMC, SD and eMMC storage mediums.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> +  - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
> +    controller.
> +  - "samsung,exynos4210-sdhci": For controller compatible with Exynos4 sdhci
> +    controller.
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +  depends on the interrupt controller.
> +
> +
> +Required Board Specific Properties:
> +- gpios: Should specify the gpios used for clock, command and data lines. The
> +  gpio specifier format depends on the gpio controller. Note: There is no
> +  particular order in which the gpio's have to be listed.
> +
> +
> +Optional Board Specific Properties:
> +- samsung,sdhci-bus-width: Number of data lines connected to the controller.
> +  Note: This excludes the clock,command and card detect lines. If this property
> +  is not specified, default value is 1.
> +
> +- samsung,cd-gpio-invert: If 'samsung,sdhci-cd-gpio' card detect method is
> +  selected, this property can be optionally specified to invert the value of
> +  external card detect gpio line.
> +
> +- One of the following properties for card detect type.
> +  - samsung,sdhci-cd-internal: Card detect line from the card slot  is
> +    connected to the card detect pad of the sdhci controller. A gpio is
> +    used for this connection (with possible pin function settings).
> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
> +    is used a card detect line. This gpio line is not connected to card detect
> +    pad of the sdhci controller.
> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
> +    detect the presence of the card. (DEFAULT, if no card detect property
> +    is specified).
> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
> +    permanently connected to the sdhci controller.
> +
> +- gpio-cd: The gpio to be used as card detect line for
> +  'samsung,sdhci-cd-internal' or 'samsung,sdhci-cd-gpio' card detection method.
> +  The gpio specifier format depends on the gpio controller.
> +
> +Example:
> +	sdhci@12530000 {
> +		compatible = "samsung,exynos4210-sdhci";
> +		reg = <0x12530000 0x100>;
> +		interrupts = <139>;
> +		samsung,sdhci-bus-width = <4>;
> +		samsung,sdhci-cd-internal;
> +		gpio-cd = <&gpk2 2 2 3 3>;
> +		gpios = <&gpk2 0 2 0 3>,  /* clock line */
> +			<&gpk2 1 2 0 3>,  /* command line */
> +			<&gpk2 3 2 3 3>,  /* data line 0 */
> +			<&gpk2 4 2 3 3>,  /* data line 1 */
> +			<&gpk2 5 2 3 3>,  /* data line 2 */
> +			<&gpk2 6 2 3 3>;  /* data line 3 */
> +	};
> +
> +	Note: This example shows both SoC specific and board specific properties
> +	in a single device node. The properties can be actually be seperated
> +	into SoC specific node and board specific node.
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 1760ba8..6159542 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -20,6 +20,8 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <linux/mmc/host.h>
>  
> @@ -29,6 +31,8 @@
>  #include "sdhci.h"
>  
>  #define MAX_BUS_CLK	(4)
> +/* Number of gpio's used is max data bus width + command and clock lines */
> +#define NUM_GPIOS(x)	(x + 2)
>  
>  /**
>   * struct sdhci_s3c - S3C SDHCI instance
> @@ -37,6 +41,7 @@
>   * @ioarea: The resource created when we claimed the IO area.
>   * @pdata: The platform data for this controller.
>   * @cur_clk: The index of the current bus clock.
> + * @gpios: List of gpio numbers parsed from device tree.
>   * @clk_io: The clock for the internal bus interface.
>   * @clk_bus: The clocks that are available for the SD/MMC bus clock.
>   */
> @@ -48,6 +53,7 @@ struct sdhci_s3c {
>  	unsigned int		cur_clk;
>  	int			ext_cd_irq;
>  	int			ext_cd_gpio;
> +	int			*gpios;
>  
>  	struct clk		*clk_io;
>  	struct clk		*clk_bus[MAX_BUS_CLK];
> @@ -415,9 +421,110 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
>  	}
>  }
>  
> +#ifdef CONFIG_OF
> +static int __devinit sdhci_s3c_parse_dt(struct device *dev,
> +		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
> +{
> +	struct device_node *node = dev->of_node;
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	u32 max_width;
> +	int gpio, cnt, ret;
> +
> +	/* if the bus-width property is not specified, assume width as 1 */
> +	if (of_property_read_u32(node, "samsung,sdhci-bus-width",
> +				&max_width))
> +		max_width = 1;
> +	pdata->max_width = max_width;
> +
> +	ourhost->gpios = devm_kzalloc(dev, NUM_GPIOS(pdata->max_width) *
> +				sizeof(int), GFP_KERNEL);
> +	if (!ourhost->gpios)
> +		return -ENOMEM;
> +
> +	/* get the card detection method */
> +	if (of_get_property(node, "samsung,sdhci-cd-internal", NULL))
> +		pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
> +	else if (of_get_property(node, "samsung,sdhci-cd-gpio", NULL))
> +		pdata->cd_type = S3C_SDHCI_CD_GPIO;
> +	else if (of_get_property(node, "samsung,sdhci-cd-none", NULL))
> +		pdata->cd_type = S3C_SDHCI_CD_NONE;
> +	else if (of_get_property(node, "samsung,sdhci-cd-permanent", NULL))
> +		pdata->cd_type = S3C_SDHCI_CD_PERMANENT;
> +	else
> +		pdata->cd_type = S3C_SDHCI_CD_NONE;
> +
> +	/* get the gpio used for card detection */
> +	if (pdata->cd_type == S3C_SDHCI_CD_GPIO ||
> +			pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		gpio = of_get_named_gpio(node, "gpio-cd", 0);
> +		if (!gpio_is_valid(gpio)) {
> +			dev_err(dev, "invalid card detect gpio specified\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (pdata->cd_type == S3C_SDHCI_CD_GPIO) {
> +		pdata->ext_cd_gpio = gpio;
> +		ourhost->ext_cd_gpio = -1; /* invalid gpio number */
> +		if (of_get_property(node, "samsung,cd-gpio-invert", NULL))
> +			pdata->ext_cd_gpio_invert = 1;
> +	} else if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		ret = gpio_request(gpio, "sdhci-cd");
> +		if (ret) {
> +			dev_err(dev, "card detect gpio request failed\n");
> +			return -EINVAL;
> +		}
> +		ourhost->ext_cd_gpio = gpio;
> +	}
> +
> +	/* get the gpios for command, clock and data lines */
> +	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
> +		gpio = of_get_gpio(node, cnt);
> +		if (!gpio_is_valid(gpio)) {
> +			dev_err(dev, "invalid gpio[%d]\n", cnt);
> +			goto err_free_dt_cd_gpio;
> +		}
> +		ourhost->gpios[cnt] = gpio;
> +	}
> +
> +	for (cnt = 0; cnt < NUM_GPIOS(pdata->max_width); cnt++) {
> +		ret = gpio_request(ourhost->gpios[cnt], "sdhci-gpio");
> +		if (ret) {
> +			dev_err(dev, "gpio[%d] request failed\n", cnt);
> +			goto err_free_dt_gpios;
> +		}
> +	}
> +
> +	return 0;
> +
> + err_free_dt_gpios:
> +	while (--cnt >= 0)
> +		gpio_free(ourhost->gpios[cnt]);
> + err_free_dt_cd_gpio:
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
> +		gpio_free(ourhost->ext_cd_gpio);
> +	return -EINVAL;
> +}
> +#else
> +static int __devinit sdhci_s3c_parse_dt(struct device *dev,
> +		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static const struct of_device_id sdhci_s3c_dt_match[];
> +
>  static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>  			struct platform_device *pdev)
>  {
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
> +		return (struct sdhci_s3c_drv_data *)match->data;
> +	}
> +#endif
>  	return (struct sdhci_s3c_drv_data *)
>  			platform_get_device_id(pdev)->driver_data;
>  }
> @@ -432,7 +539,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret, irq, ptr, clks;
>  
> -	if (!pdev->dev.platform_data) {
> +	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
>  		dev_err(dev, "no device data specified\n");
>  		return -ENOENT;
>  	}
> @@ -454,21 +561,28 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  		dev_err(dev, "sdhci_alloc_host() failed\n");
>  		return PTR_ERR(host);
>  	}
> +	sc = sdhci_priv(host);
>  
>  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
>  		ret = -ENOMEM;
> -		goto err_io_clk;
> +		goto err_pdata;
> +	}
> +
> +	if (pdev->dev.of_node) {
> +		ret = sdhci_s3c_parse_dt(&pdev->dev, host, pdata);
> +		if (ret)
> +			goto err_pdata;
> +	} else {
> +		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +		sc->ext_cd_gpio = -1; /* invalid gpio number */
>  	}
> -	memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
>  
>  	drv_data = sdhci_s3c_get_driver_data(pdev);
> -	sc = sdhci_priv(host);
>  
>  	sc->host = host;
>  	sc->pdev = pdev;
>  	sc->pdata = pdata;
> -	sc->ext_cd_gpio = -1; /* invalid gpio number */
>  
>  	platform_set_drvdata(pdev, host);
>  
> @@ -637,6 +751,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	clk_put(sc->clk_io);
>  
>   err_io_clk:
> +	for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
> +		gpio_free(sc->gpios[ptr]);
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
> +		gpio_free(sc->ext_cd_gpio);
> +
> + err_pdata:
>  	sdhci_free_host(host);
>  
>  	return ret;
> @@ -644,9 +764,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  {
> -	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
>  	struct sdhci_host *host =  platform_get_drvdata(pdev);
>  	struct sdhci_s3c *sc = sdhci_priv(host);
> +	struct s3c_sdhci_platdata *pdata = sc->pdata;
>  	int ptr;
>  
>  	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
> @@ -673,6 +793,11 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  	release_resource(sc->ioarea);
>  	kfree(sc->ioarea);
>  
> +	if (pdev->dev.of_node) {
> +		for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
> +			gpio_free(sc->gpios[ptr]);
> +	}
> +
>  	sdhci_free_host(host);
>  	platform_set_drvdata(pdev, NULL);
>  
> @@ -727,6 +852,16 @@ static struct platform_device_id sdhci_s3c_driver_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id sdhci_s3c_dt_match[] = {
> +	{ .compatible = "samsung,s3c6410-sdhci", },
> +	{ .compatible = "samsung,exynos4210-sdhci",
> +		.data = &exynos4_sdhci_drv_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> +#endif
> +
>  static struct platform_driver sdhci_s3c_driver = {
>  	.probe		= sdhci_s3c_probe,
>  	.remove		= __devexit_p(sdhci_s3c_remove),
> @@ -734,6 +869,7 @@ static struct platform_driver sdhci_s3c_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",
> +		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
>  		.pm	= SDHCI_S3C_PMOPS,
>  	},
>  };
> -- 
> 1.6.6.rc2
> 
