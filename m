From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmci-omap: Use resource_size
Date: Fri, 27 Aug 2010 20:42:22 +0100
Message-ID: <20100827194221.GH23079@void.printf.net>
References: <1273133059-6335-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1273133059-6335-1-git-send-email-tklauser@distanz.ch>
Sender: linux-omap-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: jarkko.lavinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, May 06, 2010 at 10:04:19AM +0200, Tobias Klauser wrote:
> Use the resource_size function instead of manually calculating the
> resource size.  This reduces the chance of introducing off-by-one
> errors.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/mmc/host/omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 84d2804..a2c8545 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1415,7 +1415,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  	if (res == NULL || irq < 0)
>  		return -ENXIO;
>  
> -	res = request_mem_region(res->start, res->end - res->start + 1,
> +	res = request_mem_region(res->start, resource_size(res),
>  				 pdev->name);
>  	if (res == NULL)
>  		return -EBUSY;
> @@ -1537,7 +1537,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
>  
>  	iounmap(host->virt_base);
>  	release_mem_region(pdev->resource[0].start,
> -			   pdev->resource[0].end - pdev->resource[0].start + 1);
> +			   resource_size(&pdev->resource[0]));
>  
>  	kfree(host);
>  
> -- 
> 1.6.3.3

This wasn't picked up, and in the meantime the request_mem_region() call
has been converted over to use resource_size() but release_mem_region()
hasn't.  Could someone pick up the second hunk?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
