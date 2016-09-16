From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Fri, 16 Sep 2016 17:40:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609161729340.1657-100000@iolanthe.rowland.org>
References: <1474040525.18741.1.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36960 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1755022AbcIPVkZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2016 17:40:25 -0400
In-Reply-To: <1474040525.18741.1.camel@researchut.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Fri, 16 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hello Ulf and Alan,
> 
> On Thu, 2016-09-15 at 10:16 -0400, Alan Stern wrote:
> > > ---
> > >  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > index 6c71fc9..a59c7fa 100644
> > > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct
> > *work)
> > >                 container_of(work, struct rtsx_usb_sdmmc, led_work);
> > >         struct rtsx_ucr *ucr = host->ucr;
> > > 
> > > +       pm_runtime_get_sync(sdmmc_dev(host));
> > >         mutex_lock(&ucr->dev_mutex);
> > > 
> > >         if (host->led.brightness == LED_OFF)
> > > @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct
> > *work)
> > >                 rtsx_usb_turn_on_led(ucr);
> > > 
> > >         mutex_unlock(&ucr->dev_mutex);
> > > +       pm_runtime_put(sdmmc_dev(host));
> > >  }
> > >  #endif
> > > 
> > > -- 
> > > 
> > > Although, I doubt the above is the main reason to the issues we see.
> > 
> > I don't know -- it could well be the reason.  The symptoms are 
> > definitely what you would expect to see if some thread was doing I/O 
> > without calling the pm_runtime_* routines.

> I was able to hit it again. Please find the usbmon trace at:
> https://people.debian.org/~rrs/tmp/usb-4.8.0-rc6ulf1+.log.gz

 
We're still getting runtime suspends, but now at 2-second intervals.   
This is partly because the driver isn't calling
pm_runtime_mark_last_busy(), but there may be more to it.  The 2-second 
period is the default autosuspend timeout for USB devices.  However, I 
don't see the activity that rtsx_usb_get_card_status() should produce 
when rtsx_usb_suspend() runs; I don't know why not.

We're also getting occasional I/O attempts while the device is
suspended.  They must be on some other pathway, not the one fixed by
the patch above.  Let's see if we can find out just where they come
from.

Ritesh, please try applying this patch on top of the previous one.  It 
will produce output in the kernel log whenever these bad I/O attempts 
occur.  Also, enable dynamic debugging for the rtsx_usb driver:

	echo 'module rtsx_usb =p' >/sys/kernel/debug/dynamic_debug/control

before starting the test.  (You may need to mount a debugfs filesystem 
on /sys/kernel/debug first.)

Alan Stern



Index: usb-4.x/drivers/usb/core/hcd.c
===================================================================
--- usb-4.x.orig/drivers/usb/core/hcd.c
+++ usb-4.x/drivers/usb/core/hcd.c
@@ -1647,6 +1647,8 @@ int usb_hcd_submit_urb (struct urb *urb,
 		status = map_urb_for_dma(hcd, urb, mem_flags);
 		if (likely(status == 0)) {
 			status = hcd->driver->urb_enqueue(hcd, urb, mem_flags);
+			if (status == -EHOSTUNREACH)
+				dump_stack();
 			if (unlikely(status))
 				unmap_urb_for_dma(hcd, urb);
 		}


