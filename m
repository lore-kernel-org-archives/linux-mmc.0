From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/5] mmc: tmio: Provide separate interrupt handlers
Date: Tue, 16 Aug 2011 13:13:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108161250470.13913@axis700.grange>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-3-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108160924030.13154@axis700.grange> <20110816075919.GA12097@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110816075919.GA12097@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Aug 2011, Simon Horman wrote:

> On Tue, Aug 16, 2011 at 09:41:52AM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 16 Aug 2011, Simon Horman wrote:

[snip]

> > > +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> > > +{
> > > +	struct tmio_mmc_host *host = devid;
> > > +	unsigned int ireg, status;
> > > +
> > > +	pr_debug("MMC IRQ begin\n");
> > > +
> > > +	tmio_mmc_card_irq_status(host, &ireg, &status);
> > > +	__tmio_mmc_card_detect_irq(host, ireg, status);
> > 
> > Same here - I would return, if a card hot-plug event occurred.
> 
> Will do.
> 
> > > +	__tmio_mmc_sdcard_irq(host, ireg, status);
> > 
> > Ditto
> > 
> > > +
> > > +	tmio_mmc_sdio_irq(irq, devid);
> > 
> > Any specific reason, why you now process SDIO IRQs last?
> 
> I believe this is in keeping with the ordering implied by original code.

I believe it's not. The original version did SDIO first, then hotplug, 
then normal IO. I'm not necessarily saying, that the original code was 
correct or better, I'm just saying, it was different. As for which one we 
should prefer... I think, I'd check for hotplug first: if the card is 
removed, no reason to try to communicate with it. And we have to first 
report a new card, before reporting any IRQs from it. But then - IO or 
SDIO as second? Well, since SDIO IRQs are asynchronous, it shouldn't be a 
big problem for them to wait a bit, whereas normal IO IRQs are card's 
response to host's actions, so, the originator might want to know the 
result before processing any asynchronous events. So, I actually like your 
ordering better... But I'll give it a short spin with SDIO, unless you do 
it yourself.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
