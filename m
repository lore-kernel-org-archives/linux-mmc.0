From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4] mmc: Kill block requests if card is removed
Date: Thu, 08 Dec 2011 11:22:23 +0200
Message-ID: <4EE081CF.3010303@intel.com>
References: <1323333350-14315-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32048 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab1LHJW0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Dec 2011 04:22:26 -0500
In-Reply-To: <1323333350-14315-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, per.lkml@gmail.com, cjb@laptop.org

On 08/12/11 10:35, Sujit Reddy Thumma wrote:
> Kill block requests when the host realizes that the card is
> removed from the slot and is sure that subsequent requests
> are bound to fail. Do this silently so that the block
> layer doesn't output unnecessary error messages.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> Changes in v4:
> 	- Extra check to make sure no further commands are sent
> 	in error case when the card is removed.
> Changes in v3:
> 	- Dropped dependency on Per's patch and is now dependent
> 	on "[PATCH V4] mmc: allow upper layers to determine immediately
> 	if a card has been removed" by Adrian Hunter.
> 	- Modified commit text slightly as Adrian has
> 	implemented his own suggestion in a different patch.
> 
> Changes in v2:
> 	- Changed the implementation with further comments from Adrian
> 	- Set the card removed flag in bus notifier callbacks
> 	- This patch is now dependent on patch from Per Forlin:
> 	http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=11211
> ---
>  drivers/mmc/card/block.c |   17 ++++++++++++++++-
>  drivers/mmc/card/queue.c |    5 +++++
>  2 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 0c959c9..0cad48a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -121,6 +121,7 @@ enum mmc_blk_status {
>  	MMC_BLK_ABORT,
>  	MMC_BLK_DATA_ERR,
>  	MMC_BLK_ECC_ERR,
> +	MMC_BLK_NOMEDIUM,
>  };
>  
>  module_param(perdev_minors, int, 0444);
> @@ -639,6 +640,7 @@ static int get_card_status(struct mmc_card *card, u32 *status, int retries)
>  	return err;
>  }
>  
> +#define ERR_NOMEDIUM	3
>  #define ERR_RETRY	2
>  #define ERR_ABORT	1
>  #define ERR_CONTINUE	0
> @@ -706,6 +708,9 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>  	u32 status, stop_status = 0;
>  	int err, retry;
>  
> +	if (mmc_card_removed(card))
> +		return ERR_NOMEDIUM;
> +
>  	/*
>  	 * Try to get card status which indicates both the card state
>  	 * and why there was no response.  If the first attempt fails,
> @@ -722,8 +727,12 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>  	}
>  
>  	/* We couldn't get a response from the card.  Give up. */
> -	if (err)
> +	if (err) {
> +		/* Check if the card is removed */
> +		if (mmc_detect_card_removed(card->host))
> +			return ERR_NOMEDIUM;
>  		return ERR_ABORT;
> +	}
>  
>  	/* Flag ECC errors */
>  	if ((status & R1_CARD_ECC_FAILED) ||
> @@ -996,6 +1005,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
>  			return MMC_BLK_RETRY;
>  		case ERR_ABORT:
>  			return MMC_BLK_ABORT;
> +		case ERR_NOMEDIUM:
> +			return MMC_BLK_NOMEDIUM;
>  		case ERR_CONTINUE:
>  			break;
>  		}
> @@ -1329,6 +1340,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			if (!ret)
>  				goto start_new_req;
>  			break;
> +		case MMC_BLK_NOMEDIUM:
> +			goto cmd_abort;
>  		}
>  
>  		if (ret) {
> @@ -1345,6 +1358,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  
>   cmd_abort:
>  	spin_lock_irq(&md->lock);
> +	if (mmc_card_removed(card))
> +		req->cmd_flags |= REQ_QUIET;
>  	while (ret)
>  		ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
>  	spin_unlock_irq(&md->lock);
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index dcad59c..2517547 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -29,6 +29,8 @@
>   */
>  static int mmc_prep_request(struct request_queue *q, struct request *req)
>  {
> +	struct mmc_queue *mq = q->queuedata;
> +
>  	/*
>  	 * We only like normal block requests and discards.
>  	 */
> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>  		return BLKPREP_KILL;
>  	}
>  
> +	if (mq && mmc_card_removed(mq->card))
> +		return BLKPREP_KILL;
> +
>  	req->cmd_flags |= REQ_DONTPREP;
>  
>  	return BLKPREP_OK;

