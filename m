From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v2 1/3] mmc: omap_hsmmc: Enable SDIO IRQ using a
 GPIO in idle mode.
Date: Mon, 20 May 2013 13:58:16 -0700
Message-ID: <20130520205815.GJ10378@atomide.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1368607516-2789-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52650 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab3ETU6Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 16:58:24 -0400
Content-Disposition: inline
In-Reply-To: <1368607516-2789-2-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [130515 01:51]:
> Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
> the system. This patch reconfigures dat1 line as a gpio while the fclk is
> off. When the fclk is present it uses the standard SDIO IRQ detection of
> the module.
> 
> The gpio irq is managed via the 'disable_depth' ref counter of the irq
> subsystem, this driver simply calls enable_irq/disable_irq when needed.
> 
>                       sdio irq    sdio irq
>                       unmasked     masked
>    -----------------------------------------
>     runtime default  |    1     |   2
>     runtime suspend  |    0     |   1
> 
>                   irq disable depth
> 
> 
> only when sdio irq is enabled AND the module is idle, the reference
> count drops to zero and the gpio irq is effectively armed.
> 
> Patch was tested on AM335x/Stream800. Test setup was two modules
> with sdio wifi cards. Modules where connected to a dual-band AP, each
> module using a different band. One of module was running iperf as server
> the other as client connecting to the server in a while true loop. Test
> was running for 4+ weeks. There were about 60 Mio. suspend/resume
> transitions. Test was shut down regularly.

Looks like this somehow breaks detecting of eMMC on mmc2 for me at least
with the non-dt legacyboot. For a removable mmc1 still keeps working.

For mmc2 I have .nonremovable = true and no gpio_cd or gpio_wp.

Also few comments below.
 
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> +	host->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(host->pinctrl)) {
> +		ret = PTR_ERR(host->pinctrl);
> +		goto err_pinctrl;
> +	}
> +
> +	host->active = pinctrl_lookup_state(host->pinctrl,
> +					    PINCTRL_STATE_DEFAULT);
> +	if (IS_ERR(host->active)) {
> +		dev_warn(mmc_dev(host->mmc), "Unable to lookup active pinmux\n");
> +		ret = PTR_ERR(host->active);
> +		goto err_pinctrl_state;
> +	}

This should be checked, we have systems with all muxing done statically
in the bootloader. And we also have systems that provide the default
pinctrl state only as they don't need remuxing. So at most a warning should
be printed.

>  static int omap_hsmmc_runtime_resume(struct device *dev)
>  {
>  	struct omap_hsmmc_host *host;
> +	unsigned long flags;
> +	int ret = 0;
>  
>  	host = platform_get_drvdata(to_platform_device(dev));
>  	omap_hsmmc_context_restore(host);
>  	dev_dbg(dev, "enabled\n");
>  
> -	return 0;
> +	if (mmc_slot(host).sdio_irq && host->pinctrl) {
> +		disable_irq(mmc_slot(host).sdio_irq);
> +
> +		ret = pinctrl_select_state(host->pinctrl, host->active);
> +		if (ret < 0) {
> +			dev_warn(mmc_dev(host->mmc), "Unable to select active pinmux\n");
> +			return ret;
> +		}
> +
> +		spin_lock_irqsave(&host->irq_lock, flags);
> +		host->active_pinmux = true;
> +
> +		if (host->sdio_irq_en) {
> +			OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +			OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
> +			OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
> +		}
> +		spin_unlock_irqrestore(&host->irq_lock, flags);
> +	}
> +	return ret;
>  }

The check for sdio_irq && host->pinctrl looks broken too as we may
have not dynamic muxing via pinctrl needed for let's say omap3 based
systems.

Other than that, looks good to me.

Regards,

Tony
