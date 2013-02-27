From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 3/5] mmc: davinci_mmc: add DT support
Date: Wed, 27 Feb 2013 17:13:43 +0530
Message-ID: <512DF16F.50702@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com> <1360909322-1858-4-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1360909322-1858-4-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, mporter@ti.com
List-Id: linux-mmc@vger.kernel.org

On 2/15/2013 11:52 AM, Manjunathappa, Prakash wrote:
> Adds device tree support for davinci_mmc. Also add binding documentation.
> As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> option because of dependencies on EDMA and GPIO module DT support.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: cjb@laptop.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: mporter@ti.com

> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 874dc60..6b08b9a 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -34,6 +34,8 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/edma.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/platform_data/mmc-davinci.h>
>  
> @@ -1156,6 +1158,7 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
>  
>  	mmc_davinci_reset_ctrl(host, 0);
>  }
> +

Stray line addition.

>  static struct platform_device_id davinci_mmc_devtype[] = {
>  	{
>  		.name	= "davinci-mmc-dm355",
> @@ -1168,9 +1171,63 @@ static struct platform_device_id davinci_mmc_devtype[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);
>  
> -static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> +static const struct of_device_id davinci_mmc_dt_ids[] = {
> +	{
> +		.compatible = "ti,davinci-mmc-dm355",
> +		.data = &davinci_mmc_devtype[MMC_CTLR_VERSION_1],
> +	},
> +	{
> +		.compatible = "ti,davinci-mmc-da830",
> +		.data = &davinci_mmc_devtype[MMC_CTLR_VERSION_2],
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, davinci_mmc_dt_ids);
> +
> +static struct davinci_mmc_config
> +	*mmc_parse_pdata(struct platform_device *pdev)
>  {
> +	struct device_node *np;
>  	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
> +	const struct of_device_id *match =
> +		of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
> +	u32 data;
> +
> +	np = pdev->dev.of_node;
> +	if (!np)
> +		return pdata;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
> +		goto nodata;

devm_kzalloc() returns NULL on error so you will end up returning
success in this case.

> +	}
> +
> +	if (match)
> +		pdev->id_entry = match->data;
> +
> +	of_property_read_u32(np, "max-frequency", &pdata->max_freq);
> +	if (!pdata->max_freq)
> +		dev_info(&pdev->dev, "'max-frequency' property not specified, defaulting to 25MHz\n");


of_property_read_u32() returns error on failure. pdata->max_freq is not
guaranteed to be zero in case of error. See comments atop
of_property_read_u32_array().

> +
> +	of_property_read_u32(np, "bus-width", &data);
> +	switch (data) {
> +	case 1:
> +	case 4:
> +	case 8:
> +		pdata->wires = data;
> +		break;
> +	default:
> +		pdata->wires = 1;
> +		dev_info(&pdev->dev, "Unsupported buswidth, defaulting to 1 bit\n");
> +	}
> +nodata:
> +	return pdata;
> +}
> +

Thanks,
Sekhar
