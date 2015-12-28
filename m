From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND] mmc:Fix error handling in the function
 mmc_blk_issue_rq
Date: Mon, 28 Dec 2015 10:42:33 +0200
Message-ID: <5680F5F9.9020207@intel.com>
References: <1451160642-26585-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42349 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbL1Ip4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Dec 2015 03:45:56 -0500
In-Reply-To: <1451160642-26585-1-git-send-email-xerofoify@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>, ulf.hansson@linaro.org
Cc: tomas.winkler@intel.com, tklauser@distanz.ch, sholi@nvidia.com, kuninori.morimoto.gx@renesas.com, lporzio@micron.com, chuanxiao.dong@intel.com, jonathanh@nvidia.com, grundler@chromium.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 26/12/15 22:10, Nicholas Krause wrote:
> This fixes error handling in the function mmc_blk_issue_rq for
> checking if the calls to the function mmc_blk_issue_rw_rq have
> failed by returning zero as there return value and if so jump
> immediately to the goto label out for cleanup of resources used
> and allocated by the function mmc_blk_issue_rq before returning
> this return value to the caller of this particular function to
> indicate to the caller that it's call(s) have failed.

Are you experiencing a problem with the existing code, because it looks more
correct to me?

There does seem to be a gap in the way MMC_QUEUE_NEW_REQUEST is handled,
since the code is expecting that mmc_blk_issue_rw_rq() will have done
waiting for any ongoing request, but it is not clear it will have if
MMC_QUEUE_NEW_REQUEST is possible.  But that is a different issue.

> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/card/block.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a1b820f..354a151 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2055,7 +2055,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  	if (cmd_flags & REQ_DISCARD) {
>  		/* complete ongoing async transfer before issuing discard */
>  		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> +			ret = mmc_blk_issue_rw_rq(mq, NULL);
> +		if (!ret)
> +			goto out;
>  		if (req->cmd_flags & REQ_SECURE)
>  			ret = mmc_blk_issue_secdiscard_rq(mq, req);
>  		else
> @@ -2063,7 +2065,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  	} else if (cmd_flags & REQ_FLUSH) {
>  		/* complete ongoing async transfer before issuing flush */
>  		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> +			ret = mmc_blk_issue_rw_rq(mq, NULL);
> +		if (!ret)
> +			goto out;
>  		ret = mmc_blk_issue_flush(mq, req);
>  	} else {
>  		if (!req && host->areq) {
> 

