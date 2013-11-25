From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to
 support SDIO interrupt on AM335x.
Date: Mon, 25 Nov 2013 14:46:02 -0800
Message-ID: <20131125224601.GX10023@atomide.com>
References: <1385386009-14981-1-git-send-email-afenkart@gmail.com>
 <1385386009-14981-3-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385386009-14981-3-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [131125 05:30]:
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -452,10 +475,23 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
>  	} else
>  		pdata->slots[0].gpio_wp = -EINVAL;
>  
> +	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
> +		ret = gpio_request_one(pdata->slots[0].gpio_cirq, GPIOF_DIR_IN,
> +				       "sdio_cirq");
> +		if (ret)
> +			goto err_free_ro;
> +
> +	} else {
> +		pdata->slots[0].gpio_cirq = -EINVAL;
> +	}
> +
> +
>  	return 0;
>  
> +err_free_ro:
> +	if (gpio_is_valid(pdata->slots[0].gpio_wp))
>  err_free_wp:
> -	gpio_free(pdata->slots[0].gpio_wp);
> +		gpio_free(pdata->slots[0].gpio_wp);
>  err_free_cd:
>  	if (gpio_is_valid(pdata->slots[0].switch_pin))
>  err_free_sp:

This patch we can now make a bit more generic with the recent addition
of interrupts-extended property that's now merged in mainline tree :)

We can optionally pass two interrupts to omap_hsmmc.c where the second
interrupt is either the pinctrl-single wake-up interrupt, or the GPIO
interrupt.

Both the iochain wake interrupt or the GPIO interrupt are available with
request_irq as long as configured in the .dts file. And can both use the
SDIO interrupt handler. The only difference is that the GPIO wake-up
still needs to do the dynamic remuxing of pins.

So omap3 can use:

mmc: mmc@4800abcd {
	compatible = "ti,omap3-hsmmc";
	...
	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
	...
};

And am33xx can use:

mmc: mmc@4810abcd {
	compatible = "ti,omap33xx-hsmmc";
	...
	interrupts-extended = <&intc 64 &gpio3 28>;
	...
};

Then the logic of enabling the dynamic remuxing can be done based
on the ti,omap33xx-hsmmc compatible flag if there are two interrupts
and the needed pin states are defined.

> @@ -1791,6 +1890,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  	pdata->nr_slots = 1;
>  	pdata->slots[0].switch_pin = cd_gpio;
>  	pdata->slots[0].gpio_wp = wp_gpio;
> +	pdata->slots[0].gpio_cirq = of_get_named_gpio(np, "ti,cirq-gpio", 0);
>  
>  	if (of_find_property(np, "ti,non-removable", NULL)) {
>  		pdata->slots[0].nonremovable = true;

We should just add the two interrupts to the host, not to the pdata.

Regards,

Tony
