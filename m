From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH/RESEND] mmc: tmio_mmc: allow multi-element
	scatter-gather lists (fwd)
Date: Wed, 5 Jan 2011 19:32:18 +0000
Message-ID: <20110105193218.GA9198@void.printf.net>
References: <Pine.LNX.4.64.1011111214020.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011111214020.15747@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Thu, Nov 11, 2010 at 12:15:06PM +0100, Guennadi Liakhovetski wrote:
> The driver is capable of handling multi-element sg lists in both PIO and DMA
> modes. In DMA mode this also allows to use the DMA sg capability more
> efficiently and almost doubles the throughput.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Sorry, one of the addresses was wrong last time, resending to all again to 
> simplify commenting.
> 
>  drivers/mmc/host/tmio_mmc.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index e7765a8..9034414 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -864,10 +864,14 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
>  		goto host_free;
>  
>  	mmc->ops = &tmio_mmc_ops;
> -	mmc->caps = MMC_CAP_4_BIT_DATA;
> -	mmc->caps |= pdata->capabilities;
> +	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
>  	mmc->f_max = pdata->hclk;
>  	mmc->f_min = mmc->f_max / 512;
> +	mmc->max_segs = 32;
> +	mmc->max_blk_size = 512;
> +	mmc->max_blk_count = PAGE_CACHE_SIZE / mmc->max_blk_size * mmc->max_segs;
> +	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> +	mmc->max_seg_size = mmc->max_req_size;
>  	if (pdata->ocr_mask)
>  		mmc->ocr_avail = pdata->ocr_mask;
>  	else

Thanks, pushed to mmc-next for .38 with a trivial style change:

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 9034414..4e75799 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -869,7 +869,8 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	mmc->f_min = mmc->f_max / 512;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
-	mmc->max_blk_count = PAGE_CACHE_SIZE / mmc->max_blk_size * mmc->max_segs;
+	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
+		mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 	if (pdata->ocr_mask)
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
