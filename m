From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc:Add pointer cast to long for slave_id_rx and tx in the function, sh_mmcif_request_dma_one
Date: Mon, 11 May 2015 20:28:24 +0300
Message-ID: <1694173.4OOsIkYGBD@avalon>
References: <1431364517-26967-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:49942 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbEKR2U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 13:28:20 -0400
In-Reply-To: <1431364517-26967-1-git-send-email-xerofoify@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: ulf.hansson@linaro.org, ben.dooks@codethink.co.uk, ykaneko0929@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kouichi.tomita.yn@renesas.com, kuninori.morimoto.gx@renesas.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Monday 11 May 2015 13:15:17 Nicholas Krause wrote:
> This adds a pointer cast to long in the function, sh_mmif_request_dma_one

I would use the uintptr_t type instead of long, as it has been designed for 
this purpose exactly.

> for the when assigning one of the variables slave_id_tx or slave_id_rx of
> the structure pointer,pdata to the void pointer, slave_data and the enum
> directon respectfully.

It's very nice to be respectful, but the commit message doesn't tell why this 
is needed. Something along the lines of "Cast integer to void * through 
uintptr_t to avoid compiler warning when compiling on 64bit platforms." would 
be more helpful.

> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/host/sh_mmcif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7eff087..e276558 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -398,8 +398,8 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> 
>  	if (pdata)
>  		slave_data = direction == DMA_MEM_TO_DEV ?
> -			(void *)pdata->slave_id_tx :
> -			(void *)pdata->slave_id_rx;
> +			(void *)(long)pdata->slave_id_tx :
> +			(void *)(long)pdata->slave_id_rx;
> 
>  	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
>  				slave_data, &host->pd->dev,

-- 
Regards,

Laurent Pinchart

