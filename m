From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: Use mmc_can_gpio_cd() when validating for
 native hotplug
Date: Thu, 5 Jan 2017 12:50:33 +0100
Message-ID: <20170105115033.jperzle6iww6ecqe@ninjato>
References: <1483097985-22446-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47728 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970592AbdAELug (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Jan 2017 06:50:36 -0500
Content-Disposition: inline
In-Reply-To: <1483097985-22446-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

On Fri, Dec 30, 2016 at 12:39:45PM +0100, Ulf Hansson wrote:
> To validate whether native hotplug is intended to be used, the tmio driver
> checks whether the GPIO isr has been successfully assigned. This isn't
> entirely correct, as GPIO could still be used for card detect, but in a
> polling mode.

Isn't that checked with MMC_CAP_NEEDS_POLL? Could we maybe get rid of
that then?

> 
> Therefore, let's convert to use the correct mmc interface,
> mmc_can_gpio_cd() as it tells exactly what we need for the native hotplug
> validation.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 3ca97f3..580ca9c 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1178,7 +1178,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>  	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>  				  mmc->caps & MMC_CAP_NEEDS_POLL ||
>  				  !mmc_card_is_removable(mmc) ||
> -				  mmc->slot.cd_irq >= 0);
> +				  mmc_can_gpio_cd(mmc));
>  
>  	/*
>  	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
> -- 
> 1.9.1
> 
