From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH 2/2] mmc: block: don't start new request when the card
 is removed
Date: Fri, 08 Feb 2013 14:08:14 +0200
Message-ID: <5114EAAE.6000109@codeaurora.org>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com> <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org> <201210292337.35620.heiko@sntech.de> <001e01cdf88d$f666ecb0$e334c610$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:12732 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946330Ab3BHMIS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Feb 2013 07:08:18 -0500
In-Reply-To: <001e01cdf88d$f666ecb0$e334c610$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Sujit Reddy Thumma' <sthumma@codeaurora.org>, 'Adrian Hunter' <adrian.hunter@intel.com>


Tested-by: Konstantin Dorfman <kdorfman@codeaurora.org>

On 01/22/2013 12:48 PM, Seungwon Jeon wrote:
> Current request can be started newly while handling the error.
> But if the card is removed, it's unnecessary to restart a request.
> This makes the extra error handling.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>   drivers/mmc/card/block.c |   10 ++++++++--
>   1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index f79b468..1170afe 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1456,8 +1456,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>
>    start_new_req:
>   	if (rqc) {
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
>   	}
>
>   	return 0;
>


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
