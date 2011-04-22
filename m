From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Fri, 22 Apr 2011 11:20:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104221058140.1877-100000@iolanthe.rowland.org>
References: <201104220006.09982.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50882 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752204Ab1DVPUa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 11:20:30 -0400
In-Reply-To: <201104220006.09982.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Fri, 22 Apr 2011, Rafael J. Wysocki wrote:

> > The subsystem should be smart enough to handle runtime PM requests while
> > the driver's remove callback is running.
> 
> If we make such a rule, we may as well remove all of the runtime PM
> calls from __device_release_driver().
>  
> > > I think the current code is better than any of the alternatives considered
> > > so far.
> > 
> > Then you think Guennadi should leave his patch as it is, including the 
> > "reversed" put/get?
> 
> This, or we need to remove the runtime PM calls from __device_release_driver().

Let's go back to first principles.  The underlying problem we want to
solve is that runtime PM callbacks race with driver unbinding.  In a
worst-case scenario, a driver module might be unbound and unloaded from
memory and then a runtime PM callback could occur, causing an invalid
memory access.

Related to this is the fact that some drivers want to use runtime PM 
from within their remove routines.  This implies that the PM core 
shouldn't simply disallow all runtime PM callbacks during unbinding.

As it happens, the PM core doesn't call drivers' runtime PM routines 
directly.  Instead it calls bus, type, class, and power-domain 
routines -- which may in turn invoke the driver routines.

Put together, this all suggests that the PM core can't solve the
underlying problem and shouldn't try.  Instead, it should be up to the
subsystems to insure they don't make invalid callbacks.  For example,
the USB subsystem does this by explicitly doing pm_runtime_get_sync() 
before unbinding a driver.  Other subsystems would want to use a 
different approach.

If we add this requirement then yes, it would make sense to remove the 
get_noresume and put_sync calls from __device_release_driver().  We 
probably want to keep the barrier, though.

> I'm a bit worried about the driver_sysfs_remove() and the bus notifier that
> in theory may affect the runtime PM callbacks potentially executed before
> ->remove() is called.

The driver_sysfs_remove() call merely gets rid of a couple of symlinks 
in sysfs.  I don't think that will impact runtime PM.

The bus notifier might, however.  Perhaps the barrier should be moved 
down, after the notifier call.  How does this patch look?

Alan Stern



 drivers/base/dd.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -316,15 +316,13 @@ static void __device_release_driver(stru
 
 	drv = dev->driver;
 	if (drv) {
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
 		driver_sysfs_remove(dev);
 
 		if (dev->bus)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBIND_DRIVER,
 						     dev);
+		pm_runtime_barrier(dev);
 
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
@@ -337,8 +335,6 @@ static void __device_release_driver(stru
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
-
-		pm_runtime_put_sync(dev);
 	}
 }
 

