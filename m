From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Thu, 21 Apr 2011 14:36:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104211432490.1939-100000@iolanthe.rowland.org>
References: <201104212000.29754.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57533 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750887Ab1DUSgJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 14:36:09 -0400
In-Reply-To: <201104212000.29754.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Thu, 21 Apr 2011, Rafael J. Wysocki wrote:

> > > What about making a rule that it is invalid to schedule a future suspend
> > > or queue a resume request of a device whose driver is being removed?
> > > 
> > > Arguably, we can't prevent people from shooting themselves in the foot this
> > > way or another and I'm not sure if this particular case is worth additional
> > > handling.
> > 
> > After thinking about this, I tend to agree.  The synchronization 
> > issues, combined with the unknown needs of the driver, make this very 
> > difficult to handle in the PM core.
> > 
> > Here's another possible approach: If a driver wants to leave its device 
> > in a powered-down state after unbinding then it can invoke its own 
> > runtime_suspend callback directly, in the following way:
> > 
> > 	... unregister all child devices below dev ...
> > 	pm_runtime_disable(dev);
> > 	if (dev->power.runtime_status != RPM_SUSPENDED) {
> > 		pm_set_suspended(dev);
> > 		my_runtime_suspend_callback(dev);
> > 	}
> 
> I think this would work too, but then possibly many drivers would have to
> do the same thing in their "remove" routines.
> 
> > There may be issues regarding coordination with the subsystem or the
> > power domain; at the moment it's not clear what should be done.  Maybe
> > the runtime-PM core should include an API for directly invoking the
> > appropriate callbacks.
> 
> If we choose this approach, then yes, we should provide a suitable API, but
> I'm still thinking it would be simpler to move the pm_runtime_put_sync() before driver_sysfs_remove() and make the rule as I said previously. :-)

The problem is synchronization.  At what point is the driver supposed 
to stop queuing runtime PM requests?  It would have to be sometime 
before the pm_runtime_barrier() call.  How is the driver supposed to 
know when that point is reached?  The remove routine isn't called until 
later.

Alan Stern

