From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] mmc: atmel-mci: remove unused sg_len variable
Date: Tue, 11 Jul 2017 11:49:03 +0200
Message-ID: <20170711094903.favkmc5rjb76q2dq@rfolt0960.corp.atmel.com>
References: <1499330625-108840-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:22071 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdGKJt2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 05:49:28 -0400
Content-Disposition: inline
In-Reply-To: <1499330625-108840-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>

On Thu, Jul 06, 2017 at 04:43:45PM +0800, Shawn Lin wrote:
> We got a warning:
> 
> drivers/mmc/host/atmel-mci.c:1086:15: warning: variable 'sg_len' set but
> not used [-Wunused-but-set-variable]
> 
> Ideally we should check to see if sg_len is zero but looking
> into the code closely, I didn't find any possible to do that as
> atmci_start_request didn't even deploy any error handling for
> its host->prepare_data hook. So even we return error value for iflags
> like what other host drivers did, for instance, sdhci and dwmmc, it still
> need some extra work to improve the code.
> 
> Just remove it to silent the warning, although it isn't perfect.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
> 
>  drivers/mmc/host/atmel-mci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 97de2d3..53e30b0 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1083,7 +1083,6 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
>  atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
>  {
>  	u32 iflags, tmp;
> -	unsigned int sg_len;
>  	int i;
>  
>  	data->error = -EINPROGRESS;
> @@ -1108,8 +1107,8 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
>  
>  	/* Configure PDC */
>  	host->data_size = data->blocks * data->blksz;
> -	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> -			    mmc_get_dma_dir(data));
> +	dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> +		   mmc_get_dma_dir(data));
>  
>  	if ((!host->caps.has_rwproof)
>  	    && (host->data->flags & MMC_DATA_WRITE)) {
> -- 
> 1.9.1
> 
> 
