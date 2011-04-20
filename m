From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 17:16:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104201710450.1686-100000@iolanthe.rowland.org>
References: <201104202206.14240.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55547 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752670Ab1DTVQO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 17:16:14 -0400
In-Reply-To: <201104202206.14240.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Wed, 20 Apr 2011, Rafael J. Wysocki wrote:

> On Wednesday, April 20, 2011, Alan Stern wrote:
> > On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:
> ...
> > Ah, now I see the problem.  It looks like we did not give sufficient
> > thought to the case where a device starts off (and therefore should
> > finish up) in a powered-down state.  Calling pm_runtime_put_sync()
> > after unbinding the device driver seems a little futile -- with no
> > driver, the subsystem may not be able to power-down the device!
> > 
> > Rafael, how do you think we should handle this?  Get rid of the 
> > pm_runtime_get_no_resume() and pm_runtime_put_sync() calls in 
> > dd.c:__device_release_driver()?
> 
> I think we need pm_runtime_barrier() in there.  Otherwise we risk
> removing the driver while there's a runtime PM request pending.
> 
> But we can move the pm_runtime_put_sync() before driver_sysfs_remove().

What happens if another runtime PM request is queued between the
put_sync() and the remove callback?  We may need a safe way to prevent
async runtime PM requests while still allowing synchronous requests.

Alan Stern

