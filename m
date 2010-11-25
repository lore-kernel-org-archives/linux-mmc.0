From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] [ARM] mxcmmc: remove a unnecessary
	release_resource() call
Date: Thu, 25 Nov 2010 10:03:11 +0100
Message-ID: <20101125090311.GP6017@pengutronix.de>
References: <1290415359.5471.4.camel@mola> <1290415467.5471.7.camel@mola> <1290415534.5471.8.camel@mola> <1290415596.5471.10.camel@mola> <1290415671.5471.13.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55415 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0KYJDY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2010 04:03:24 -0500
Content-Disposition: inline
In-Reply-To: <1290415671.5471.13.camel@mola>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

On Mon, Nov 22, 2010 at 04:47:51PM +0800, Axel Lin wrote:
> Remove release_resource() after release_mem_region().
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/mmc/host/mxcmmc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 2b9f7c8..4428594 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -967,7 +967,6 @@ static int mxcmci_remove(struct platform_device *pdev)
>  	clk_put(host->clk);
>  
>  	release_mem_region(host->res->start, resource_size(host->res));
> -	release_resource(host->res);
>  
>  	mmc_free_host(mmc);
>  
> -- 
> 1.7.2
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
