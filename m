From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] RFC/RFT: Powering on MMC Wifi/BT modules in MMC
	core
Date: Thu, 13 Feb 2014 10:36:40 +0000
Message-ID: <20140213103640.GT26684@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <20140130214917.GE15937@n2100.arm.linux.org.uk> <20140201161420.GA26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34835 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752864AbaBMKgv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 05:36:51 -0500
Content-Disposition: inline
In-Reply-To: <20140201161420.GA26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Chris Ball <chris@printf.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, linux-mmc@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org

Any comments on this?

On Sat, Feb 01, 2014 at 04:14:20PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 30, 2014 at 09:49:17PM +0000, Russell King - ARM Linux wrote:
> > On Sun, Jan 19, 2014 at 07:56:52PM -0800, Olof Johansson wrote:
> > > This is a small series enhancing the MMC core code to power on modules
> > > before the host in cases where needed, and the corresponding DT bindings
> > > changes.
> > > 
> > > I've got some other issues to debug on the Chromebook, i.e. the interface
> > > doens't actually work. So far it seems unrelated to this patch set so
> > > it's worth posting this and get things going since others need the same
> > > functionality (i.e Cubox-i).
> > > 
> > > As mentioned in the patch in the series, I haven't implemented power-down
> > > yet, I wanted to make sure that the power-on side will be adequate for
> > > those who are looking to use it right away.
> > > 
> > > Comments/test reports/etc welcome.
> > 
> > So, I thought I'd give this a go on the Cubox-i4, and... it doesn't work
> > there.  It's not your patches, it's down to sdhci-esdhc-imx.c not using
> > mmc_of_parse() at all, so those new properties have no way to be used
> > there.
> > 
> > It doesn't look like it could in its current form use mmc_of_parse(),
> > as the imx code manually parses some of the generic properties to hand
> > them into the sdhci layer.  This looks icky, and it looks like something
> > that should be fixed - why should drivers be parsing the core attributes
> > themselves?
> 
> Here's an illustration of why it's icky.
> 
> If we call mmc_of_parse() in the sdhci-esdhc-imx driver (which we'd need to
> do in order to get information on how to configure the card detection etc)
> then this fills in mmc->f_max.
> 
> However, the subsequent call to sdhci_add_host() computes the maximum clock
> from the sdhci capabilities, and then does this:
> 
>         host->max_clk *= 1000000;
>         if (host->max_clk == 0 || host->quirks &
>                         SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
>                 if (!host->ops->get_max_clock) {
>                         pr_err("%s: Hardware doesn't specify base clock "
>                                "frequency.\n", mmc_hostname(mmc));
>                         return -ENODEV;
>                 }
>                 host->max_clk = host->ops->get_max_clock(host);
>         }
> ...
>         /*
>          * Set host parameters.
>          */
>         mmc->ops = &sdhci_ops;
>         mmc->f_max = host->max_clk;
> 
> which would have the effect of overwriting a previously set f_max from
> the OF data.
> 
> There's also the whole "cd-gpios" thing which would need sorting out -
> the imx sdhci driver already parses this property itself, and sets its
> own internal data (so it knows whether it has to use the controller
> based card detect or the gpio card detect) and simply adding a call to
> mmc_of_parse() would result in the gpio slot stuff being setup twice.
> 
> The obvious solution here is to rewrite the sdhci initialisation such
> that it uses the generic infrastructure, but I don't have the motivation
> to do that (I've already plenty of patches to deal with that I don't
> need any more at the moment.)
> 
> A simpler solution would be to split mmc_of_parse() so that the new bits
> are a separate function, which the generic MMC core always calls for
> every host - taking the decision over whether this is supported completely
> away from hosts.  I think that makes a lot of sense, especially as this
> has nothing to do with the facilities found on any particular host.
> 
> There's another issue here about resets.  Let's take the case where the
> external card is powered off, but has active high resets.  At the moment,
> the sequence is this:
> 
> power: _____/~~~~~~~~~~~~
> reset: __/~~~~\__________
> 
> That's not particularly nice, as the reset signal will tend do drive power
> into the device before it's powered up via the clamping diodes in the case.
> Generally, devices are not designed to be powered in this way.  However,
> this is a relatively minor issue though compared to this one, which is what
> happens if the card uses active low reset:
> 
> power: _____/~~~~~~~~~~~~
> reset: ~~\_____/~~~~~~~~~
> 
> This is definitely not good, because it means that the reset is higher for
> longer, which may result in unacceptable dissapation in the package from
> those clamping diodes.  What we need instead is for active low reset is:
> 
> power: _____/~~~~~~~~~~~~
> reset: ________/~~~~~~~~~
> 
> So, we need the GPIO layer to tell us whether the output is active high or
> active low and adjust the initial setting accordingly.  Basically, whenever
> the attached device is powered down, GPIOs to it should be held at low level
> or high impedance (with a pull-down to reduce the risks of ESD damage.)
> 
> I've seen designs get this wrong in the past - Intel Assabet is a good one
> where the UDA1341 audio codec ends up illuminating a LED by being powered
> not via it's supply pin, but by a CPLD output driving one of the I2S pins
> high.  The result is that the CPLD output sources quite a bit of current
> into the UDA1341, which then holds other pins on the SA1110 around mid-rail,
> which is the /worst/ thing you can do with CMOS.  Powering chips via their
> inputs is basically a big no-no.
> 
> So, I think something like the below is needed on top of your patches.
> Note that I added -EPROBE_DEFER handling too (which fixes a bug, because
> regulator_get() returns pointer-errors):
> 
>  drivers/mmc/core/host.c            | 90 +++++++++++++++++++++++++++-----------
>  1 files changed, 65 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index e6b850b3241f..64942eb495b6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -316,7 +316,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	u32 bus_width;
>  	bool explicit_inv_wp, gpio_inv_wp = false;
>  	enum of_gpio_flags flags;
> -	int i, len, ret, gpio;
> +	int len, ret, gpio;
>  
>  	if (!host->parent || !host->parent->of_node)
>  		return 0;
> @@ -419,30 +419,6 @@ int mmc_of_parse(struct mmc_host *host)
>  	if (explicit_inv_wp ^ gpio_inv_wp)
>  		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>  
> -	/* Parse card power/reset/clock control */
> -	if (of_find_property(np, "card-reset-gpios", NULL)) {
> -		struct gpio_desc *gpd;
> -		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> -			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
> -			if (IS_ERR(gpd))
> -				break;
> -			gpiod_direction_output(gpd, 0);
> -			host->card_reset_gpios[i] = gpd;
> -		}
> -
> -		gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
> -		if (!IS_ERR(gpd)) {
> -			dev_warn(host->parent, "More reset gpios than we can handle");
> -			gpiod_put(gpd);
> -		}
> -	}
> -
> -	host->card_clk = of_clk_get_by_name(np, "card_ext_clock");
> -	if (IS_ERR(host->card_clk))
> -		host->card_clk = NULL;
> -
> -	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> -
>  	if (of_find_property(np, "cap-sd-highspeed", &len))
>  		host->caps |= MMC_CAP_SD_HIGHSPEED;
>  	if (of_find_property(np, "cap-mmc-highspeed", &len))
> @@ -467,6 +443,66 @@ int mmc_of_parse(struct mmc_host *host)
>  
>  EXPORT_SYMBOL(mmc_of_parse);
>  
> +static int mmc_of_parse_child(struct mmc_host *host)
> +{
> +	struct device_node *np;
> +	struct clk *clk;
> +	int i;
> +
> +	if (!host->parent || !host->parent->of_node)
> +		return 0;
> +
> +	np = host->parent->of_node;
> +
> +	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> +	if (IS_ERR(host->card_regulator)) {
> +		if (PTR_ERR(host->card_regulator) == -EPROBE_DEFER)
> +			return PTR_ERR(host->card_regulator);
> +		host->card_regulator = NULL;
> +	}
> +
> +	/* Parse card power/reset/clock control */
> +	if (of_find_property(np, "card-reset-gpios", NULL)) {
> +		struct gpio_desc *gpd;
> +		int level = 0;
> +
> +		/*
> +		 * If the regulator is enabled, then we can hold the
> +		 * card in reset with an active high resets.  Otherwise,
> +		 * hold the resets low.
> +		 */
> +		if (host->card_regulator && regulator_is_enabled(host->card_regulator))
> +			level = 1;
> +
> +		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> +			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
> +			if (IS_ERR(gpd)) {
> +				if (PTR_ERR(gpd) == -EPROBE_DEFER)
> +					return PTR_ERR(gpd);
> +				break;
> +			}
> +			gpiod_direction_output(gpd, gpiod_is_active_low(gpd) | level);
> +			host->card_reset_gpios[i] = gpd;
> +		}
> +
> +		gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
> +		if (!IS_ERR(gpd)) {
> +			dev_warn(host->parent, "More reset gpios than we can handle");
> +			gpiod_put(gpd);
> +		}
> +	}
> +
> +	clk = of_clk_get_by_name(np, "card_ext_clock");
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> +			return PTR_ERR(clk);
> +		clk = NULL;
> +	}
> +	host->card_clk = clk;
> +
> +	return 0;
> +}
> +
>  /**
>   *	mmc_alloc_host - initialise the per-host structure.
>   *	@extra: sizeof private data structure
> @@ -546,6 +582,10 @@ int mmc_add_host(struct mmc_host *host)
>  {
>  	int err;
>  
> +	err = mmc_of_parse_child(host);
> +	if (err)
> +		return err;
> +
>  	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
>  		!host->ops->enable_sdio_irq);
>  
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
