From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/1] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Wed, 30 Nov 2016 11:29:46 +0100
Message-ID: <CAPDyKFrhQimUZ-GcJE2x7cq4CfnGw=mOtOc+6hTucCvuSgSkKQ@mail.gmail.com>
References: <1480429488-22289-1-git-send-email-thierry.escande@collabora.com>
 <CGME20161129142519epcas3p17c89a8e9123e8daa7d2479cb9d107fad@epcas3p1.samsung.com>
 <1480429488-22289-2-git-send-email-thierry.escande@collabora.com>
 <89a61073-6f1e-d386-c2d1-866447bcd715@samsung.com> <302c7160-bdb2-d31a-4847-5c066f43feaf@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35099 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755441AbcK3K3t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 05:29:49 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so264336156wmd.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2016 02:29:48 -0800 (PST)
In-Reply-To: <302c7160-bdb2-d31a-4847-5c066f43feaf@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Escande <thierry.escande@collabora.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Bernie Thompson <bhthompson@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

+Alex

On 30 November 2016 at 10:10, Thierry Escande
<thierry.escande@collabora.com> wrote:
> Hi Jaehoon,
>
> On 30/11/2016 09:46, Jaehoon Chung wrote:
>>
>> On 11/29/2016 11:24 PM, Thierry Escande wrote:
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index df19777..774d478 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1941,8 +1941,14 @@ static int _mmc_suspend(struct mmc_host *host,
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
>>>                 err = mmc_sleep(host);
>>
>>
>> After running mmc_poweroff_notify(), also doing mmc_sleep()? Is it right?
>
>
> Yes, that's what the quirk is intended for. This firmware resumes from sleep
> faster if it has been notified for power-off. This is a recommendation from
> Hynix.

I think we need to discuss this change in the context of eMMC sleep
notification - as a generic solution and conforming to the eMMC spec.

This was also as pointed out by Alex [1]. Perhaps you can respond to
his earlier reply?

>
> Regards,
>  Thierry

Kind regards
Uffe

[1]
http://www.spinics.net/lists/linux-mmc/msg39892.html
