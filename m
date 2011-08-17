From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Wed, 17 Aug 2011 21:07:49 +0900
Message-ID: <20110817120748.GB13086@verge.net.au>
References: <1313578756-10413-1-git-send-email-horms@verge.net.au>
 <1313578756-10413-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108171320310.18317@axis700.grange>
 <20110817114147.GA13086@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54951 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab1HQMHz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 08:07:55 -0400
Content-Disposition: inline
In-Reply-To: <20110817114147.GA13086@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Wed, Aug 17, 2011 at 08:41:47PM +0900, Simon Horman wrote:
> On Wed, Aug 17, 2011 at 01:24:58PM +0200, Guennadi Liakhovetski wrote:
> > On Wed, 17 Aug 2011, Simon Horman wrote:
> > 
> > > Make use of per-source irq handles if the
> > > platform (data) has multiple irq sources.
> > > 
> > > Also, as suggested by Guennadi Liakhovetski,
> > > add and use defines the index or irqs in platform data.
> > > 
> > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > ---
> > > 
> > > v5
> > > * As suggested by Guennadi Liakhovetski:
> > >   - Allow only SH_MOBILE_SDHI_IRQ_SDCARD and
> > >     SH_MOBILE_SDHI_IRQ_SDIO to be specified in platform data
> > 
> > This means, CARD_DETECT is optional in a multi-irq configuration, agree.
> 
> [snip]
> 
> > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> > > +	if (irq >= 0) {
> > > +		multi_irq = true;
> > > +		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
> > > +				  dev_name(&pdev->dev), host);
> > > +		if (ret)
> > > +			goto eirq_sdcard;
> > >  	}
> > 
> > This means SDCARD is optional in both single- and multi-irq 
> > configurations.
> > 
> > > +
> > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> > > +	if (irq < 0)
> > > +		goto eirq_card_detect;
> > 
> > This means, CARD_DETECT is compulsory in all configurations.
> > 
> > One of us must be speaking klingonish today.
> 
> Sorry, I messed that up a bit.
> 
> I will make CARD_DETECT optional in multi-irq configurations.
> Likewise SDIO will be optional in multi-irq configurations.
> 
> But SDCARD will always be required.

Oops, that scheme won't work because in single-irq configuration
the only IRQ will be #0, but SDCARD != 0.

So I have it in mind to allow the following combinations.

i) SDIO, SDCARD, CARD_DETECT
ii) SDIO, SDCARD
iii) SDCARD, CARD_DETECT
iv) SDCARD only (sets multi_irq = true locally, but only one irq!)
v) CARD_DETECT only (uses tmio_mmc_irq(), traditional single-irq setup)

Do you think iii and iv are necessary?
