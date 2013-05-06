From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 10/22] mmc: mxs-mmc: remove unnecessary
 platform_set_drvdata()
Date: Mon, 6 May 2013 16:49:00 +0800
Message-ID: <20130506084858.GI1749@S2101-09.ap.freescale.net>
References: <005501ce4a22$2377cb80$6a676280$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:7160 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752228Ab3EFIsv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 04:48:51 -0400
Content-Disposition: inline
In-Reply-To: <005501ce4a22$2377cb80$6a676280$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Marc Kleine-Budde' <mkl@pengutronix.de>

On Mon, May 06, 2013 at 03:22:51PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/mmc/host/mxs-mmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 4278a17..d38f0da 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -708,8 +708,6 @@ static int mxs_mmc_remove(struct platform_device *pdev)
>  
>  	mmc_remove_host(mmc);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	if (ssp->dmach)
>  		dma_release_channel(ssp->dmach);
>  
> -- 
> 1.7.2.5
> 
> 

