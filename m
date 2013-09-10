From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: abort transfer on timeout error
Date: Tue, 10 Sep 2013 09:54:39 +0200
Message-ID: <522ED03F.5070404@atmel.com>
References: <1378740596-25026-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:5965 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab3IJHyk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Sep 2013 03:54:40 -0400
In-Reply-To: <1378740596-25026-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org, etesial@gmail.com

On 09/09/2013 17:29, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> When a software timeout occurs, the transfer is not stopped. In DMA case, it
> causes DMA channel to be stuck because the transfer is still active causing
> following transfers to be queued but not computed.
>
> Cc: <stable@vger.kernel.org> #3.9+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> Reported-by: Alexander Morozov <etesial@gmail.com>
> ---
>   drivers/mmc/host/atmel-mci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index bdb84da..e9ea2fc 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -582,6 +582,13 @@ static void atmci_timeout_timer(unsigned long data)
>   	if (host->mrq->cmd->data) {
>   		host->mrq->cmd->data->error = -ETIMEDOUT;
>   		host->data = NULL;
> +		/*
> +		 * With some SDIO modules, sometimes DMA transfer hangs. If
> +		 * stop_transfer() is not called then the DMA request is not
> +		 * removed, following ones are queued and never computed.
> +		 */
> +		if (host->state == STATE_DATA_XFER)
> +			host->stop_transfer(host);
>   	} else {
>   		host->mrq->cmd->error = -ETIMEDOUT;
>   		host->cmd = NULL;
>


-- 
Nicolas Ferre
