From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Added set_power sdhci_ops handler.
Date: Wed, 22 May 2013 22:30:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305222230050.19558@axis700.grange>
References: <1369244832-23868-1-git-send-email-eu@felipetonello.com>
 <1369244832-23868-2-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369244832-23868-2-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, cjb@laptop.org, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 22 May 2013, Felipe F. Tonello wrote:

> From: "Felipe F. Tonello" <eu@felipetonello.com>
> 
> This is useful for power managment purposes if a sdhci child host wants to
> turn off some other peripheral also.

Sorry, could you elaborate a bit? In what situations is it exactly useful? 
And why cannot the regulator API be used there?

Thanks
Guennadi

> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ea429c..0a026c6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1244,6 +1244,10 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
>  	u8 pwr = 0;
>  
>  	if (power != (unsigned short)-1) {
> +
> +		if (host->ops->set_power)
> +			host->ops->set_power(host, true);
> +
>  		switch (1 << power) {
>  		case MMC_VDD_165_195:
>  			pwr = SDHCI_POWER_180;
> @@ -1259,6 +1263,10 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
>  		default:
>  			BUG();
>  		}
> +	} else {
> +
> +		if (host->ops->set_power)
> +			host->ops->set_power(host, false);
>  	}
>  
>  	if (host->pwr == pwr)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 379e09d..293d56d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -294,6 +294,7 @@ struct sdhci_ops {
>  	void	(*platform_resume)(struct sdhci_host *host);
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>  	void	(*platform_init)(struct sdhci_host *host);
> +	void	(*set_power)(struct sdhci_host *host, bool power);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
