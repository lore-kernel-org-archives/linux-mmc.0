From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Fri, 3 Feb 2017 22:27:15 +0530
Message-ID: <c00cb414-be2e-0f07-41e3-b9e88a0d4295@codeaurora.org>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <dc423c8d-ae55-2437-9f6e-b099a68c9d59@codeaurora.org>
 <CAPDyKFqD00jmG=HesANpGv_=FP_cKodFkv2SdkX5DihLTbP_tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdBCQ5Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 11:57:24 -0500
In-Reply-To: <CAPDyKFqD00jmG=HesANpGv_=FP_cKodFkv2SdkX5DihLTbP_tA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Uri Yanai <uri.yanai@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>



On 2/3/2017 5:16 PM, Ulf Hansson wrote:
> On 3 February 2017 at 10:33, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>> Hi,
>>
>> On 2/2/2017 6:19 PM, Ulf Hansson wrote:
>>>
>>> + Adrian, Shawn-Lin, Jaehoon, Ritesh
>>>
>>> On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
>>>>
>>>> In case of Runtime Suspend, check the device BKOPS level.
>>>> Return –EBUSY if device need more time to complete its internal BKOPS.
>>
>> Do we need to abort the runtime suspend at all even though we are using
>> CMD5?
>>
>> From what I understood from the spec is as follows - (please correct me if I
>> am wrong) -
>> CMD7 -> CMD5 -> Busy line de-asserted by device(means autobkops execution is
>> complete) -> Enter sleep mode.
>>
>> Is the above understanding correct? In that case we may not need to abort
>> the runtime suspend right?
>> Since CMD5 completion should ensure that background operation execution is
>> complete (until then the busy line will be kept asserted).
>>
>> Opinion?
>
> Unfortunate the eMMC spec isn't crystal clear on this point. Anyway,
> my interpretation of it is not as yours. Let me elaborate on my view.
>
> In case we have enabled POWERED_ON bit (0x1) in POWER_OFF_NOTIFICATION
> register byte, during the card initialization, and we later want to
> put the device into sleep state by using CMD5. Then we need to follow
> the below sequence:
> 1) Using CMD6, write SLEEP_NOTIFICATION bits (0x4) to
> POWER_OFF_NOTIFICATION register byte.
> 2) Wait for busy! Maximum time specified in
> SLEEP_NOTIFICATION_TIME[216] (worst case 83.88s).
> 3) Put the card to sleep by send CMD5 and wait for busy (current
> implemented method of issuing sleep).
>
> As we have enabled POWERED_ON for those cards that supports
> POWER_OFF_NOTIFICATION (added in eMMC 4.5 spec), then we also need to
> follow the above sequence for when sending sleep (CMD5).
Thanks for clarifying. I initially misunderstood and missed 
SLEEP_NOTIFICATION part.
Yes, you are right, we do need to follow the above sequence you mentioned.

>
> This may become a severe problem, because the SLEEP_NOTIFICATION_TIME
> may be ridiculously long and since it immediately affects the total
> system suspend time for the platform.
Do we know more card internal details on why this time could be long?
Although POWER_OFF_SHORT time is within generic CMD6 response time.


So enabling auto bkops *may* help reduce the sleep notification time to 
some extent I guess.
Since card may already would have completed it's background operations 
while the card was idle, then sleep notification time may reduce, right?
Although, someone who have more knowledge of card internals would know 
better here.

And in case where the bkops exception level is high, patch is anyway 
aborting suspend by returning -EBUSY, giving enough time for card to 
first complete it's background operations.

>
> We need to think of something clever here to avoid a long sleep
> notification timeout from happen.
>
> [...]
>
>>>
>>> Hmm.
>>>
>>> Shouldn't we abort (return -EBUSY) also in the system PM suspend case
>>> and not only for runtime PM suspend?
>>
>>
>> My opinion - Auto bkops generally is meant for device to autonomously
>> initiate the background transfer whenever the device is idle -> in such
>> cases, we expect the device to keep it's autobkops exception level under
>> control.
>> In that case will it be good idea to abort the suspend as well?
>
> I follow your reasoning and it seems reasonable. However, see my comment below.
>
>>
>> Off-course unless we would like to cover a case where device is not idle at
>> all and during this heavy device usage suspend is getting triggered manually
>> - which gives no time for device to do auto-bkops
>> Please correct me if my understanding is wrong?
>
> This is the case that I thought off. Don't you think this could be a
> valid scenario for an Android device?
Yes, totally agree. This can be a valid use case on Android.
There can be watchdog timer monitoring per device suspend time. So, if 
we don't take care of mmc suspend case, it may result into watchdog 
bark, since mmc_suspend may take longer.

So as you mentioned, even suspend case needs to be taken care here.


>
> [...]
>
> It seems like we are discussing several related things at the same
> time. Perhaps this is the only way, as they are so closely related.
>
> Kind regards
> Uffe
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
