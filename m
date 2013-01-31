From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: fix the aysync mechanism when card removed
Date: Thu, 31 Jan 2013 16:06:18 +0900
Message-ID: <510A17EA.8060005@samsung.com>
References: <50FE838C.5010709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18952 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3AaHGq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 02:06:46 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHH008HFACIGWR0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 16:06:45 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHH001VWAF8IHO0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 16:06:44 +0900 (KST)
In-reply-to: <50FE838C.5010709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, Per FORLIN <per.forlin@stericsson.com>, Maya Erez <merez@codeaurora.org>

Have any other opinion?

On 01/22/2013 09:18 PM, Jaehoon Chung wrote:
> When card removed, then didn't complete the previously data.
> (It didn't wakeup any interrupt.)
> If card is removed, then we can assume to complete the previously data.
> And wakeup the interrupt for wait_event of data.
> 
> This problem is produced when sd-card is removed.(Sd-card is running some operation)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |   31 ++++++++++++++++++++-----------
>  1 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b3a122..bc1d627 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -515,17 +515,26 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  		mmc_pre_req(host, areq->mrq, !host->areq);
>  
>  	if (host->areq) {
> -			err = mmc_wait_for_data_req_done(host, host->areq->mrq,
> -					areq);
> -			if (err == MMC_BLK_NEW_REQUEST) {
> -				if (error)
> -					*error = err;
> -				/*
> -				 * The previous request was not completed,
> -				 * nothing to return
> -				 */
> -				return NULL;
> -			}
> +		err = mmc_wait_for_data_req_done(host, host->areq->mrq,
> +				areq);
> +		if (err == MMC_BLK_NEW_REQUEST) {
> +			if (error)
> +				*error = err;
> +			/*
> +			 * The previous request was not completed,
> +			 * nothing to return
> +			 */
> +			return NULL;
> +		} else if (err == MMC_BLK_NOMEDIUM && areq) {
> +			struct mmc_context_info *ctnx = &host->context_info;
> +			/*
> +			 * If crad is removed,
> +			 * then we didn't wait for data completed.
> +			 * Assume that data-recieve done.
> +			 */
> +			ctnx->is_done_rcv = true;
> +			wake_up_interruptible(&ctnx->wait);
> +		}
>  		/*
>  		 * Check BKOPS urgency for each R1 response
>  		 */
> 

