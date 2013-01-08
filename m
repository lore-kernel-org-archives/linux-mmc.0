From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Fix warning due to incorrect type
Date: Tue, 8 Jan 2013 07:57:29 +0100
Message-ID: <201301080757.29584.marex@denx.de>
References: <1357605755-8872-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54408 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3AHG5c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 01:57:32 -0500
In-Reply-To: <1357605755-8872-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fixes the following warning when building with W=1 option:
> 
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_adtc':
> drivers/mmc/host/mxs-mmc.c:401:2: warning: comparison between signed and
> unsigned integer expressions [-Wsign-compare]
> 
> The warning happens because 'i' is used in 'for_each_sg(sgl, sg, sg_len,
> i)' and should be made unsigned.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Nice

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/mmc/host/mxs-mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 206fe49..eb33cb1 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -354,7 +354,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
>  	struct dma_async_tx_descriptor *desc;
>  	struct scatterlist *sgl = data->sg, *sg;
>  	unsigned int sg_len = data->sg_len;
> -	int i;
> +	unsigned int i;
> 
>  	unsigned short dma_data_dir, timeout;
>  	enum dma_transfer_direction slave_dirn;

Best regards,
Marek Vasut
