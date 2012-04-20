From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Fri, 20 Apr 2012 09:43:07 -0700
Message-ID: <20120420164305.GB21106@atomide.com>
References: <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
 <20120419013914.GV21106@atomide.com>
 <20120419174332.GY25053@n2100.arm.linux.org.uk>
 <20120419180741.GX21106@atomide.com>
 <20120420151034.GA24205@n2100.arm.linux.org.uk>
 <20120420152623.GA21106@atomide.com>
 <20120420153743.GB24205@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420153743.GB24205@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 08:41]:
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -83,11 +84,11 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
>  	struct omap_sg *sg = d->sg + idx;
>  
>  	if (d->dir == DMA_DEV_TO_MEM)
> -		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> -				sg->addr, 0, 0);
> +		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
> +			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
>  	else
> -		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> -				sg->addr, 0, 0);
> +		omap_set_dma_src_params(c->dma_ch, d->periph_port,
> +			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
>  
>  	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
>  		d->sync_mode, c->dma_sig, d->sync_type);

These are now wrong way around, should use OMAP_DMA_PORT_EMIFF here..

> @@ -111,11 +112,11 @@ static void omap_dma_start_desc(struct omap_chan *c)
>  	c->sgidx = 0;
>  
>  	if (d->dir == DMA_DEV_TO_MEM)
> -		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> -			d->dev_addr, 0, 0);
> +		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
> +			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
>  	else
> -		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> -			d->dev_addr, 0, 0);
> +		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
> +			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
>  
>  	omap_dma_start_sg(c, d, 0);
>  }

..and then use d->periph_port here. So the following is also needed on
top of this:

--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -84,10 +84,10 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	struct omap_sg *sg = d->sg + idx;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
+		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
 			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
 	else
-		omap_set_dma_src_params(c->dma_ch, d->periph_port,
+		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
 			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
 
 	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
@@ -112,10 +112,10 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->sgidx = 0;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
+		omap_set_dma_src_params(c->dma_ch, d->periph_port,
 			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
 	else
-		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
+		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
 			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
 
 	omap_dma_start_sg(c, d, 0);
