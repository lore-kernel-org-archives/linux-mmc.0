From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Fri, 21 Jan 2011 14:33:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101211431050.8580@xanadu.home>
References: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:16814 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1AUTdO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 14:33:14 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFE00MIS0YR4680@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 21 Jan 2011 14:32:51 -0500 (EST)
In-reply-to: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>

On Fri, 21 Jan 2011, zhangfei gao wrote:

> >From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Fri, 21 Jan 2011 18:02:47 -0500
> Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq
> 
> 	When debugging wifi host sleep, race condition about
> SDHCI_INT_CARD_INT happens.
> 	Host free_irq in suspend and request_irq when resume back.
> 	However SDHCI_INT_CARD_INT is not cleared, so interrupt will
> immediately happen after request_irq.
> 	mmc_signal_sdio_irq will be called and wakeup sdio_irq_thread.
> 	As a result irq_handler in sdio driver is called even before host resume back.
> 
> 	The correct case is mmc_sdio_resume calls mmc_signal_sdio_irq to
> wakeup sdio_irq_thread
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>

That makes sense, as long as the masking of interrupts doesn't prevent 
a SDIO card interrupt from waking up the host system.


> ---
>  drivers/mmc/host/sdhci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aacd78c..97074ae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1707,6 +1707,7 @@ int sdhci_suspend_host(struct sdhci_host *host,
> pm_message_t state)
>  	ret = mmc_suspend_host(host->mmc);
>  	if (ret)
>  		return ret;
> +	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
> 
>  	free_irq(host->irq, host);
> 
> -- 
> 1.7.0.4
> 
