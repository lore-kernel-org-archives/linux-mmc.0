From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Thu, 27 Oct 2016 21:49:09 +0200
Message-ID: <CAPDyKFq+t4-m3V9Qx37x8B6_FSV3C_vJtQyaEu5+fgSffcEyDg@mail.gmail.com>
References: <1475504388-31304-1-git-send-email-thierry.escande@collabora.com>
 <CAPDyKFoO1JX2-jpux+f-1O8kDC+jumspXapA0PZvKMBUE3YhSA@mail.gmail.com> <e28c3ced-ddaa-27a3-469b-d1f5cc29b407@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38120 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJ0TtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 15:49:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id n67so70204101wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 12:49:11 -0700 (PDT)
In-Reply-To: <e28c3ced-ddaa-27a3-469b-d1f5cc29b407@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Escande <thierry.escande@collabora.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 27 October 2016 at 17:06, Thierry Escande
<thierry.escande@collabora.com> wrote:
> Hi Ulf,
>
> On 25/10/2016 12:03, Ulf Hansson wrote:
>>
>> On 3 October 2016 at 16:19, Thierry Escande
>> <thierry.escande@collabora.com> wrote:
>>>
>>> From: zhaojohn <john.zhao@intel.com>
>>>
>>> Hynix eMMC devices sometimes take 50% longer to resume from sleep.
>>> Based on a recommendation from Hynix, send a Power-Off Notification
>>> before going to S3 to restore a resume time consistently within spec.
>>
>>
>> Could you also share what mmc controller and SoC you get this results
>> from?
>>
>> More precisely, are you using MMC_CAP_WAIT_WHILE_BUSY?
>
> This occurs on a braswell based chromebook, using the acpi sdhci controller.
> So yes, using MMC_CAP_WAIT_WHILE_BUSY.
>
> [...]
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index f2d185c..46a4562 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1925,8 +1925,14 @@ static int _mmc_suspend(struct mmc_host *host,
>>> bool is_suspend)
>>>         if (mmc_can_poweroff_notify(host->card) &&
>>>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>>                 err = mmc_poweroff_notify(host->card, notify_type);
>>> -       else if (mmc_can_sleep(host->card))
>>> +       else if (mmc_can_sleep(host->card)) {
>>> +               if (host->card->quirks &
>>> MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
>>> +                       err = mmc_poweroff_notify(host->card,
>>> notify_type);
>>> +                       if (err)
>>> +                               goto out;
>>> +               }
>>
>>
>> So, I am curious to know from a power management point of view; how
>> does the card behave comparing the sleep and power off notification
>> command?
>>
>> Is the card in a low power state after the power off notification has
>> been received? If so, did you manage to do some measurement for that
>> or perhaps the data-sheet tells about this? It would be interesting to
>> know if there were any differences between sleep and power off
>> notification in this regards.
>
> I do not have any clue about that. It appears only with Hynix emmc and the
> fix has been approved by Hynix engineers... It seems that if not powered
> off, the firmware does some garbage collection when resuming and it takes
> more time...

Okay, I see. So before I continue reviewing, can you please also tell
what regulators to the card that is being cut while powering off in
this path.

VMMC, VQMMC?

Kind regards
Uffe
