From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
 enum
Date: Fri, 19 Aug 2011 09:52:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108190945270.11363@axis700.grange>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-5-git-send-email-horms@verge.net.au>
 <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
 <20110819052004.GB17548@verge.net.au> <20110819063857.GC16419@verge.net.au>
 <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
 <20110819071720.GD16419@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110819071720.GD16419@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 19 Aug 2011, Simon Horman wrote:

> On Fri, Aug 19, 2011 at 03:51:49PM +0900, Magnus Damm wrote:
> > On Fri, Aug 19, 2011 at 3:39 PM, Simon Horman <horms@verge.net.au> wrote:

[snip]

> > > As we are already on the slippery slope of allowing combinations
> > > other than 1 (legacy) or 3 (specific) IRQ sources I plan to implement
> > > a variant of your flag idea. The variation being to use names instead
> > > because a) that allows the use of platform_get_irq_byname() and b)
> > > the flags bits seem to be full and not driver-specific.
> > 
> > Great, platform_get_irq_byname() seems like a perfect match.
> > 
> > May I suggest "hotplug", "data" and "sdio" as names? I don't care very
> > much about names except keeping them short and precise to prevent
> > errors that can only be caught during runtime.
> 
> Earlier on in the life of this series Guennadi suggested
> the names "card_detect", "sdcard" and "sdio". While I am
> not particularly attached to those names the do seem
> reasonable and are already used consistently by this series.
> So I would prefer to use those names.

Just one more thing I forgot to mention in the previous mail: using names 
also makes the transition simple: first patch all platforms with names (at 
least those with multiple IRQs, if your legacy fallback implementation 
will accept unnamed IRQs), and then patch sh_mobile_sdhi.c

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
