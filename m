From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 11:12:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104201104230.2159-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1104201629030.18555@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36990 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754083Ab1DTPM4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 11:12:56 -0400
In-Reply-To: <Pine.LNX.4.64.1104201629030.18555@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:

> As I said above - I did mean probe() and remove(). Now, I have now traced 
> down the cause of my problem. In dd.c::driver_probe_device():
> 
> 	pm_runtime_get_noresume(dev);
> 	pm_runtime_barrier(dev);
> 	ret = really_probe(dev, drv);
> 	pm_runtime_put_sync(dev);
> 
> Which means, if originally 
> 
> 	usage_count = 0
> 	disable_depth = 1
> 
> the first get_noresume() increments
> 
> 	usage_count = 1
> 
> In probe() we do enable(), which decrements
> 
> 	disable_depth = 0
> 
> and resume(), which poweres everything up. If we now return from probe(), 
> put_sync() will power down and decrement
> 
> 	usage_count = 0
> 
> which is ok for sh_mmcif.c. If there is no card in the slot, we keep 
> interface powered down, card polling works also in powered down mode if 
> there's a GPIO, or the MMC core will wake us up every time to check for a 
> new card. Next, let's say, a card has been inserted, and we rmmod the 
> driver. dd.c::__device_release_driver() does
> 
> 	pm_runtime_get_noresume(dev);
> 	pm_runtime_barrier(dev);
> 	.remove();
> 	pm_runtime_put_sync(dev);
> 
> the first get_noresume() increments
> 
> 	usage_count = 1
> 
> Then if we go the "exact inverse" route, we do suspend(), which does 
> nothing, because usage_count > 0, then we do disable(), which increments
> 
> 	disable_depth = 1
> 
> After returning from .remove() pm_runtime_put_sync() is executed, but also 
> it does nothing, because disable_depth > 0. The interface stays powered 
> on. So, as you see, the problem is on the .remove() path. I work around it 
> by doing
> 
> 	pm_runtime_put_sync(&pdev->dev);
> 	pm_runtime_disable(&pdev->dev);
> 	pm_runtime_get_noresume(&pdev->dev);
> 
> in the driver. This way the first call decrements
> 
> 	usage_count = 0
> 
> and powers down, the second one increments
> 
> 	disable_depth = 1
> 
> the third one
> 
> 	usage_count = 1
> 
> Then, back in dd.c again
> 
> 	usage_count = 0
> 
> and all is happy:-) But the above triplet looks kinda ugly to me. Is this 
> really how it is supposed to work?...

Ah, now I see the problem.  It looks like we did not give sufficient
thought to the case where a device starts off (and therefore should
finish up) in a powered-down state.  Calling pm_runtime_put_sync()
after unbinding the device driver seems a little futile -- with no
driver, the subsystem may not be able to power-down the device!

Rafael, how do you think we should handle this?  Get rid of the 
pm_runtime_get_no_resume() and pm_runtime_put_sync() calls in 
dd.c:__device_release_driver()?

Alan Stern

