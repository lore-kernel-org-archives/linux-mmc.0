From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Wed, 17 Aug 2011 19:46:08 +0900
Message-ID: <20110817104605.GA6586@verge.net.au>
References: <1313542255-31662-1-git-send-email-horms@verge.net.au>
 <1313542255-31662-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108171010350.18317@axis700.grange>
 <20110817094908.GB3561@verge.net.au>
 <Pine.LNX.4.64.1108171154270.18317@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108171154270.18317@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 17, 2011 at 12:06:56PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 17 Aug 2011, Simon Horman wrote:
> 
> > On Wed, Aug 17, 2011 at 10:20:24AM +0200, Guennadi Liakhovetski wrote:
> > > On Wed, 17 Aug 2011, Simon Horman wrote:
> > 
> > [snip ]
> > 
> > > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> > > > +	if (irq >= 0) {
> > > > +		multi_irq = true;
> > > > +		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
> > > > +				  dev_name(&pdev->dev), host);
> > > > +		if (ret)
> > > > +			goto eirq_sdcard;
> > > > +	} else if (multi_irq)
> > > > +		goto eirq_sdcard;
> > > > +
> > > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> > > > +	if (irq < 0)
> > > > +		goto eirq_card_detect;
> > > > +	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
> > > > +	ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
> > > > +	if (ret)
> > > > +		goto eirq_card_detect;
> > > > +
> > > 
> > > I still don't see why a multi-IRQ configuration without a card-detect IRQ 
> > > like
> > > 
> > > static struct resource sdhi_resources[] = {
> > > 	[0] = {
> > > 		.name	= "SDHI2",
> > > 		...,
> > > 	},
> > > 	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
> > > 		.start	= ...,
> > > 		.flags	= IORESOURCE_IRQ,
> > > 	},
> > > 	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
> > > 		.start	= ...,
> > > 		.flags	= IORESOURCE_IRQ,
> > > 	},
> > > };
> > > 
> > > should be invalid. Especially since we actually want to avoid using the 
> > > controller card-detect IRQ for power efficiency and use a GPIO instead.
> > 
> > Ok, in this case you would like SH_MOBILE_SDHI_IRQ_SDCARD to use
> > tmio_mmc_sdcard_irq() ?
> 
> This is a good question. I think your erroring out is wrong, but I'm not 
> sure what is best here. Using sdcard and sdio ISR in this case seems most 
> logical to me. But I don't know if we ever can get hardware, where we 
> indeed only have two SDHI interrupts - one for SDIO and one for SDCARD and 
> CARD_DETECT. I'm not aware of such hardware so far, so, yes, I'd go with 
> SDIO and SDCARD ISRs for now. In any case, this is SDHI internal decision, 
> so, we can change it at any time, if we need to.

Agreed.
