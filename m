From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 03/25] mmc: queue: Factor out
 mmc_queue_alloc_bounce_sgs()
Date: Mon, 28 Nov 2016 09:18:05 +0530
Message-ID: <e0b62119-9d39-715d-c235-942f919eb925@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbcK1Dsd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 22:48:33 -0500
In-Reply-To: <1480068442-5169-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> In preparation for supporting a queue of requests, factor out
> mmc_queue_alloc_bounce_sgs().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good!
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

> ---
>  drivers/mmc/card/queue.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index ea8b01f76d55..3756303b4bbc 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -211,6 +211,30 @@ static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
>  	return true;
>  }
>
> +static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
> +				      unsigned int bouncesz)
> +{
> +	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> +	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> +	int ret;
> +
> +	mqrq_cur->sg = mmc_alloc_sg(1, &ret);
> +	if (ret)
> +		return ret;
> +
> +	mqrq_cur->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
> +	if (ret)
> +		return ret;
> +
> +	mqrq_prev->sg = mmc_alloc_sg(1, &ret);
> +	if (ret)
> +		return ret;
> +
> +	mqrq_prev->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * mmc_init_queue - initialise a queue structure.
>   * @mq: mmc queue
> @@ -225,6 +249,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  {
>  	struct mmc_host *host = card->host;
>  	u64 limit = BLK_BOUNCE_HIGH;
> +	bool bounce = false;
>  	int ret;
>  	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
>  	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
> @@ -267,28 +292,15 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  			blk_queue_max_segments(mq->queue, bouncesz / 512);
>  			blk_queue_max_segment_size(mq->queue, bouncesz);
>
> -			mqrq_cur->sg = mmc_alloc_sg(1, &ret);
> -			if (ret)
> -				goto cleanup_queue;
> -
> -			mqrq_cur->bounce_sg =
> -				mmc_alloc_sg(bouncesz / 512, &ret);
> -			if (ret)
> -				goto cleanup_queue;
> -
> -			mqrq_prev->sg = mmc_alloc_sg(1, &ret);
> -			if (ret)
> -				goto cleanup_queue;
> -
> -			mqrq_prev->bounce_sg =
> -				mmc_alloc_sg(bouncesz / 512, &ret);
> +			ret = mmc_queue_alloc_bounce_sgs(mq, bouncesz);
>  			if (ret)
>  				goto cleanup_queue;
> +			bounce = true;
>  		}
>  	}
>  #endif
>
> -	if (!mqrq_cur->bounce_buf && !mqrq_prev->bounce_buf) {
> +	if (!bounce) {
>  		blk_queue_bounce_limit(mq->queue, limit);
>  		blk_queue_max_hw_sectors(mq->queue,
>  			min(host->max_blk_count, host->max_req_size / 512));
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
