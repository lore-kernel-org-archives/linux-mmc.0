Return-Path: <SRS0=BwSF=5X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B78C2BA16
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 06:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23042074F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 06:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgDGGiU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:38:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:58680 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgDGGiU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Apr 2020 02:38:20 -0400
IronPort-SDR: 6fVd+Tl0D+VeHngz5oTZt6+b0RZiD0ns7uydhDeTmfsxCghyYua5vgt/la/xdhb7hz5dIgTUFa
 venK98bfLUfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 23:38:19 -0700
IronPort-SDR: acXIqMHlC2Var749gsjCYLUDv65hiGtYDDjyccFn7fbSKcPf0wneY31yBcdySE4077Hxhhc6Bx
 awghGDehFkcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="296867632"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 23:38:16 -0700
Subject: Re: [PATCH v4 1/3] mmc: host: Introduce the request_atomic() for the
 host
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585896945.git.baolin.wang7@gmail.com>
 <04c25ff9f9b17d41d734c498e4be61dee745bb30.1585896945.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5a55947b-e920-4515-49cf-163f6d539421@intel.com>
Date:   Tue, 7 Apr 2020 09:37:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04c25ff9f9b17d41d734c498e4be61dee745bb30.1585896945.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/04/20 10:05 am, Baolin Wang wrote:
> The SD host controller can process one request in the atomic context if
> the card is nonremovable, which means we can submit next request in the
> irq hard handler when using the MMC host software queue to reduce the
> latency. Thus this patch adds a new API request_atomic() for the host
> controller, as well as adding support for host software queue to submit
> a request by the new request_atomic() API.
> 
> Moreover there is an unusual case that the card is busy when trying to
> send a command, and we can not polling the card status in interrupt
> context by using request_atomic() to dispatch requests. Thus we should
> queue a work to try again in the non-atomic context in case the host
> releases the busy signal later.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>


One minor point below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/mmc_hsq.c | 29 ++++++++++++++++++++++++++++-
>  drivers/mmc/host/mmc_hsq.h |  1 +
>  include/linux/mmc/host.h   |  3 +++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index b90b2c9..a57f802 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -16,11 +16,20 @@
>  #define HSQ_NUM_SLOTS	64
>  #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
>  
> +static void mmc_hsq_retry_handler(struct work_struct *work)
> +{
> +	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> +	struct mmc_host *mmc = hsq->mmc;
> +
> +	mmc->ops->request(mmc, hsq->mrq);
> +}
> +
>  static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>  {
>  	struct mmc_host *mmc = hsq->mmc;
>  	struct hsq_slot *slot;
>  	unsigned long flags;
> +	int ret = 0;
>  
>  	spin_lock_irqsave(&hsq->lock, flags);
>  
> @@ -42,7 +51,24 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>  
>  	spin_unlock_irqrestore(&hsq->lock, flags);
>  
> -	mmc->ops->request(mmc, hsq->mrq);
> +	if (mmc->ops->request_atomic)
> +		ret = mmc->ops->request_atomic(mmc, hsq->mrq);
> +	else
> +		mmc->ops->request(mmc, hsq->mrq);
> +
> +	/*
> +	 * If returning BUSY from request_atomic(), which means the card
> +	 * may be busy now, and we should change to non-atomic context to
> +	 * try again for this unusual case, to avoid time-consuming operations
> +	 * in the atomic context.
> +	 *
> +	 * Note: we just give a warning for other error cases, since the host
> +	 * driver will handle them.
> +	 */
> +	if (ret == -EBUSY)
> +		schedule_work(&hsq->retry_work);
> +	else
> +		WARN_ON_ONCE(ret && ret != -EBUSY);

'ret != -EBUSY' is redundant because it is always true in the 'else' clause.

>  }
>  
>  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
> @@ -325,6 +351,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>  	hsq->mmc->cqe_private = hsq;
>  	mmc->cqe_ops = &mmc_hsq_ops;
>  
> +	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
>  	spin_lock_init(&hsq->lock);
>  	init_waitqueue_head(&hsq->wait_queue);
>  
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index 18b9cf5..ffdd9cd 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -12,6 +12,7 @@ struct mmc_hsq {
>  	wait_queue_head_t wait_queue;
>  	struct hsq_slot *slot;
>  	spinlock_t lock;
> +	struct work_struct retry_work;
>  
>  	int next_tag;
>  	int num_slots;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c318fb5..d4a50e5d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -92,6 +92,9 @@ struct mmc_host_ops {
>  			    int err);
>  	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
>  	void	(*request)(struct mmc_host *host, struct mmc_request *req);
> +	/* Submit one request to host in atomic context. */
> +	int	(*request_atomic)(struct mmc_host *host,
> +				  struct mmc_request *req);
>  
>  	/*
>  	 * Avoid calling the next three functions too often or in a "fast
> 

