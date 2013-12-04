From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap: Fix error introduced by fix to
 release_mem_region() path
Date: Wed, 4 Dec 2013 10:01:56 -0800
Message-ID: <20131204180154.GT26766@atomide.com>
References: <20131202193459.GL26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15895 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753595Ab3LDSCA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 13:02:00 -0500
Content-Disposition: inline
In-Reply-To: <20131202193459.GL26766@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>

* Tony Lindgren <tony@atomide.com> [131202 11:36]:
> Commit 31ee9181eb92: (mmc: omap: Fix DMA configuration to not rely
> on device id) fixed getting of the DMA resources when booted with
> device tree. This patch however changed the handling of the
> free_mem_region() error path by reusing the struct resource *res
> for the DMA resources.
> 
> Fix the error the same way omap_hsmmc.c driver handles it, which
> is to restore the resource before using the values to call
> release_mem_region().
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Chris, looks like the patch introducing this error is queued in
> arm-soc fixes branch.. Care to ack this one too and I'll merge it
> via arm-soc as well?
> 
> After that, no need for me to patch this driver for my mach-omap2
> device tree conversion I hope :)

OK the previous fixes just hit the mainline, no need for me to
queue this any longer. Please feel free to pick this one up for
the -rc cycle.

Regards,

Tony
 
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1465,7 +1465,10 @@ err_free_mmc_host:
>  err_ioremap:
>  	kfree(host);
>  err_free_mem_region:
> -	release_mem_region(res->start, resource_size(res));
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		release_mem_region(res->start, resource_size(res));
> +
>  	return ret;
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
