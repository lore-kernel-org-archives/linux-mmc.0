From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing led
Date: Tue, 20 Sep 2016 11:34:17 +0200
Message-ID: <CAPDyKFq2Y1vn1OjNJJg7hocbzFo-QUpezLSMWnF_1cSJ9Ot3NQ@mail.gmail.com>
References: <CAPDyKFpFObRkvUC5kOKznE3FAGL6H_Hufa7ZEFWpmB694AY9ow@mail.gmail.com>
 <Pine.LNX.4.44L0.1609191348440.1458-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33156 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbcITJeV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 05:34:21 -0400
Received: by mail-lf0-f47.google.com with SMTP id h127so8437294lfh.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2016 02:34:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609191348440.1458-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ritesh Raj Sarraf <rrs@researchut.com>, USB list <linux-usb@vger.kernel.org>, Micky Ching <micky_ching@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 19 September 2016 at 20:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 19 Sep 2016, Ulf Hansson wrote:
>
>> On 18 September 2016 at 04:30, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Sat, 17 Sep 2016, Ulf Hansson wrote:
>> >
>> >> Each access of the parent device (usb device) needs to be done in runtime
>> >> resumed state. Currently this isn't case while changing the leds, so let's
>> >> add pm_runtime_get_sync() and pm_runtime_put() around these calls.
>> >>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> ---
>> >>
>> >> While discussing an issue[1] related to runtime PM, I found out that this
>> >> minor change at least improves the behavior that has been observed.
>> >>
>> >> [1]
>> >> http://www.spinics.net/lists/linux-usb/msg144634.html
>> >>
>> >> ---
>> >>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
>> >> index 6c71fc9..a59c7fa 100644
>> >> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
>> >> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
>> >> @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>> >>               container_of(work, struct rtsx_usb_sdmmc, led_work);
>> >>       struct rtsx_ucr *ucr = host->ucr;
>> >>
>> >> +     pm_runtime_get_sync(sdmmc_dev(host));
>> >>       mutex_lock(&ucr->dev_mutex);
>> >>
>> >>       if (host->led.brightness == LED_OFF)
>> >> @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>> >>               rtsx_usb_turn_on_led(ucr);
>> >>
>> >>       mutex_unlock(&ucr->dev_mutex);
>> >> +     pm_runtime_put(sdmmc_dev(host));
>> >>  }
>> >>  #endif
>> >
>> > The missing aspect here is that this won't stop the parent USB device
>> > from going into autosuspend every 2 seconds and then resuming shortly
>> > afterward.  There are two ways of preventing this:
>> >
>> >         Call usb_mark_last_busy() at appropriate places.
>> >
>> >         Enable autosuspend for the sdmmc device.
>> >
>> > The second approach would also prevent the sdmmc device from going into
>> > autosuspend as soon as the LED update is finished.  Maybe that's okay,
>> > but if going into suspend is a lightweight procedure then you may want
>> > to prevent it.
>> >
>>
>> We can for sure enable autosuspend for the sdmmc device, although as
>> soon as an SD card will be detected the rtsx driver will increase the
>> runtime PM usage count. The count is decreased when the card is
>> removed (or failed to be initialized), thus runtime suspend is
>> prevented as long as there is a functional card inserted.
>
> Which means that autosuspend matters only when a card isn't present,
> and the host is polled every second or so to see whether a card has
> been inserted.
>
> Under those circumstances you probably don't want to use autosuspend.
> That is, resuming before each poll and suspending afterward may use
> less energy than staying at full power all the time.
>
>> I am wondering what you think would be a good autosuspend timeout in
>> this case? It seems to me that the only thing the rtsx driver really
>> care about is to tell the parent device that it needs to be runtime
>> resumed during a certain timeframe, more or less it would like to
>> inherit the parents settings.
>>
>> Other mmc hosts, not being usb-mmc devices, are using an autosuspend
>> timeout of ~50-100ms but that doesn't seem like good value here,
>> right?
>
> Well, if you decide to let the device go into runtime suspend between
> polls then there's no reason to use autosuspend at all.  Once a poll
> has ended, you know there won't be any more activity until the next
> poll.

We could change that, as currently the approach in the mmc core isn't
that sophisticated. I even think this has been discussed earlier for
the very similar reasons regards polling card detect mode.

I guess the main reason to why we yet have changed this, is because
mmc host drivers are using an autosuspend timeout of ~50-100 ms, so in
the end it haven't been such a big deal.

>
> On the other hand, if you decide to keep the device at full power all
> the time during polling, then any autosuspend timeout larger than 1000
> ms would do what you want.
>
> Mostly I'm concerned about how this will interact with the USB runtime
> PM.  The thing is, suspending the sdmmc device doesn't save any energy,
> whereas suspending the USB device does.

Yes, I agree.

My concern is also 2s autosuspend timeout which is set for the usb
device. Somehow I feel we need to be able "share" more information
between a parent-child relationship, in this case between the sdmmc
device and the usb device.

An observation I made, is when the sdmmc device gets runtime resumed
(pm_runtime_get_sync()), the parent device (the usb device) may also
become runtime resumed (unless it's already). In this sequence, but
*only* when actually runtime resuming the usb device, the runtime PM
core decides to update the last busy mark for the usb device. Should
it really do that?

Moreover, I am curious about the 2s usb timeout. Why isn't that chosen
to something like ~100ms instead? Is there is a long latency to
runtime resume the usb device or because we fear to wear out the HW,
which may be powered on/off too frequently?

If we assume that the usb device shouldn't be used with a timeout less
than 2s, then I think we have two options:

*) As the mmc polling timeout is 1s, there is really no point in
trying to runtime suspend the usb device, it may just be left runtime
resumed all the time. Wasting power, of course!
**) Add an interface to allow dynamically changes of the mmc polling
timeout to better suit the current user.

[...]

Kind regards
Uffe
