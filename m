From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
 enum
Date: Tue, 16 Aug 2011 21:23:30 +0900
Message-ID: <20110816122330.GA14755@verge.net.au>
References: <1313489486-831-1-git-send-email-horms@verge.net.au>
 <1313489486-831-5-git-send-email-horms@verge.net.au>
 <20110816111350.GC27653@trinity.fluff.org>
 <20110816113620.GC3110@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110816113620.GC3110@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 16, 2011 at 08:36:20PM +0900, Simon Horman wrote:
> On Tue, Aug 16, 2011 at 12:13:50PM +0100, Ben Dooks wrote:
> > On Tue, Aug 16, 2011 at 07:11:26PM +0900, Simon Horman wrote:
> > > This is intended to make it easier to correctly order IRQs.
> > > 
> > > As suggested by Guennadi Liakhovetski.
> > > 
> > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > ---
> > > 
> > > Depends on "mmc: sdhi: Make use of per-source irq handlers"
> > > ---
> > >  arch/arm/mach-shmobile/board-ag5evm.c   |   12 ++++++------
> > >  arch/arm/mach-shmobile/board-mackerel.c |   18 +++++++++---------
> > >  2 files changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
> > > index ce5c251..c687f67 100644
> > > --- a/arch/arm/mach-shmobile/board-ag5evm.c
> > > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> > > @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] = {
> > >  		.end	= 0xee1000ff,
> > >  		.flags	= IORESOURCE_MEM,
> > >  	},
> > > -	[1] = {
> > > +	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
> > >  		.start	= gic_spi(83),
> > >  		.flags	= IORESOURCE_IRQ,
> > >  	},
> > > -	[2] = {
> > > +	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
> > >  		.start	= gic_spi(84),
> > >  		.flags	= IORESOURCE_IRQ,
> > >  	},
> > > -	[3] = {
> > > +	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
> > >  		.start	= gic_spi(85),
> > >  		.flags	= IORESOURCE_IRQ,
> > >  	},
> > 
> > how about naming the irqs?
> 
> Sorry, I'm not sure what you are asking for.

Sorry, I've turned my brain back on...

I assume you are asking for #defines to give names to 83, 84 and 85.
While I think that sounds reasonable it would not be in
keeping with the rest contents of the platform files in question.
So I am a little reluctant to open that can of worms.
