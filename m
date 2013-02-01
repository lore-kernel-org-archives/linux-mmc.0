From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: block: don't start new request when the card is
 removed
Date: Fri, 01 Feb 2013 14:25:17 +0900
Message-ID: <510B51BD.6000108@samsung.com>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
 <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
 <201210292337.35620.heiko@sntech.de>
 <001e01cdf88d$f666ecb0$e334c610$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31543 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab3BAFZs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Feb 2013 00:25:48 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHJ0068C0EZY570@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 01 Feb 2013 14:25:47 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHJ001CJ0EXG430@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 01 Feb 2013 14:25:46 +0900 (KST)
In-reply-to: <001e01cdf88d$f666ecb0$e334c610$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Sujit Reddy Thumma' <sthumma@codeaurora.org>, 'Adrian Hunter' <adrian.hunter@intel.com>

Hi Seungwon,

It looks good to me..

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 01/22/2013 07:48 PM, Seungwon Jeon wrote:
> Current request can be started newly while handling the error.
> But if the card is removed, it's unnecessary to restart a request.
> This makes the extra error handling.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/card/block.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index f79b468..1170afe 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1456,8 +1456,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  
>   start_new_req:
>  	if (rqc) {
> -		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> -		mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
> +		if (mmc_card_removed(card)) {
> +			rqc->cmd_flags |= REQ_QUIET;
> +			blk_end_request_all(rqc, -EIO);
> +		} else {
> +			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> +			mmc_start_req(card->host,
> +				      &mq->mqrq_cur->mmc_active, NULL);
> +		}
>  	}
>  
>  	return 0;
> 

