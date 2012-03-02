From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/4] mmc: omap_hsmmc: Use gpio_find_by_chip_name() for
 omap_hsmmc_gpio_init()
Date: Fri, 02 Mar 2012 11:24:56 +0530
Message-ID: <4F5060B0.7010703@ti.com>
References: <20120301185044.29210.44521.stgit@kaulin.local> <20120301185528.29210.85854.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44024 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab2CBFzF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 00:55:05 -0500
Received: by yhpp61 with SMTP id p61so758735yhp.11
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 21:55:04 -0800 (PST)
In-Reply-To: <20120301185528.29210.85854.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linuxkernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 02 March 2012 12:25 AM, Tony Lindgren wrote:
> Use gpio_find_by_chip_name() to find the GPIO pins as they can
> be dynamically allocated on various gpio_chips.
>
> Note that we don't want to touch the platform data as it can
> now specify the GPIO offset on a named gpio_chip.
>
> This removes the need to use callbacks to set the GPIO pins
> in platform data.

While one of the reasons for those callbacks was to set the GPIO
pins in platform data, I guess the other and more important one
was to make sure the init sequencing between twl4030-gpio and the
mmc device depending on it was done rightly. Doesn't this patch now
leave the sequencing to work by luck (in the absence of something
like deferred probe being in place) like is the case of twl6030 and
mmc init sequence on OMAP4 already?

regards,
Rajendra

