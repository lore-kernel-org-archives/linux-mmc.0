From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: fix the critical bug for multiple block read
Date: Mon, 31 Oct 2011 19:52:07 +0900
Message-ID: <4EAE7DD7.6090304@samsung.com>
References: <4EAE7C76.1050104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23503 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933619Ab1JaKwJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 06:52:09 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LTX009TZFIKKGX0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 31 Oct 2011 19:52:08 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LTX00E15FIWKYD0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 31 Oct 2011 19:52:08 +0900 (KST)
In-reply-to: <4EAE7C76.1050104@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, paul@pwsan.com

Sorry card->host->caps instead of host->mmc->caps.(typo)

On 10/31/2011 07:46 PM, Jaehoon Chung wrote:

> This patch is fixed the critical bug for multiple block read.
> 
> In Paul's patch(commit:6d621423128909f09072835445ce36dd357a758a),
> used MMC_CAP2_NO_MULTI_READ. But that value was assigned card->host->caps.
> 
> MMC_CAPS2_NO_MULTI_READ must assign card->host->caps2 instead of card->host->caps.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4fd5723..1882149 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1037,7 +1037,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  			brq->data.blocks = 1;
>  
>  		/* Some controllers can't do multiblock reads due to hw bugs */
> -		if (card->host->caps & MMC_CAP2_NO_MULTI_READ &&
> +		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
>  		    rq_data_dir(req) == READ)
>  			brq->data.blocks = 1;
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


