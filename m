From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap_hsmmc: Reduce max_segs for reliability
Date: Mon, 26 Jun 2017 00:35:09 -0700
Message-ID: <20170626073508.GS3730@atomide.com>
References: <20170622105753.28708-1-willn@resin.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44422 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbdFZHfM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Jun 2017 03:35:12 -0400
Content-Disposition: inline
In-Reply-To: <20170622105753.28708-1-willn@resin.io>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, Will Newton <willn@resin.io>

* Will Newton <will.newton@gmail.com> [170622 03:58]:
> Reduce max_segs to 64, a value that allows allocation of an entire
> EDMA descriptor list within a single page - EDMA descriptors
> are 40 bytes and the header is much larger. This avoids doing a
> higher order GFP_ATOMIC allocation in edma_prep_slave_sg
> when setting up a transfer which can potentially fail due to
> fragmentation under heavy I/O load.
> 
> The current value of 1024 is unusually high in comparison to
> other mmc host drivers which mostly use values of between 1
> and 256. The EDMA driver at present splits lists above 20
> segments in any case so reducing the size of lists we pass to
> it shouldn't add much overhead.

Thanks for updating the description, makes sense to me. Sounds
like we may want to set the size different for ADMA later on if
needed and there's nothing preventing that, so:

Acked-by: Tony Lindgren <tony@atomide.com>

> 
> Signed-off-by: Will Newton <willn@resin.io>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Changes in v2:
>  - More verbose commit message
>  - Rebased onto current master
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 8c39dcc..bbcca93 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2097,9 +2097,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  		host->dbclk = NULL;
>  	}
>  
> -	/* Since we do only SG emulation, we can have as many segs
> -	 * as we want. */
> -	mmc->max_segs = 1024;
> +	/* Set this to a value that allows allocating an entire descriptor
> +	 * list within a page (zero order allocation). */
> +	mmc->max_segs = 64;
>  
>  	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>  	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
> -- 
> 2.9.4
> 
