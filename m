From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix wakeup issue when using runtime
 pm
Date: Fri, 11 Mar 2016 16:55:51 +0100
Message-ID: <20160311155551.GE11592@odux.rfo.atmel.com>
References: <20160309163809.GM2690@odux.rfo.atmel.com>
 <1457605858-30907-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:47873 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596AbcCKP4O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2016 10:56:14 -0500
Content-Disposition: inline
In-Reply-To: <1457605858-30907-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

On Thu, Mar 10, 2016 at 11:30:58AM +0100, Ludovic Desroches wrote:
> It was impossible to wake-up on card detect event because when sdhci
> controller is runtime suspend, it is assumed that all the clocks are
> disabled so we can't get irqs.
> If the device is removable and there is no gpio to manage the card
> detection then card detection polling is used.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> Hi Ulf, Adrian,
> 
> Following the discussion, I need to fix my issue. I think we could both agree
> on this patch that I see more as temporary workaround.
> 
> I will try to change the muxing of the card detect pio in order to no more
> use the sdhci controller to manage it but a gpio. If it do not work then
> I may send another patch in the spirit of the previous one (keeping one clock
> enabled and not calling sdhci_runtime_suspend_host()).

I have changed the muxing for the card detect signal to get it on a gpio
instead of the card detect pio (peripheral io) of the controller. I thought
it can work because we have a 'force card detect' bit. Unfortunately, it is
resetted when we perform a software reset. Moreover I need to keep the
card detect pio, because it used to perform fast startup from ultra low power
modes.

Maybe it could work by using an extra pin but it invovles to do hardawre
changes on the boards and needing two pins for one signal is not acceptable.

I'll do more tests to use runtime pm without polling for card detection
and without using sdhci_runtime_suspend_host().


> 
> Regards
> 
>  drivers/mmc/host/sdhci-of-at91.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 35c02fc..dac8508 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -204,6 +205,21 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto pm_runtime_disable;
>  
> +	/*
> +	 * When calling sdhci_runtime_suspend_host(), the sdhci layer makes
> +	 * the assumption that all the clocks of the controller are disabled.
> +	 * It means we can't get irq from it when it is runtime suspended.
> +	 * For that reason, it is not planned to wake-up on a card detect irq
> +	 * from the controller.
> +	 * If we want to use runtime PM and to be able to wake-up on card
> +	 * insertion, we have to use a GPIO for the card detection or we can
> +	 * use polling for the card detection. Be aware that using polling
> +	 * will resume/suspend the controller between each attempt.
> +	 */
> +	if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
> +	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
> +		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
> -- 
> 2.5.0
> 
