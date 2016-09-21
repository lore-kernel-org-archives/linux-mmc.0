From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing led
Date: Wed, 21 Sep 2016 12:39:31 +0200
Message-ID: <CAPDyKFqgfhsOdrz5ncTh5Z_OZ6tvnMVoQ_2g7ZyM02aaVzGQWg@mail.gmail.com>
References: <CAPDyKFq2Y1vn1OjNJJg7hocbzFo-QUpezLSMWnF_1cSJ9Ot3NQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1609200951500.1459-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609200951500.1459-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Micky Ching <micky_ching-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 20 September 2016 at 16:09, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>
> On Tue, 20 Sep 2016, Ulf Hansson wrote:
>
> > >> I am wondering what you think would be a good autosuspend timeout in
> > >> this case? It seems to me that the only thing the rtsx driver really
> > >> care about is to tell the parent device that it needs to be runtime
> > >> resumed during a certain timeframe, more or less it would like to
> > >> inherit the parents settings.
> > >>
> > >> Other mmc hosts, not being usb-mmc devices, are using an autosuspend
> > >> timeout of ~50-100ms but that doesn't seem like good value here,
> > >> right?
> > >
> > > Well, if you decide to let the device go into runtime suspend between
> > > polls then there's no reason to use autosuspend at all.  Once a poll
> > > has ended, you know there won't be any more activity until the next
> > > poll.
> >
> > We could change that, as currently the approach in the mmc core isn't
> > that sophisticated. I even think this has been discussed earlier for
> > the very similar reasons regards polling card detect mode.
> >
> > I guess the main reason to why we yet have changed this, is because
> > mmc host drivers are using an autosuspend timeout of ~50-100 ms, so in
> > the end it haven't been such a big deal.
>
> No, it isn't.  Although at a polling interval of 1 second, it means
> reducing the low-power time by as much as 10%.

Yes, I agree we shouldn't neglect its impact - especially in this usb use case.

I will put it on my TODO list for mmc PM things.

>
> > > On the other hand, if you decide to keep the device at full power all
> > > the time during polling, then any autosuspend timeout larger than 1000
> > > ms would do what you want.
> > >
> > > Mostly I'm concerned about how this will interact with the USB runtime
> > > PM.  The thing is, suspending the sdmmc device doesn't save any energy,
> > > whereas suspending the USB device does.
> >
> > Yes, I agree.
> >
> > My concern is also 2s autosuspend timeout which is set for the usb
> > device. Somehow I feel we need to be able "share" more information
> > between a parent-child relationship, in this case between the sdmmc
> > device and the usb device.
>
> I agree, but it's not clear how this should be done.  One easy solution
> would be to turn off USB autosuspend and do all the runtime-PM
> management in the sdmmc and memstick drivers.

Hmm, this could be a very good option. In the end the sdmmc/memstick
drivers knows best about which autosuspend timeout to use.

>
> > An observation I made, is when the sdmmc device gets runtime resumed
> > (pm_runtime_get_sync()), the parent device (the usb device) may also
> > become runtime resumed (unless it's already). In this sequence, but
> > *only* when actually runtime resuming the usb device, the runtime PM
> > core decides to update the last busy mark for the usb device. Should
> > it really do that?
>
> Yes, that's deliberate.  The whole idea of autosuspend is to prevent
> the device from being runtime-suspended too soon after it was used, and
> the PM core considers runtime-resume to be a form of usage.

I understand it's deliberate, but I was more question whether we
actually should have the runtime PM core to behaves like this.

I don't think its behaviour is consistent, as in such case all calls
to __pm_runtime_resume() should trigger the runtime PM core to update
the last busy mark.

Don't get me wrong, I am *not* suggesting we should do that change, as
it would mean the last busy mark would be updated way too often.
Instead, perhaps it's better to leave the responsibility of updating
the last busy mark to the runtime PM users solely.

>
> > Moreover, I am curious about the 2s usb timeout. Why isn't that chosen
> > to something like ~100ms instead? Is there is a long latency to
> > runtime resume the usb device or because we fear to wear out the HW,
> > which may be powered on/off too frequently?
>
> When I first implemented runtime PM for the USB stack, I had to choose
> a autosuspend timeout.  Not having any basis for such a choice, and
> figuring that a suspend-resume cycle takes around 100 ms, I decided
> that 2 seconds would be a reasonable value.  But it's just a default;
> drivers and userspace can change it whenever they want.

Okay, I see. Thanks for sharing that information.

>
> > If we assume that the usb device shouldn't be used with a timeout less
> > than 2s, then I think we have two options:
> >
> > *) As the mmc polling timeout is 1s, there is really no point in
> > trying to runtime suspend the usb device, it may just be left runtime
> > resumed all the time. Wasting power, of course!
>
> Or we can decrease the USB autosuspend delay to 100 ms.

Yes, something like that makes sense to me.

Unless we decide to turn off autosuspend completely for the usb host
as you suggested above. Then it would really become clear that the
sdmmc/memstick drivers gets the responsible for the autosuspend, which
certainly makes most sense.

>
> > **) Add an interface to allow dynamically changes of the mmc polling
> > timeout to better suit the current user.
>
> Note that the block layer does its own polling for removable media, and
> it already has a sysfs interface to control the polling interval (or
> disable it entirely).  But I don't know how the MMC stack interacts
> with the block layer.
>
> One awkward point is that the sdmmc and memstick drivers each do their
> own polling.  This is a waste.  You can see it in the usbmon trace;
> every second there are two query-response interactions.  Even if
> there's no good way to reduce the number, we should at least try to
> synchronize the polls so that the device doesn't need to be resumed
> twice every second.

Yes, you are right. I just haven't been able to prioritize doing that
change for MMC. Another thing added on my mmc TODO list. :-)

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
