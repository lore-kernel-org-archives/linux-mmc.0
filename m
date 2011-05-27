From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: RE: [PATCH 3/3] ARM: mach-shmobile: add coherent DMA mask for SDHI
 devices
Date: Fri, 27 May 2011 18:51:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271848190.30635@axis700.grange>
References: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
 <Pine.LNX.4.64.1105271243390.25265@axis700.grange>
 <0D753D10438DA54287A00B027084269764D331AB17@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50549 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab1E0Qv3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 12:51:29 -0400
In-Reply-To: <0D753D10438DA54287A00B027084269764D331AB17@AUSP01VMBX24.collaborationhost.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On Fri, 27 May 2011, H Hartley Sweeten wrote:

> On Friday, May 27, 2011 3:45 AM, Guennadi Liakhovetski wrote:
> >
> > It is now required, because the SDHI / TMIO driver is using
> > dma_alloc_coherent() to allocate the DMA bounce buffer.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  arch/arm/mach-shmobile/board-ag5evm.c   |    6 ++++--
> >  arch/arm/mach-shmobile/board-ap4evb.c   |    6 ++++--
> >  arch/arm/mach-shmobile/board-mackerel.c |    9 ++++++---
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
> > index c95258c..a5a737c 100644
> > --- a/arch/arm/mach-shmobile/board-ag5evm.c
> > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> > @@ -372,7 +372,8 @@ static struct platform_device sdhi0_device = {
> >  	.num_resources	= ARRAY_SIZE(sdhi0_resources),
> >  	.resource	= sdhi0_resources,
> >  	.dev	= {
> > -		.platform_data	= &sdhi0_info,
> > +		.platform_data		= &sdhi0_info,
> > +		.coherent_dma_mask	= 0xffffffff,
> 
> I think these should all be
> 
> 		.coherent_dma_mask	= DMA_BIT_MASK(32),

Yes, you're right, I looked at a bad example:( Will post v2 next week. 
Thanks for spotting.

> Also, don't you need the .dma_mask also?

It works without it:) Not sure, if it's needed for some kind of academic 
correctness though.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
