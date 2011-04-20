From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 16:50:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104201629030.18555@axis700.grange>
References: <Pine.LNX.4.44L0.1104201011100.2159-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59156 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1DTOun (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 10:50:43 -0400
In-Reply-To: <Pine.LNX.4.44L0.1104201011100.2159-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 20 Apr 2011, Alan Stern wrote:

> On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:
> 
> > Thanks to all for clarifications. Since everyone is convinced, that that 
> > idle function in mmc bus.c is appropriate, I restored it and managed to 
> > achieve my goals also without it by adjusting the platform runtime pm and 
> > power domain prototype support.
> > 
> > But I still need those "cheating" calls to
> > 
> > 	pm_runtime_put_noidle(&pdev->dev);
> > and
> > 	pm_runtime_get_noresume(&pdev->dev);
> > 
> > in the sh_mmcif.c driver. If I use the patch as posted at
> > 
> > http://article.gmane.org/gmane.linux.ports.sh.devel/10724
> > 
> > but without those two calls, and load and unload the driver, while a card 
> > is plugged in, unloading the driver doesn't power down the interface, 
> > because the usage_count == 1 also after the kernel has soft-ejected the 
> > card
> 
> You haven't explained why you want the interface to be powered down
> when the driver is unloaded.  Normally, unloading a driver is pretty
> much the exact reverse of loading it -- if the interface wasn't powered
> down before the driver was loaded originally then it shouldn't be
> powered down after the driver is unloaded.

The interface was powered down before loading. And yes, sorry, I actually 
meant probing and removing, which in case of platform devices is almost 
equivalent to driver loading and unloading, yes, you can also use bind / 
unbind to do the same.

> Conversely, if the interface _was_ powered down before the driver was 
> loaded originally, then making unload the exact reverse of load will 
> naturally leave the interface powered down, with no need for any extra 
> "cheating" calls.

Not quite, see below.

> > mmc0: card 0001 removed
> > 
> > With my put_noidle() / get_noresume() hack all cases of modprobe / rmmod, 
> > card insert / eject work correctly.
> 
> Depending on the subsystem, those calls may not be "cheating" at all.  
> When a subsystem has to deal with a variety of device drivers, some of
> which may not support runtime PM, a standard trick is for the subsystem
> to increment the usage_count value before probing.  Drivers that aren't
> runtime-PM-aware will leave the usage_count alone and therefore the
> device won't ever be runtime-suspended.  Drivers that _are_
> runtime-PM-aware will know to decrement the usage_count in their probe
> routine and increment it in their remove routine.
> 
> However this involves calling pm_runtime_put_noidle() during probe and
> pm_runtime_get_noresume() during remove -- not during module
> initialization and module unloading.

As I said above - I did mean probe() and remove(). Now, I have now traced 
down the cause of my problem. In dd.c::driver_probe_device():

	pm_runtime_get_noresume(dev);
	pm_runtime_barrier(dev);
	ret = really_probe(dev, drv);
	pm_runtime_put_sync(dev);

Which means, if originally 

	usage_count = 0
	disable_depth = 1

the first get_noresume() increments

	usage_count = 1

In probe() we do enable(), which decrements

	disable_depth = 0

and resume(), which poweres everything up. If we now return from probe(), 
put_sync() will power down and decrement

	usage_count = 0

which is ok for sh_mmcif.c. If there is no card in the slot, we keep 
interface powered down, card polling works also in powered down mode if 
there's a GPIO, or the MMC core will wake us up every time to check for a 
new card. Next, let's say, a card has been inserted, and we rmmod the 
driver. dd.c::__device_release_driver() does

	pm_runtime_get_noresume(dev);
	pm_runtime_barrier(dev);
	.remove();
	pm_runtime_put_sync(dev);

the first get_noresume() increments

	usage_count = 1

Then if we go the "exact inverse" route, we do suspend(), which does 
nothing, because usage_count > 0, then we do disable(), which increments

	disable_depth = 1

After returning from .remove() pm_runtime_put_sync() is executed, but also 
it does nothing, because disable_depth > 0. The interface stays powered 
on. So, as you see, the problem is on the .remove() path. I work around it 
by doing

	pm_runtime_put_sync(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
	pm_runtime_get_noresume(&pdev->dev);

in the driver. This way the first call decrements

	usage_count = 0

and powers down, the second one increments

	disable_depth = 1

the third one

	usage_count = 1

Then, back in dd.c again

	usage_count = 0

and all is happy:-) But the above triplet looks kinda ugly to me. Is this 
really how it is supposed to work?...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
