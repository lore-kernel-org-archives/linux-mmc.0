From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Wed, 13 Jun 2012 12:07:12 +0900
Message-ID: <4FD803E0.8050206@samsung.com>
References: <dc39d568ca6fa31dda7d6420a61cba3f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62468 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab2FMDHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 23:07:44 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M5J00JLQCON9AE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jun 2012 12:07:42 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M5J00IRECOTSQ60@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jun 2012 12:07:42 +0900 (KST)
In-reply-to: <dc39d568ca6fa31dda7d6420a61cba3f.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On 06/12/2012 07:58 PM, merez@codeaurora.org wrote:

>> @@ -359,12 +443,15 @@ struct mmc_async_req *mmc_start_req(struct
> mmc_host
>> *host,
>>  	if (!err && areq)
>>  		start_err = __mmc_start_req(host, areq->mrq);
>>
>> -	if (host->areq)
>> +	if (host->areq) {
>> +		if (!areq && host->areq && mmc_card_mmc(host->card))
>> +			mmc_start_bkops(host->card);
> I think it would be better to start tey BKOPs in the queue thread when it
> becomes idle.
> We have seen cases where there are several requests fetched and then NULL
> but by the time the previous request ends there are more requests to be
> fetched. Starting the BKOPs here instead of in the queue thread increases
> the probability of using HPI to stop the BKOPs due to incoming request,
> which is not a desirable action.

I will change this point.

> 
>>  		mmc_post_req(host, host->areq->mrq, 0);
>> +	}
>>
>>  	 /* Cancel a prepared request if it was not started. */
>>  	if ((err || start_err) && areq)
>> -			mmc_post_req(host, areq->mrq, -EINVAL);
>> +		mmc_post_req(host, areq->mrq, -EINVAL);
> Remove this change, it is not related to this patch.

Ok.
Anything else?

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


