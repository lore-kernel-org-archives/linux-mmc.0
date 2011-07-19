From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix runtime PM with -ENOSYS suspend case
Date: Mon, 18 Jul 2011 22:00:58 -0400
Message-ID: <m2wrff9gh1.fsf@bob.laptop.org>
References: <20110717153821.695FC9D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43837 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1GSCBB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jul 2011 22:01:01 -0400
In-Reply-To: <20110717153821.695FC9D401C@zog.reactivated.net> (Daniel Drake's
	message of "Sun, 17 Jul 2011 16:38:21 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Dan,

On Sun, Jul 17 2011, Daniel Drake wrote:
> From: Ohad Ben-Cohen <ohad@wizery.com>
>
> In the case where a driver returns -ENOSYS from its suspend handler
> to indicate that the device should be powered down over suspend, the
> remove routine of the driver was not being called, leading to lots of
> confusion during resume.
>
> The problem is that runtime PM is disabled during this process,
> and when we reach mmc_sdio_remove, calling the runtime PM functions here
> (validly) return errors, and this was causing us to skip the remove
> function.
>
> Fix this by ignoring the error value of pm_runtime_get_sync(), which
> can return valid errors. This also matches the behaviour of
> pci_device_remove().
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/core/sdio_bus.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> For linux-3.1.
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index d2565df..e4e6822 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -167,11 +167,8 @@ static int sdio_bus_remove(struct device *dev)
>  	int ret = 0;
>  
>  	/* Make sure card is powered before invoking ->remove() */
> -	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			goto out;
> -	}
> +	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
> +		pm_runtime_get_sync(dev);
>  
>  	drv->remove(func);
>  
> @@ -191,7 +188,6 @@ static int sdio_bus_remove(struct device *dev)
>  	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>  		pm_runtime_put_sync(dev);
>  
> -out:
>  	return ret;
>  }

Thanks very much, pushed to mmc-next for 3.1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
