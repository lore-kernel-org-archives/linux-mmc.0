From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: release correct resource
Date: Wed, 18 Apr 2012 10:58:47 +0100
Message-ID: <20120418095847.GJ25053@n2100.arm.linux.org.uk>
References: <y> <1334742553-11060-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43627 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2DRJ7J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 05:59:09 -0400
Content-Disposition: inline
In-Reply-To: <1334742553-11060-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Apr 18, 2012 at 03:19:11PM +0530, Venkatraman S wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>

Please correct this to "Russell King <rmk+kernel@arm.linux.org.uk>"

> 
> res can be one of several resources, as this variable is re-used several
> times during probe.  This can cause the wrong resource parameters to be
> passed to release_mem_region().
> 
> Get the original memory resource before calling release_mem_region().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4254b6f..d15b149 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2042,7 +2042,9 @@ err1:
>  err_alloc:
>  	omap_hsmmc_gpio_free(pdata);
>  err:
> -	release_mem_region(res->start, resource_size(res));
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		release_mem_region(res->start, resource_size(res));
>  	return ret;
>  }
>  
> -- 
> 1.7.10.rc2
> 
