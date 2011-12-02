From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sh_mmcif: process requests asynchronously
Date: Fri, 2 Dec 2011 16:54:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112021639120.21238@axis700.grange>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
 <CANqRtoRvqZCuVQF0zeh9kyCnanfjA6k6ttWLOcf1y+-b4OcM_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoRvqZCuVQF0zeh9kyCnanfjA6k6ttWLOcf1y+-b4OcM_Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Magnus

On Sat, 3 Dec 2011, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Thu, Dec 1, 2011 at 12:07 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This patch converts the sh_mmcif MMC host driver to process requests
> > asynchronously instead of waiting in its .request() method for completion.
> > This is achieved by using threaded IRQs.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thanks for your work on this! Interesting with threaded IRQ support.
> 
> Would it be possible to split this up into smaller chunks somehow?
> This rather big patch is more or less a rewrite of the driver - so it
> somehow looks to me like you're implementing multiple functional
> changes in a single commit. Maybe you're not doing that, but if so
> then at least the new code flow needs some documentation.

Yes, the diff is, unfortunately, pretty large. But so far I don't see a 
good way to split it. Essentially this patch introduces two changes:

1. asynchronous request processing
2. threaded IRQ

but, I don't think, splitting these changes would make sense. You don't 
want to implement (1) by another means, other than (2), because that'd be 
a double work. And if you already do (2) - you practically arrive at (1) 
too.

I'm not that much rewriting the driver either - most low-level functions 
are preserved, but many of them have to be rearranged. E.g., functions to 
process specific requests - single block read / write, multiple block r/w, 
etc., are split into to - the part before going to sleep, and the part 
after the hardware interrupt, which is now called from the IRQ thread. But 
the diff cannot show that as moved code, so, it looks huge.

But I'll spend some more time, thinking about possibilities to split or 
reduce the diff, maybe I get an idea...

> How about including some ascii-art style charts of the different
> states involved in reads and writes both for PIO and DMA? I'm thinking
> of something similar to the comments that describe the bus transaction
> and interrupts in drivers/i2c/busses/i2c-sh_mobile.c.

Ok, I'll try to add some documentation to the next version of the patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
