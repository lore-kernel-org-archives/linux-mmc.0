From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: core: fix permanent sleep of mmcqd during card
 removal
Date: Thu, 31 Jan 2013 20:05:35 +0900
Message-ID: <510A4FFF.4070100@samsung.com>
References: <n@samsung.com>
 <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org>
 <001d01cdf88d$f4214270$dc63c750$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30696 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3AaLGE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 06:06:04 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHH0067YLHQ5FL0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 20:06:02 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHH00EUGLI19S70@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 Jan 2013 20:06:02 +0900 (KST)
In-reply-to: <001d01cdf88d$f4214270$dc63c750$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>

Great..

I also found this problem and sent the similar patch at mailing.
But i think this patch is more generic.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 01/22/2013 07:48 PM, Seungwon Jeon wrote:
> This patch is derived from 'mmc: fix async request mechanism ...'.
> According as async transfer, a request is handled with twice mmc_start_req.
> When the card is removed, the request is actually not issued in the first
> mmc_start_req [__mmc_start_data_req]. And then mmc_wait_for_data_req_done
> will come in the next mmc_start_req. But there is no event for completions.
> wake_up_interruptible is needed in __mmc_start_data_req for the case of
> removed card.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8b3a122..997b257 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -350,6 +350,7 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
>  	mrq->host = host;
>  	if (mmc_card_removed(host->card)) {
>  		mrq->cmd->error = -ENOMEDIUM;
> +		mmc_wait_data_done(mrq);
>  		return -ENOMEDIUM;
>  	}
>  	mmc_start_request(host, mrq);
> 

