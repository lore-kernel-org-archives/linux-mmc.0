From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Mon, 6 Feb 2017 12:07:46 +0100
Message-ID: <CAPDyKFqG8BvCSXUJjbT_CG-Hz3Rtu5m0Lg8D+Bi4npSyO9tpmg@mail.gmail.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com> <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <dc423c8d-ae55-2437-9f6e-b099a68c9d59@codeaurora.org> <CAPDyKFqD00jmG=HesANpGv_=FP_cKodFkv2SdkX5DihLTbP_tA@mail.gmail.com>
 <c00cb414-be2e-0f07-41e3-b9e88a0d4295@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33769 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdBFLHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2017 06:07:49 -0500
Received: by mail-wr0-f181.google.com with SMTP id i10so21539827wrb.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2017 03:07:48 -0800 (PST)
In-Reply-To: <c00cb414-be2e-0f07-41e3-b9e88a0d4295@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Uri Yanai <uri.yanai@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>

[...]

>>
>> This may become a severe problem, because the SLEEP_NOTIFICATION_TIME
>> may be ridiculously long and since it immediately affects the total
>> system suspend time for the platform.
>
> Do we know more card internal details on why this time could be long?

I think this will be hard to get an answer to, because it do varies
depending on the eMMC vendor.

> Although POWER_OFF_SHORT time is within generic CMD6 response time.

Assuming you mean the case when sending a power off notification using
POWER_OFF_SHORT, instead of sending sleep (CMD5) when suspending? This
is the case for those mmc hosts using MMC_CAP2_FULL_PWR_CYCLE (DT
binding "full-pwr-cycle", MMC_CAP2_FULL_PWR_CYCLE == host can power
off both VCC and VCCQ). So these have no issues.

However, the majority of platforms/hosts don't use
MMC_CAP2_FULL_PWR_CYCLE, which means using sleep (CMD5) at suspend.
For these cases and when the eMMC cards is a v5.0+ (eMMC v5.0 added
sleep notification), the mmc core are currently violating the eMMC
spec - because we don't write the SLEEP_NOTIFICATION bits.

>
>
> So enabling auto bkops *may* help reduce the sleep notification time to some
> extent I guess.
> Since card may already would have completed it's background operations while
> the card was idle, then sleep notification time may reduce, right?

I agree, this seems like a reasonable conclusion we should make.
Unless eMMC vendors tells us different.

> Although, someone who have more knowledge of card internals would know
> better here.
>
> And in case where the bkops exception level is high, patch is anyway
> aborting suspend by returning -EBUSY, giving enough time for card to first
> complete it's background operations.
>
>>
>> We need to think of something clever here to avoid a long sleep
>> notification timeout from happen.
>>
>> [...]
>>
>>>>
>>>> Hmm.
>>>>
>>>> Shouldn't we abort (return -EBUSY) also in the system PM suspend case
>>>> and not only for runtime PM suspend?
>>>
>>>
>>>
>>> My opinion - Auto bkops generally is meant for device to autonomously
>>> initiate the background transfer whenever the device is idle -> in such
>>> cases, we expect the device to keep it's autobkops exception level under
>>> control.
>>> In that case will it be good idea to abort the suspend as well?
>>
>>
>> I follow your reasoning and it seems reasonable. However, see my comment
>> below.
>>
>>>
>>> Off-course unless we would like to cover a case where device is not idle
>>> at
>>> all and during this heavy device usage suspend is getting triggered
>>> manually
>>> - which gives no time for device to do auto-bkops
>>> Please correct me if my understanding is wrong?
>>
>>
>> This is the case that I thought off. Don't you think this could be a
>> valid scenario for an Android device?
>
> Yes, totally agree. This can be a valid use case on Android.
> There can be watchdog timer monitoring per device suspend time. So, if we
> don't take care of mmc suspend case, it may result into watchdog bark, since
> mmc_suspend may take longer.

Yes, exactly.

So, hopefully we can improve the situation for when we need to write
the SLEEP_NOFITICATION bits, by first checking BKOPS status and
returning -EBUSY.

>
> So as you mentioned, even suspend case needs to be taken care here.

Great, thanks for your input!

[...]

Kind regards
Uffe
