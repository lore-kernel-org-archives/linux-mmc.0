From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
 enum
Date: Fri, 19 Aug 2011 09:45:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108190929030.11363@axis700.grange>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-5-git-send-email-horms@verge.net.au>
 <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
 <20110819052004.GB17548@verge.net.au> <20110819063857.GC16419@verge.net.au>
 <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 19 Aug 2011, Magnus Damm wrote:

> On Fri, Aug 19, 2011 at 3:39 PM, Simon Horman <horms@verge.net.au> wrote:

[snip]

> > As we are already on the slippery slope of allowing combinations
> > other than 1 (legacy) or 3 (specific) IRQ sources I plan to implement
> > a variant of your flag idea. The variation being to use names instead
> > because a) that allows the use of platform_get_irq_byname() and b)
> > the flags bits seem to be full and not driver-specific.
> 
> Great, platform_get_irq_byname() seems like a perfect match.

Indeed, good idea! This API is (unfortunately) so rarely used, that it was  
pretty much completely absent from my "active dictionary."

> May I suggest "hotplug", "data" and "sdio" as names? I don't care very
> much about names except keeping them short and precise to prevent
> errors that can only be caught during runtime.

I don't care about names all that much either, but as Simon suggested in 
his other mail, consistency is good. Besides, yes, I thought about "data"
as a name for the main SDHI IRQ, but I decided it didn't reflect its 
function very well. Firstly, it is not only data, secondly, SDIO IRQs can 
also announce data availability, I think. The even more precise 
description of these two IRQs would be, perhaps, "synchronous" and 
"asynchronous," but that's probably not very intuitivy.

So, I'll accept any names, that you two agree upon:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
