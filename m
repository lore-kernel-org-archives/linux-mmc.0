From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Fri, 02 Mar 2012 17:28:03 +0900
Message-ID: <4F508493.2000107@samsung.com>
References: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30333 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab2CBI2H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 03:28:07 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M09004630SOPC80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Mar 2012 17:28:04 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0900AEJ0UROI30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Mar 2012 17:28:04 +0900 (KST)
In-reply-to: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf.

I tested with this patch.
But in my environment, this patch didn't work fine before.
1) When remove/insert, didn't entered the suspend.
2) When removed during something write,
[   50.755067] FAT-fs (mmcblk1p1): Directory bread(block 8254) failed
[   50.761235] FAT-fs (mmcblk1p1): Directory bread(block 8255) failed
then at next-time, didn't detect sd-card.

Did you know this?
If you want more information, i will debug, and share the result.

Best Regards,
Jaehoon Chung

On 03/02/2012 12:44 AM, Ulf Hansson wrote:

> Make sure mmc_start_req cancel the prepared job, if the request
> was prevented to be started due to the card has been removed.
> 
> This bug was introduced in commit:
> mmc: allow upper layers to know immediately if card has been removed
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/core/core.c |   35 +++++++++++++++--------------------
>  1 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b317f0..9e562ab 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -249,16 +249,17 @@ static void mmc_wait_done(struct mmc_request *mrq)
>  	complete(&mrq->completion);
>  }
>  
> -static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
> +static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
>  	init_completion(&mrq->completion);
>  	mrq->done = mmc_wait_done;
>  	if (mmc_card_removed(host->card)) {
>  		mrq->cmd->error = -ENOMEDIUM;
>  		complete(&mrq->completion);
> -		return;
> +		return -ENOMEDIUM;
>  	}
>  	mmc_start_request(host, mrq);
> +	return 0;
>  }
>  
>  static void mmc_wait_for_req_done(struct mmc_host *host,
> @@ -342,6 +343,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  				    struct mmc_async_req *areq, int *error)
>  {
>  	int err = 0;
> +	int start_err = 0;
>  	struct mmc_async_req *data = host->areq;
>  
>  	/* Prepare a new request */
> @@ -351,30 +353,23 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>  	if (host->areq) {
>  		mmc_wait_for_req_done(host, host->areq->mrq);
>  		err = host->areq->err_check(host->card, host->areq);
> -		if (err) {
> -			/* post process the completed failed request */
> -			mmc_post_req(host, host->areq->mrq, 0);
> -			if (areq)
> -				/*
> -				 * Cancel the new prepared request, because
> -				 * it can't run until the failed
> -				 * request has been properly handled.
> -				 */
> -				mmc_post_req(host, areq->mrq, -EINVAL);
> -
> -			host->areq = NULL;
> -			goto out;
> -		}
>  	}
>  
> -	if (areq)
> -		__mmc_start_req(host, areq->mrq);
> +	if (!err && areq)
> +		start_err = __mmc_start_req(host, areq->mrq);
>  
>  	if (host->areq)
>  		mmc_post_req(host, host->areq->mrq, 0);
>  
> -	host->areq = areq;
> - out:
> +	if (err || start_err) {
> +		if (areq)
> +			/* The prepared request was not started, cancel it. */
> +			mmc_post_req(host, areq->mrq, -EINVAL);
> +		host->areq = NULL;
> +	} else {
> +		host->areq = areq;
> +	}
> +
>  	if (error)
>  		*error = err;
>  	return data;


