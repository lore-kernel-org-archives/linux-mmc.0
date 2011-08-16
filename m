From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add defines for platform irq indexes
Date: Tue, 16 Aug 2011 19:12:02 +0900
Message-ID: <20110816101159.GD12097@verge.net.au>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108160944130.13154@axis700.grange>
 <20110816080304.GB12097@verge.net.au>
 <Pine.LNX.4.64.1108161031340.13154@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108161031340.13154@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 16, 2011 at 10:34:22AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 16 Aug 2011, Simon Horman wrote:
> 
> > On Tue, Aug 16, 2011 at 09:51:00AM +0200, Guennadi Liakhovetski wrote:
> > > On Tue, 16 Aug 2011, Simon Horman wrote:
> > > 
> > > > This is intended to make it easier to correctly
> > > > order platform defines in platform data and
> > > > the logic that uses them.
> > > > 
> > > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > Cc: Paul Mundt <lethal@linux-sh.org>
> > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > > ---
> > > >  include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
> > > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> > > > index bd50b36..c66c58c 100644
> > > > --- a/include/linux/mmc/sh_mobile_sdhi.h
> > > > +++ b/include/linux/mmc/sh_mobile_sdhi.h
> > > > @@ -3,6 +3,10 @@
> > > >  
> > > >  #include <linux/types.h>
> > > >  
> > > > +#define SH_MOBILE_SDHI_IRQ_SDCARD	0
> > > > +#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	1
> > > > +#define SH_MOBILE_SDHI_IRQ_SDIO		2
> > > > +
> > > 
> > > An idea: make this an enum, put SH_MOBILE_SDHI_IRQ_NUMBER as a last item 
> > > and use it in sh_mobile_sdhi_remove() as
> > > 
> > > 	for (i = 0; i < SH_MOBILE_SDHI_IRQ_NUMBER; i++) {
> > 
> > Sure.
> > 
> > > ? I would also merge it with PATCH 4/5.
> > 
> > I prefer to keep it separate as 5/5 also depends on this change
> > and that is a change for a different maintainer.
> 
> Yes, 5/5 anyway depends on 3/5 in your case and they are for different 
> maintainers (or need an ack), and, in fact, 5/5 can also be extended to 
> more mach-shmobile boards, and that is not urgent, it can be done any time 
> later. Whereas 3/5 and 4/5 anyway go via one tree and I see no advantage 
> in splitting them. But it's up to you in the end - not a big deal.

I reconsidered and have decided to merge 3/5 and 4/5 as you suggest.
