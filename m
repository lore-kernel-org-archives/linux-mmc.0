From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Fri, 22 Apr 2011 22:25:24 +0200
Message-ID: <201104222225.24472.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1104221058140.1877-100000@iolanthe.rowland.org> <201104222222.01289.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45031 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407Ab1DVUYx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:24:53 -0400
In-Reply-To: <201104222222.01289.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Friday, April 22, 2011, Rafael J. Wysocki wrote:
> On Friday, April 22, 2011, Alan Stern wrote:
> > On Fri, 22 Apr 2011, Rafael J. Wysocki wrote:
> > 
> > > > The subsystem should be smart enough to handle runtime PM requests while
> > > > the driver's remove callback is running.
> > > 
> > > If we make such a rule, we may as well remove all of the runtime PM
> > > calls from __device_release_driver().
> > >  
> > > > > I think the current code is better than any of the alternatives considered
> > > > > so far.
> > > > 
> > > > Then you think Guennadi should leave his patch as it is, including the 
> > > > "reversed" put/get?
> > > 
> > > This, or we need to remove the runtime PM calls from __device_release_driver().
> > 
> > Let's go back to first principles.  The underlying problem we want to
> > solve is that runtime PM callbacks race with driver unbinding.  In a
> > worst-case scenario, a driver module might be unbound and unloaded from
> > memory and then a runtime PM callback could occur, causing an invalid
> > memory access.
> > 
> > Related to this is the fact that some drivers want to use runtime PM 
> > from within their remove routines.  This implies that the PM core 
> > shouldn't simply disallow all runtime PM callbacks during unbinding.
> > 
> > As it happens, the PM core doesn't call drivers' runtime PM routines 
> > directly.  Instead it calls bus, type, class, and power-domain 
> > routines -- which may in turn invoke the driver routines.
> > 
> > Put together, this all suggests that the PM core can't solve the
> > underlying problem and shouldn't try.  Instead, it should be up to the
> > subsystems to insure they don't make invalid callbacks.  For example,
> > the USB subsystem does this by explicitly doing pm_runtime_get_sync() 
> > before unbinding a driver.  Other subsystems would want to use a 
> > different approach.
> > 
> > If we add this requirement then yes, it would make sense to remove the 
> > get_noresume and put_sync calls from __device_release_driver().  We 
> > probably want to keep the barrier, though.
> > 
> > > I'm a bit worried about the driver_sysfs_remove() and the bus notifier that
> > > in theory may affect the runtime PM callbacks potentially executed before
> > > ->remove() is called.
> > 
> > The driver_sysfs_remove() call merely gets rid of a couple of symlinks 
> > in sysfs.  I don't think that will impact runtime PM.
> > 
> > The bus notifier might, however.
> 
> Not only it might, but it actually does.  There are platforms currently in
> the ARM tree where the runtime PM hadling of devices is set up and cleaned up
> by the bus notifier, so after the notifier has run the device will be handled
> differently.
> 
> > Perhaps the barrier should be moved down, after the notifier call.
> > How does this patch look?
> > 
> >  drivers/base/dd.c |    6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > Index: usb-2.6/drivers/base/dd.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/dd.c
> > +++ usb-2.6/drivers/base/dd.c
> > @@ -316,15 +316,13 @@ static void __device_release_driver(stru
> >  
> >  	drv = dev->driver;
> >  	if (drv) {
> > -		pm_runtime_get_noresume(dev);
> > -		pm_runtime_barrier(dev);
> > -
> >  		driver_sysfs_remove(dev);
> >  
> >  		if (dev->bus)
> >  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> >  						     BUS_NOTIFY_UNBIND_DRIVER,
> >  						     dev);
> > +		pm_runtime_barrier(dev);
> 
> The barrier would not prevent the race between the notifier and runtie PM
> from taking place.  Why don't we do something like this instead:
> 
> ---
>  drivers/base/dd.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/dd.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/dd.c
> +++ linux-2.6/drivers/base/dd.c
> @@ -326,6 +326,8 @@ static void __device_release_driver(stru
>  						     BUS_NOTIFY_UNBIND_DRIVER,
>  						     dev);
>  
> +		pm_runtime_put_sync(dev);
> +

In fact, I think this one may be _noidle.  If we allow the bus/driver
to do what they wont, we might as well let them handle the "device idle"
case from ->remove().

>  		if (dev->bus && dev->bus->remove)
>  			dev->bus->remove(dev);
>  		else if (drv->remove)
> @@ -338,7 +340,6 @@ static void __device_release_driver(stru
>  						     BUS_NOTIFY_UNBOUND_DRIVER,
>  						     dev);
>  
> -		pm_runtime_put_sync(dev);
>  	}
>  }

Thanks,
Rafael
