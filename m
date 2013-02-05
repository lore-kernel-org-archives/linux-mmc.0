From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 1/2] mmc: core: fix permanent sleep of mmcqd during card
 removal
Date: Tue, 05 Feb 2013 13:02:11 +0530
Message-ID: <5110B57B.1040903@codeaurora.org>
References: <n@samsung.com> <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org> <001201cdfeb3$3e628ee0$bb27aca0$%jun@samsung.com> <510F9ED6.2030402@codeaurora.org> <001f01ce0365$a7e7f560$f7b7e020$%jun@samsung.com> <5110AF4E.5040207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:56710 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab3BEHcQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Feb 2013 02:32:16 -0500
In-Reply-To: <5110AF4E.5040207@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 2/5/2013 12:35 PM, Jaehoon Chung wrote:
> Hi Subhash,
>
> As Mr. Seungwon mentioned, your patch didn't solve the dead-lock issue.
> I'm prefered to the seungwon's patch.

Yes, i got the problem with the patch. I guess it's better to g ahead
with Seungwon's patch.
Looks good to me. Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

>
> Best Regards,
> Jaehoon Chung
>
> On 02/05/2013 02:57 PM, Seungwon Jeon wrote:
>> On Monday, February 04, 2013, Subhash Jadavani wrote:
>>> On 1/30/2013 12:00 PM, Seungwon Jeon wrote:
>>>> Hi Konstantin.
>>>>
>>>> Could you check this patch with [2/2]?
>>>> [PATCH 2/2] mmc: block: don't start new request when the card is removed
>>>>
>>>> mmcqd is often sleeping with acquiring the claim(mmc_claim_host) when a card is removed.
>>>> As a result, mmc_rescan can be blocked for the insertion of a card newly. It's a dead lock.
>>>>
>>>> Thanks,
>>>> Seungwon Jeon
>>>>
>>>> On Tuesday, January 22, 2013, Seungwon Jeon wrote:
>>>>> This patch is derived from 'mmc: fix async request mechanism ...'.
>>>>> According as async transfer, a request is handled with twice mmc_start_req.
>>>>> When the card is removed, the request is actually not issued in the first
>>>>> mmc_start_req [__mmc_start_data_req]. And then mmc_wait_for_data_req_done
>>>>> will come in the next mmc_start_req. But there is no event for completions.
>>>>> wake_up_interruptible is needed in __mmc_start_data_req for the case of
>>>>> removed card.
>>> Hi Seungwon,
>>>
>>> I looked at this again and i guess there is something wrong with
>>> mmc_start_req() itself.
>>> As per your commit text, first call to mmc_start_req() calls the
>>> __mmc_start_data_req() function and __mmc_start_data_req() returns the
>>> -ENOMEDIUM error (as card is removed) without starting the request on
>>> host controller. so now in mmc_start_req(), "start_err" should be set.
>>> But currently mmc_start_req() incorrectly marks the "host->areq" to
>>> "areq" in even if the start_err is set which i guess is wrong. what do
>>> you think about it?
>>>
>>> So how about this fix? I guess this is better and it should fix the
>>> deadlock issue as well. Do let me know you thoughts on this. If it looks
>>> reasonable, i can post the formal patch.
>> Hi Subhash,
>>
>> I tested your fix, but there is still problem.
>> I didn't look into the reason.
>>
>> Thanks,
>> Seungwon Jeon
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 39f28af..1aa7dbe 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -546,7 +546,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host
>>> *host,
>>> if ((err || start_err) && areq)
>>> mmc_post_req(host, areq->mrq, -EINVAL);
>>>
>>> - if (err)
>>> + if (err || start_err)
>>> host->areq = NULL;
>>> else
>>> host->areq = areq;
>>>
>>> Regards,
>>> Subhash
>>>
>>>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>>>> ---
>>>>>  drivers/mmc/core/core.c |    1 +
>>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 8b3a122..997b257 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -350,6 +350,7 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
>>>>>  	mrq->host = host;
>>>>>  	if (mmc_card_removed(host->card)) {
>>>>>  		mrq->cmd->error = -ENOMEDIUM;
>>>>> +		mmc_wait_data_done(mrq);
>>>>>  		return -ENOMEDIUM;
>>>>>  	}
>>>>>  	mmc_start_request(host, mrq);
>>>>> --
>>>>> 1.7.0.4
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

