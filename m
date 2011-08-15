From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC 0/4] mmc: tmio, sdhi: provide multiple irq handlers
Date: Mon, 15 Aug 2011 18:43:58 +0900
Message-ID: <20110815094355.GA17762@verge.net.au>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108150950330.7851@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35093 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1HOJoE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2011 05:44:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108150950330.7851@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Aug 15, 2011 at 10:17:28AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Mon, 15 Aug 2011, Simon Horman wrote:
> 
> > The SDHI driver already supports making use of up to three interrupt
> > sources.
> > 
> > This series breaks up the existing interrupt handler into three handlers,
> > one for card access, one for card detect interrupts, and one for SDIO
> > interrupts.  A cover-all handler, which makes use of these new broken-out
> > handlers is provided for for the case where there is only one interrupt
> > source.
> 
> The idea is good, thanks for the patches. Only I'm not sure I find the way 
> you split the patches extremely intuitive;-) How about:
> 
> [PATCH 1/x] cache IRQ masks
>  * in this patch I'd propose to cache SD-card and SDIO IRQ masks in struct 
>    tmio_mmc_host, instead of reading them every time from the hardware

Sure, that sounds reasonable - though it seems somewhat orthogonal to my series.

I'll check over the code, but it seems that you are implying that
the masks never change.

> [PATCH 2/x] split the ISR
>  * in this patch you split the IRQ handler directly into the final form as 
>    after the first your 3 patches, without intermediate steps, also adding 
>    them to the header

The current split was intended to make bite-size patches that
are easy to review. I'm happy to combine the patches as you
suggest if that is what you prefer.

> [PATCH 3/x] SDHI: use specialized ISRs when available
>  * you know what to do here:-) Also, I'd

> #define SH_MOBILE_SDHI_IRQ_SDCARD	0
> #define SH_MOBILE_SDHI_IRQ_CARD_DETECT	1
> #define SH_MOBILE_SDHI_IRQ_SDIO		2
> 
> and use these defines both in platforms
> 
> 	}, [1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
> ...

I think I see what you are getting at there.
I will try and make it so.

> and in sh_mobile_sdhi.c, instead of going "case 2:" Please, also consider 
> unfolding the loop over platform IRQs in probing, it might look better 
> flat.

I agree the current loop isn't entirely clean.
I'll unroll it and see how things look.

> "card_access" in function names I would replace with "io" or "data," 
> "card_irq" with "sdcard_irq" because I believe, that "SD card" is a proper 
> identification to pure storage card in SD format, as opposed to SDIO 
> cards.

Sure, if you would prefer that naming scheme.

> Also, maybe you can double-check, whether you really need all those 
> functions with names, beginning with a double underscore, and whether 
> better names wouldn't be possible for them.

The motivation behind that aspect of the implementation is
to allow re-use of code while avoiding extra register reads.

I believe the two sdio functions could be collapsed into a single function
while only losing (probably unused) debugging information. I will do that,
though I decided against that option previously for the sake of consistency.

For the card_irq() functions I think it is a bit difficult to collapse things
because the access and detect handlers actually need to read the same
register(s).
