From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Fri, 22 Apr 2011 17:20:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104221709030.1791-100000@iolanthe.rowland.org>
References: <201104222225.24472.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52146 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756240Ab1DVVUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 17:20:53 -0400
In-Reply-To: <201104222225.24472.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

On Fri, 22 Apr 2011, Rafael J. Wysocki wrote:

> > The barrier would not prevent the race between the notifier and runtie PM
> > from taking place.  Why don't we do something like this instead:
> > 
> > ---
> >  drivers/base/dd.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/base/dd.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/dd.c
> > +++ linux-2.6/drivers/base/dd.c
> > @@ -326,6 +326,8 @@ static void __device_release_driver(stru
> >  						     BUS_NOTIFY_UNBIND_DRIVER,
> >  						     dev);
> >  
> > +		pm_runtime_put_sync(dev);
> > +
> 
> In fact, I think this one may be _noidle.  If we allow the bus/driver
> to do what they wont, we might as well let them handle the "device idle"
> case from ->remove().

Maybe...  But keeping it put_sync doesn't do any harm.  In Guennadi's 
case, it might allow him to get rid of the pm_runtime_suspend() call in 
the remove routine.

> >  		if (dev->bus && dev->bus->remove)
> >  			dev->bus->remove(dev);
> >  		else if (drv->remove)
> > @@ -338,7 +340,6 @@ static void __device_release_driver(stru
> >  						     BUS_NOTIFY_UNBOUND_DRIVER,
> >  						     dev);
> >  
> > -		pm_runtime_put_sync(dev);
> >  	}
> >  }

Basically this is okay with me, and it should allow Guennadi to avoid
the extra put/get pair.  Do you know if any other subsystems rely on
the usage_count being > 0 during unbinding?

Alan Stern

