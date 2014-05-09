From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v11 5/7] mmc: omap_hsmmc: abort runtime suspend if pending
 sdio irq detected
Date: Fri, 9 May 2014 22:40:54 +0530
Message-ID: <536D0C1E.1010300@ti.com>
References: <1399591018-12930-1-git-send-email-afenkart@gmail.com> <1399591234-13089-1-git-send-email-afenkart@gmail.com> <1399591234-13089-5-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1399591234-13089-5-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 09 May 2014 04:50 AM, Andreas Fenkart wrote:
> On multicores, an sdio irq handler could be running in parallel to
> runtime suspend. In the worst case it could be waiting for the spinlock
> held by the runtime suspend. When runtime suspend is complete and the
> functional clock (fclk) turned off, the irq handler will continue and
> cause a SIGBUS on the first register access.
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>

Acked-by: Balaji T K <balajitk@ti.com>

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 14857d7..47a5982 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -134,6 +134,9 @@ static void apply_clk_hack(struct device *dev)
>   #define SRD			(1 << 26)
>   #define SOFTRESET		(1 << 1)
>
> +/* PSTATE */
> +#define DLEV_DAT(x)		(1 << (20 + (x)))
> +
>   /* Interrupt masks for IE and ISE register */
>   #define CC_EN			(1 << 0)
>   #define TC_EN			(1 << 1)
> @@ -2455,6 +2458,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
>   	unsigned long flags;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_save(host);
> @@ -2466,14 +2470,29 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>   		/* disable sdio irq handling to prevent race */
>   		OMAP_HSMMC_WRITE(host->base, ISE, 0);
>   		OMAP_HSMMC_WRITE(host->base, IE, 0);
> -		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +
> +		if (!(OMAP_HSMMC_READ(host->base, PSTATE) & DLEV_DAT(1))) {
> +			/*
> +			 * dat1 line low, pending sdio irq
> +			 * race condition: possible irq handler running on
> +			 * multi-core, abort
> +			 */
> +			dev_dbg(dev, "pending sdio irq, abort suspend\n");
> +			OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +			OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
> +			OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
> +			pm_runtime_mark_last_busy(dev);
> +			ret = -EBUSY;
> +			goto abort;
> +		}
>
>   		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
>   		enable_irq(host->wake_irq);
>   		host->flags |= HSMMC_WAKE_IRQ_ENABLED;
>   	}
> +abort:
>   	spin_unlock_irqrestore(&host->irq_lock, flags);
> -	return 0;
> +	return ret;
>   }
>
>   static int omap_hsmmc_runtime_resume(struct device *dev)
>

