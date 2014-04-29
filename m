From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v10 1/5] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Mon, 28 Apr 2014 23:42:04 -0500
Message-ID: <535F2D9C.6090304@ti.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com> <1398670860-30695-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50379 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbaD3Cae (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Apr 2014 22:30:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1WfKHa-0000LT-Vm
	for linux-mmc@vger.kernel.org; Wed, 30 Apr 2014 04:30:32 +0200
Received: from 12.130.116.19 ([12.130.116.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 30 Apr 2014 04:30:02 +0200
Received: from joelf by 12.130.116.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 30 Apr 2014 04:30:02 +0200
In-Reply-To: <1398670860-30695-2-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-omap@vger.kernel.orglinux-omap@vger.kernel.org

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


