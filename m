From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease
 users
Date: Fri, 7 Dec 2012 14:49:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212071438010.24520@axis700.grange>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62032 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030293Ab2LGNtr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 08:49:47 -0500
In-Reply-To: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Hi Shawn

On Fri, 7 Dec 2012, Shawn Guo wrote:

> Use devm_* managed functions, so that slot-gpio users do not have to
> call mmc_gpio_free_ro/cd to free up resources requested in
> mmc_gpio_request_ro/cd.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for the patch, but I'm not sure this is a good idea. Firstly, using 
devm_* allocation functions means, that normally you don't have to free 
these resources explicitly any more. So, actually you would have to remove 
free_irq() and gpio_free() calls completely from the API instead of 
replacing them with devm_* analogs. Secondly, I do use devm_kzalloc() in 
the API because I really want that allocated memory to just be allocated 
once and stay there until the device is freed. Whereas with with card 
detection and write-protect pins - usually you're right, you would only 
allocate those once during the lifetime of your host device. But - are we 
sure there cannot be exceptions? What if someone decides to switch between 
CD-IRQ and CD-polling at runtime? Or do something equally weird with their 
GPIOs... At least I personally don't think I have sufficient knowledge of 
all possible configurations to make such a decision. Think about pinctrl 
etc. What if at runtime the CD pin has to be released by mmc to be used 
by some other device? Anyway, I'm fine either way, but I'm just not sure 
how reasonable this change is.

Thanks
Guennadi

> ---
>  drivers/mmc/core/slot-gpio.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 16a1c0b..8b55748 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -106,7 +106,8 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
>  
>  	ctx = host->slot.handler_priv;
>  
> -	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
> +	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
> +				    ctx->ro_label);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -128,7 +129,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
>  
>  	ctx = host->slot.handler_priv;
>  
> -	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
> +	ret = devm_gpio_request_one(&host->class_dev, gpio, GPIOF_DIR_IN,
> +				    ctx->cd_label);
>  	if (ret < 0)
>  		/*
>  		 * don't bother freeing memory. It might still get used by other
> @@ -146,7 +148,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
>  		irq = -EINVAL;
>  
>  	if (irq >= 0) {
> -		ret = request_threaded_irq(irq, NULL, mmc_gpio_cd_irqt,
> +		ret = devm_request_threaded_irq(&host->class_dev, irq,
> +			NULL, mmc_gpio_cd_irqt,
>  			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  			ctx->cd_label, host);
>  		if (ret < 0)
> @@ -175,7 +178,7 @@ void mmc_gpio_free_ro(struct mmc_host *host)
>  	gpio = ctx->ro_gpio;
>  	ctx->ro_gpio = -EINVAL;
>  
> -	gpio_free(gpio);
> +	devm_gpio_free(&host->class_dev, gpio);
>  }
>  EXPORT_SYMBOL(mmc_gpio_free_ro);
>  
> @@ -188,13 +191,13 @@ void mmc_gpio_free_cd(struct mmc_host *host)
>  		return;
>  
>  	if (host->slot.cd_irq >= 0) {
> -		free_irq(host->slot.cd_irq, host);
> +		devm_free_irq(&host->class_dev, host->slot.cd_irq, host);
>  		host->slot.cd_irq = -EINVAL;
>  	}
>  
>  	gpio = ctx->cd_gpio;
>  	ctx->cd_gpio = -EINVAL;
>  
> -	gpio_free(gpio);
> +	devm_gpio_free(&host->class_dev, gpio);
>  }
>  EXPORT_SYMBOL(mmc_gpio_free_cd);
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
