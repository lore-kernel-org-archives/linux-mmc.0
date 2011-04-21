From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Thu, 21 Apr 2011 22:05:47 +0200
Message-ID: <201104212205.47338.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1104211432490.1939-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42931 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab1DUUFm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 16:05:42 -0400
In-Reply-To: <Pine.LNX.4.44L0.1104211432490.1939-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Thursday, April 21, 2011, Alan Stern wrote:
> On Thu, 21 Apr 2011, Rafael J. Wysocki wrote:
> 
> > > > What about making a rule that it is invalid to schedule a future suspend
> > > > or queue a resume request of a device whose driver is being removed?
> > > > 
> > > > Arguably, we can't prevent people from shooting themselves in the foot this
> > > > way or another and I'm not sure if this particular case is worth additional
> > > > handling.
> > > 
> > > After thinking about this, I tend to agree.  The synchronization 
> > > issues, combined with the unknown needs of the driver, make this very 
> > > difficult to handle in the PM core.
> > > 
> > > Here's another possible approach: If a driver wants to leave its device 
> > > in a powered-down state after unbinding then it can invoke its own 
> > > runtime_suspend callback directly, in the following way:
> > > 
> > > 	... unregister all child devices below dev ...
> > > 	pm_runtime_disable(dev);
> > > 	if (dev->power.runtime_status != RPM_SUSPENDED) {
> > > 		pm_set_suspended(dev);
> > > 		my_runtime_suspend_callback(dev);
> > > 	}
> > 
> > I think this would work too, but then possibly many drivers would have to
> > do the same thing in their "remove" routines.
> > 
> > > There may be issues regarding coordination with the subsystem or the
> > > power domain; at the moment it's not clear what should be done.  Maybe
> > > the runtime-PM core should include an API for directly invoking the
> > > appropriate callbacks.
> > 
> > If we choose this approach, then yes, we should provide a suitable API, but
> > I'm still thinking it would be simpler to move the pm_runtime_put_sync() before driver_sysfs_remove() and make the rule as I said previously. :-)
> 
> The problem is synchronization.  At what point is the driver supposed 
> to stop queuing runtime PM requests?  It would have to be sometime 
> before the pm_runtime_barrier() call.  How is the driver supposed to 
> know when that point is reached?  The remove routine isn't called until 
> later.

Executing the driver's callback is not an ideal solution either, because
it simply may be insufficient (it may be necessary to execute the power
domain and/or subsystem callbacks, pretty much what rpm_suspend() does,
but without taking the usage counter into consideration).

Moreover,  if we want the driver's ->remove() to do the cleanup anyway,
there's not much point in doing any cleanup before in the core.  Also,
there's a little problem that the bus ->remove() is called before the
driver's ->remove(), so it may not be entirely possible to power down
the device when the driver's ->remove() is called already.

I think the current code is better than any of the alternatives considered
so far.

Rafael
