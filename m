From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device loss]
Date: Thu, 15 Sep 2016 15:59:43 +0200
Message-ID: <CAPDyKFo5E=MXGi7Zk84mfbrjKVc-68OsKv6jBCGKgvybj9jMfQ@mail.gmail.com>
References: <1473864634.9913.12.camel@researchut.com> <Pine.LNX.4.44L0.1609141101380.1576-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33706 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934451AbcION7q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2016 09:59:46 -0400
Received: by mail-qk0-f181.google.com with SMTP id w204so51347509qka.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Sep 2016 06:59:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609141101380.1576-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 14 September 2016 at 17:19, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 14 Sep 2016, Ritesh Raj Sarraf wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Hello Ulf and Alan,
>>
>> On Fri, 2016-09-09 at 19:34 +0530, Ritesh Raj Sarraf wrote:
>> > For #2, I'm building the 4.8-rc5 kernel with the following change. This build
>> > does not include the previous change you had suggested (related to
>> > POWER_CYCLE)
>> >
>> > Date:   Fri Sep 9 19:28:03 2016 +0530
>> >
>> >     Disable pm runtime in mmc core
>> >
>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> > index e55cde6..32388d5 100644
>> > --- a/drivers/mmc/core/core.c
>> > +++ b/drivers/mmc/core/core.c
>> > @@ -970,9 +970,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t
>> > *abort)
>> >         spin_unlock_irqrestore(&host->lock, flags);
>> >         remove_wait_queue(&host->wq, &wait);
>> >
>> > -       if (pm)
>> > -               pm_runtime_get_sync(mmc_dev(host));
>> > -
>> >         return stop;
>> >  }
>> >  EXPORT_SYMBOL(__mmc_claim_host);
>> > @@ -1000,7 +997,6 @@ void mmc_release_host(struct mmc_host *host)
>> >                 spin_unlock_irqrestore(&host->lock, flags);
>> >                 wake_up(&host->wq);
>> >                 pm_runtime_mark_last_busy(mmc_dev(host));
>> > -               pm_runtime_put_autosuspend(mmc_dev(host));
>> >         }
>> >  }
>> >  EXPORT_SYMBOL(mmc_release_host);
>>
>> I tried with these changes on 4.8-rc6 and I only saw 2 resets so far.
>> I captured the usb trace [1], just in case if you need it.
>>
>> [1] https://people.debian.org/~rrs/tmp/4.8-rc6-ulf.txt.gz
>
> The situation isn't any better.  At the start of the trace,
> the device is in runtime suspend but there are many attempts to
> communicate with it, all of which fail.

It's really weird. Have this driver ever worked!? :-)

>
> Then a little less than an hour after the trace started, the device was
> resumed.  At that point it started working okay.  Until there was a
> spontaneous disconnect.
>
> The device reconnected, but after 3 seconds it was runtime suspended
> again -- and the I/O attempts continued.  Some time later there was
> another runtime resume, and the device began working again.  Until
> another spontaneous disconnect occurred.  And so on...
>
> Ulf, we really need to figure out why the autosuspends are occurring
> and why the I/O doesn't stop while the device is suspended.

Okay, let's see.

I had another look in the rtsx_usb_sdmmc driver. Apparently it
registers a led classdev. Updating the led is done from a work, by
calling rtsx_usb_turn_on|off_led(), which do access the usb device.
These calls are not properly managed by runtime PM, so I have fixed
those according to below change:

---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6c71fc9..a59c7fa 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
                container_of(work, struct rtsx_usb_sdmmc, led_work);
        struct rtsx_ucr *ucr = host->ucr;

+       pm_runtime_get_sync(sdmmc_dev(host));
        mutex_lock(&ucr->dev_mutex);

        if (host->led.brightness == LED_OFF)
@@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
                rtsx_usb_turn_on_led(ucr);

        mutex_unlock(&ucr->dev_mutex);
+       pm_runtime_put(sdmmc_dev(host));
 }
 #endif

-- 

Although, I doubt the above is the main reason to the issues we see.
Instead I think somehow the parent device (usb device) isn't being
properly managed through runtime PM, but not due to wrong deployment
in the mmc core nor in the rtsx_usb_driver, but at some place else.
:-)

I started looking for calls to pm_suspend_ignore_children(dev, true),
which would decouple the usb device from the mmc platform device from
a runtime PM point of view. I found one suspicious case!

drivers/usb/storage/realtek_cr.c:
pm_suspend_ignore_children(&us->pusb_intf->dev, true);

As I am not so familiar with USB, I can't really tell why the above
exists, although perhaps just removing that line would be worth a
try!?

If neither of the above works, the next step could be to start
checking error codes in the mmc core and in the rtsx_usb_sdmmc driver,
from the calls to pm_runtime_get|put() and pm_runtime_enable().

Kind regards
Uffe
