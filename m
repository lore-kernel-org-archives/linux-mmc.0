From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: host: fix memory leak in mmc_add_host
Date: Mon, 11 Apr 2011 17:25:48 -0400
Message-ID: <m3ei58a3ab.fsf@pullcord.laptop.org>
References: <1302495089-23699-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55538 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1DKVUx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Apr 2011 17:20:53 -0400
In-Reply-To: <1302495089-23699-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Mon, 11 Apr 2011 06:11:29 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linus.walleij@linaro.org

Hi Wolfram,

On Mon, Apr 11 2011, Wolfram Sang wrote:
> led_trigger_register_simple() allocates memory which must not be leaked
> in the error-path of mmc_add_host. Move it past the only error-check in
> the function.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>
> I don't see any reason why it needs to be called before device_add.
>
>  drivers/mmc/core/host.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 461e6a1..b29d3e8 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -325,12 +325,12 @@ int mmc_add_host(struct mmc_host *host)
>  	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
>  		!host->ops->enable_sdio_irq);
>  
> -	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
> -
>  	err = device_add(&host->class_dev);
>  	if (err)
>  		return err;
>  
> +	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
> +
>  #ifdef CONFIG_DEBUG_FS
>  	mmc_add_host_debugfs(host);
>  #endif

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
