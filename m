From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH] mmc: queue: exclude asynchronous transfer for special
 request
Date: Thu, 20 Dec 2012 16:52:47 +0200
Message-ID: <50D3263F.6050407@codeaurora.org>
References: <003c01cdde9c$95883ad0$c098b070$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11490 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2LTOwv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Dec 2012 09:52:51 -0500
In-Reply-To: <003c01cdde9c$95883ad0$c098b070$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@linaro.org>

Hello Jeon,


On 12/20/2012 12:27 PM, Seungwon Jeon wrote:
> Unlike normal r/w request, special requests(discard, flush)
> is finished with a one-time issue_fn. Request change to
> mqrq_prev makes unnecessary call.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>   drivers/mmc/card/queue.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index fadf52e..a71db7a 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -58,6 +58,7 @@ static int mmc_queue_thread(void *d)
>   	do {
>   		struct request *req = NULL;
>   		struct mmc_queue_req *tmp;
> +		unsigned int cmd_flags = 0;
>
>   		spin_lock_irq(q->queue_lock);
>   		set_current_state(TASK_INTERRUPTIBLE);
> @@ -67,12 +68,19 @@ static int mmc_queue_thread(void *d)
>
>   		if (req || mq->mqrq_prev->req) {
>   			set_current_state(TASK_RUNNING);
> +			cmd_flags = req ? req->cmd_flags : 0;
>   			mq->issue_fn(mq, req);
>
>   			/*
>   			 * Current request becomes previous request
>   			 * and vice versa.
> +			 * In case of special requests, current request
> +			 * has been finished. Do not remain it to previous
> +			 * request.
>   			 */
> +			if (cmd_flags & REQ_DISCARD || cmd_flags & REQ_FLUSH)
> +				mq->mqrq_cur->req = NULL;
> +
>   			mq->mqrq_prev->brq.mrq.data = NULL;
>   			mq->mqrq_prev->req = NULL;
>   			tmp = mq->mqrq_prev;
>
It is better to define control mask, REQ_CONTROL_MASK, which will
include all control/special requests.

Then, when additional request will be added, there will be no need to
change here, only update the mask.

Another option - to clean mq->mqrq_cur->req immediately after executing
a special request in mmc_blk_issue_rq().


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
