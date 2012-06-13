From: merez@codeaurora.org
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Tue, 12 Jun 2012 23:18:11 -0700 (PDT)
Message-ID: <63d2a1617cbe83b94750378ebe64520e.squirrel@www.codeaurora.org>
References: <dc39d568ca6fa31dda7d6420a61cba3f.squirrel@www.codeaurora.org>
    <4FD803E0.8050206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3024 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab2FMGSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 02:18:11 -0400
In-Reply-To: <4FD803E0.8050206@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: merez@codeaurora.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>


On Tue, June 12, 2012 8:07 pm, Jaehoon Chung wrote:
> On 06/12/2012 07:58 PM, merez@codeaurora.org wrote:
>
>>> @@ -359,12 +443,15 @@ struct mmc_async_req *mmc_start_req(struct
>> mmc_host
>>> *host,
>>>  	if (!err && areq)
>>>  		start_err = __mmc_start_req(host, areq->mrq);
>>>
>>> -	if (host->areq)
>>> +	if (host->areq) {
>>> +		if (!areq && host->areq && mmc_card_mmc(host->card))
>>> +			mmc_start_bkops(host->card);
>> I think it would be better to start tey BKOPs in the queue thread when
>> it
>> becomes idle.
>> We have seen cases where there are several requests fetched and then
>> NULL
>> but by the time the previous request ends there are more requests to be
>> fetched. Starting the BKOPs here instead of in the queue thread
>> increases
>> the probability of using HPI to stop the BKOPs due to incoming request,
>> which is not a desirable action.
>
> I will change this point.
>
>>
>>>  		mmc_post_req(host, host->areq->mrq, 0);
>>> +	}
>>>
>>>  	 /* Cancel a prepared request if it was not started. */
>>>  	if ((err || start_err) && areq)
>>> -			mmc_post_req(host, areq->mrq, -EINVAL);
>>> +		mmc_post_req(host, areq->mrq, -EINVAL);
>> Remove this change, it is not related to this patch.
>
> Ok.
> Anything else?
>
> Best Regards,
> Jaehoon Chung
We have no further comments.

Thanks,
Maya Erez

-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

