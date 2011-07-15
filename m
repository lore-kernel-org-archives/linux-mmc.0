From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/2] mmc: tmio: two bug-fixes
Date: Fri, 15 Jul 2011 10:46:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107150957570.22613@axis700.grange>
References: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
 <m2pqlcslx4.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m2pqlcslx4.fsf@bob.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ian Molton <ian@mnementh.co.uk>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Thu, 14 Jul 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Thu, Jul 14 2011, Guennadi Liakhovetski wrote:
> > There go two more bug-fixes for tmio on top of my earlier patches from 
> > today, so, should still be easy enough to trace. So, to pull them 
> > together, the previous ones were
> >
> > [PATCH v3] mmc: tmio: fix recursive spinlock, don't schedule with
> > interrupts disabled
> > [PATCH v3] mmc: tmio: maximize power saving
> >
> > And now follow
> >
> > [PATCH 1/2] mmc: tmio: fix a recently introduced bug in DMA code
> > [PATCH 2/2] mmc: tmio: fix a deadlock
> 
> Pushed these four plus "mmc: sh_mmcif: maximize power saving" to
> mmc-next for 3.1.  Thanks!

Thanks for a fast reaction.

> By the way, feel free to send me a MAINTAINERS update taking over
> TMIO if you'd like to; you've been doing the work.  :-)

Thanks for the offer, I appreciate it! I am not the only active tmio mmc 
contributor, but yes, I could take that role upon me, if noone objects. 
Would be good to hear, what Ian thinks? Is he maybe still planning to 
actively working on the driver? Would he like to stay listed as a 
co-maintainer? If I am to maintain the driver alone, it would be good to 
have access to some non-sh-mobile hardware, using it too, at least for 
regression testing. Any idea where to get anything like that?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
