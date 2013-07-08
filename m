From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] dmaengine: shdma: fix a build failure on platforms with
 no DMA support
Date: Mon, 8 Jul 2013 10:13:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307081004190.19819@axis700.grange>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
 <51A77CF1.7040105@ti.com> <20130531024438.GB32564@verge.net.au>
 <CAGa+x8413povhYWx+BSj=TdzQDAuYFXmjF4A2kXvQt+=n+380w@mail.gmail.com>
 <Pine.LNX.4.64.1306192125480.12502@axis700.grange> <20130705045350.GA10947@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130705045350.GA10947@intel.com>
Sender: linux-sh-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Dan Murphy <dmurphy@ti.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 5 Jul 2013, Vinod Koul wrote:

> On Wed, Jun 19, 2013 at 09:32:18PM +0200, Guennadi Liakhovetski wrote:
> > Hi Vinod
> > 
> > On Wed, 19 Jun 2013, Kevin Hilman wrote:
> > 
> > > On Thu, May 30, 2013 at 7:44 PM, Simon Horman <horms@verge.net.au> wrote:
> > > 
> > > [...]
> > > 
> > > > thanks for this. I will wait for a refresh (as we discussed earlier today).
> > > > Can I confirm that this is a fix for v3.10? If so, could ou note
> > > > that when you post your revised patch?
> > > 
> > > Any progress on this patch?
> > > 
> > > The SH-mobile defconfigs are still all failing in linux-next.
> > 
> > In
> > 
> > https://patchwork.kernel.org/patch/2640061/
> And you havent CC maintainers on this patch, so I dont have it!

Ouch, sorry, no idea how I managed not to CC you, my apologies!

> > I proposed a simple immediate fix for this problem. Arnd at the same time 
> > developed an alternative solution:
> > 
> > https://patchwork.kernel.org/patch/2644121/
> > https://patchwork.kernel.org/patch/2644111/
> Reading these patches I agree with Arnd that client drivers should not depend on
> dma slave drivers. Existing issue need to be fixed

I'm not arguing against that. My point is the following: also Arnd's 
patches have to deal with the fact, that the filter function has to be in 
files, which will be compiled with SHDMA enabled or disabled in .config. 
He solves this problem by adding #ifdef's to each .c file. Whereas I think 
it's better to add just one such #ifdef to the header. The actual issue of 
DMA client driver dependency on a specific dmaengine controller driver is 
a different (though related) problem and should be addressed separately.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
