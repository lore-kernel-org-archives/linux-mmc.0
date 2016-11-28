From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V7 07/25] mmc: queue: Use queue depth to allocate and free
Date: Mon, 28 Nov 2016 09:51:24 +0530
Message-ID: <f6c7543f-fc49-d2b2-d9cf-73de5b528a38@codeaurora.org>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
 <1480068442-5169-8-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbcK1EVv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2016 23:21:51 -0500
In-Reply-To: <1480068442-5169-8-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>



On 11/25/2016 3:37 PM, Adrian Hunter wrote:
> Instead of allocating resources for 2 slots in the queue, allow for an
> arbitrary number.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good!
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

Regards
Ritesh

> ---
>  drivers/mmc/card/queue.c | 103 +++++++++++++++++++++--------------------------
>  1 file changed, 46 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 60fa095adb14..1ea007f51ec9 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -189,86 +189,75 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
>  					unsigned int bouncesz)
>  {
> -	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> -	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> -
> -	mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
> -	if (!mqrq_cur->bounce_buf) {
> -		pr_warn("%s: unable to allocate bounce cur buffer\n",
> -			mmc_card_name(mq->card));
> -		return false;
> -	}
> +	int i;
>
> -	mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
> -	if (!mqrq_prev->bounce_buf) {
> -		pr_warn("%s: unable to allocate bounce prev buffer\n",
> -			mmc_card_name(mq->card));
> -		kfree(mqrq_cur->bounce_buf);
> -		mqrq_cur->bounce_buf = NULL;
> -		return false;
> +	for (i = 0; i < mq->qdepth; i++) {
> +		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
> +		if (!mq->mqrq[i].bounce_buf)
> +			goto out_err;
>  	}
>
>  	return true;
> +
> +out_err:
> +	while (--i >= 0) {
> +		kfree(mq->mqrq[i].bounce_buf);
> +		mq->mqrq[i].bounce_buf = NULL;
> +	}
> +	pr_warn("%s: unable to allocate bounce buffers\n",
> +		mmc_card_name(mq->card));
> +	return false;
>  }
>
>  static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
>  				      unsigned int bouncesz)
>  {
> -	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> -	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> -	int ret;
> -
> -	mqrq_cur->sg = mmc_alloc_sg(1, &ret);
> -	if (ret)
> -		return ret;
> +	int i, ret;
>
> -	mqrq_cur->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
> -	if (ret)
> -		return ret;
> -
> -	mqrq_prev->sg = mmc_alloc_sg(1, &ret);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < mq->qdepth; i++) {
> +		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
> +		if (ret)
> +			return ret;
>
> -	mqrq_prev->bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
> +		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
> +		if (ret)
> +			return ret;
> +	}
>
> -	return ret;
> +	return 0;
>  }
>
>  static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
>  {
> -	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> -	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> -	int ret;
> +	int i, ret;
>
> -	mqrq_cur->sg = mmc_alloc_sg(max_segs, &ret);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < mq->qdepth; i++) {
> +		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
> +		if (ret)
> +			return ret;
> +	}
>
> -	mqrq_prev->sg = mmc_alloc_sg(max_segs, &ret);
> +	return 0;
> +}
>
> -	return ret;
> +static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
> +{
> +	kfree(mqrq->bounce_sg);
> +	mqrq->bounce_sg = NULL;
> +
> +	kfree(mqrq->sg);
> +	mqrq->sg = NULL;
> +
> +	kfree(mqrq->bounce_buf);
> +	mqrq->bounce_buf = NULL;
>  }
>
>  static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
>  {
> -	struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> -	struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> -
> -	kfree(mqrq_cur->bounce_sg);
> -	mqrq_cur->bounce_sg = NULL;
> -	kfree(mqrq_prev->bounce_sg);
> -	mqrq_prev->bounce_sg = NULL;
> -
> -	kfree(mqrq_cur->sg);
> -	mqrq_cur->sg = NULL;
> -	kfree(mqrq_cur->bounce_buf);
> -	mqrq_cur->bounce_buf = NULL;
> -
> -	kfree(mqrq_prev->sg);
> -	mqrq_prev->sg = NULL;
> -	kfree(mqrq_prev->bounce_buf);
> -	mqrq_prev->bounce_buf = NULL;
> +	int i;
> +
> +	for (i = 0; i < mq->qdepth; i++)
> +		mmc_queue_req_free_bufs(&mq->mqrq[i]);
>  }
>
>  /**
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
