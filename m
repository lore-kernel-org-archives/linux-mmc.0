From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/3] mmc: core: Add a facility to "pause" re-tuning
Date: Wed, 11 May 2016 08:48:32 +0200
Message-ID: <CAPDyKFozyrzAPcw3v=XUEkMevLxxZ_AgHWXkwkYPN=AJkTAgXQ@mail.gmail.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
	<1462361893-11897-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrg3Fe8ypdzrbxD5DxHBNs7-6yVma-7X7NY4JfNzVzGPQ@mail.gmail.com>
	<5731DC12.4090906@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35713 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcEKGse (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2016 02:48:34 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so205051421wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 23:48:33 -0700 (PDT)
In-Reply-To: <5731DC12.4090906@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 10 May 2016 at 15:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 10/05/16 15:24, Ulf Hansson wrote:
>> On 4 May 2016 at 13:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Re-tuning is not possible when switched to the RPMB
>>> partition.  However re-tuning should not be needed
>>> if re-tuning is done immediately before switching,
>>> a small set of operations is done, and then we
>>> immediately switch back to the main partition.
>>>
>>> To ensure that re-tuning can't be done for a short
>>> while, add a facility to "pause" re-tuning.
>>>
>>> The existing facility to hold / release re-tuning
>>> is used but it also flags re-tuning as needed to cause
>>> re-tuning before the next command (which will be the
>>> switch to RPMB).
>>>
>>> We also need to "unpause" in the recovery path, which
>>> is catered for by adding it to mmc_retune_disable().
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/core/host.c  | 22 ++++++++++++++++++++++
>>>  include/linux/mmc/host.h |  4 ++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index e0a3ee16c0d3..302e5858755a 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -68,8 +68,30 @@ void mmc_retune_enable(struct mmc_host *host)
>>>                           jiffies + host->retune_period * HZ);
>>>  }
>>>
>>> +/*
>>> + * Pause re-tuning for a small set of operations.  The pause begins after the
>>> + * next command and after first doing re-tuning.
>>> + */
>>> +void mmc_retune_pause(struct mmc_host *host)
>>> +{
>>> +       if (!host->retune_paused) {
>>> +               host->retune_paused = 1;
>>> +               mmc_retune_needed(host);
>>> +               mmc_retune_hold(host);
>>> +       }
>>> +}
>>> +
>>
>> When the mmc block device driver is built as a module, this doesn't
>> build. I will drop the series from my next branch to sort this out.
>
> Oops. Sorry!
>
>> Should we export these via EXPORT_SYMBOL_GPL, or implement them as
>> inline functions?
>
> They need to be exported.  I tend to go with what else is in the same file
> i.e. host.c is exporting using EXPORT_SYMBOL()

Yes, okay!

>
>>
>> This also made me think about the SDIO/WLAN driver issue, during
>> system PM suspend/resume, which also needed temporary to disable
>> re-tuning.
>>
>> *If* we are going to export these, I want to make it works for the
>> SDIO case well...
>
> SDIO case is slightly different, and SDIO uses its own header file sdio_func.h.

I what way is it different?

Regarding the header file, my point is that I want to keep the numbers
of exported functions to a minimum.

Do you think there is way to combine these two use cases, such only
one pair of new functions would be needed?

Kind regards
Uffe
