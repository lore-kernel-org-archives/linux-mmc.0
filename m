From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/17] mmc: mmci: Put the device into low power state at system suspend
Date: Tue, 04 Feb 2014 11:22:42 -0800
Message-ID: <8738jyu1h9.fsf@paris.lan>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-6-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391529538-21685-6-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (Ulf
	Hansson's message of "Tue, 4 Feb 2014 16:58:46 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> Due to the available runtime PM callbacks, we are now able to put our
> device into low power state at system suspend.
>
> Earlier we could not accomplish this without trusting a power domain
> for the device to take care of it. Now we are able to cope with
> scenarios both with and without a power domain.
>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/host/mmci.c |   45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c88da1c..074e0cb 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1723,33 +1723,38 @@ static int mmci_remove(struct amba_device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SUSPEND
> -static int mmci_suspend(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int mmci_suspend_late(struct device *dev)
>  {
> -	struct amba_device *adev = to_amba_device(dev);
> -	struct mmc_host *mmc = amba_get_drvdata(adev);
> +	int ret = 0;
>  
> -	if (mmc) {
> -		struct mmci_host *host = mmc_priv(mmc);
> -		pm_runtime_get_sync(dev);
> -		writel(0, host->base + MMCIMASK0);
> -	}
> +	if (pm_runtime_status_suspended(dev))
> +		return 0;
>  
> -	return 0;
> +	if (dev->pm_domain && dev->pm_domain->ops.runtime_suspend)
> +		ret = dev->pm_domain->ops.runtime_suspend(dev);
> +	else
> +		ret = dev->bus->pm->runtime_suspend(dev);
> +
> +	if (!ret)
> +		pm_runtime_set_suspended(dev);

Isn't this basically open-coding pm_runtime_suspend()...

> +	return ret;
>  }
>  
> -static int mmci_resume(struct device *dev)
> +static int mmci_resume_early(struct device *dev)
>  {
> -	struct amba_device *adev = to_amba_device(dev);
> -	struct mmc_host *mmc = amba_get_drvdata(adev);
> +	int ret = 0;
>  
> -	if (mmc) {
> -		struct mmci_host *host = mmc_priv(mmc);
> -		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> -		pm_runtime_put(dev);
> -	}
> +	if (pm_runtime_status_suspended(dev))
> +		return 0;
>  
> -	return 0;
> +	if (dev->pm_domain && dev->pm_domain->ops.runtime_resume)
> +		ret = dev->pm_domain->ops.runtime_resume(dev);
> +	else
> +		ret = dev->bus->pm->runtime_resume(dev);
> +
> +	return ret;

...and this is pm_runtime_resume()? (though both terribly simplified.)

This is starting to show that building with PM_SLEEP but not PM_RUNTIME
is going to force open-coding a lot of stuff that the runtime PM
framework already provides.  So either we need some helper functions so
we're not sprinkling manual calls to bus/pm_domain callbacks all over
the place, or maybe where we need to go is have a way for platforms that
really are "runtime PM centric" to declare that even PM_SLEEP depends on
PM_RUNTIME.  

I'm trying to thing of a good reason to not make PM_SLEEP depend on
PM_RUNTIME for platforms like this.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
