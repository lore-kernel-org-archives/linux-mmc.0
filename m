From: Arend van Spriel <arend@broadcom.com>
Subject: Re: RESEND:[PATCH V3] sdhci: only reprogram retuning timer when flag
 is set
Date: Tue, 18 Mar 2014 22:02:29 +0100
Message-ID: <5328B465.5040200@broadcom.com>
References: <1393012782-23917-1-git-send-email-arend@broadcom.com>	<53183FF9.4090803@broadcom.com> <CAPDyKFpQSEhH4OoJ=v7drpfbTPZy4PQdSnbix5HG6XzGGTjzrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:36295 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbaCRVCc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Mar 2014 17:02:32 -0400
In-Reply-To: <CAPDyKFpQSEhH4OoJ=v7drpfbTPZy4PQdSnbix5HG6XzGGTjzrQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Dong Aisheng <dongas86@gmail.com>, Aaron Lu <aaron.lwe@gmail.com>

On 03/07/14 05:06, Ulf Hansson wrote:
> On 6 March 2014 10:29, Arend van Spriel<arend@broadcom.com>  wrote:
>> On 02/21/2014 08:59 PM, Arend van Spriel wrote:
>>> When the host->tuning_count is zero it means that the
>>> retuning is disabled. This is checked on the first
>>> run of sdhci_execute_tuning() by the if statement below:
>>>
>>>        if (!(host->flags&  SDHCI_NEEDS_RETUNING)&&  host->tuning_count&&
>>>            (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
>>>
>>> So only when tuning_count is non-zero it will set the host
>>> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
>>> for re-programming the timer, which means that flag must be
>>> set. Because that is not checked the else statement is executed
>>> in the first run when tuning_count is zero.
>>>
>>> This was seen on a host controller which indicated
>>> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
>>> that (one of) these registers is not properly set.
>>>
>>> Cc: Dong Aisheng<dongas86@gmail.com>
>>> Cc: Aaron Lu<aaron.lwe@gmail.com>
>>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>>> ---
>>> Noticed this patch was still not applied so please reconsider
>>> taking it in and let me know. The patch has been rebased and
>>> applies to the mmc-next branch.
>>
>> ping? Am I on some spam filter? What is needed to get this change applied?

Hi Chris,

Did this patch fall between the cracks. If needed I can rebase and 
resend it once more.

Regards,
Arend

>> Regards,
>> Arend
>>
>>> Regards,
>>> Arend
>>>
>>> V3:
>>> - remote tuning mode check for retuning timer reload
>>>
>>> V2:
>>> - add more explanation to the commit message
>>> - check host flag SDHCI_USING_RETUNING_TIMER
>>> ---
>>>   drivers/mmc/host/sdhci.c | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 9ddef47..d5b421d 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2026,12 +2026,11 @@ out:
>>>                        host->tuning_count * HZ);
>>>                /* Tuning mode 1 limits the maximum data length to 4MB */
>>>                mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
>>> -     } else {
>>> +     } else if (host->flags&  SDHCI_USING_RETUNING_TIMER) {
>>>                host->flags&= ~SDHCI_NEEDS_RETUNING;
>>>                /* Reload the new initial value for timer */
>>> -             if (host->tuning_mode == SDHCI_TUNING_MODE_1)
>>> -                     mod_timer(&host->tuning_timer, jiffies +
>>> -                             host->tuning_count * HZ);
>>> +             mod_timer(&host->tuning_timer, jiffies +
>>> +                       host->tuning_count * HZ);
>>>        }
>>>
>>>        /*
>>>
>>
>
> I don't have any deeper insight about the retuning mechanism for
> sdhci, still this seems reasonable.
>
> Acked-by: Ulf Hansson<ulf.hansson@linaro.org>

