From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 03/11] atmel-mci: use dmaengine helper functions
Date: Thu, 10 Feb 2011 16:18:54 +0100
Message-ID: <4D5401DE.5050506@atmel.com>
References: <1297350506-1522-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:53689 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391Ab1BJP2B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:28:01 -0500
In-Reply-To: <1297350506-1522-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dan Williams <dan.j.williams@intel.com>

Le 10/02/2011 16:08, Linus Walleij :
> Use the new dmaengine helpers to make the code more readable.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---

Thanks for this update Linus! (That was on my todo list ;-))

Best regards,

>  drivers/mmc/host/atmel-mci.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index df5a135..80bc9a5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -589,7 +589,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
>  	struct dma_chan *chan = host->data_chan;
>  
>  	if (chan) {
> -	  chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
> +		dmaengine_terminate_all(chan);
>  		atmci_dma_cleanup(host);
>  	} else {
>  		/* Data transfer was stopped by the interrupt handler */
> @@ -710,8 +710,8 @@ static void atmci_submit_data(struct atmel_mci *host)
>  	struct dma_async_tx_descriptor	*desc = host->dma.data_desc;
>  
>  	if (chan) {
> -		desc->tx_submit(desc);
> -		chan->device->device_issue_pending(chan);
> +		dmaengine_submit(desc);
> +		dma_async_issue_pending(chan);
>  	}
>  }
>  


-- 
Nicolas Ferre
