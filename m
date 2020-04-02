Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB105C43331
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83353206F8
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgDBKpu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:45:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:53826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbgDBKpt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 06:45:49 -0400
IronPort-SDR: H3xSB95jWYTXkx+j4NETqPnqRaC/e7CIqeI7xTeuZzr8sUO+SjbH1Kz2zdbvqpLYYZy3168mKn
 T16j6F/QdsTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 03:45:49 -0700
IronPort-SDR: KxM0FCr0vwUYqKDLXgHweWoLlVQUzA+Hvv0ii4BEJ/fusUQk21Fa8+Ik97Ub+LCeV6vca6mC3w
 CRvk5bWouKhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="240788144"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 03:45:47 -0700
Subject: Re: [PATCH v3 3/4] mmc: host: hsq: Handle an unusual case of returing
 busy
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1584615043.git.baolin.wang7@gmail.com>
 <c94b7e9a2fb48ac921fe41dba56df91efcdaa6c4.1584615043.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3e048723-2edb-cc5b-a8f1-8ab8554e077f@intel.com>
Date:   Thu, 2 Apr 2020 13:45:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c94b7e9a2fb48ac921fe41dba56df91efcdaa6c4.1584615043.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/03/20 12:54 pm, Baolin Wang wrote:
> There is an unusual case that the card is busy when trying to send a
> command, and we can not polling the card status in interrupt context
> by using request_atomic() to dispatch requests.
> 
> Thus we should queue a work to try again in the non-atomic context
> in case the host releases the busy signal later.

I think this should be part of patch 1

> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Sorry for the slow reply.

> ---
>  drivers/mmc/host/mmc_hsq.c | 37 ++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/mmc_hsq.h |  1 +
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index fdbaa98..3edad11 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -15,11 +15,33 @@
>  #define HSQ_NUM_SLOTS	64
>  #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
>  
> +static void mmc_hsq_retry_handler(struct work_struct *work)
> +{
> +	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> +	struct mmc_host *mmc = hsq->mmc;
> +	struct mmc_request *mrq = hsq->mrq;
> +	struct mmc_data *data = mrq->data;
> +
> +	if (mmc->ops->request) {

->request() is not an optional mmc operation so checking it is not necessary.

> +		mmc->ops->request(mmc, mrq);
> +		return;
> +	}
> +
> +	/*
> +	 * If host does not supply the callback in normal context to
> +	 * handle request, just finish this request.
> +	 */
> +	data->error = -EBUSY;
> +	data->bytes_xfered = 0;
> +	mmc_hsq_finalize_request(mmc, mrq);
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
> @@ -42,9 +64,21 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>  	spin_unlock_irqrestore(&hsq->lock, flags);
>  
>  	if (mmc->ops->request_atomic)
> -		mmc->ops->request_atomic(mmc, hsq->mrq);
> +		ret = mmc->ops->request_atomic(mmc, hsq->mrq);
>  	else
>  		mmc->ops->request(mmc, hsq->mrq);
> +
> +	/*
> +	 * If returning BUSY from request_atomic(), which means the card
> +	 * may be busy now, and we should change to non-atomic context to
> +	 * try again for this unusual case, to avoid time-consuming operations
> +	 * in the atomic context.
> +	 *
> +	 * Note: we can ignore other error cases, since the host driver
> +	 * will handle them.
> +	 */
> +	if (ret == -EBUSY)
> +		schedule_work(&hsq->retry_work);

Let's add a warning for unexpected return values i.e.

	WARN_ON_ONCE(ret && ret != -EBUSY);


>  }
>  
>  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
> @@ -327,6 +361,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>  	hsq->mmc->cqe_private = hsq;
>  	mmc->cqe_ops = &mmc_hsq_ops;
>  
> +	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
>  	spin_lock_init(&hsq->lock);
>  	init_waitqueue_head(&hsq->wait_queue);
>  
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index d51beb7..81f6c4f 100644
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
> 

