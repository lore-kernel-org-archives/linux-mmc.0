From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Fri, 20 Apr 2012 15:21:28 -0700
Message-ID: <20120420222125.GG21106@atomide.com>
References: <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
 <20120419013914.GV21106@atomide.com>
 <20120419174332.GY25053@n2100.arm.linux.org.uk>
 <20120419180741.GX21106@atomide.com>
 <20120420151034.GA24205@n2100.arm.linux.org.uk>
 <20120420152623.GA21106@atomide.com>
 <20120420153743.GB24205@n2100.arm.linux.org.uk>
 <20120420164305.GB21106@atomide.com>
 <20120420220957.GC24205@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:11189 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab2DTWVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Apr 2012 18:21:31 -0400
Content-Disposition: inline
In-Reply-To: <20120420220957.GC24205@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 15:13]:
> On Fri, Apr 20, 2012 at 09:43:07AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 08:41]:
> > > --- a/drivers/dma/omap-dma.c
> > > +++ b/drivers/dma/omap-dma.c
> > > @@ -83,11 +84,11 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
> > >  	struct omap_sg *sg = d->sg + idx;
> > >  
> > >  	if (d->dir == DMA_DEV_TO_MEM)
> > > -		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> > > -				sg->addr, 0, 0);
> > > +		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
> > > +			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
> > >  	else
> > > -		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> > > -				sg->addr, 0, 0);
> > > +		omap_set_dma_src_params(c->dma_ch, d->periph_port,
> > > +			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
> > >  
> > >  	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
> > >  		d->sync_mode, c->dma_sig, d->sync_type);
> > 
> > These are now wrong way around, should use OMAP_DMA_PORT_EMIFF here..
> 
> Right, sorry about that.
> 
> Okay, I'll combine all these patches into the original adding the
> OMAP DMA support tonight.  So, the new OMAP DMA driver now looks
> like this:

Thanks that works. Tried it on 700, n800, n900, 2430sdp, zoom3 and blaze:

Tested-by: Tony Lindgren <tony@atomide.com>
