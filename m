From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3, 3/7] mmc: sdhci-of-esdhc: add tuning support
Date: Mon, 10 Apr 2017 15:38:10 +0300
Message-ID: <deb93f31-abae-6242-801f-505427a7f557@intel.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-4-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490600982-5410-4-git-send-email-yangbo.lu-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Xiaobo Xie <xiaobo.xie-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 27/03/17 10:49, Yangbo Lu wrote:
> eSDHC uses tuning block for tuning procedure. So the tuning
> block control register must be configured properly before tuning.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
> Changes for v2:
> 	- Replaced old function for mmc_host_ops.execute_tuning with
> 	  esdhc_execute_tuning to support eSDHC tuning.
> Changes for v3:
> 	- Put .execute_tuning assigning after after IS_ERR(host) check.
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  5 +++++
>  drivers/mmc/host/sdhci-of-esdhc.c | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 6869567..c4bbd74 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -53,9 +53,14 @@
>  #define ESDHC_CLOCK_HCKEN		0x00000002
>  #define ESDHC_CLOCK_IPGEN		0x00000001
>  
> +/* Tuning Block Control Register */
> +#define ESDHC_TBCTL			0x120
> +#define ESDHC_TB_EN			0x00000004
> +
>  /* Control Register for DMA transfer */
>  #define ESDHC_DMA_SYSCTL		0x40c
>  #define ESDHC_PERIPHERAL_CLK_SEL	0x00080000
> +#define ESDHC_FLUSH_ASYNC_FIFO		0x00040000
>  #define ESDHC_DMA_SNOOP			0x00000040
>  
>  #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index a70499a..8c8e147 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -630,6 +630,25 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
>  	}
>  }
>  
> +static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 val;
> +
> +	/* Use tuning block for tuning procedure */
> +	esdhc_clock_enable(host, false);
> +	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> +	val |= ESDHC_FLUSH_ASYNC_FIFO;
> +	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
> +
> +	val = sdhci_readl(host, ESDHC_TBCTL);
> +	val |= ESDHC_TB_EN;
> +	sdhci_writel(host, val, ESDHC_TBCTL);
> +	esdhc_clock_enable(host, true);
> +
> +	return sdhci_execute_tuning(mmc, opcode);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static u32 esdhc_proctl;
>  static int esdhc_of_suspend(struct device *dev)
> @@ -787,6 +806,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		esdhc_signal_voltage_switch;
> +	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
>  
>  	esdhc_init(pdev, host);
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
