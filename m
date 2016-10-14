From: Tony Lindgren <tony@atomide.com>
Subject: Re: Detected aborted journal error in Kernel 3.12
Date: Fri, 14 Oct 2016 04:12:00 -0700
Message-ID: <20161014111200.vjpnwlvtdfjfrgee@atomide.com>
References: <CAFvPE2qruGv6hdGCkuagq9hHEgsmncBPfqD6ftpRLcY6tou9Bw@mail.gmail.com>
 <20160917154123.mfkkhptwvrzavs7y@atomide.com>
 <CAFvPE2ph+bGBkgvjPQfYzn3xwdXrTSXVEBHMo_CEDcdiR6-ekQ@mail.gmail.com>
 <20160919181541.45ahl6ktojawwtui@atomide.com>
 <CAALWOA_RHBW8gYq=HncNgw8k2yKipieRgmCaNyz=kvLF4RSAwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44199 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbcJNLME (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Oct 2016 07:12:04 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA_RHBW8gYq=HncNgw8k2yKipieRgmCaNyz=kvLF4RSAwg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Ankur Tank <ankurtank.linux@gmail.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [161013 13:25]:
> It would indeed be very useful to have a reproducible case on an
> uptodate kernel, but it is definitely not specific to his hardware.
> Someone on the beagleboard forum also hit this issue, but sporadically:
> 
> https://groups.google.com/d/msg/beagleboard/5ZwTUQwGSx4/r15mENdfAwAJ
> 
> I'll quote my reply to it:
> 
> On 4 October 2016 at 21:00, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> > I've also run into this once during an apt-get upgrade, leaving the system
> > in a pretty hosed state. I managed to recover it but it required a lot of
> > effort. Although evidently rare, this is clearly a very serious issue.
> >
> > The direct cause is edma_prep_slave_sg() failing to allocate memory for the
> > struct edma_desc. I don't know whether the kernel is genuinely out of memory
> > or if it simply cannot free it up immediately (the allocation is done with
> > GPF_ATOMIC), and whether this is because it is filled with a backlog of
> > writes or whether a leak of some sort is going on.
> >
> > Instead of deferring until memory is available, or even just proceeding
> > without DMA, the omap_hsmmc driver immediately fails the request with an
> > error, thus pretty much guaranteeing loss of data or even filesystem
> > corruption. I personally think this is completely unacceptable behaviour of
> > a block driver.

Yes I can see that being a problem. The fact that omap_hsmmc does
not fail back to PIO mode is just strange. We've had the omap1
drivers/mmc/host/omap.c work with and without DMA no problem,
no idea why this would not be required also for omap_hsmmc too.

> > I've been meaning to persue this matter on the linux-mmc and/or linux-omap
> > lists, but since it was a single isolated incident and I have lots of other
> > stuff to do I haven't been able to find the time and motivation yet.
> 
> If Ankur has a reproducible case then I think it's time to get
> motivated. Ankur, can you please try 4.7 or 4.8 ?

Yes please. And also let's set up a new bug in bugzilla.kernel.org
for this.

Regards,

Tony
