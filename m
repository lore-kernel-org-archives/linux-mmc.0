From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/2 v2] ARM: mach-shmobile: use GPIO interrupt also for
 card eject on SDHI0 on mackerel
Date: Fri, 15 Jul 2011 14:34:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107151432260.22613@axis700.grange>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
 <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
 <Pine.LNX.4.64.1107151257220.22613@axis700.grange>
 <CANqRtoTqppKKRyOnLYQqA=wEm--OpyNNe4vDw9-EjOYZ6vJkEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoTqppKKRyOnLYQqA=wEm--OpyNNe4vDw9-EjOYZ6vJkEg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

On Fri, 15 Jul 2011, Magnus Damm wrote:

> On Fri, Jul 15, 2011 at 7:59 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
> > also card eject events will have to be detected by the platform.
> > This patch prepares mackerel to this switch.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > v2: reconfiguring the pin for card insertion and ejection is no longer
> > needed.
> 
> Hi Guennadi,
> 
> Thanks for your work on this. I may be reading the code wrong, or
> perhaps my stack of patches is not the same as yours, but I can't see
> any code dealing with hotplug for SDHI2? It looks to me that your
> patch is updating the comment about PORT162 and IRQ0 but does nothing
> about it on the software side. I sort of assume that we want to have
> hotplug support via IRQ on all SDHI channels if possible. But maybe
> that's not possible?

Maybe;-) I've spent quite a bit of time trying to make SDHI2 work 
according to the same scheme, but so far I failed. With a kernel, patched 
to produce GPIO interrupts from SDHI2 card insertion, as soon as I insert 
a card the board locks up hard without a single character on any of the 
consoles... So, I'm afraid, we have to leave SDHI2 alone for now.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
