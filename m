From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v2] mmc: queue: exclude asynchronous transfer for special
 request
Date: Thu, 27 Dec 2012 15:21:16 +0200
Message-ID: <50DC4B4C.8090805@codeaurora.org>
References: <000701cde309$f5ed8fd0$e1c8af70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:36733 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2L0NVU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Dec 2012 08:21:20 -0500
In-Reply-To: <000701cde309$f5ed8fd0$e1c8af70$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Per Forlin' <per.forlin@linaro.org>

Reviewed-by: Konstantin Dorfman <kdorfman@codeaurora.org>

On 12/26/2012 03:40 AM, Seungwon Jeon wrote:
> Unlike normal r/w request, special requests(discard, flush)
> is finished with a one-time issue_fn. Request change to
> mqrq_prev makes unnecessary call.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>   drivers/mmc/card/queue.c |   10 ++++++++++
>   1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index fadf52e..c7e8716 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -24,6 +24,8 @@
>
>   #define MMC_QUEUE_SUSPENDED	(1 << 0)
>
> +#define MMC_REQ_SPECIAL_MASK	(REQ_DISCARD | REQ_FLUSH)
> +
>   /*
>    * Prepare a MMC request. This just filters out odd stuff.
>    */
> @@ -58,6 +60,7 @@ static int mmc_queue_thread(void *d)
>   	do {
>   		struct request *req = NULL;
>   		struct mmc_queue_req *tmp;
> +		unsigned int cmd_flags = 0;
>
>   		spin_lock_irq(q->queue_lock);
>   		set_current_state(TASK_INTERRUPTIBLE);
> @@ -67,12 +70,19 @@ static int mmc_queue_thread(void *d)
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
> +			if (cmd_flags & MMC_REQ_SPECIAL_MASK)
> +				mq->mqrq_cur->req = NULL;
> +
>   			mq->mqrq_prev->brq.mrq.data = NULL;
>   			mq->mqrq_prev->req = NULL;
>   			tmp = mq->mqrq_prev;
>


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
