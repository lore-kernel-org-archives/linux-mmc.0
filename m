From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/4] mmc: sh_mmcif: add support for Device Tree DMA bindings
Date: Thu, 06 Jun 2013 20:38:46 +0400
Message-ID: <51B0BB16.6060401@cogentembedded.com>
References: <1370533588-23642-1-git-send-email-g.liakhovetski@gmx.de> <1370533588-23642-2-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:55455 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab3FFQil (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 12:38:41 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so2584621lab.38
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jun 2013 09:38:39 -0700 (PDT)
In-Reply-To: <1370533588-23642-2-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hello.

On 06/06/2013 07:46 PM, Guennadi Liakhovetski wrote:

> To use DMA in the Device Tree case the driver has to be modified
> to use suitable API to obtain DMA channels.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>   drivers/mmc/host/sh_mmcif.c |   29 ++++++++++++++++++-----------
>   1 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 06caaae..a0937ae 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -386,25 +386,30 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
>   
>   	host->dma_active = false;
>   
> -	if (!pdata)
> -		return;
> -
> -	if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
> -		return;
> +	if (pdata) {
> +		if (pdata->slave_id_tx <= 0 || pdata->slave_id_rx <= 0)
> +			return;
> +	} else {
> +		if (!host->pd->dev.of_node)

   Why not *else if*?

> +			return;
> +	}
>   
>   	/* We can only either use DMA for both Tx and Rx or not use it at all */
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>   
> -	host->chan_tx = dma_request_channel(mask, shdma_chan_filter,
> -					    (void *)pdata->slave_id_tx);
> +	host->chan_tx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +				pdata ? (void *)pdata->slave_id_tx : NULL,
> +				&host->pd->dev, "tx");

    Could you leave the indentation unchanged here?

> @@ -412,15 +417,17 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
>   	if (ret < 0)
>   		goto ecfgtx;
>   
> -	host->chan_rx = dma_request_channel(mask, shdma_chan_filter,
> -					    (void *)pdata->slave_id_rx);
> +	host->chan_rx = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +				pdata ? (void *)pdata->slave_id_rx : NULL,
> +				&host->pd->dev, "rx");

    ... and here?

WBR, Sergei

