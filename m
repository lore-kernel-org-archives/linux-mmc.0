From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Tue, 16 Aug 2011 22:45:12 +0900
Message-ID: <20110816134510.GA18412@verge.net.au>
References: <1313489486-831-1-git-send-email-horms@verge.net.au>
 <1313489486-831-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108161232520.13913@axis700.grange>
 <20110816115141.GE3110@verge.net.au>
 <Pine.LNX.4.64.1108161438530.13913@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41391 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab1HPNpR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2011 09:45:17 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108161438530.13913@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Tue, Aug 16, 2011 at 02:40:25PM +0200, Guennadi Liakhovetski wrote:
> On Tue, 16 Aug 2011, Simon Horman wrote:
> 
> > On Tue, Aug 16, 2011 at 01:11:42PM +0200, Guennadi Liakhovetski wrote:
> > > On Tue, 16 Aug 2011, Simon Horman wrote:

[snip]

> > > Sorry, I still don't understand why you check "CARD_DETECT" and request 
> > > "sdcard_irq." Am I missing something or was my comment not clear enough in 
> > > the previous review?
> > > 
> > > > +		if (ret)
> > > > +			goto eirq_card_detect;
> > > > +	} else if (multi_irq)
> > > > +		goto eirq_card_detect;
> > > 
> > > ? Sorry, have you maybe missed my review?
> > > 
> > > > +
> > > > +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> > > > +	if (irq < 0)
> > > > +		goto eirq_sdcard;
> > > > +	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
> > > 
> > > Same here
> > 
> > Sorry, that is a bug.
> > 
> > As the code seems to work on my board I think it should be fixed by
> > inverting the values of SH_MOBILE_SDHI_IRQ_SDCARD and
> > SH_MOBILE_SDHI_IRQ_CARD_DETECT.
> > 
> > I will check that and repost.
> 
> Right, SDIO works, /proc/interrupts has
> 
>   96:          5  sh7372-intca-level     sh_mobile_sdhi.0
>   97:    4116138  sh7372-intca-level     sh_mobile_sdhi.0
>   98:      44822  sh7372-intca-level     sh_mobile_sdhi.0
> 
> So, indeed, #0 is card-detect, #1 is sdcard, #2 is sdio, your enum is 
> wrong and request_irq() swapped ISRs compensate for that mistake.

Thanks.

I swapped around the enum, made the appropriate changes elsewhere
and things do seem to work correctly. Its a bit late now so I'll hold
off on reposting until tomorrow.
