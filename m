From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Fri, 16 Sep 2016 21:12:05 +0530
Message-ID: <1474040525.18741.1.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609151010240.1938-100000@iolanthe.rowland.org>
Reply-To: rrs@researchut.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34123 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935603AbcIPPmV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2016 11:42:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id 21so2336413pfy.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2016 08:42:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609151010240.1938-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Ulf and Alan,

On Thu, 2016-09-15 at 10:16 -0400, Alan Stern wrote:
> > ---
> >  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > index 6c71fc9..a59c7fa 100644
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct
> *work)
> >                 container_of(work, struct rtsx_usb_sdmmc, led_work);
> >         struct rtsx_ucr *ucr = host->ucr;
> > 
> > +       pm_runtime_get_sync(sdmmc_dev(host));
> >         mutex_lock(&ucr->dev_mutex);
> > 
> >         if (host->led.brightness == LED_OFF)
> > @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct
> *work)
> >                 rtsx_usb_turn_on_led(ucr);
> > 
> >         mutex_unlock(&ucr->dev_mutex);
> > +       pm_runtime_put(sdmmc_dev(host));
> >  }
> >  #endif
> > 
> > -- 
> > 
> > Although, I doubt the above is the main reason to the issues we see.
> 
> I don't know -- it could well be the reason.  The symptoms are 
> definitely what you would expect to see if some thread was doing I/O 
> without calling the pm_runtime_* routines.
> 
> > Instead I think somehow the parent device (usb device) isn't being
> > properly managed through runtime PM, but not due to wrong deployment
> > in the mmc core nor in the rtsx_usb_driver, but at some place else.
> > :-)
> > 
> > I started looking for calls to pm_suspend_ignore_children(dev, true),
> > which would decouple the usb device from the mmc platform device from
> > a runtime PM point of view. I found one suspicious case!
> > 
> > drivers/usb/storage/realtek_cr.c:
> > pm_suspend_ignore_children(&us->pusb_intf->dev, true);
> > 
> > As I am not so familiar with USB, I can't really tell why the above
> > exists, although perhaps just removing that line would be worth a
> > try!?
> 
> No, the realtek_cr driver has no connection with this.  It's a
> sub-module of the usb_storage driver; it uses the SCSI interface,
> not the MMC interface.
> 
> > If neither of the above works, the next step could be to start
> > checking error codes in the mmc core and in the rtsx_usb_sdmmc driver,
> > from the calls to pm_runtime_get|put() and pm_runtime_enable().
> 
> Let's see what this patch does.

I was able to hit it again. Please find the usbmon trace at:
https://people.debian.org/~rrs/tmp/usb-4.8.0-rc6ulf1+.log.gz


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX3BLOAAoJEKY6WKPy4XVpXMgP/jTyKOX/SYCPTU9twYldY7LQ
f64hpiWqXOUs+jFYM+BcrF5B5DuXiB1Wm4F3+Xm/QBN3grJD7yBq1nrhv/mAhCr3
y1gFRIbeKfZsEp1vdBov9m1jQCZzzIZlFXPmRGT/8uC/GZTHlgIeSLqBntpq9+yL
MQSE91tLVayVgaOQxpPz+uZ4PTAom19sU21Haa90ECHLKAUTJ9WncQFecjPLHMjb
4SUvgq53V2s1Yo1E85RhtgR6Nrk/Bh7qZEC1NyeganLazGbbsz9YnRcGy58x9Jiq
xmfURTtvG834CnGcGuzcRU09FGPMtXx/u57EYC6mdEMWhSglo0h6YhVxcUOtAhRD
s1gs+a6ToKTDLn6qr0cnIwG27ALyLh41QmzxEpiaZiugIEBzZ/uK3TBjzcul4Huj
v0+x2fSC0SXwGo4P3GAOnHuWUjgj3C1wElP1R3brXfO0aayESUNKzE8V7RbQIWiC
mHewSlKTiPwCr/lchaINTt2TyFcHJWOx90iV10GO5TpMyqho4AzpBpoimItrbx2t
qQJCvGzDLPjr0tPvpeWyJSfBnqCDqbJ44CY3nCFgKhTd3BXp4fDj09eBtNmSiuvu
UdZZxm84FD3BDSNX8k2W9CF81jML/4lzwliJge3uIPrXNDqGSZMxDSpd0u1EFNHf
rEQ/kP1WlArvqButQ5ZN
=fiWV
-----END PGP SIGNATURE-----

