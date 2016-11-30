From: Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Wed, 30 Nov 2016 18:05:30 +0100
Message-ID: <84376ac1-1f13-63c3-a552-0c26d24235df@collabora.com>
References: <1475504388-31304-1-git-send-email-thierry.escande@collabora.com>
 <CAPDyKFoO1JX2-jpux+f-1O8kDC+jumspXapA0PZvKMBUE3YhSA@mail.gmail.com>
 <e28c3ced-ddaa-27a3-469b-d1f5cc29b407@collabora.com>
 <CAPDyKFq+t4-m3V9Qx37x8B6_FSV3C_vJtQyaEu5+fgSffcEyDg@mail.gmail.com>
 <A6F6C92B-1E3A-4326-88B7-E3E9100E2DD8@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755563AbcK3RFf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 12:05:35 -0500
In-Reply-To: <A6F6C92B-1E3A-4326-88B7-E3E9100E2DD8@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On 31/10/2016 11:14, Alex Lemberg wrote:
> Hi,
>
> By the eMMC5.0 spec, before sending Sleep command (CMD5), hosts may set the
> POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
> Isn’t this a case in this patch?
> If yes, why not sending SLEEP_NOTIFICATION instead of POWER_OFF_SHORT?
I cannot tell if this was really what the Hynix engineers meant here.

> In the past we had a discussion on this topic, but the solution became more complicated because
> of possibly long timeout (max 83 seconds) on SLEEP_NOTIFICATION.
> https://marc.info/?t=143374696600002&r=1&w=1
>
> But still, in case we want to support POWER_OFF_NOTIFICATION before Sleep command,
> and in case we want to be eMMC spec aligned, I believe the right thing to do
> is to support SLEEP_NOTIFICATION…
I can give a try to this patchset to see if it solves the issue and get 
back to you afterward.

Regards,
  Thierry

>
> Thanks,
> Alex
>
> On 10/27/16, 10:49 PM, "linux-mmc-owner@vger.kernel.org on behalf of Ulf Hansson" <linux-mmc-owner@vger.kernel.org on behalf of ulf.hansson@linaro.org> wrote:
>
>> On 27 October 2016 at 17:06, Thierry Escande
>> <thierry.escande@collabora.com> wrote:
>>> Hi Ulf,
>>>
>>> On 25/10/2016 12:03, Ulf Hansson wrote:
>>>>
>>>> On 3 October 2016 at 16:19, Thierry Escande
>>>> <thierry.escande@collabora.com> wrote:
>>>>>
>>>>> From: zhaojohn <john.zhao@intel.com>
>>>>>
>>>>> Hynix eMMC devices sometimes take 50% longer to resume from sleep.
>>>>> Based on a recommendation from Hynix, send a Power-Off Notification
>>>>> before going to S3 to restore a resume time consistently within spec.
>>>>
>>>>
>>>> Could you also share what mmc controller and SoC you get this results
>>>> from?
>>>>
>>>> More precisely, are you using MMC_CAP_WAIT_WHILE_BUSY?
>>>
>>> This occurs on a braswell based chromebook, using the acpi sdhci controller.
>>> So yes, using MMC_CAP_WAIT_WHILE_BUSY.
>>>
>>> [...]
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index f2d185c..46a4562 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -1925,8 +1925,14 @@ static int _mmc_suspend(struct mmc_host *host,
>>>>> bool is_suspend)
>>>>>         if (mmc_can_poweroff_notify(host->card) &&
>>>>>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>>>>                 err = mmc_poweroff_notify(host->card, notify_type);
>>>>> -       else if (mmc_can_sleep(host->card))
>>>>> +       else if (mmc_can_sleep(host->card)) {
>>>>> +               if (host->card->quirks &
>>>>> MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
>>>>> +                       err = mmc_poweroff_notify(host->card,
>>>>> notify_type);
>>>>> +                       if (err)
>>>>> +                               goto out;
>>>>> +               }
>>>>
>>>>
>>>> So, I am curious to know from a power management point of view; how
>>>> does the card behave comparing the sleep and power off notification
>>>> command?
>>>>
>>>> Is the card in a low power state after the power off notification has
>>>> been received? If so, did you manage to do some measurement for that
>>>> or perhaps the data-sheet tells about this? It would be interesting to
>>>> know if there were any differences between sleep and power off
>>>> notification in this regards.
>>>
>>> I do not have any clue about that. It appears only with Hynix emmc and the
>>> fix has been approved by Hynix engineers... It seems that if not powered
>>> off, the firmware does some garbage collection when resuming and it takes
>>> more time...
>>
>> Okay, I see. So before I continue reviewing, can you please also tell
>> what regulators to the card that is being cut while powering off in
>> this path.
>>
>> VMMC, VQMMC?
>>
>> Kind regards
>> Uffe
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
