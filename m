From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Thu, 17 Nov 2011 11:18:09 +0200
Message-ID: <4EC4D151.1030008@intel.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34793 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab1KQJSM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Nov 2011 04:18:12 -0500
In-Reply-To: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>

On 14/11/11 13:12, Per Forlin wrote:
> Host is claimed as long as there are requests in the block queue
> and all request are completed successfully. If an error occur release
> the host in case someone else needs to claim it, for instance if the card
> is removed during a transfer.
> 
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> ---
>  drivers/mmc/card/block.c |   37 +++++++++++++++++++++++++++++--------
>  1 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c80bb6d..c21fd2c 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1158,6 +1158,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
>  	return ret;
>  }
>  
> +/*
> + * This function should be called to resend a request after failure.
> + * Prepares and starts the request.
> + */
> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
> +						   struct mmc_queue *mq,
> +						   struct mmc_queue_req *mqrq,
> +						   int disable_multi,
> +						   struct mmc_async_req *areq)
> +{
> +	/*
> +	 * Release host after failure in case the host is needed
> +	 * by someone else. For instance, if the card is removed the
> +	 * worker thread needs to claim the host in order to do mmc_rescan.
> +	 */
> +	mmc_release_host(card->host);
> +	mmc_claim_host(card->host);

Does this work?  Won't the current thread win the race
to claim the host again?


> +
> +	mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
> +	return mmc_start_req(card->host, areq, NULL);
> +}
> +
>  static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  {
>  	struct mmc_blk_data *md = mq->data;
> @@ -1257,14 +1279,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			break;
>  		}
>  
> -		if (ret) {
> +		if (ret)
>  			/*
>  			 * In case of a incomplete request
>  			 * prepare it again and resend.
>  			 */
> -			mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
> -			mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
> -		}
> +			mmc_blk_resend(card, mq, mq_rq, disable_multi,
> +				       &mq_rq->mmc_active);
> +
>  	} while (ret);
>  
>  	return 1;
> @@ -1276,10 +1298,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  	spin_unlock_irq(&md->lock);
>  
>   start_new_req:
> -	if (rqc) {
> -		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> -		mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
> -	}
> +	if (rqc)
> +		mmc_blk_resend(card, mq, mq->mqrq_cur, 0,
> +			       &mq->mqrq_cur->mmc_active);
>  
>  	return 0;
>  }

