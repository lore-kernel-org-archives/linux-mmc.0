From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: fix the aysync mechanism when card removed
Date: Thu, 31 Jan 2013 18:46:17 +0900
Message-ID: <510A3D69.5080309@samsung.com>
References: <50FE838C.5010709@samsung.com> <510A2E69.6000608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30115 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab3AaJqu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 04:46:50 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHH00ERGHTAF6G0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 18:46:48 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHH00AOMHTVVH70@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 18:46:48 +0900 (KST)
In-reply-to: <510A2E69.6000608@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, Per FORLIN <per.forlin@stericsson.com>, Maya Erez <merez@codeaurora.org>

On 01/31/2013 05:42 PM, Subhash Jadavani wrote:
> On 1/22/2013 5:48 PM, Jaehoon Chung wrote:
>> When card removed, then didn't complete the previously data.
>> (It didn't wakeup any interrupt.)
>> If card is removed, then we can assume to complete the previously data.
>> And wakeup the interrupt for wait_event of data.
>>
>> This problem is produced when sd-card is removed.(Sd-card is running some operation)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
>> ---
>>   drivers/mmc/core/core.c |   31 ++++++++++++++++++++-----------
>>   1 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 8b3a122..bc1d627 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -515,17 +515,26 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>>           mmc_pre_req(host, areq->mrq, !host->areq);
>>         if (host->areq) {
>> -            err = mmc_wait_for_data_req_done(host, host->areq->mrq,
>> -                    areq);
>> -            if (err == MMC_BLK_NEW_REQUEST) {
>> -                if (error)
>> -                    *error = err;
>> -                /*
>> -                 * The previous request was not completed,
>> -                 * nothing to return
>> -                 */
>> -                return NULL;
>> -            }
>> +        err = mmc_wait_for_data_req_done(host, host->areq->mrq,
>> +                areq);
>> +        if (err == MMC_BLK_NEW_REQUEST) {
>> +            if (error)
>> +                *error = err;
>> +            /*
>> +             * The previous request was not completed,
>> +             * nothing to return
>> +             */
>> +            return NULL;
>> +        } else if (err == MMC_BLK_NOMEDIUM && areq) {
>> +            struct mmc_context_info *ctnx = &host->context_info;
>> +            /*
>> +             * If crad is removed,
>> +             * then we didn't wait for data completed.
>> +             * Assume that data-recieve done.
>> +             */
>> +            ctnx->is_done_rcv = true;
>> +            wake_up_interruptible(&ctnx->wait);
> 
> Can you please explain more on what exactly we are trying to do here (may be you can list down the call flow)? I am not sure if i understood this correctly. But why would you need to wakeup the thread here? We are here because thread is already woken up. mmc_wait_for_data_req_done() would return only if either the new request is received or the currently running request on controller is completed.
This problem is produced when card is removed and running some operation.
If card is removed, mmc_wait_for_data_req_done() is returned error, right?
But if there was async request and running async operation, then maybe run mmc_start_request() with areq.
controller is waiting "_for_req_data_done_" for areq.

If request is host->areq.process is running at this time.
But if request is areq(prepared request), then mmc_wait_for_data_req_done should be pending.
and system is dead-lock.

Best Regards,
Jaehoon Chung

> 
> Regards,
> Subhash
> 
>> +        }
>>           /*
>>            * Check BKOPS urgency for each R1 response
>>            */
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

