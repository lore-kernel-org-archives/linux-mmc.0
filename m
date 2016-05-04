From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: queue: allocate the scatterlist with a correct value
Date: Wed, 4 May 2016 09:29:16 +0300
Message-ID: <572996BC.70703@intel.com>
References: <1462339891-10477-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61517 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbcEDGdI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 02:33:08 -0400
In-Reply-To: <1462339891-10477-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com

On 04/05/16 08:31, Jaehoon Chung wrote:
> If host->max is lower than PAGE_CACHE_SIZE, it should allocate

host->max?

PAGE_CACHE_SIZE does not exist anymore.  Now there is only PAGE_SIZE.

> the scatterlist with incorrect size.

Don't understand what you mean.

> To prevent illegal behavior, fixed the scatterlist size for mmc_alloc_sg().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/card/queue.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 6f4323c..0353f99 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -276,12 +276,14 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>  		blk_queue_max_segments(mq->queue, host->max_segs);

So now mq->queue->limits.max_segments == host->max_segs unless it was zero.

>  		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
>  
> -		mqrq_cur->sg = mmc_alloc_sg(host->max_segs, &ret);
> +		mqrq_cur->sg =
> +			mmc_alloc_sg(mq->queue->limits.max_segments, &ret);

So that is the same unless host->max_segs is zero.

>  		if (ret)
>  			goto cleanup_queue;
>  
>  
> -		mqrq_prev->sg = mmc_alloc_sg(host->max_segs, &ret);
> +		mqrq_prev->sg =
> +			mmc_alloc_sg(mq->queue->limits.max_segments, &ret);
>  		if (ret)
>  			goto cleanup_queue;
>  	}
> 

