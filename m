From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Wed, 12 Jun 2013 07:37:18 -0700
Message-ID: <20130612143718.GB8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370546059-24181-7-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [130606 12:20]:
> PBIAS register configuration is based on the regulator voltage
> which supplies these pbias cells, sd i/o pads.
> With PBIAS register address and bit definitions different across
> omap[3,4,5], Simplify PBIAS configuration under three different
> regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl states
> are defined as pbias_off, pbias_1v8, pbias_3v.
> 
> pinctrl state mmc_init is used for configuring speed mode, loopback clock
> (in devconf0/devconf1/prog_io1 register for omap3) and pull strength
> configuration (in control_mmc1 for omap4)
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   83 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 533ced2..8dd1cd3 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -182,6 +182,9 @@ struct omap_hsmmc_host {
>  	int			req_in_progress;
>  	struct omap_hsmmc_next	next_data;
>  
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pbias_off, *pbias_1v8, *pbias_3v, *mmc_init;
> +
>  	struct	omap_mmc_platform_data	*pdata;
>  	int needs_vmmc:1;
>  	int needs_vmmc_aux:1;
> @@ -267,6 +270,12 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	if (mmc_slot(host).before_set_reg)
>  		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
>  
> +	if (host->pinctrl && host->pbias_off) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
> +		if (ret < 0)
> +			dev_err(host->dev, "pinctrl pbias_off select error\n");
> +	}
> +
>  	/*
>  	 * Assume Vcc regulator is used only to power the card ... OMAP
>  	 * VDDS is used to power the pins, optionally with a transceiver to
> @@ -304,6 +313,25 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	if (mmc_slot(host).after_set_reg)
>  		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
>  
> +	/* 100ms delay required for PBIAS configuration */
> +	msleep(100);

Hmm, why is the delay needed before the configuration? Is this something
you could avoid by reading the pinconf state maybe?

> +	if (!vdd && host->pinctrl && host->pbias_off) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
> +		if (ret < 0)
> +			dev_err(host->dev, "pinctrl pbias_off select error\n");
> +	} else if (((1 << vdd) <= MMC_VDD_165_195) && host->pinctrl &&
> +			host->pbias_1v8) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pbias_1v8);
> +		if (ret < 0)
> +			dev_err(host->dev, "pinctrl pbias_1v8 select error\n");
> +	} else if (((1 << vdd) > MMC_VDD_165_195) && host->pinctrl &&
> +			host->pbias_3v) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pbias_3v);
> +		if (ret < 0)
> +			dev_err(host->dev, "pinctrl pbias_3v select error\n");
> +	}
> +	usleep_range(350, 400);
> +
>  	return ret;
>  }

Maybe add some macro for doing the if (((1 << vdd) <= MMC_VDD_165_195)... tests?

> @@ -1775,6 +1803,52 @@ static inline struct omap_mmc_platform_data
>  }
>  #endif
>  
> +static int omap_hsmmc_pinctrl_init(struct omap_hsmmc_host *host)
> +{
> +	int ret = 0;
> +
> +	host->pinctrl = devm_pinctrl_get(host->dev);
> +	if (IS_ERR(host->pinctrl)) {
> +		host->pinctrl = NULL;
> +		dev_warn(host->dev,
> +			 "pins are not configured from the driver\n");
> +		return 0;
> +	}
> +
> +	host->mmc_init = pinctrl_lookup_state(host->pinctrl, "mmc_init");
> +	if (IS_ERR(host->mmc_init)) {
> +		dev_vdbg(host->dev, "optional: mmc_init lookup error");
> +		host->mmc_init = NULL;
> +	} else {
> +		ret = pinctrl_select_state(host->pinctrl, host->mmc_init);
> +		if (ret < 0) {
> +			dev_err(host->dev, "pinctrl mmc_init select error\n");
> +			goto err_pinctrl;
> +		}
> +	}
> +
> +	host->pbias_off = pinctrl_lookup_state(host->pinctrl, "pbias_off");
> +	if (IS_ERR(host->pbias_off)) {
> +		dev_vdbg(host->dev, "optional: pbias_off lookup error");
> +		host->pbias_off = NULL;
> +	}
> +
> +	host->pbias_1v8 = pinctrl_lookup_state(host->pinctrl, "pbias_1v8");
> +	if (IS_ERR(host->pbias_1v8)) {
> +		dev_vdbg(host->dev, "optional: pbias_1v8 lookup error");
> +		host->pbias_1v8 = NULL;
> +	}
> +
> +	host->pbias_3v = pinctrl_lookup_state(host->pinctrl, "pbias_3v");
> +	if (IS_ERR(host->pbias_3v)) {
> +		dev_vdbg(host->dev, "optional: pbias_3v lookup error");
> +		host->pbias_3v = NULL;
> +	}
> +
> +err_pinctrl:
> +	return ret;
> +}

Linus W may have some comments on this, although this is not the standard
muxing stuff. The "mmc_init" state pins should be added to just the regular
default state? Note that you can have phandles to however many sets of
pins there.

>  static int omap_hsmmc_probe(struct platform_device *pdev)
>  {
>  	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
> @@ -1785,7 +1859,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	dma_cap_mask_t mask;
>  	unsigned tx_req, rx_req;
> -	struct pinctrl *pinctrl;
>  
>  	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
>  	if (match) {
> @@ -2005,10 +2078,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  
>  	omap_hsmmc_disable_irq(host);
>  
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(pinctrl))
> -		dev_warn(&pdev->dev,
> -			"pins are not configured from the driver\n");
> +	ret = omap_hsmmc_pinctrl_init(host);
> +	if (ret)
> +		goto err_pinctrl_state;
>  
>  	omap_hsmmc_protect_card(host);
>  
> @@ -2034,6 +2106,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  
>  err_slot_name:
>  	mmc_remove_host(mmc);
> +err_pinctrl_state:
>  	free_irq(mmc_slot(host).card_detect_irq, host);
>  err_irq_cd:
>  	omap_hsmmc_reg_put(host);

Regards,

Tony
