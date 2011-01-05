From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/6 v3] mmc: tmio: implement SDIO IRQ
Date: Wed, 5 Jan 2011 22:09:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101052203090.5375@axis700.grange>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
 <1293574956-30035-2-git-send-email-arnd@arndnet.de> <20110105205717.GG9198@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1AEVKt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 16:10:49 -0500
In-Reply-To: <20110105205717.GG9198@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Hannemann <arnd@arndnet.de>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Chris

On Wed, 5 Jan 2011, Chris Ball wrote:

> Hi Arnd,
> 
> On Tue, Dec 28, 2010 at 11:22:31PM +0100, Arnd Hannemann wrote:
> > This patch implements SDIO IRQ support for mfds which
> > announce the TMIO_MMC_SDIO_IRQ flag for tmio_mmc.
> > If MMC_CAP_SDIO_IRQ is also set SDIO IRQ signalling is activated.
> > Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.
> > 
> > Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> 
> Thanks, pushed to mmc-next for .38 with minor 80-col changes below:
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index d74cdac..8d55b8a 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -298,8 +298,9 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
>  
>  	/*
>  	 * Testing on sh-mobile showed that SDIO IRQs are unmasked when
> -	 * CTL_CLK_AND_WAIT_CTL gets written, so we have to disable the device IRQ
> -	 * here and restore the SDIO IRQ mask before re-enabling the device IRQ.
> +	 * CTL_CLK_AND_WAIT_CTL gets written, so we have to disable the
> +	 * device IRQ here and restore the SDIO IRQ mask before
> +	 * re-enabling the device IRQ.
>  	 */
>  	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
>  		disable_irq(host->irq);
> @@ -623,8 +624,9 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
>  		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
>  
>  		if (sdio_ireg && !host->sdio_irq_enabled) {
> -			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
> -				sdio_status, sdio_irq_mask, sdio_ireg);
> +			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! "
> +				   "0x%04x 0x%04x 0x%04x\n",
> +				   sdio_status, sdio_irq_mask, sdio_ireg);

Don't think this is a good idea. 80-columns restriction stopped being a 
requirement since some time, and - it has always been explicitly requested 
_not_ to break strings in prints because of this. Yes, it is not very 
likely, that someone will grep for "IRQ.*\%" or similar, still, I would 
prefer to keep the original version.

Thanks
Guennadi

>  			tmio_mmc_enable_sdio_irq(host->mmc, 0);
>  			goto out;
>  		}
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
