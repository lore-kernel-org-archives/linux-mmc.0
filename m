From: Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Thu, 27 Oct 2016 17:06:28 +0200
Message-ID: <e28c3ced-ddaa-27a3-469b-d1f5cc29b407@collabora.com>
References: <1475504388-31304-1-git-send-email-thierry.escande@collabora.com>
 <CAPDyKFoO1JX2-jpux+f-1O8kDC+jumspXapA0PZvKMBUE3YhSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943233AbcJ0PGi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 11:06:38 -0400
In-Reply-To: <CAPDyKFoO1JX2-jpux+f-1O8kDC+jumspXapA0PZvKMBUE3YhSA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf,

On 25/10/2016 12:03, Ulf Hansson wrote:
> On 3 October 2016 at 16:19, Thierry Escande
> <thierry.escande@collabora.com> wrote:
>> From: zhaojohn <john.zhao@intel.com>
>>
>> Hynix eMMC devices sometimes take 50% longer to resume from sleep.
>> Based on a recommendation from Hynix, send a Power-Off Notification
>> before going to S3 to restore a resume time consistently within spec.
>
> Could you also share what mmc controller and SoC you get this results from?
>
> More precisely, are you using MMC_CAP_WAIT_WHILE_BUSY?
This occurs on a braswell based chromebook, using the acpi sdhci 
controller. So yes, using MMC_CAP_WAIT_WHILE_BUSY.

[...]
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f2d185c..46a4562 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1925,8 +1925,14 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>         if (mmc_can_poweroff_notify(host->card) &&
>>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>                 err = mmc_poweroff_notify(host->card, notify_type);
>> -       else if (mmc_can_sleep(host->card))
>> +       else if (mmc_can_sleep(host->card)) {
>> +               if (host->card->quirks & MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
>> +                       err = mmc_poweroff_notify(host->card, notify_type);
>> +                       if (err)
>> +                               goto out;
>> +               }
>
> So, I am curious to know from a power management point of view; how
> does the card behave comparing the sleep and power off notification
> command?
>
> Is the card in a low power state after the power off notification has
> been received? If so, did you manage to do some measurement for that
> or perhaps the data-sheet tells about this? It would be interesting to
> know if there were any differences between sleep and power off
> notification in this regards.
I do not have any clue about that. It appears only with Hynix emmc and 
the fix has been approved by Hynix engineers... It seems that if not 
powered off, the firmware does some garbage collection when resuming and 
it takes more time...

Regards,
  Thierry
