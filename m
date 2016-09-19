From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing led
Date: Mon, 19 Sep 2016 11:24:18 +0200
Message-ID: <CAPDyKFpFObRkvUC5kOKznE3FAGL6H_Hufa7ZEFWpmB694AY9ow@mail.gmail.com>
References: <1474107278-3271-1-git-send-email-ulf.hansson@linaro.org> <Pine.LNX.4.44L0.1609172219100.1716-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37681 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbcISJYV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2016 05:24:21 -0400
Received: by mail-wm0-f54.google.com with SMTP id b130so51990773wmc.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2016 02:24:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1609172219100.1716-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ritesh Raj Sarraf <rrs@researchut.com>, USB list <linux-usb@vger.kernel.org>, Micky Ching <micky_ching@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 18 September 2016 at 04:30, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 17 Sep 2016, Ulf Hansson wrote:
>
>> Each access of the parent device (usb device) needs to be done in runtime
>> resumed state. Currently this isn't case while changing the leds, so let's
>> add pm_runtime_get_sync() and pm_runtime_put() around these calls.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> While discussing an issue[1] related to runtime PM, I found out that this
>> minor change at least improves the behavior that has been observed.
>>
>> [1]
>> http://www.spinics.net/lists/linux-usb/msg144634.html
>>
>> ---
>>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
>> index 6c71fc9..a59c7fa 100644
>> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
>> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
>> @@ -1314,6 +1314,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>>               container_of(work, struct rtsx_usb_sdmmc, led_work);
>>       struct rtsx_ucr *ucr = host->ucr;
>>
>> +     pm_runtime_get_sync(sdmmc_dev(host));
>>       mutex_lock(&ucr->dev_mutex);
>>
>>       if (host->led.brightness == LED_OFF)
>> @@ -1322,6 +1323,7 @@ static void rtsx_usb_update_led(struct work_struct *work)
>>               rtsx_usb_turn_on_led(ucr);
>>
>>       mutex_unlock(&ucr->dev_mutex);
>> +     pm_runtime_put(sdmmc_dev(host));
>>  }
>>  #endif
>
> The missing aspect here is that this won't stop the parent USB device
> from going into autosuspend every 2 seconds and then resuming shortly
> afterward.  There are two ways of preventing this:
>
>         Call usb_mark_last_busy() at appropriate places.
>
>         Enable autosuspend for the sdmmc device.
>
> The second approach would also prevent the sdmmc device from going into
> autosuspend as soon as the LED update is finished.  Maybe that's okay,
> but if going into suspend is a lightweight procedure then you may want
> to prevent it.
>

We can for sure enable autosuspend for the sdmmc device, although as
soon as an SD card will be detected the rtsx driver will increase the
runtime PM usage count. The count is decreased when the card is
removed (or failed to be initialized), thus runtime suspend is
prevented as long as there is a functional card inserted.

I am wondering what you think would be a good autosuspend timeout in
this case? It seems to me that the only thing the rtsx driver really
care about is to tell the parent device that it needs to be runtime
resumed during a certain timeframe, more or less it would like to
inherit the parents settings.

Other mmc hosts, not being usb-mmc devices, are using an autosuspend
timeout of ~50-100ms but that doesn't seem like good value here,
right?

Kind regards
Uffe
