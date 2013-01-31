From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH] mmc: core: fix the aysync mechanism when card removed
Date: Thu, 31 Jan 2013 14:12:17 +0530
Message-ID: <510A2E69.6000608@codeaurora.org>
References: <50FE838C.5010709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:38273 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3AaImW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 03:42:22 -0500
In-Reply-To: <50FE838C.5010709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, Per FORLIN <per.forlin@stericsson.com>, Maya Erez <merez@codeaurora.org>

On 1/22/2013 5:48 PM, Jaehoon Chung wrote:
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
>   drivers/mmc/core/core.c |   31 ++++++++++++++++++++-----------
>   1 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b3a122..bc1d627 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -515,17 +515,26 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>   		mmc_pre_req(host, areq->mrq, !host->areq);
>   
>   	if (host->areq) {
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

Can you please explain more on what exactly we are trying to do here 
(may be you can list down the call flow)? I am not sure if i understood 
this correctly. But why would you need to wakeup the thread here? We are 
here because thread is already woken up. mmc_wait_for_data_req_done() 
would return only if either the new request is received or the currently 
running request on controller is completed.

Regards,
Subhash

> +		}
>   		/*
>   		 * Check BKOPS urgency for each R1 response
>   		 */

