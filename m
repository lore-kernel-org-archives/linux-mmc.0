From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Sat, 23 Apr 2011 00:11:47 +0200
Message-ID: <201104230011.48073.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1104221709030.1791-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45236 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740Ab1DVWLv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 18:11:51 -0400
In-Reply-To: <Pine.LNX.4.44L0.1104221709030.1791-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Friday, April 22, 2011, Alan Stern wrote:
> On Fri, 22 Apr 2011, Rafael J. Wysocki wrote:
> 
> > > The barrier would not prevent the race between the notifier and runtie PM
> > > from taking place.  Why don't we do something like this instead:
> > > 
> > > ---
> > >  drivers/base/dd.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/drivers/base/dd.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/base/dd.c
> > > +++ linux-2.6/drivers/base/dd.c
> > > @@ -326,6 +326,8 @@ static void __device_release_driver(stru
> > >  						     BUS_NOTIFY_UNBIND_DRIVER,
> > >  						     dev);
> > >  
> > > +		pm_runtime_put_sync(dev);
> > > +
> > 
> > In fact, I think this one may be _noidle.  If we allow the bus/driver
> > to do what they wont, we might as well let them handle the "device idle"
> > case from ->remove().
> 
> Maybe...  But keeping it put_sync doesn't do any harm.  In Guennadi's 
> case, it might allow him to get rid of the pm_runtime_suspend() call in 
> the remove routine.
> 
> > >  		if (dev->bus && dev->bus->remove)
> > >  			dev->bus->remove(dev);
> > >  		else if (drv->remove)
> > > @@ -338,7 +340,6 @@ static void __device_release_driver(stru
> > >  						     BUS_NOTIFY_UNBOUND_DRIVER,
> > >  						     dev);
> > >  
> > > -		pm_runtime_put_sync(dev);
> > >  	}
> > >  }
> 
> Basically this is okay with me, and it should allow Guennadi to avoid
> the extra put/get pair.

OK, so I'm going to put the appended patch into my linux-next branch
(hopefully, the problem is explained sufficiently in the changelog).

> Do you know if any other subsystems rely on the usage_count
> being > 0 during unbinding?

Do you mean if I know of subsystems that the patch below may cause to
fail?  No, I don't. :-)

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Runtime: Allow runtime suspend to be done from remove callbacks

The driver core prevents race conditions between device runtime PM
and driver removal from happening by incrementing the runtime PM
usage counter of the device and executing pm_runtime_barrier() before
running the bus notifier and the ->remove() callbacks provided by the
device's subsystem or driver.  This guarantees that, if a future
runtime suspend of the device has been scheduled or a runtime resume
or idle request has been queued up right before the driver removal,
it will be canceled or waited for to complete and no other
asynchronous runtime suspend or idle requests for the device will be
put into the PM workqueue until the ->remove() callback returns.
However, this also means that the device's subsystem or driver will
not be able put it into the suspended state by calling
pm_runtime_suspend() from its ->remove() routine.  This turns out to
be a major inconvenience for some subsystems and drivers that want to
leave the devices they handle in the suspended state.

To allow subsystems and drivers to put devices into the suspended
state by calling pm_runtime_suspend() from their ->remove() routines
execute pm_runtime_put_sync() after running the bus notifier in
__device_release_driver().  [The bus notifier still needs to be
protected from racing with runtime PM routines, because it is used
by some subsystems to carry out operations affecting the runtime PM
functionality.]  This will require subsystems and drivers to make
their ->remove() callbacks avoid races with runtime PM directly, but
it will allow of more flexibility in the handling of devices during
the removal of their drivers.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/dd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/dd.c
===================================================================
--- linux-2.6.orig/drivers/base/dd.c
+++ linux-2.6/drivers/base/dd.c
@@ -326,6 +326,8 @@ static void __device_release_driver(stru
 						     BUS_NOTIFY_UNBIND_DRIVER,
 						     dev);
 
+		pm_runtime_put_sync(dev);
+
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
@@ -338,7 +340,6 @@ static void __device_release_driver(stru
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
 
-		pm_runtime_put_sync(dev);
 	}
 }
 
