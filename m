From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/10] mmc: mxs-mmc: add device tree support
Date: Tue, 8 May 2012 01:58:07 +0200
Message-ID: <201205080158.07259.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org> <1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42758 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab2EGX6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 19:58:37 -0400
In-Reply-To: <1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

Dear Shawn Guo,

> It adds device tree probe support for mxs-mmc driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |   26 +++++++++++
>  drivers/mmc/host/mxs-mmc.c                        |   48
> ++++++++++++++++++-- 2 files changed, 69 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt new file mode 100644
> index 0000000..d7c2a40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
> @@ -0,0 +1,26 @@
> +* Freescale MXS MMC controller
> +
> +The Freescale MXS Synchronous Serial Ports (SSP) can act as a MMC
> controller +to support MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible: Should be "fsl,<chip>-mmc".  The supported chips include
> +  imx23 and imx28.
> +- reg: Should contain registers location and length
> +- interrupts: Should contain ERROR and DMA interrupts
> +- fsl,ssp-dma-channel: APBH DMA channel for the SSP
> +- fsl,bus-width: Number of data lines, can be <1>, <4>, or <8>
> +
> +Optional properties:
> +- wp-gpios: Specify GPIOs for write protection

You can have multiple wp-gpio per port? :-)

> +
> +Examples:
> +
> +ssp0: ssp@80010000 {
> +	compatible = "fsl,imx28-mmc";
> +	reg = <0x80010000 2000>;
> +	interrupts = <96 82>;
> +	fsl,ssp-dma-channel = <0>;
> +	fsl,bus-width = <8>;
> +	status = "okay";
> +};
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 66f792a..c6b56b4 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -23,6 +23,9 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> @@ -685,8 +688,18 @@ static struct platform_device_id mxs_mmc_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, mxs_mmc_ids);
> 
> +static const struct of_device_id mxs_mmc_dt_ids[] = {
> +	{ .compatible = "fsl,imx23-mmc", .data = (void *) IMX23_MMC, },
> +	{ .compatible = "fsl,imx28-mmc", .data = (void *) IMX28_MMC, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
> +
>  static int mxs_mmc_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id =
> +			of_match_device(mxs_mmc_dt_ids, &pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mxs_mmc_host *host;
>  	struct mmc_host *mmc;
>  	struct resource *iores, *dmares;
> @@ -699,7 +712,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>  	irq_err = platform_get_irq(pdev, 0);
>  	irq_dma = platform_get_irq(pdev, 1);
> -	if (!iores || !dmares || irq_err < 0 || irq_dma < 0)
> +	if (!iores || irq_err < 0 || irq_dma < 0)
>  		return -EINVAL;
> 
>  	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
> @@ -713,15 +726,31 @@ static int mxs_mmc_probe(struct platform_device
> *pdev) goto out_mmc_free;
>  	}
> 
> -	host->devid = pdev->id_entry->driver_data;
> +	if (np) {
> +		host->devid = (enum mxs_mmc_id) of_id->data;
> +		/*
> +		 * TODO: This is a temporary solution and should be changed
> +		 * to use generic DMA binding later when the helplers get in.
> +		 */
> +		ret = of_property_read_u32(np, "fsl,ssp-dma-channel",
> +					   &host->dma_channel);
> +		if (ret) {
> +			dev_err(mmc_dev(host->mmc),
> +				"failed to get dma channel\n");
> +			goto out_mmc_free;
> +		}
> +	} else {
> +		host->devid = pdev->id_entry->driver_data;
> +		host->dma_channel = dmares->start;
> +	}
> +
>  	host->mmc = mmc;
> -	host->dma_channel = dmares->start;
>  	host->sdio_irq_en = 0;
> 
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>  	if (IS_ERR(pinctrl)) {
>  		ret = PTR_ERR(pinctrl);
> -		goto out_iounmap;
> +		goto out_mmc_free;
>  	}
> 
>  	host->clk = clk_get(&pdev->dev, NULL);
> @@ -749,7 +778,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
> 
>  	pdata =	mmc_dev(host->mmc)->platform_data;
> -	if (pdata) {
> +	if (!pdata) {
> +		u32 bus_width = 0;
> +		of_property_read_u32(np, "fsl,bus-width", &bus_width);
> +		if (bus_width == 4)
> +			mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		else if (bus_width == 8)
> +			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> +		host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
> +	} else {
>  		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>  			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>  		if (pdata->flags & SLOTF_4_BIT_CAPABLE)
> @@ -857,6 +894,7 @@ static struct platform_driver mxs_mmc_driver = {
>  		.owner	= THIS_MODULE,
>  #ifdef CONFIG_PM
>  		.pm	= &mxs_mmc_pm_ops,
> +		.of_match_table = mxs_mmc_dt_ids,
>  #endif
>  	},
>  };

Best regards,
Marek Vasut