>
> Cc: Chris Ball<cjb@laptop.org>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/hsmmc.c           |    3 +
>   arch/arm/mach-omap2/hsmmc.h           |    5 ++
>   arch/arm/plat-omap/include/plat/mmc.h |    3 +
>   drivers/gpio/gpio-twl4030.c           |    2 +
>   drivers/mmc/host/omap_hsmmc.c         |  109 +++++++++++++++++++++------------
>   5 files changed, 82 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index a97876d..dda88f7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -323,7 +323,10 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>
>   	mmc->get_context_loss_count = hsmmc_get_context_loss;
>
> +	mmc->slots[0].gpiochip_cd = c->gpiochip_cd;
>   	mmc->slots[0].switch_pin = c->gpio_cd;
> +
> +	mmc->slots[0].gpiochip_wp = c->gpiochip_wp;
>   	mmc->slots[0].gpio_wp = c->gpio_wp;
>
>   	mmc->slots[0].remux = c->remux;
> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
> index 07831cc..ffbb78d 100644
> --- a/arch/arm/mach-omap2/hsmmc.h
> +++ b/arch/arm/mach-omap2/hsmmc.h
> @@ -22,8 +22,13 @@ struct omap2_hsmmc_info {
>   	bool	no_off_init;	/* no power off when not in MMC sleep state */
>   	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
>   	bool	deferred;	/* mmc needs a deferred probe */
> +
> +	char	*gpiochip_cd;	/* Optional gpiochip for gpio_cd */
>   	int	gpio_cd;	/* or -EINVAL */
> +
> +	char	*gpiochip_wp;	/* Optional gpiochip for gpio_wp */
>   	int	gpio_wp;	/* or -EINVAL */
> +
>   	char	*name;		/* or NULL for default */
>   	struct platform_device *pdev;	/* mmc controller instance */
>   	int	ocr_mask;	/* temporary HACK */
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
> index f75946c..cbfbdc3 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -130,7 +130,10 @@ struct omap_mmc_platform_data {
>   #define HSMMC_HAS_UPDATED_RESET	(1<<  1)
>   		unsigned features;
>
> +		char *gpiochip_cd;		/* optional gpiochip for card detect */
>   		int switch_pin;			/* gpio (card detect) */
> +
> +		char *gpiochip_wp;		/* optional gpiochip for write protect */
>   		int gpio_wp;			/* gpio (write protect) */
>
>   		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
> index b8b4f22..d0f266c 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -391,6 +391,7 @@ static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
>   }
>
>   static int gpio_twl4030_remove(struct platform_device *pdev);
> +static struct platform_driver gpio_twl4030_driver;
>
>   static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
>   {
> @@ -430,6 +431,7 @@ no_irqs:
>   				pdata->debounce, pdata->mmc_cd,
>   				ret);
>
> +	twl_gpiochip.label = gpio_twl4030_driver.driver.name;
>   	twl_gpiochip.base = pdata->gpio_base;
>   	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
>   	twl_gpiochip.dev =&pdev->dev;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index fd0c661..1aa2420 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -176,6 +176,8 @@ struct omap_hsmmc_host {
>   	int			use_dma, dma_ch;
>   	int			dma_line_tx, dma_line_rx;
>   	int			slot_id;
> +	int			gpio_cd;
> +	int			gpio_wp;
>   	int			got_dbclk;
>   	int			response_busy;
>   	int			context_loss;
> @@ -192,26 +194,29 @@ struct omap_hsmmc_host {
>
>   static int omap_hsmmc_card_detect(struct device *dev, int slot)
>   {
> -	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +	struct omap_hsmmc_host *host =
> +		platform_get_drvdata(to_platform_device(dev));
>
>   	/* NOTE: assumes card detect signal is active-low */
> -	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> +	return !gpio_get_value_cansleep(host->gpio_cd);
>   }
>
>   static int omap_hsmmc_get_wp(struct device *dev, int slot)
>   {
> -	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +	struct omap_hsmmc_host *host =
> +		platform_get_drvdata(to_platform_device(dev));
>
>   	/* NOTE: assumes write protect signal is active-high */
> -	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
> +	return gpio_get_value_cansleep(host->gpio_wp);
>   }
>
>   static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
>   {
> -	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +	struct omap_hsmmc_host *host =
> +		platform_get_drvdata(to_platform_device(dev));
>
>   	/* NOTE: assumes card detect signal is active-low */
> -	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> +	return !gpio_get_value_cansleep(host->gpio_cd);
>   }
>
>   #ifdef CONFIG_PM
> @@ -497,55 +502,80 @@ static inline int omap_hsmmc_have_reg(void)
>
>   #endif
>
> -static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> +static int omap_hsmmc_gpio_init(struct omap_hsmmc_host *host)
>   {
> -	int ret;
> -
> -	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
> -		if (pdata->slots[0].cover)
> -			pdata->slots[0].get_cover_state =
> +	struct omap_mmc_platform_data *pdata = host->pdata;
> +	struct omap_mmc_slot_data *slot =&pdata->slots[0];
> +	int gpio, ret;
> +
> +	gpio = slot->switch_pin;
> +	if (slot->gpiochip_cd)
> +		gpio = gpio_find_by_chip_name(slot->gpiochip_cd, gpio);
> +	if (gpio_is_valid(gpio)) {
> +		if (slot->cover)
> +			slot->get_cover_state =
>   					omap_hsmmc_get_cover_state;
>   		else
> -			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
> -		pdata->slots[0].card_detect_irq =
> -				gpio_to_irq(pdata->slots[0].switch_pin);
> -		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
> +			slot->card_detect = omap_hsmmc_card_detect;
> +		slot->card_detect_irq =
> +				gpio_to_irq(gpio);
> +		ret = gpio_request(gpio, "mmc_cd");
>   		if (ret)
>   			return ret;
> -		ret = gpio_direction_input(pdata->slots[0].switch_pin);
> +		ret = gpio_direction_input(gpio);
>   		if (ret)
>   			goto err_free_sp;
> -	} else
> -		pdata->slots[0].switch_pin = -EINVAL;
> +		host->gpio_cd = gpio;
> +	} else {
> +		if (slot->gpiochip_cd) {
> +			pr_warning("MMC %s card detect GPIO chip %s unavailable\n",
> +				slot->name, slot->gpiochip_cd);
> +			ret = -ENODEV;
> +			goto err_free_sp;
> +		}
> +		host->gpio_cd = -EINVAL;
> +	}
>
> -	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
> -		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
> -		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
> +	gpio = slot->gpio_wp;
> +	if (slot->gpiochip_wp)
> +		gpio = gpio_find_by_chip_name(slot->gpiochip_wp, gpio);
> +	if (gpio_is_valid(gpio)) {
> +		slot->get_ro = omap_hsmmc_get_wp;
> +		ret = gpio_request(gpio, "mmc_wp");
>   		if (ret)
>   			goto err_free_cd;
> -		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
> +		ret = gpio_direction_input(gpio);
>   		if (ret)
>   			goto err_free_wp;
> -	} else
> -		pdata->slots[0].gpio_wp = -EINVAL;
> +		host->gpio_wp = gpio;
> +	} else {
> +		if (slot->gpiochip_wp) {
> +			pr_warning("MMC %s write protect GPIO chip %s unavailable\n",
> +				slot->name, slot->gpiochip_wp);
> +			ret = -ENODEV;
> +			goto err_free_wp;
> +		}
> +		host->gpio_wp = -EINVAL;
> +	}
>
>   	return 0;
>
>   err_free_wp:
> -	gpio_free(pdata->slots[0].gpio_wp);
> +	if (gpio_is_valid(host->gpio_wp))
> +		gpio_free(host->gpio_wp);
>   err_free_cd:
> -	if (gpio_is_valid(pdata->slots[0].switch_pin))
> +	if (gpio_is_valid(host->gpio_cd))
>   err_free_sp:
> -		gpio_free(pdata->slots[0].switch_pin);
> +		gpio_free(host->gpio_cd);
>   	return ret;
>   }
>
> -static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
> +static void omap_hsmmc_gpio_free(struct omap_hsmmc_host *host)
>   {
> -	if (gpio_is_valid(pdata->slots[0].gpio_wp))
> -		gpio_free(pdata->slots[0].gpio_wp);
> -	if (gpio_is_valid(pdata->slots[0].switch_pin))
> -		gpio_free(pdata->slots[0].switch_pin);
> +	if (gpio_is_valid(host->gpio_wp))
> +		gpio_free(host->gpio_wp);
> +	if (gpio_is_valid(host->gpio_cd))
> +		gpio_free(host->gpio_cd);
>   }
>
>   /*
> @@ -1876,10 +1906,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>   	if (res == NULL)
>   		return -EBUSY;
>
> -	ret = omap_hsmmc_gpio_init(pdata);
> -	if (ret)
> -		goto err;
> -
>   	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host),&pdev->dev);
>   	if (!mmc) {
>   		ret = -ENOMEM;
> @@ -1903,6 +1929,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, host);
>
> +	ret = omap_hsmmc_gpio_init(host);
> +	if (ret)
> +		goto err1;
> +
>   	mmc->ops	=&omap_hsmmc_ops;
>
>   	/*
> @@ -2093,8 +2123,7 @@ err1:
>   	platform_set_drvdata(pdev, NULL);
>   	mmc_free_host(mmc);
>   err_alloc:
> -	omap_hsmmc_gpio_free(pdata);
> -err:
> +	omap_hsmmc_gpio_free(host);
>   	release_mem_region(res->start, resource_size(res));
>   	return ret;
>   }
> @@ -2125,7 +2154,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>
>   		mmc_free_host(host->mmc);
>   		iounmap(host->base);
> -		omap_hsmmc_gpio_free(pdev->dev.platform_data);
> +		omap_hsmmc_gpio_free(host);
>   	}
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>

