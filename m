From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] atmel-mci: fix transfers < 16 bytes problem in PDC mode
Date: Fri, 6 Dec 2013 12:10:38 +0100
Message-ID: <20131206111038.GZ3582@odulo-laptop>
References: <20131204080943.GK3582@odulo-laptop>
 <1386236716-25163-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:45476 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3LFLKe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 06:10:34 -0500
Content-Disposition: inline
In-Reply-To: <1386236716-25163-1-git-send-email-olivier@sobrie.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Olivier,

On Thu, Dec 05, 2013 at 10:45:16AM +0100, Olivier Sobrie wrote:

[...]

> 
> Hi Ludovic,
> 
> With this patch I'm able to use the wlan sdio module wl1271.
> When you've time, it would be nice to validate or fix this
> patch.

Thanks for your patch, before giving my ack I would like to test it on
other devices. I hope I could manage that next week.

Regards

Ludovic

> 
> Thanks for your help,
> 
> Olivier
> 
>  drivers/mmc/host/atmel-mci.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index b86b482..c599731 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -45,6 +45,7 @@
>  
>  #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
>  #define ATMCI_DMA_THRESHOLD	16
> +#define ATMCI_PDC_MIN_DATASIZE	16
>  
>  enum {
>  	EVENT_CMD_RDY = 0,
> @@ -765,7 +766,10 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
>  	}
>  
>  	if (host->data_size <= buf_size) {
> -		if (host->data_size & 0x3) {
> +		if ((host->data_size < ATMCI_PDC_MIN_DATASIZE) &&
> +		    (dir == XFER_TRANSMIT)) {
> +			atmci_writel(host, counter_reg, 4);
> +		} else if (host->data_size & 0x3) {
>  			/* If size is different from modulo 4, transfer bytes */
>  			atmci_writel(host, counter_reg, host->data_size);
>  			atmci_writel(host, ATMCI_MR, host->mode_reg | ATMCI_MR_PDCFBYTE);
> -- 
> 1.7.9.5
> 
