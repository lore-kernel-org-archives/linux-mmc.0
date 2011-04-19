From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Tue, 19 Apr 2011 10:26:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104191015340.1835-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1104191505230.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33068 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751805Ab1DSO0g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 10:26:36 -0400
In-Reply-To: <Pine.LNX.4.64.1104191505230.16641@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 19 Apr 2011, Guennadi Liakhovetski wrote:

> On Tue, 19 Apr 2011, Ohad Ben-Cohen wrote:
> 
> > On Tue, Apr 19, 2011 at 1:46 PM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > > MMC bus PM operations implement a .runtime_idle() method, which calls
> > > pm_runtime_suspend(), but this call is not balanced by a resume
> > > counterpart,
> > 
> > What's the exact flow you refer to ?
> 
> Seeing a "struct dev_pm_ops" instance with .runtime_suspend(), 
> .runtime_resume(), and .runtime_idle() methods I understand, that 
> "suspend" and "resume" are two counterparts, that balance each other.

No, they do not balance each other.  There is no "suspend counter" or
"resume counter".  Whenever a suspend or resume call is made, it
overrides all previous calls.

This is different from dev_pm_info's usage_count value, which _is_ a
counter.  However it does not count suspend or resume calls; instead it
counts the number of routines that need to use the device.  When
usage_count drops to 0, the PM core assumes the device is no longer
being used and may therefore be suspended safely (at which point the
core invokes the pm_idle callback).  If usage_count > 0 then attempts
to call pm_runtime_suspend will fail.

>  Now 
> with "idle" I am not sure which method should balance it. With platform 
> devices in the generic case idle ends up calling 
> pm_generic_runtime_idle(), which then calls pm_runtime_suspend(). So, 
> there should be a balancing pm_runtime_resume() somewhere?

No.  If the device is idle, suspending it is appropriate.  The device 
will be resumed later when a driver needs to use it.

> > > which causes problems with repeated card-plug and driver-load
> > > cycles.
> > 
> > Can you please be more specific ? What are you trying to achieve, what
> > are the problems you encounter ?
> 
> See this patch:
> 
> http://article.gmane.org/gmane.linux.ports.sh.devel/10724
> 
> The purpose of that patch is to (1) implement runtime PM in a way, that 
> whenever the driver is unloaded or the card is ejected the interface is 
> powered down, and (2) implement system-wide PM. For (1) doing the usual
> 
> probe()
> {
> 	...
> 	pm_runtime_enable();
> 	pm_runtime_resume();
> 	...
> }
> 
> remove()
> {
> 	...
> 	pm_runtime_suspend();
> 	pm_runtime_dieabls();
> 	...
> }
> 
> set_ios()
> {
> 	...
> 	if (power_down)
> 		pm_runtime_put();
> 	if (power_up)
> 		pm_runtime_get_sync();
> 	...
> }
> 
> Doesn't work: some internal MMC counters become disbalanced and after one 
> card replug or driver reloading the interface gets stuck with power either 
> permanently on or off.

I'm not familiar enough with the inner workings of the MMC subsystem to 
help much with this.  You'd have to explain things in sufficient detail 
first.

> > >  Removing this method fixes the disbalance.
> > 
> > I'm not sure which disbalance you're referring to, but if you'll
> > remove this method you will break MMC/SDIO runtime PM.
> > 
> > More specifically, without having this ->runtime_idle() handler, the
> > last user giving up its power usage_count (e.g. by calling
> > pm_runtime_put{_sync}) will not end up powering down the MMC card.
> 
> How do they work then? Who does the pm_runtime_resume() to undo the 
> effects of the pm_runtime_suspend(), or is it the platform runtime-pm, 
> that is implementing the "idle" method wrongly?

Put it this way: When do you want the interface to be powered up and 
powered down?  That is, what events should cause the power level to 
change?  The code that handles those events is responsible for calling 
the appropriate PM runtime routines.

Alan Stern

