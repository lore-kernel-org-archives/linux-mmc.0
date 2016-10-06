From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/2] sdhci: Prevent SD from doing highspeed timing when
 sd-broken-highspeed property is set
Date: Thu, 6 Oct 2016 09:39:05 +0300
Message-ID: <22930ee3-7de9-64b6-d133-283b87ff0eaf@intel.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
 <1474660869-15532-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474660869-15532-3-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 23/09/16 23:01, Zach Brown wrote:
> From: Chen Yee Chew <chen.yee.chew-acOepvfBmUk@public.gmane.org>
> 
> When the sd-broken-highspeed property is set the sdhci driver will not
> go into highspeed mode even if the controller and card appear to
> otherwise support highspeed mode.
> 
> This is useful in cases where the controller and card support highspeed,
> but the board configuration or some other issue make highspeed
> impossible.
> 
> Signed-off-by: Chen Yee Chew <chen.yee.chew-acOepvfBmUk@public.gmane.org>
> Reviewed-by: Keng Soon Cheah <keng.soon.cheah-acOepvfBmUk@public.gmane.org>
> Reviewed-by: Joe Hershberger <joe.hershberger-acOepvfBmUk@public.gmane.org>
> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 3 +++
>  drivers/mmc/host/sdhci.c       | 3 ++-
>  drivers/mmc/host/sdhci.h       | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index ad49bfa..7482706 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -87,6 +87,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  	if (of_get_property(np, "broken-cd", NULL))
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  
> +	if (of_get_property(np, "sd-broken-highspeed", NULL))
> +		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HISPD;
> +

We don't really want new quirks.

>  	if (of_get_property(np, "no-1-8-v", NULL))
>  		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4805566..4b0969c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3274,7 +3274,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
>  		mmc->caps &= ~MMC_CAP_CMD23;
>  
> -	if (host->caps & SDHCI_CAN_DO_HISPD)
> +	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
> +	    !(host->quirks2 & SDHCI_QUIRK2_BROKEN_HISPD))

Is there any reason this can't just be:

	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
	    !(of_property_read_bool(mmc_dev(mmc)->of_node, "broken-highspeed")))

AFAICT it does the right thing whether or not OF is configured or of_node is null.

>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c722cd2..3d0fdda 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -424,6 +424,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> +/* Highspeed is broken even if it appears otherwise */
> +#define SDHCI_QUIRK2_BROKEN_HISPD		(1<<16)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
