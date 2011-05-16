From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: Fix race condition resulting in spurious
 interrupts
Date: Mon, 16 May 2011 23:01:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105162258510.29373@axis700.grange>
References: <E1QLbJK-0007cv-An@outmx05.plus.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63043 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1EPVBw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 17:01:52 -0400
In-Reply-To: <E1QLbJK-0007cv-An@outmx05.plus.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

On Sun, 15 May 2011, Paul Parsons wrote:

> There is a race condition in the tmio_mmc_irq() interrupt handler, 
> caused by the presence of a while loop, which results in warnings of 
> spurious interrupts. This was found on an HP iPAQ hx4700 whose HTC ASIC3 
> reportedly incorporates the Toshiba TC6380AF controller.

I wouldn't call this a "race."

> Towards the end of a multiple read (CMD18) operation the handler clears 
> the final RXRDY status bit in the first loop iteration, sees the DATAEND 
> status bit at the bottom of the loop, and so clears the DATAEND status 
> bit in the second loop iteration. However the DATAEND interrupt is still 
> queued in the system somewhere and can't be delivered until the handler 
> has returned. This second interrupt is then reported as spurious in the 
> next call to the handler. Likewise for single read (CMD17) operations. 
> And something similar occurs for multiple write (CMD25) and single write 
> (CMD24) operations, where CMDRESPEND and TXRQ status bits are cleared in 
> a single call.
> 
> In these cases the interrupt handler clears two separate interrupts when 
> it should only clear the one interrupt for which it was invoked. The fix 
> is to remove the while loop.

Sorry, don't understand. Isn't a spurious interrupt reported per "nobody 
cared" if an ISR returns IRQ_NONE? And the TMIO ISR never does this. Is 
the IRQ number, reported as spurious, that of TMIO? Is it shared?

> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> 
> Interestingly a comment in tmio_mmc_pio.c regarding a problem on the 
> SuperH concludes that "waiting for one more interrupt fixes the 
> problem". Is that problem caused by the same race condition? And if so 
> will this patch fix that too?

Don't think so, that comment only applies to the DMA case.

Thanks
Guennadi

> 
> diff -uprN clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c
> --- clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-11 00:54:17.651289833 +0100
> +++ linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc_pio.c	2011-05-14 17:45:06.699829896 +0100
> @@ -593,58 +593,46 @@ static irqreturn_t tmio_mmc_irq(int irq,
>  	pr_debug_status(status);
>  	pr_debug_status(ireg);
>  
> -	if (!ireg) {
> -		tmio_mmc_disable_mmc_irqs(host, status & ~irq_mask);
> -
> -		pr_warning("tmio_mmc: Spurious irq, disabling! "
> -			"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
> -		pr_debug_status(status);
> -
> +	/* Card insert / remove attempts */
> +	if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
> +		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
> +			TMIO_STAT_CARD_REMOVE);
> +		mmc_detect_change(host->mmc, msecs_to_jiffies(100));
>  		goto out;
>  	}
>  
> -	while (ireg) {
> -		/* Card insert / remove attempts */
> -		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
> -			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
> -				TMIO_STAT_CARD_REMOVE);
> -			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
> -		}
> -
> -		/* CRC and other errors */
> -/*		if (ireg & TMIO_STAT_ERR_IRQ)
> - *			handled |= tmio_error_irq(host, irq, stat);
> +	/* CRC and other errors */
> +/*	if (ireg & TMIO_STAT_ERR_IRQ)
> + *		handled |= tmio_error_irq(host, irq, stat);
>   */
>  
> -		/* Command completion */
> -		if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
> -			tmio_mmc_ack_mmc_irqs(host,
> -				     TMIO_STAT_CMDRESPEND |
> -				     TMIO_STAT_CMDTIMEOUT);
> -			tmio_mmc_cmd_irq(host, status);
> -		}
> -
> -		/* Data transfer */
> -		if (ireg & (TMIO_STAT_RXRDY | TMIO_STAT_TXRQ)) {
> -			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_RXRDY | TMIO_STAT_TXRQ);
> -			tmio_mmc_pio_irq(host);
> -		}
> -
> -		/* Data transfer completion */
> -		if (ireg & TMIO_STAT_DATAEND) {
> -			tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
> -			tmio_mmc_data_irq(host);
> -		}
> -
> -		/* Check status - keep going until we've handled it all */
> -		status = sd_ctrl_read32(host, CTL_STATUS);
> -		irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
> -		ireg = status & TMIO_MASK_IRQ & ~irq_mask;
> +	/* Command completion */
> +	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
> +		tmio_mmc_ack_mmc_irqs(host,
> +			     TMIO_STAT_CMDRESPEND |
> +			     TMIO_STAT_CMDTIMEOUT);
> +		tmio_mmc_cmd_irq(host, status);
> +		goto out;
> +	}
> +
> +	/* Data transfer */
> +	if (ireg & (TMIO_STAT_RXRDY | TMIO_STAT_TXRQ)) {
> +		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_RXRDY | TMIO_STAT_TXRQ);
> +		tmio_mmc_pio_irq(host);
> +		goto out;
> +	}
>  
> -		pr_debug("Status at end of loop: %08x\n", status);
> -		pr_debug_status(status);
> +	/* Data transfer completion */
> +	if (ireg & TMIO_STAT_DATAEND) {
> +		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
> +		tmio_mmc_data_irq(host);
> +		goto out;
>  	}
> -	pr_debug("MMC IRQ end\n");
> +
> +	pr_warning("tmio_mmc: Spurious irq, disabling! "
> +		"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
> +	pr_debug_status(status);
> +	tmio_mmc_disable_mmc_irqs(host, status & ~irq_mask);
>  
>  out:
>  	return IRQ_HANDLED;
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
