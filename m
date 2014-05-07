From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel: don't test host->data
Date: Wed, 7 May 2014 16:43:06 +0200
Message-ID: <20140507144306.GO7438@ldesroches-Latitude-E6320>
References: <1399391006-16007-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:54462 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaEGOmy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 May 2014 10:42:54 -0400
Content-Disposition: inline
In-Reply-To: <1399391006-16007-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Tue, May 06, 2014 at 05:43:26PM +0200, Alexandre Belloni wrote:
> Found using smatch:
> drivers/mmc/host/atmel-mci.c:827 atmci_pdc_complete() warn: variable
> dereferenced before check 'host->data' (see line 807)
> 
> Stop testing host->data as it is not NULL at that point.

I agree

> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 42706ea0ba85..aece7cafbb97 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -820,16 +820,9 @@ static void atmci_pdc_complete(struct atmel_mci *host)
>  
>  	atmci_pdc_cleanup(host);
>  
> -	/*
> -	 * If the card was removed, data will be NULL. No point trying
> -	 * to send the stop command or waiting for NBUSY in this case.
> -	 */
> -	if (host->data) {
> -		dev_dbg(&host->pdev->dev,
> -		        "(%s) set pending xfer complete\n", __func__);
> -		atmci_set_pending(host, EVENT_XFER_COMPLETE);
> -		tasklet_schedule(&host->tasklet);
> -	}
> +	dev_dbg(&host->pdev->dev, "(%s) set pending xfer complete\n", __func__);
> +	atmci_set_pending(host, EVENT_XFER_COMPLETE);
> +	tasklet_schedule(&host->tasklet);
>  }
>  
>  static void atmci_dma_cleanup(struct atmel_mci *host)
> -- 
> 1.9.1
> 
