From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Thu, 15 Sep 2016 10:16:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609151010240.1938-100000@iolanthe.rowland.org>
References: <CAPDyKFo5E=MXGi7Zk84mfbrjKVc-68OsKv6jBCGKgvybj9jMfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38914 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1757959AbcIOOQt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2016 10:16:49 -0400
In-Reply-To: <CAPDyKFo5E=MXGi7Zk84mfbrjKVc-68OsKv6jBCGKgvybj9jMfQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Thu, 15 Sep 2016, Ulf Hansson wrote:

> > The situation isn't any better.  At the start of the trace,
> > the device is in runtime suspend but there are many attempts to
> > communicate with it, all of which fail.
> 
> It's really weird. Have this driver ever worked!? :-)

Probably not.  Or at least, not with runtime PM.

> > Then a little less than an hour after the trace started, the device was
> > resumed.  At that point it started working okay.  Until there was a
> > spontaneous disconnect.
> >
> > The device reconnected, but after 3 seconds it was runtime suspended
> > again -- and the I/O attempts continued.  Some time later there was
> > another runtime resume, and the device began working again.  Until
> > another spontaneous disconnect occurred.  And so on...
> >
> > Ulf, we really need to figure out why the autosuspends are occurring
> > and why the I/O doesn't stop while the device is suspended.
> 
> Okay, let's see.
> 
> I had another look in the rtsx_usb_sdmmc driver. Apparently it
> registers a led classdev. Updating the led is done from a work, by
> calling rtsx_usb_turn_on|off_led(), which do access the usb device.
> These calls are not properly managed by runtime PM, so I have fixed
> those according to below change:
> 
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
> b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 6c71fc9..a59c7fa 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>                 container_of(work, struct rtsx_usb_sdmmc, led_work);
>         struct rtsx_ucr *ucr = host->ucr;
> 
> +       pm_runtime_get_sync(sdmmc_dev(host));
>         mutex_lock(&ucr->dev_mutex);
> 
>         if (host->led.brightness == LED_OFF)
> @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>                 rtsx_usb_turn_on_led(ucr);
> 
>         mutex_unlock(&ucr->dev_mutex);
> +       pm_runtime_put(sdmmc_dev(host));
>  }
>  #endif
> 
> -- 
> 
> Although, I doubt the above is the main reason to the issues we see.

I don't know -- it could well be the reason.  The symptoms are 
definitely what you would expect to see if some thread was doing I/O 
without calling the pm_runtime_* routines.

> Instead I think somehow the parent device (usb device) isn't being
> properly managed through runtime PM, but not due to wrong deployment
> in the mmc core nor in the rtsx_usb_driver, but at some place else.
> :-)
> 
> I started looking for calls to pm_suspend_ignore_children(dev, true),
> which would decouple the usb device from the mmc platform device from
> a runtime PM point of view. I found one suspicious case!
> 
> drivers/usb/storage/realtek_cr.c:
> pm_suspend_ignore_children(&us->pusb_intf->dev, true);
> 
> As I am not so familiar with USB, I can't really tell why the above
> exists, although perhaps just removing that line would be worth a
> try!?

No, the realtek_cr driver has no connection with this.  It's a
sub-module of the usb_storage driver; it uses the SCSI interface,
not the MMC interface.

> If neither of the above works, the next step could be to start
> checking error codes in the mmc core and in the rtsx_usb_sdmmc driver,
> from the calls to pm_runtime_get|put() and pm_runtime_enable().

Let's see what this patch does.

Alan Stern

