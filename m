From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: slot-gpio: Fix missing assignment to ctx->ro_gpio
Date: Mon, 10 Sep 2012 23:37:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1209102337070.26171@axis700.grange>
References: <87pq5vzyry.fsf@octavius.laptop.org> <Pine.LNX.4.64.1209092318550.11567@axis700.grange>
 <87627mzitr.fsf_-_@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59548 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab2IJVhb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 17:37:31 -0400
In-Reply-To: <87627mzitr.fsf_-_@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, 9 Sep 2012, Chris Ball wrote:

> mmc_gpio_request_ro() doesn't store the requested gpio in ctx->ro_gpio.
> As a result, subsequent calls to mmc_gpio_get_ro() will always fail
> with -ENOSYS because the gpio number isn't available to that function.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Chris Ball <cjb@laptop.org>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
> v2, addressing Guennadi's review comments:
>  - If gpio_request_one() fails, ctx->ro_gpio shouldn't contain a
>    valid GPIO number.
> 
>  drivers/mmc/core/slot-gpio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 0582429..08c6b3d 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -100,7 +100,13 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
>  
>  	ctx = host->slot.handler_priv;
>  
> -	return gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
> +	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->ro_gpio = gpio;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(mmc_gpio_request_ro);
>  
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
