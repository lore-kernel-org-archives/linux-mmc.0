From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Wed, 21 Sep 2016 10:45:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609211038270.1996-100000@iolanthe.rowland.org>
References: <CAPDyKFqgfhsOdrz5ncTh5Z_OZ6tvnMVoQ_2g7ZyM02aaVzGQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqgfhsOdrz5ncTh5Z_OZ6tvnMVoQ_2g7ZyM02aaVzGQWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Micky Ching <micky_ching-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Sep 2016, Ulf Hansson wrote:

> > > My concern is also 2s autosuspend timeout which is set for the usb
> > > device. Somehow I feel we need to be able "share" more information
> > > between a parent-child relationship, in this case between the sdmmc
> > > device and the usb device.
> >
> > I agree, but it's not clear how this should be done.  One easy solution
> > would be to turn off USB autosuspend and do all the runtime-PM
> > management in the sdmmc and memstick drivers.
> 
> Hmm, this could be a very good option. In the end the sdmmc/memstick
> drivers knows best about which autosuspend timeout to use.

I tend to agree, and so does Oliver.

> > > An observation I made, is when the sdmmc device gets runtime resumed
> > > (pm_runtime_get_sync()), the parent device (the usb device) may also
> > > become runtime resumed (unless it's already). In this sequence, but
> > > *only* when actually runtime resuming the usb device, the runtime PM
> > > core decides to update the last busy mark for the usb device. Should
> > > it really do that?
> >
> > Yes, that's deliberate.  The whole idea of autosuspend is to prevent
> > the device from being runtime-suspended too soon after it was used, and
> > the PM core considers runtime-resume to be a form of usage.
> 
> I understand it's deliberate, but I was more question whether we
> actually should have the runtime PM core to behaves like this.
> 
> I don't think its behaviour is consistent, as in such case all calls
> to __pm_runtime_resume() should trigger the runtime PM core to update
> the last busy mark.

Not a bad idea...

> Don't get me wrong, I am *not* suggesting we should do that change, as
> it would mean the last busy mark would be updated way too often.

The updates aren't very expensive.  Just one atomic write.  It probably
takes less time than acquiring the runtime-PM spinlock.

> Instead, perhaps it's better to leave the responsibility of updating
> the last busy mark to the runtime PM users solely.

Maybe, but I think doing it once in the core, like this, can remove the
need for a lot of function calls in drivers.

> > > If we assume that the usb device shouldn't be used with a timeout less
> > > than 2s, then I think we have two options:
> > >
> > > *) As the mmc polling timeout is 1s, there is really no point in
> > > trying to runtime suspend the usb device, it may just be left runtime
> > > resumed all the time. Wasting power, of course!
> >
> > Or we can decrease the USB autosuspend delay to 100 ms.
> 
> Yes, something like that makes sense to me.
> 
> Unless we decide to turn off autosuspend completely for the usb host
> as you suggested above. Then it would really become clear that the
> sdmmc/memstick drivers gets the responsible for the autosuspend, which
> certainly makes most sense.

Yes.

> > > **) Add an interface to allow dynamically changes of the mmc polling
> > > timeout to better suit the current user.
> >
> > Note that the block layer does its own polling for removable media, and
> > it already has a sysfs interface to control the polling interval (or
> > disable it entirely).  But I don't know how the MMC stack interacts
> > with the block layer.
> >
> > One awkward point is that the sdmmc and memstick drivers each do their
> > own polling.  This is a waste.  You can see it in the usbmon trace;
> > every second there are two query-response interactions.  Even if
> > there's no good way to reduce the number, we should at least try to
> > synchronize the polls so that the device doesn't need to be resumed
> > twice every second.
> 
> Yes, you are right. I just haven't been able to prioritize doing that
> change for MMC. Another thing added on my mmc TODO list. :-)

To tell the truth, I'm not sure how you would synchronize the polling
activities in the sdmmc and memstick drivers.  Move most of it into the
upper MFD driver?

One point worth mentioning is that if you already know an SDMMC card is
present then there's no reason to poll for a MemoryStick card, and vice
versa.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
