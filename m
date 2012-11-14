From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Wed, 14 Nov 2012 17:15:36 +0200
Message-ID: <50A3B598.4030702@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>	<5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org>	<5089549D.3060507@stericsson.com>	<CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>	<508D2F2E.3020006@codeaurora.org>	<CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>	<508FC5E4.8010906@codeaurora.org> <CAFEEs1=+xD+jkydx7O-MLcvbyNkZ7BQbi=Q10c_Ln0XyXdRPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050400060304060608090305"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:58962 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422641Ab2KNPPl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Nov 2012 10:15:41 -0500
In-Reply-To: <CAFEEs1=+xD+jkydx7O-MLcvbyNkZ7BQbi=Q10c_Ln0XyXdRPmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, per.forlin@stericsson.com

This is a multi-part message in MIME format.
--------------050400060304060608090305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Per,

On 11/13/2012 11:10 PM, Per Forlin wrote:
> On Tue, Oct 30, 2012 at 1:19 PM, Konstantin Dorfman
> <kdorfman@codeaurora.org> wrote:
>> Hello,
>>
>> On 10/29/2012 11:40 PM, Per Forlin wrote:
>>> Hi,
>>>
>>> I would like to move the focus of my concerns from root cause analysis
>>> to the actual patch,
>>> My first reflection is that the patch is relatively complex and some
>>> of the code looks duplicated.
>>> Would it be possible to simplify it and re-use  the current execution flow.
>>>
>>> Is the following flow feasible?
>>>
>>> in mmc_start_req():
>>> --------------
>>> if (rqc == NULL && not_resend)
>>>   wait_for_both_mmc_and_arrival_of_new_req
>>> else
>>>   wait_only_for_mmc
>>>
>>> if (arrival_of_new_req) {
>>>    set flag to indicate fetch-new_req
>>>   return NULL;
>>> }
>>> -----------------
>>>
>>> in queue.c:
>>> if (fetch-new_req)
>>>   don't overwrite previous req.
>>>
>>> BR
>>> Per
>>
>> You are talking about using both waiting mechanisms, old (wait on
>> completion) and new - wait_event_interruptible()? But how done()
>> callback, called on host controller irq context, will differentiate
>> which one is relevant for the request?
>>
>> I think it is better to use single wait point for mmc thread.
> 
> I have sketch a patch to better explain my point. It's not tested it
> barely compiles :)
> The patch tries to introduce your feature and still keep the same code
> path. And it exposes an API that could be used by SDIO as well.
> The intention of my sketch patch is only to explain what I tried to
> visualize in the pseudo code previously in this thread.
> The out come of your final patch should be documented here I think:
> Documentation/mmc/mmc-async-req.txt
This document is ready, attaching it to this mail and will be included
in next version of the patch (or RESEND).
> 
> Here follows my patch sketch:
> ........................................................
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..08036a1 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
>  		spin_unlock_irq(q->queue_lock);
> 
>  		if (req || mq->mqrq_prev->req) {
> +			if (!req)
> +				mmc_prefetch_start(&mq->mqrq_prev->mmc_active, true);
>  			set_current_state(TASK_RUNNING);
>  			mq->issue_fn(mq, req);
>  		} else {
> @@ -79,11 +81,13 @@ static int mmc_queue_thread(void *d)
>  		}
> 
>  		/* Current request becomes previous request and vice versa. */
> -		mq->mqrq_prev->brq.mrq.data = NULL;
> -		mq->mqrq_prev->req = NULL;
> -		tmp = mq->mqrq_prev;
> -		mq->mqrq_prev = mq->mqrq_cur;
> -		mq->mqrq_cur = tmp;
> +		if (!mmc_prefetch_pending(&mq->mqrq_prev->mmc_active)) {
> +			mq->mqrq_prev->brq.mrq.data = NULL;
> +			mq->mqrq_prev->req = NULL;
> +			tmp = mq->mqrq_prev;
> +			mq->mqrq_prev = mq->mqrq_cur;
> +			mq->mqrq_cur = tmp;
> +		}
>  	} while (1);
>  	up(&mq->thread_sem);
> 
> @@ -109,10 +113,44 @@ static void mmc_request_fn(struct request_queue *q)
>  		return;
>  	}
> 
> +	if (mq->prefetch_enable) {
> +		spin_lock(&mq->prefetch_lock);
> +		if (mq->prefetch_completion)
> +			complete(mq->prefetch_completion);
> +		mq->prefetch_pending = true;
> +		spin_unlock(&mq->prefetch_lock);
> +	}
> +
>  	if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
>  		wake_up_process(mq->thread);
>  }
> 
> +static void mmc_req_init(struct mmc_async_req *areq, struct completion *compl)
> +{
> +	struct mmc_queue *mq =
> +		container_of(areq->prefetch, struct mmc_queue, prefetch);
> +
> +	spin_lock(&mq->prefetch_lock);
> +	mq->prefetch_completion = compl;
> +	if (mq->prefetch_pending)
> +		complete(mq->prefetch_completion);
> +	spin_unlock(&mq->prefetch_lock);
> +}
> +
> +static void mmc_req_start(struct mmc_async_req *areq, bool enable)
> +{
> +	struct mmc_queue *mq =
> +		container_of(areq->prefetch, struct mmc_queue, prefetch);
> +	mq->prefetch_enable = enable;
> +}
> +
> +static bool mmc_req_pending(struct mmc_async_req *areq)
> +{
> +	struct mmc_queue *mq =
> +		container_of(areq->prefetch, struct mmc_queue, prefetch);
> +	return mq->prefetch_pending;
> +}
> +
>  static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
>  {
>  	struct scatterlist *sg;
> @@ -166,6 +204,12 @@ int mmc_init_queue(struct mmc_queue *mq, struct
> mmc_card *card,
>  	int ret;
>  	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
>  	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
> +	spin_lock_init(&mq->prefetch_lock);
> +	mq->prefetch.wait_req_init = mmc_req_init;
> +	mq->prefetch.wait_req_start = mmc_req_start;
> +	mq->prefetch.wait_req_pending = mmc_req_pending;
> +	mqrq_cur->mmc_active.prefetch = &mq->prefetch;
> +	mqrq_prev->mmc_active.prefetch = &mq->prefetch;
> 
>  	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>  		limit = *mmc_dev(host)->dma_mask;
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d2a1eb4..5afd467 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -33,6 +33,12 @@ struct mmc_queue {
>  	struct mmc_queue_req	mqrq[2];
>  	struct mmc_queue_req	*mqrq_cur;
>  	struct mmc_queue_req	*mqrq_prev;
> +
> +	struct mmc_async_prefetch prefetch;
> +	spinlock_t		prefetch_lock;
> +	struct completion	*prefetch_completion;
> +	bool			prefetch_enable;
> +	bool			prefetch_pending;
>  };
> 
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9503cab..06fc036 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -352,7 +352,15 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  		mmc_pre_req(host, areq->mrq, !host->areq);
> 
>  	if (host->areq) {
> +		if (!areq)
> +			mmc_prefetch_init(host->areq,
> +					  &host->areq->mrq->completion);
>  		mmc_wait_for_req_done(host, host->areq->mrq);
> +		if (!areq) {
> +			mmc_prefetch_start(host->areq, false);
> +			if (mmc_prefetch_pending(host->areq))
> +				return NULL;
> +		}
>  		err = host->areq->err_check(host->card, host->areq);
>  	}
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 65c64ee..ce5d03f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -15,6 +15,7 @@
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
> +#include <linux/completion.h>
> 
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/pm.h>
> @@ -140,6 +141,13 @@ struct mmc_host_ops {
> 
>  struct mmc_card;
>  struct device;
> +struct mmc_async_req;
> +
> +struct mmc_async_prefetch {
> +	void (*wait_req_init)(struct mmc_async_req *, struct completion *);
> +	void (*wait_req_start)(struct mmc_async_req *, bool);
> +	bool (*wait_req_pending)(struct mmc_async_req *);
> +};
> 
>  struct mmc_async_req {
>  	/* active mmc request */
> @@ -149,8 +157,33 @@ struct mmc_async_req {
>  	 * Returns 0 if success otherwise non zero.
>  	 */
>  	int (*err_check) (struct mmc_card *, struct mmc_async_req *);
> +	struct mmc_async_prefetch *prefetch;
>  };
> 
> +/* set completion variable, complete == NULL to reset completion */
> +static inline void mmc_prefetch_init(struct mmc_async_req *areq,
> +				     struct completion *complete)
> +{
> +	if (areq->prefetch && areq->prefetch->wait_req_init)
> +		areq->prefetch->wait_req_init(areq, complete);
> +}
> +
> +/* enable or disable prefetch feature */
> +static inline void mmc_prefetch_start(struct mmc_async_req *areq, bool enable)
> +{
> +	if (areq->prefetch && areq->prefetch->wait_req_start)
> +		areq->prefetch->wait_req_start(areq, enable);
> +}
> +
> +/* return true if new request is pending otherwise false */
> +static inline bool mmc_prefetch_pending(struct mmc_async_req *areq)
> +{
> +	if (areq->prefetch && areq->prefetch->wait_req_pending)
> +		return areq->prefetch->wait_req_pending(areq);
> +	else
> +		return false;
> +}
> +
>  /**
>   * struct mmc_slot - MMC slot functions
>   *
> ....................................................................
> 
> 
> BR
> Per
I understand your motivation and idea for re-structure the patch. It is
still not clear for me how exactly mmc thread will be awaken on new
request notification in your version, but I have another problem:

We want to expand this event based mechanism (unblock mmc thread from
waiting for the running request) by adding another reason/event. This is
URGENT_REQUEST event. When block layer has Urgent request to execute, it
notifies mmc layer (similar to mmc_request() notification) and mmc layer
handles this urgent request notification by correctly stopping running
request, re-inserting back to I/O scheduler all not yet performed parts
and fetching & starting the urgent request.
The reasoning and general idea are documented together with "New event"
and will be submitted soon. The patch itself will be submitted in a week
or so.

As for our discussion - to handle both events mmc layer should be
capable to be awaken not only in case of no mmc_prefetch_pending() (in
your patch terms), but also when we have perfect case of async requests:
one running on the bus and second prepared and waiting for the first.

I think, that in case SDIO protocol driver need such functionality as
NEW_REQUEST, one need to implement notification to the mmc layer similar
to mmc_request() code in my patch.

Does this make sense?


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

--------------050400060304060608090305
Content-Type: text/plain;
 name="mmc-wakeup.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mmc-wakeup.txt"

Introduction
============
The file system adds block requests to the block device queue
asynchronously without waiting for completion. The MMC framework takes
these block request synchronously one by one and pushes them to the host
driver. When the host driver has completed the request, the framework
will pull out a new block request from the block request queue. For each
block request the MMC framework converts the generic request to a mmc
request. The host driver takes the mmc request and does necessary
preparations to process the request. For non-DMA host driver the
necessary pre and post preparations are insignificant, but for DMA the
cache maintenance is significant. Adding non-blocking request to the
MMC framework (between block layer and host driver) will make it
possible to prepare caches for one request while another request is
being processed by the MMC controller.

[Referenced from the Rational section of
https://wiki.linaro.org/WorkingGroups/Kernel/Specs/
StoragePerfMMC-async-req]


Software description
====================
In case of sequential read operations async request mechanism isn't
functional, due to the read ahead mechanism: When "mmcqd" (MMC thread)
reports on completion of a request, there should be a context switch to
allow the insertion of the next read ahead BIOs to the block layer.
Since the "mmcqd" tries to fetch another request immediately after the
completion of the previous request - it gets NULL and begins waiting for
the completion of the previous request.  This wait on completion gives
the FS (File System) the opportunity to insert the next request but the
MMC layer is already blocked on the previous request completion and is
not aware of the new request waiting to be fetched. As a result of this
missed oportunity to start cashe prepeare for the new request, while
previous request is being serviced. Also it can't look to see if the new
request is urgent and the the previous request is not interrupted
immediately.

A solution of the above would be to add a mechanism that allows to wake
up the MMC layer immediately with new block request when it is available
for fetch.

Design
======

The main idea is to replace the blocking wait for a completion with an
event driven mechanism and add a set of events that will unblock the MMC
layer context from waiting on host driver complete.
The new events to be added are:
1. NEW_REQUEST:
	When the block layer notifies the MMC layer on a new request
	(mmc_request() callback), and the MMC layer is waiting on a
	previous request completion and the current request is NULL. In
	such a case the NEW_REQUEST event will be triggered to wakeup
	the waiting thread.  MMC layer will then fetch the new request
	and after its preparation will go back to waiting on the
	completion of previous request.

2. URGENT_REQUEST:
	In order to decrease a latency of a prioritized requests (such
	as READ requests) we might want to stop the transmission of a
	"low priority" request (such as WRITE) in order to handle the
	"high priority one".  The urgency of the request is decided by
	the block layer I/O scheduler.  When the block layer notifies
	the MMC layer of an urgent request and the MMC layer is blocked
	it will be woken up. The decision on whether to stop an ongoing
	transfer is taken according to several parameters, one of them
	being the number of bytes transferred though host controller so
	far. The stopped request (and next prepared request in case it
	is exists) re-inserted back to the I/O scheduler to be handled
	after the completion of the urgent request.
	When the decision taken was not to stop the ongoing transfer,
	MMC context will wait for normal completion of the ongoing
	transfer, then already prepared next request (if it exists)
	will be re-inserted back into block layer and the urgent request
	fetched.
	URGENT_REQUEST handling is possible only when host controller
	driver supports stop_request() API, otherwise
	mmc_urgent_request() notification callback will not be
	registered into block layer.

Performance
===========
With the new event mechanism the  READ throughput is improved by 16%.
With the Urgent-Request Event (and ROW  scheduler) the   READ latency is
decreased by 41%.

Known issues
============
As an performance metric of NEW_REQUEST and URGENT_REQUEST flows we are
using average and worst case latency between:
1) block layer dispatches the request
2) MMC layer fetches the request
This latency should be minimized to achieve best overall performance.
Right now the latency changes due to bus speed, CPU cores and other
changes depending on specific hardware and software configuration.

To do
=====
For URGENT_REQUEST implementation in MMC layer, decision heuristic to
stop ongoing transaction may be more accurate and based not on byte
count transferred by host controller to the card, but on time needed
by MMC card to perform the request.

--------------050400060304060608090305--
