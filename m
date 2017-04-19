From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/4] mmc: pxamci: Enhance error checking
Date: Wed, 19 Apr 2017 21:12:11 +0200
Message-ID: <87o9vs6wl0.fsf@belgarion.home>
References: <cover.1492492523.git.petr.cvek@tul.cz>
        <a8769ce8-2732-1f23-eaca-33591951ee78@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30888 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968021AbdDSTMQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 15:12:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The pxamci_dma_irq() and pxamci_data_done() should print errors if they
> obtains invalid parameters. Make the pxamci_dma_irq() call with
> the MMC_DATA_READ flag a fault as the DMA callback is used only for write.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  drivers/mmc/host/pxamci.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 80bc8065b50f..48c26d848e9f 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -354,13 +354,22 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
>  	struct mmc_data *data = host->data;
>  	struct dma_chan *chan;
>  
> -	if (!data)
> +	if (!data) {
> +		pr_err("%s: Missing data structure\n",
> +			mmc_hostname(host->mmc));
I'd rather have :
    dev_err(mmc_dev(mmc), ...)

>  		return 0;
> +	}
>  
>  	if (data->flags & MMC_DATA_READ)
>  		chan = host->dma_chan_rx;
> -	else
> +	else if (data->flags & MMC_DATA_WRITE)
>  		chan = host->dma_chan_tx;
> +	else {
> +		pr_err("%s: Unknown data direction, flags=%08x\n",
> +			mmc_hostname(host->mmc), data->flags);
Ditto.

> +	if (!host->data) {
> +		pr_err("%s: Missing data structure\n",
> +			mmc_hostname(host->mmc));
Ditto.

>  		goto out_unlock;
> +	}
>  
> -	if (host->data->flags & MMC_DATA_READ)
> -		chan = host->dma_chan_rx;
> -	else
> -		chan = host->dma_chan_tx;
> +	if (!(host->data->flags & MMC_DATA_WRITE)) {
> +		pr_err("%s: DMA callback is only for tx channel, flags=%x\n",
> +			mmc_hostname(host->mmc), host->data->flags);
Ditto.

> +		goto out_unlock;
> +	}
> +
> +	chan = host->dma_chan_tx;
>  
>  	status = dmaengine_tx_status(chan, host->dma_cookie, &state);
>  
>  	if (likely(status == DMA_COMPLETE)) {
>  		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
>  	} else {
> -		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
> -			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
> +		pr_err("%s: Invalid DMA status %i\n", mmc_hostname(host->mmc),
> +			status);
Ditto.

Cheers.

-- 
Robert
