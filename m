From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v10 1/5] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Mon, 28 Apr 2014 23:43:41 -0500
Message-ID: <535F2DFD.5070307@ti.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com> <1398670860-30695-2-git-send-email-afenkart@gmail.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1398670860-30695-2-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Minor nit...

On 04/28/2014 02:40 AM, Andreas Fenkart wrote:
[..]
>  	/* Do not initialize card-specific things if the power is off */
>  	if (host->power_mode == MMC_POWER_OFF)
> @@ -1117,8 +1138,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>  	int status;
>  
>  	status = OMAP_HSMMC_READ(host->base, STAT);
> -	while (status & INT_EN_MASK && host->req_in_progress) {
> -		omap_hsmmc_do_irq(host, status);
> +	while (status & (INT_EN_MASK | CIRQ_EN)) {
> +		if (host->req_in_progress)
> +			omap_hsmmc_do_irq(host, status);
> +
> +		if (status & CIRQ_EN)
> +			mmc_signal_sdio_irq(host->mmc);
>  
>  		/* Flush posted write */
>  		status = OMAP_HSMMC_READ(host->base, STAT);
> @@ -1127,6 +1152,23 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
> +{
> +	struct omap_hsmmc_host *host = dev_id;
> +	unsigned long flags;
> +
> +	/* cirq is level triggered, disable to avoid infinite loop */
> +	spin_lock_irqsave(&host->irq_lock, flags);

Do you need to save restore flags here? IRQ is already disabled since
you're in hard IRQ context so spin_lock() seems sufficient.

> +	if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
> +		disable_irq_nosync(host->wake_irq);
> +		host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
> +	}
> +	spin_unlock_irqrestore(&host->irq_lock, flags);

spin_unlock() seems sufficient.

regards,
-Joel

