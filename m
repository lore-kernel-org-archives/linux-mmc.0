From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Thu, 22 Sep 2016 09:56:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609220955420.1835-100000@iolanthe.rowland.org>
References: <CAPDyKFozTL9h3HXoimHc4X3jeWQtJaedrfExVq1A5g7-JzcNLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFozTL9h3HXoimHc4X3jeWQtJaedrfExVq1A5g7-JzcNLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Sep 2016, Ulf Hansson wrote:

> >> > > An observation I made, is when the sdmmc device gets runtime resumed
> >> > > (pm_runtime_get_sync()), the parent device (the usb device) may also
> >> > > become runtime resumed (unless it's already). In this sequence, but
> >> > > *only* when actually runtime resuming the usb device, the runtime PM
> >> > > core decides to update the last busy mark for the usb device. Should
> >> > > it really do that?
> >> >
> >> > Yes, that's deliberate.  The whole idea of autosuspend is to prevent
> >> > the device from being runtime-suspended too soon after it was used, and
> >> > the PM core considers runtime-resume to be a form of usage.
> >>
> >> I understand it's deliberate, but I was more question whether we
> >> actually should have the runtime PM core to behaves like this.
> >>
> >> I don't think its behaviour is consistent, as in such case all calls
> >> to __pm_runtime_resume() should trigger the runtime PM core to update
> >> the last busy mark.
> >
> > Not a bad idea...
> 
> Yes, it is. :-)
> 
> Although, I am still concerned about he inconsistent behaviour.
> 
> >
> >> Don't get me wrong, I am *not* suggesting we should do that change, as
> >> it would mean the last busy mark would be updated way too often.
> >
> > The updates aren't very expensive.  Just one atomic write.  It probably
> > takes less time than acquiring the runtime-PM spinlock.
> >
> >> Instead, perhaps it's better to leave the responsibility of updating
> >> the last busy mark to the runtime PM users solely.
> >
> > Maybe, but I think doing it once in the core, like this, can remove the
> > need for a lot of function calls in drivers.
> 
> Unfortunate not. Most updates of the last busy mark happens when a
> device is no longer required to be runtime resumed. As when a driver
> has completed to serve a request and is about to call pm_runtime_put()
> (or similar API).
> 
> So, I still believe doing it in the runtime PM core is just a waste.
> 
> I think it's better to leave the update to the users entirely, it
> would become consistent but also more flexible, as one could easily
> think of situations where you may in some cases want to update the
> last busy mark and in some other not.

You can try making this change if you want.  I'd be afraid of 
regressions.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
