From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH v1 1/3] mmc: sdio: fix resume failure
Date: Fri, 07 Dec 2012 17:45:55 +0530
Message-ID: <50C1DDFB.2060005@codeaurora.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org> <1354620980-23764-2-git-send-email-subhashj@codeaurora.org> <CAPDyKFowKZcUXr-4Qug_Awww6wPGXsAm-gMaKs7oOrTwN9RFVw@mail.gmail.com> <50C0B8E5.4020502@codeaurora.org> <CAPDyKFrNEKMDpKLZno2WqExrbdjeK8axjLW9bTuJXf+OygChHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:60551 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933765Ab2LGMP7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 07:15:59 -0500
In-Reply-To: <CAPDyKFrNEKMDpKLZno2WqExrbdjeK8axjLW9bTuJXf+OygChHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 12/7/2012 3:40 AM, Ulf Hansson wrote:
> On 6 December 2012 16:25, Subhash Jadavani <subhashj@codeaurora.org> wrote:
>> On 12/6/2012 4:03 PM, Ulf Hansson wrote:
>>> On 4 December 2012 12:36, Subhash Jadavani <subhashj@codeaurora.org>
>>> wrote:
>>>> If SDIO keep power flag (MMC_PM_KEEP_POWER) is not set, card would
>>>> be reinitialized during resume but as we are not resetting
>>>> (CMD52 reset) the SDIO card during this reinitialization, card may
>>>> fail to respond back to subsequent commands (CMD5 etc...).
>>>>
>>>> This change resets the card before the reinitialization of card
>>>> during resume.
>>>>
>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>> ---
>>>>    drivers/mmc/core/sdio.c |    6 ++++--
>>>>    1 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>>> index 2273ce6..34ad4c8 100644
>>>> --- a/drivers/mmc/core/sdio.c
>>>> +++ b/drivers/mmc/core/sdio.c
>>>> @@ -937,10 +937,12 @@ static int mmc_sdio_resume(struct mmc_host *host)
>>>>           mmc_claim_host(host);
>>>>
>>>>           /* No need to reinitialize powered-resumed nonremovable cards */
>>>> -       if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
>>>> +       if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
>>>> +               sdio_reset(host);
>>>> +               mmc_go_idle(host);
>>> If the card has lost power, why is this needed? Could it be that the
>>> host is not capable of cutting the power to card?
>>
>> Yes, the regulator powering the card is always on in this case which means
>> SDIO VDD is not powered off during the suspend.
>>
> So in principle the host should be able to notify the protocol layer
> about that mmc_card_keep_power will always be set somehow.
> That could be a more proper way of solving this maybe? What do you think?
Ok.
Basically this would be the suspend/resume sequence with Keep Power flag 
cleared.

Suspend:
1. Execute Function driver suspend
2. mmc_power_off()
     2.1 As this is regulator powering card SDIO VDD line is always on 
regulator, it will stay on.

Resume:
1. mmc_power_up()
      1.1 Regulator was anyway on so nothing change here.
2.  mmc_sdio_init_card() - reinitialize the card
      2.1 CMD5 gets the commands response timeout which means card 
doesn't respond back.

My understanding is that behaviour seen in 2.1 (resume) is because 
during suspend, function driver suspend might have done something with 
the SDIO card (as keep power flag was disabled) and that's the reason 
during resume, card fails to respond back to CMD5 (unless we send the 
CMD52 to reset the card). It's an athros SDIO wifi card here.

 >> So in principle the host should be able to notify the protocol layer 
about that mmc_card_keep_power will always be set somehow.
Given the above issue, i am not sure how is this suggestion going to 
help in this case?

Regards,
Subhash

>
>>> It might be more safe to do this but I would like to understand more,
>>> before you get my ack on this patch.
>>>
>>>>                   err = mmc_sdio_init_card(host, host->ocr, host->card,
>>>>                                           mmc_card_keep_power(host));
>>>> -       else if (mmc_card_keep_power(host) &&
>>>> mmc_card_wake_sdio_irq(host)) {
>>>> +       } else if (mmc_card_keep_power(host) &&
>>>> mmc_card_wake_sdio_irq(host)) {
>>>>                   /* We may have switched to 1-bit mode during suspend */
>>>>                   err = sdio_enable_4bit_bus(host->card);
>>>>                   if (err > 0) {
>>>> --
>>>> --
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>>>> of Code Aurora Forum, hosted by The Linux Foundation
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Kind regards
>>> Ulf Hansson
>>

