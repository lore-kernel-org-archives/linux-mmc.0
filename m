From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/6] dma: shdma: increase the number of DMA descriptors
 and add a MODULE_ALIAS()
Date: Thu, 11 Nov 2010 13:48:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011110934360.15747@axis700.grange>
References: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
 <Pine.LNX.4.64.1011110834130.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011110834130.15747@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Nov 2010, Guennadi Liakhovetski wrote:

> Currently shdma only works, if it manages to allocate DMA descriptors for all
> sg elements during the prepare stage. Allocation is carried out from a
> static pool of 32 DMA descriptors. This is not enough for, e.g., MMC, where up
> to 61 sg elements can be sent at once. Ideally we should be able to reuse
> descriptors, while processing one request, but for now increase their number
> to 64.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/dma/shdma.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
> index eb6b54d..85dd0ad 100644
> --- a/drivers/dma/shdma.c
> +++ b/drivers/dma/shdma.c
> @@ -39,7 +39,7 @@ enum sh_dmae_desc_status {
>  	DESC_WAITING,	/* callback called, waiting for ack / re-submit */
>  };
>  
> -#define NR_DESCS_PER_CHANNEL 32
> +#define NR_DESCS_PER_CHANNEL 64

Hm, I think, there's also an alternative solution to this. In 
sh_mmcif.c::sh_mmcif_probe() we find:

	mmc->max_segs = 128;
	mmc->max_blk_size = 512;
	mmc->max_blk_count = 65535;
	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
	mmc->max_seg_size = mmc->max_req_size;

So, I think, it's the .max_segs value, that allows the block and mmc 
layers to issue requests with 61 sg elements, and, possibly, even more. 
So, maybe we can reduce this number to 32? Besides, I don't think 
"->max_blk_count = 65535" makes much sense. From the header:

	unsigned int		max_blk_count;	/* maximum number of blocks in one req */

for which 65535 seems "a bit" too high. Shall we not set it the same way 
as in my today's patch for tmio_mmc as

	mmc->max_blk_count = PAGE_CACHE_SIZE / mmc->max_blk_size * mmc->max_segs;

? Then we can leave the number of descriptors in shdma.c as is. Paul, what 
would you prefer?

>  /* Default MEMCPY transfer size = 2^2 = 4 bytes */
>  #define LOG2_DEFAULT_XFER_SIZE	2
>  
> @@ -1213,3 +1213,4 @@ module_exit(sh_dmae_exit);
>  MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>");
>  MODULE_DESCRIPTION("Renesas SH DMA Engine driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:sh-dma-engine");
> -- 
> 1.7.2.3

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
