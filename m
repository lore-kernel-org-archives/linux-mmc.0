From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card
 detect
Date: Fri, 02 Mar 2012 11:40:03 +0530
Message-ID: <4F50643B.9050500@ti.com>
References: <20120301185044.29210.44521.stgit@kaulin.local> <20120301185535.29210.71546.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37915 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756754Ab2CBGKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 01:10:12 -0500
Received: by yhmm54 with SMTP id m54so793877yhm.5
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 22:10:10 -0800 (PST)
In-Reply-To: <20120301185535.29210.71546.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linuxkernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Friday 02 March 2012 12:25 AM, Tony Lindgren wrote:
> There's no need to use callbacks for this, we can
> do it directly between MMC driver and twl6030.
>
> Cc: Samuel Ortiz<sameo@linux.intel.com>
> Cc: Chris Ball<cjb@laptop.org>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> ---
[..]
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 7ca7a5c..8cf4e54 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -153,8 +153,8 @@ static struct omap2_hsmmc_info mmc[] = {
>   	{
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> -		.gpio_wp	= -EINVAL,
>   		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,

stray change.

>   	},
[..]
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index c6b456a..ce0002b 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -283,35 +283,30 @@ int twl6030_mmc_card_detect_config(void)
>   	 * Card status on TWL6030 for MMC1
>   	 */
>   	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0,&reg_val, TWL6030_MMCCTRL);
> -	if (ret<  0) {
> -		pr_err("twl6030: Failed to read MMCCTRL, error %d\n", ret);
> -		return ret;
> -	}
> +	if (ret<  0)
> +		goto err;
>   	reg_val&= ~VMMC_AUTO_OFF;
>   	reg_val |= SW_FC;
>   	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
> -	if (ret<  0) {
> -		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
> -		return ret;
> -	}
> +	if (ret<  0)
> +		goto err;
>
>   	/* Configuring PullUp-PullDown register */
>   	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0,&reg_val,
>   						TWL6030_CFG_INPUT_PUPD3);
> -	if (ret<  0) {
> -		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
> -									ret);
> -		return ret;
> -	}
> +	if (ret<  0)
> +		goto err;
>   	reg_val&= ~(MMC_PU | MMC_PD);
>   	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>   						TWL6030_CFG_INPUT_PUPD3);
> -	if (ret<  0) {
> -		pr_err("twl6030: Failed to write CFG_INPUT_PUPD3, error %d\n",
> -									ret);
> -		return ret;
> -	}
> -	return 0;
> +	if (ret<  0)
> +		goto err;
> +
> +	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
> +
> +err:
> +	pr_err("twl6030: Failed to initialize MMC card detect: %d\n", ret);
> +	return -ENODEV;
>   }
>   EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1aa2420..7f483b7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -34,6 +34,7 @@
>   #include<linux/gpio.h>
>   #include<linux/regulator/consumer.h>
>   #include<linux/pm_runtime.h>
> +#include<linux/i2c/twl.h>
>   #include<plat/dma.h>
>   #include<mach/hardware.h>
>   #include<plat/board.h>
> @@ -578,6 +579,32 @@ static void omap_hsmmc_gpio_free(struct omap_hsmmc_host *host)
>   		gpio_free(host->gpio_cd);
>   }
>
> +#ifdef CONFIG_TWL4030_CORE
> +static int omap_hsmmc_init_twl6030(struct omap_hsmmc_host *host)
> +{
> +	struct omap_mmc_platform_data *pdata = host->pdata;
> +	struct omap_mmc_slot_data *slot =&pdata->slots[0];
> +	int irq;
> +
> +	if (gpio_is_valid(host->gpio_cd) || host->id)

I have a series, which I am asking Chris to pull, which completely
gets rid of all host->id based hard-codings' in the driver.
Isn't there a better way to do this than rely on the device instance?

regards,
Rajendra

> +		return 0;
> +
> +	irq = twl6030_mmc_card_detect_config();
> +	if (irq<= 0)
> +		return irq;
> +
> +	slot->card_detect_irq = irq;
> +	slot->card_detect = twl6030_mmc_card_detect;
> +
> +	return 0;
> +}
> +#else
> +static inline int omap_hsmmc_init_twl6030(struct omap_hsmmc_host *host)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>   /*
>    * Start clock to the card
>    */
> @@ -1933,6 +1960,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err1;
>
> +	ret = omap_hsmmc_init_twl6030(host);
> +	if (ret)
> +		goto err1;
> +
>   	mmc->ops	=&omap_hsmmc_ops;
>
>   	/*
>

