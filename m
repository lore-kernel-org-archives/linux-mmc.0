From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Thu, 21 Apr 2011 09:58:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104210945470.1939-100000@iolanthe.rowland.org>
References: <201104202344.43652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43613 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752150Ab1DUN6b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 09:58:31 -0400
In-Reply-To: <201104202344.43652.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Wed, 20 Apr 2011, Rafael J. Wysocki wrote:

> On Wednesday, April 20, 2011, Alan Stern wrote:
> > On Wed, 20 Apr 2011, Rafael J. Wysocki wrote:
> > 
> > > On Wednesday, April 20, 2011, Alan Stern wrote:
> > > > On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:
> > > ...
> > > > Ah, now I see the problem.  It looks like we did not give sufficient
> > > > thought to the case where a device starts off (and therefore should
> > > > finish up) in a powered-down state.  Calling pm_runtime_put_sync()
> > > > after unbinding the device driver seems a little futile -- with no
> > > > driver, the subsystem may not be able to power-down the device!
> > > > 
> > > > Rafael, how do you think we should handle this?  Get rid of the 
> > > > pm_runtime_get_no_resume() and pm_runtime_put_sync() calls in 
> > > > dd.c:__device_release_driver()?
> > > 
> > > I think we need pm_runtime_barrier() in there.  Otherwise we risk
> > > removing the driver while there's a runtime PM request pending.
> > > 
> > > But we can move the pm_runtime_put_sync() before driver_sysfs_remove().
> > 
> > What happens if another runtime PM request is queued between the
> > put_sync() and the remove callback?  We may need a safe way to prevent
> > async runtime PM requests while still allowing synchronous requests.
> 
> What about making a rule that it is invalid to schedule a future suspend
> or queue a resume request of a device whose driver is being removed?
> 
> Arguably, we can't prevent people from shooting themselves in the foot this
> way or another and I'm not sure if this particular case is worth additional
> handling.

After thinking about this, I tend to agree.  The synchronization 
issues, combined with the unknown needs of the driver, make this very 
difficult to handle in the PM core.

Here's another possible approach: If a driver wants to leave its device 
in a powered-down state after unbinding then it can invoke its own 
runtime_suspend callback directly, in the following way:

	... unregister all child devices below dev ...
	pm_runtime_disable(dev);
	if (dev->power.runtime_status != RPM_SUSPENDED) {
		pm_set_suspended(dev);
		my_runtime_suspend_callback(dev);
	}

There may be issues regarding coordination with the subsystem or the
power domain; at the moment it's not clear what should be done.  Maybe
the runtime-PM core should include an API for directly invoking the
appropriate callbacks.

Alan Stern

