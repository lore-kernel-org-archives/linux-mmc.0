From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 10:22:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104201011100.2159-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1104200030370.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35690 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753842Ab1DTOXG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 10:23:06 -0400
In-Reply-To: <Pine.LNX.4.64.1104200030370.16641@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:

> Thanks to all for clarifications. Since everyone is convinced, that that 
> idle function in mmc bus.c is appropriate, I restored it and managed to 
> achieve my goals also without it by adjusting the platform runtime pm and 
> power domain prototype support.
> 
> But I still need those "cheating" calls to
> 
> 	pm_runtime_put_noidle(&pdev->dev);
> and
> 	pm_runtime_get_noresume(&pdev->dev);
> 
> in the sh_mmcif.c driver. If I use the patch as posted at
> 
> http://article.gmane.org/gmane.linux.ports.sh.devel/10724
> 
> but without those two calls, and load and unload the driver, while a card 
> is plugged in, unloading the driver doesn't power down the interface, 
> because the usage_count == 1 also after the kernel has soft-ejected the 
> card

You haven't explained why you want the interface to be powered down
when the driver is unloaded.  Normally, unloading a driver is pretty
much the exact reverse of loading it -- if the interface wasn't powered
down before the driver was loaded originally then it shouldn't be
powered down after the driver is unloaded.

Conversely, if the interface _was_ powered down before the driver was 
loaded originally, then making unload the exact reverse of load will 
naturally leave the interface powered down, with no need for any extra 
"cheating" calls.

> mmc0: card 0001 removed
> 
> With my put_noidle() / get_noresume() hack all cases of modprobe / rmmod, 
> card insert / eject work correctly.

Depending on the subsystem, those calls may not be "cheating" at all.  
When a subsystem has to deal with a variety of device drivers, some of
which may not support runtime PM, a standard trick is for the subsystem
to increment the usage_count value before probing.  Drivers that aren't
runtime-PM-aware will leave the usage_count alone and therefore the
device won't ever be runtime-suspended.  Drivers that _are_
runtime-PM-aware will know to decrement the usage_count in their probe
routine and increment it in their remove routine.

However this involves calling pm_runtime_put_noidle() during probe and
pm_runtime_get_noresume() during remove -- not during module
initialization and module unloading.

Alan Stern

