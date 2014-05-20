From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: split omap-dma header file
Date: Tue, 20 May 2014 07:50:09 -0700
Message-ID: <20140520145009.GC27830@atomide.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
 <1399654013-28262-7-git-send-email-balajitk@ti.com>
 <20140516214116.GM12881@atomide.com>
 <5379F0C6.6070004@ti.com>
 <20140519165441.GI4849@atomide.com>
 <537B5873.5010006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537B5873.5010006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [140520 06:29]:
> On Monday 19 May 2014 10:24 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk@ti.com> [140519 04:54]:
> >>On Saturday 17 May 2014 03:11 AM, Tony Lindgren wrote:
> >>>>-
> >>>>-#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
> >>>>-bool omap_dma_filter_fn(struct dma_chan *, void *);
> >>>>-#else
> >>>>-static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
> >>>>-{
> >>>>-	return false;
> >>>>-}
> >>>>-#endif
> >>>>+#include <linux/omap-dmaengine.h>
> >>>
> >>>Can't the drivers needing this include it directly?
> >>>
> >>
> >>Yes, I have converted omap_hsmmc as part of this patch.
> >>Due to lack of bandwidth, I haven't touched upon all other drivers that include
> >>omap-dma.h. Once that is done in other subsystem after this patch gets merged,
> >>this include can then be removed from omap-dma.h
> >
> >OK
> >
> >>>Also, has this been tested with make randconfig? Changes like
> >>>this can easily cause problems elsewhere..
> >>
> >>May be I am missing something, Can you please elaborate ?
> >
> >You're touching a header included in many places, so you
> >need to make sure you're not accidentally breaking anything.
> >
> 
> True
> 
> >There's an option that allows you to specify some selected
> >options like CONFIG_ARCH_OMAP2PLUS=y with KCONFIG_ALLCONFIG
> >and then run make randconfig. This should expose quite fast
> >if there are some issues for the other drivers.
> >
> >Also, have you compile tested this with omap1_defconfig?
> >
> 
> checked omap1_defconfig and randconfig's, both are OK.

OK thanks:

Acked-by: Tony Lindgren <tony@atomide.com>
