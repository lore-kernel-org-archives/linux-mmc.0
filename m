From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/6] mmc: sdhci: implement enhanced strobe callback
Date: Mon, 9 May 2016 15:02:19 +0300
Message-ID: <57307C4B.2040003@intel.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
 <1461898103-29026-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461898103-29026-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 29/04/16 05:48, Shawn Lin wrote:
> Enhanced strobe stuff currently is beyond the scope
> of Secure Digital Host Controller Interface. So we can't
> find a register here to enable/disable it. We experct
> variant drivers to finish the details according to their
> vendor settings.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 94cffa7..a04e4c4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2049,6 +2049,16 @@ out_unlock:
>  	return err;
>  }
>  
> +static int sdhci_prepare_enhanced_strobe(struct mmc_host *mmc, bool enable)
> +{
> +	/*
> +	* Currently we can't find a register to enable enhanced strobe
> +	* function for standard sdhci, so we expect variant drivers to
> +	* overwrite it.
> +	*/
> +	return -EINVAL;
> +}

Since we don't need it at the moment, let's not have it at all for now.

> +
>  static int sdhci_select_drive_strength(struct mmc_card *card,
>  				       unsigned int max_dtr, int host_drv,
>  				       int card_drv, int *drv_type)
> @@ -2158,6 +2168,7 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.enable_sdio_irq = sdhci_enable_sdio_irq,
>  	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
>  	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
> +	.prepare_enhanced_strobe	= sdhci_prepare_enhanced_strobe,
>  	.execute_tuning			= sdhci_execute_tuning,
>  	.select_drive_strength		= sdhci_select_drive_strength,
>  	.card_event			= sdhci_card_event,
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
