From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Mon, 19 Sep 2016 14:02:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609191348440.1458-100000@iolanthe.rowland.org>
References: <CAPDyKFpFObRkvUC5kOKznE3FAGL6H_Hufa7ZEFWpmB694AY9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpFObRkvUC5kOKznE3FAGL6H_Hufa7ZEFWpmB694AY9ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Micky Ching <micky_ching-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 19 Sep 2016, Ulf Hansson wrote:

> On 18 September 2016 at 04:30, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > On Sat, 17 Sep 2016, Ulf Hansson wrote:
> >
> >> Each access of the parent device (usb device) needs to be done in runtime
> >> resumed state. Currently this isn't case while changing the leds, so let's
> >> add pm_runtime_get_sync() and pm_runtime_put() around these calls.
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> ---
> >>
> >> While discussing an issue[1] related to runtime PM, I found out that this
> >> minor change at least improves the behavior that has been observed.
> >>
> >> [1]
> >> http://www.spinics.net/lists/linux-usb/msg144634.html
> >>
> >> ---
> >>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> >> index 6c71fc9..a59c7fa 100644
> >> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> >> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> >> @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
> >>               container_of(work, struct rtsx_usb_sdmmc, led_work);
> >>       struct rtsx_ucr *ucr = host->ucr;
> >>
> >> +     pm_runtime_get_sync(sdmmc_dev(host));
> >>       mutex_lock(&ucr->dev_mutex);
> >>
> >>       if (host->led.brightness == LED_OFF)
> >> @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
> >>               rtsx_usb_turn_on_led(ucr);
> >>
> >>       mutex_unlock(&ucr->dev_mutex);
> >> +     pm_runtime_put(sdmmc_dev(host));
> >>  }
> >>  #endif
> >
> > The missing aspect here is that this won't stop the parent USB device
> > from going into autosuspend every 2 seconds and then resuming shortly
> > afterward.  There are two ways of preventing this:
> >
> >         Call usb_mark_last_busy() at appropriate places.
> >
> >         Enable autosuspend for the sdmmc device.
> >
> > The second approach would also prevent the sdmmc device from going into
> > autosuspend as soon as the LED update is finished.  Maybe that's okay,
> > but if going into suspend is a lightweight procedure then you may want
> > to prevent it.
> >
> 
> We can for sure enable autosuspend for the sdmmc device, although as
> soon as an SD card will be detected the rtsx driver will increase the
> runtime PM usage count. The count is decreased when the card is
> removed (or failed to be initialized), thus runtime suspend is
> prevented as long as there is a functional card inserted.

Which means that autosuspend matters only when a card isn't present, 
and the host is polled every second or so to see whether a card has 
been inserted.

Under those circumstances you probably don't want to use autosuspend.  
That is, resuming before each poll and suspending afterward may use 
less energy than staying at full power all the time.

> I am wondering what you think would be a good autosuspend timeout in
> this case? It seems to me that the only thing the rtsx driver really
> care about is to tell the parent device that it needs to be runtime
> resumed during a certain timeframe, more or less it would like to
> inherit the parents settings.
> 
> Other mmc hosts, not being usb-mmc devices, are using an autosuspend
> timeout of ~50-100ms but that doesn't seem like good value here,
> right?

Well, if you decide to let the device go into runtime suspend between
polls then there's no reason to use autosuspend at all.  Once a poll 
has ended, you know there won't be any more activity until the next 
poll.

On the other hand, if you decide to keep the device at full power all 
the time during polling, then any autosuspend timeout larger than 1000 
ms would do what you want.

Mostly I'm concerned about how this will interact with the USB runtime
PM.  The thing is, suspending the sdmmc device doesn't save any energy,
whereas suspending the USB device does.

Let's see how well everything works with the patch to the rtsx memstick
driver.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
