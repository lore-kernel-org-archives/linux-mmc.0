From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 06/25] mmc: queue: Introduce queue depth
Date: Mon, 28 Nov 2016 09:49:43 +0530
Message-ID: <fc5ca510-e383-e0dc-90e1-397a07dec791@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbcK1ETx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 23:19:53 -0500
In-Reply-To: <1480068442-5169-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> Add a mmc_queue member to record the size of the queue, which currently
> supports 2 requests on-the-go at a time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/card/block.c | 3 +++
>  drivers/mmc/card/queue.c | 1 +
>  drivers/mmc/card/queue.h | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index f8e51640596e..47835b78872f 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1439,6 +1439,9 @@ static int mmc_packed_init(struct mmc_queue *mq, struct mmc_card *card)
>  	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
>  	int ret = 0;
>
> +	/* Queue depth is only ever 2 with packed commands */
> +	if (mq->qdepth != 2)
> +		return -EINVAL;
I think you are referring here that with SWMCDQ, packed commands wont be 
used. Instead of qdepth do you think we should check cmdq_en ?
Also maybe we shouldn't even call mmc_packed_init if cmdq_en is true?


>
>  	mqrq_cur->packed = kzalloc(sizeof(struct mmc_packed), GFP_KERNEL);
>  	if (!mqrq_cur->packed) {
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index cbe92c9cfda1..60fa095adb14 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -296,6 +296,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  	if (!mq->queue)
>  		return -ENOMEM;
>
> +	mq->qdepth = 2;
>  	mq->mqrq_cur = &mq->mqrq[0];
>  	mq->mqrq_prev = &mq->mqrq[1];
>  	mq->queue->queuedata = mq;
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 0e8133c626c9..8a0a45e5650d 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -64,6 +64,7 @@ struct mmc_queue {
>  	struct mmc_queue_req	mqrq[2];
>  	struct mmc_queue_req	*mqrq_cur;
>  	struct mmc_queue_req	*mqrq_prev;
> +	int			qdepth;
>  };
>
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
