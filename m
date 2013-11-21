From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when
 using DMA
Date: Thu, 21 Nov 2013 16:42:08 +0100
Message-ID: <528E29D0.9080507@atmel.com>
References: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:30752 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3KUPmO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2013 10:42:14 -0500
In-Reply-To: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, cjb@laptop.org

On 20/11/2013 16:01, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> With some SDIO devices, timeout errors can happen when reading data. To solve
> this issue the DMA transfer has to be activated before sending the command to
> the device. This order is incorrect in PDC mode. So we have to take care if we
> are using DMA or PDC to know when to send the MMC command.
>
> Cc: <stable@vger.kernel.org> #3.2+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,

> ---
>   drivers/mmc/host/atmel-mci.c |   13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index b8dfe0d..289da71 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1193,11 +1193,22 @@ static void atmci_start_request(struct atmel_mci *host,
>   	iflags |= ATMCI_CMDRDY;
>   	cmd = mrq->cmd;
>   	cmdflags = atmci_prepare_command(slot->mmc, cmd);
> -	atmci_send_command(host, cmd, cmdflags);
> +
> +	/*
> +	 * DMA transfer should be started before sending the command to avoid
> +	 * unexpected errors especially for read operations in SDIO mode.
> +	 * Unfortunately, in PDC mode, command has to be sent before starting
> +	 * the transfer.
> +	 */
> +	if (host->submit_data != &atmci_submit_data_dma)
> +		atmci_send_command(host, cmd, cmdflags);
>
>   	if (data)
>   		host->submit_data(host, data);
>
> +	if (host->submit_data == &atmci_submit_data_dma)
> +		atmci_send_command(host, cmd, cmdflags);
> +
>   	if (mrq->stop) {
>   		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
>   		host->stop_cmdr |= ATMCI_CMDR_STOP_XFER;
>


-- 
Nicolas Ferre
