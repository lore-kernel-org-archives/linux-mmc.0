From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] mmcoops with panic/oops
Date: Wed, 01 Dec 2010 13:42:09 +0900
Message-ID: <4CF5D221.7040500@samsung.com>
References: <4CF4B8E5.9070604@samsung.com>
 <20101130145141.d01f277f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50290 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab0LAEmW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 23:42:22 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LCQ005EPFQ0O010@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Dec 2010 13:42:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LCQ00DSXFQ027@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Dec 2010 13:42:00 +0900 (KST)
In-reply-to: <20101130145141.d01f277f.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>

Hi Andrew.

Andrew Morton wrote:
> On Tue, 30 Nov 2010 17:42:13 +0900
> Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
>> This patch is mmcoops.
>>
>> When Kernel panic or oops, write panic log to circular buffer in eMMC.
>> then after reset, we can see the log in MMC.
>>
>> So we need change mmc_wait_for_req().
>> because if we used schedule(), we can find atomic schedule warning.
>> That is not our needs log. so i used delay.
>> i want to know how about __mmc_wait_for_req()
>>
>> If any question, let me know.
>>
>> ...
>>  
>>  /**
>> - *	mmc_wait_for_req - start a request and wait for completion
>> + *	__mmc_wait_for_req - start a request and wait for completion
>>   *	@host: MMC host to start command
>>   *	@mrq: MMC request to start
>> + *	@panic: kernel panic/oops or not
>>   *
>>   *	Start a new MMC custom command request for a host, and wait
>>   *	for the command to complete. Does not attempt to parse the
>>   *	response.
>>   */
>> -void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>> +void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
>> +		int panic)
>>  {
>> -	DECLARE_COMPLETION_ONSTACK(complete);
>> +	if (panic) {
>> +		DECLARE_WAITQUEUE(wait, current);
>> +
>> +		mmc_start_request(host, mrq);
>> +
>> +		spin_lock_irq(&host->wq.lock);
>> +		init_waitqueue_head(&host->wq);
>> +
>> +		add_wait_queue_exclusive(&host->wq, &wait);
>> +		set_current_state(TASK_UNINTERRUPTIBLE);
>>  
>> -	mrq->done_data = &complete;
>> -	mrq->done = mmc_wait_done;
>> +		mdelay(10);
>> +		spin_unlock_irq(&host->wq.lock);
>> +	} else {
>> +		DECLARE_COMPLETION_ONSTACK(complete);
>> +
>> +		mrq->done_data = &complete;
>> +		mrq->done = mmc_wait_done;
>> +
>> +		mmc_start_request(host, mrq);
>> +
>> +		wait_for_completion(&complete);
>> +	}
>> +}
> 
> This approach seems somewhat OK - it will only do the busy-wait in the
> "panic=1" case, so existing callers shouldn't be affected.  (`panic'
> could have had type `bool', btw).
> 
> That being said, the code is odd/wrong.
> 
> void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
> 		int panic)
> {
> 	if (panic) {
> 		DECLARE_WAITQUEUE(wait, current);
> 
> 		mmc_start_request(host, mrq);
> 
> 		spin_lock_irq(&host->wq.lock);
> 		init_waitqueue_head(&host->wq);
> 
> 		add_wait_queue_exclusive(&host->wq, &wait);
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 
> 		mdelay(10);
> 		spin_unlock_irq(&host->wq.lock);
> 	} else {
> 
> Surely the waitqueue is unneeded and the missing remove_wait_queue() is a
> bug and the set_current_state() is a bug and the spin_lock_irq()
> appears to be unneeded.  afaict you want this:
> 

Sorry, Missing remove_wait_queue()...
Yes, actually i want below code. but that is not working well..
You said we need to know request completed.
But it is difficult to know correct delay time..

And when we try to write log, if happen other panic/oops log..
maybe that try to write that log..then happen write crash..
So i used waitqueue.

i changed spin_lock_irqsave() instead of spin_lock_irq()

> void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
> 		int panic)
> {
> 	if (panic) {
> 		mmc_start_request(host, mrq);
> 		mdelay(10);
> 	} else {
> 
> 
> However it is pretty bad to just delay 10 milliseconds and then assume
> that the request has completed.  Would it not be better to poll for the
> IRQ completion, or to poll some hardware flag?

right, 10 milliseconds is assumed..i'm also testing how much delay need..
If need, i will change that time. 

> 
> (We can't poll for IRQ completion if the caller has disabled IRQs, but
> if the caller has disabled IRQs then the use of spin_lock_irq() instead
> of spin_lock_irqsave() is yet another bug!)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thank you...

Regards,
Jaehoon Chung
