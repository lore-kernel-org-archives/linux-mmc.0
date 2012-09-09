From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: slot-gpio: Fix missing assignment to ctx->ro_gpio
Date: Sun, 9 Sep 2012 23:21:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1209092318550.11567@axis700.grange>
References: <87pq5vzyry.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52524 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab2IIVVW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Sep 2012 17:21:22 -0400
In-Reply-To: <87pq5vzyry.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris

On Sat, 8 Sep 2012, Chris Ball wrote:

> mmc_gpio_request_ro() doesn't store the requested gpio in ctx->ro_gpio.
> As a result, subsequent calls to mmc_gpio_get_ro() will always fail
> with -ENOSYS because the gpio number isn't available to that function.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/core/slot-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 0582429..4f9b366 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -99,6 +99,7 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
>  		return ret;
>  
>  	ctx = host->slot.handler_priv;
> +	ctx->ro_gpio = gpio;

Huh, I wonder how this got lost. But, please, let's do it a bit 
differently. If gpio_request_one() fails, ctx->ro_gpio shouldn't contain a 
valid GPIO number. So, I think, it should be

+	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
+	if (ret < 0)
+		return ret;
+
+	ctx->ro_gpio = gpio;
+
+	return 0;

Agree?

Thanks
Guennadi

>  
>  	return gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
>  }
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
