From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Tue, 24 Apr 2012 09:51:48 -0700
Message-ID: <20120424165147.GP3739@atomide.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <20120424103858.GC25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59163 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab2DXQvx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:51:53 -0400
Content-Disposition: inline
In-Reply-To: <20120424103858.GC25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120424 03:42]:
> Here's another patch - for the OMAP NAND driver.
> 
> One thing this doesn't do is configure up the source/destination bursts,
> which the old code did:
> 
>                         omap_set_dma_dest_burst_mode(info->dma_ch,
>                                         OMAP_DMA_DATA_BURST_16);
>                         omap_set_dma_src_burst_mode(info->dma_ch,
>                                         OMAP_DMA_DATA_BURST_16);

Grazvydas, care to give this patch a go?
 
> In dma-engine speak, I'm using "burst" for the number of elements to
> transfer for each frame, with frame sync in place (in other words, the
> number of transfers to occur for every assertion of the DMA request.)
> That's how burst is defined on other DMA hardware, so I'm not entirely
> sure at the moment how critical (or what) the above bursts are doing,
> whether they're configuring the memory side of the transfer or not.
> I'll take a deeper look into that this evening, but in the mean time,
> what's below should be a direct conversion.

For omaps it enables multiple access.
 
> MTD does have this weirdness that it uses vmalloc regions and passes
> addresses in vmalloc regions into drivers - I've left that hack in but
> it is _highly_ undefined whether the DMA activity would be visible via
> the vmalloc mapping as things currently stand.  (You're probably going
> to be okay with non-aliasing VIPT caches, but VIVT and aliasing VIPT
> caches are potential random data corruption candidates.)  That's a
> short-coming across many MTD drivers, one which needs sorting out across
> the board.
> 
>  drivers/mtd/nand/omap2.c |   93 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 92 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index c2b0bba..bd4ed08 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> @@ -119,6 +120,7 @@ struct omap_nand_info {
>  	int				gpmc_cs;
>  	unsigned long			phys_base;
>  	struct completion		comp;
> +	struct dma_chan			*dma;
>  	int				dma_ch;
>  	int				gpmc_irq;
>  	enum {
> @@ -336,6 +338,10 @@ static void omap_nand_dma_cb(int lch, u16 ch_status, void *data)
>  {
>  	complete((struct completion *) data);
>  }
> +static void omap_nand_dma_callback(void *data)
> +{
> +	complete((struct completion *) data);
> +}
>  
>  /*
>   * omap_nand_dma_transfer: configer and start dma transfer
> @@ -373,6 +379,56 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>  		addr = page_address(p1) + ((size_t)addr & ~PAGE_MASK);
>  	}
>  
> +	if (info->dma) {
> +		struct dma_async_tx_descriptor *tx;
> +		struct scatterlist sg;
> +		unsigned n;
> +
> +		sg_init_one(&sg, addr, len);
> +		n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
> +		if (n == 0) {
> +			dev_err(&info->pdev->dev,
> +				"Couldn't DMA map a %d byte buffer\n", len);
> +			goto out_copy;
> +		}
> +
> +		tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
> +			is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
> +			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +		if (!tx) {
> +			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
> +			goto out_copy;
> +		}
> +		tx->callback = omap_nand_dma_callback;
> +		tx->callback_param = &info->comp;
> +		dmaengine_submit(tx);
> +
> +		/*  configure and start prefetch transfer */
> +		ret = gpmc_prefetch_enable(info->gpmc_cs,
> +			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
> +		if (ret) {
> +			/* PFPW engine is busy, use cpu copy method */
> +			dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
> +			goto out_copy;
> +		}
> +
> +		init_completion(&info->comp);
> +		dma_async_issue_pending(info->dma);
> +
> +		/* setup and start DMA using dma_addr */
> +		wait_for_completion(&info->comp);
> +		tim = 0;
> +		limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
> +		while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))
> +			cpu_relax();
> +
> +		/* disable and stop the PFPW engine */
> +		gpmc_prefetch_reset(info->gpmc_cs);
> +
> +		dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
> +		return 0;
> +	}
> +
>  	dma_addr = dma_map_single(&info->pdev->dev, addr, len, dir);
>  	if (dma_mapping_error(&info->pdev->dev, dma_addr)) {
>  		dev_err(&info->pdev->dev,
> @@ -405,7 +461,6 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>  		goto out_copy;
>  
>  	init_completion(&info->comp);
> -
>  	omap_start_dma(info->dma_ch);
>  
>  	/* setup and start DMA using dma_addr */
> @@ -925,12 +980,16 @@ static int omap_dev_ready(struct mtd_info *mtd)
>  	return 1;
>  }
>  
> +extern bool omap_dma_filter_fn(struct dma_chan *chan, void *param);
> +
>  static int __devinit omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
>  	struct omap_nand_platform_data	*pdata;
>  	int				err;
>  	int				i, offset;
> +	dma_cap_mask_t mask;
> +	unsigned sig;
>  
>  	pdata = pdev->dev.platform_data;
>  	if (pdata == NULL) {
> @@ -1011,6 +1070,33 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  		break;
>  
>  	case NAND_OMAP_PREFETCH_DMA:
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +		sig = OMAP24XX_DMA_GPMC;
> +		info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> +		if (!info->dma) {
> +			dev_warn(&pdev->dev, "DMA engine request failed\n");
> +		} else {
> +			struct dma_slave_config cfg;
> +			int rc;
> +
> +			memset(&cfg, 0, sizeof(cfg));
> +			cfg.src_addr = info->phys_base;
> +			cfg.dst_addr = info->phys_base;
> +			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			cfg.src_maxburst = 16;
> +			cfg.dst_maxburst = 16;
> +			rc = dmaengine_slave_config(info->dma, &cfg);
> +			if (rc) {
> +				dev_err(&pdev->dev, "DMA engine slave config failed: %d\n",
> +					rc);
> +				goto out_release_mem_region;
> +			}
> +			info->nand.read_buf   = omap_read_buf_dma_pref;
> +			info->nand.write_buf  = omap_write_buf_dma_pref;
> +			break;
> +		}
>  		err = omap_request_dma(OMAP24XX_DMA_GPMC, "NAND",
>  				omap_nand_dma_cb, &info->comp, &info->dma_ch);
>  		if (err < 0) {
> @@ -1110,6 +1196,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_release_mem_region:
> +	if (info->dma)
> +		dma_release_channel(info->dma);
>  	release_mem_region(info->phys_base, NAND_IO_SIZE);
>  out_free_info:
>  	kfree(info);
> @@ -1127,6 +1215,9 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	if (info->dma_ch != -1)
>  		omap_free_dma(info->dma_ch);
>  
> +	if (info->dma)
> +		dma_release_channel(info->dma);
> +
>  	if (info->gpmc_irq)
>  		free_irq(info->gpmc_irq, info);
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
