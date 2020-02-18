Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5037FC34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 08:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261D821D56
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 08:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgBRIQp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:16:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:51548 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgBRIQp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 03:16:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314984382"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2020 00:16:41 -0800
Subject: Re: [PATCH v3 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, linus.walleij@linaro.org
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-9-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c02cf466-a6fe-2996-d928-a7ef3640c3af@intel.com>
Date:   Tue, 18 Feb 2020 10:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581324597-31031-9-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/02/20 10:49 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> To make dma_set_max_seg_size() work, need to create dev->dma_parms.
> 
> Find this issue on i.MX8QM mek board, this platform config the
> max_segment_size to 65535, but this dma_set_max_seg_size do not
> actuall work, find sometimes the segment size is 65536, exceed
> the hardware max segment limitation, trigger ADMA error.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/queue.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 9edc08685e86..f74c28c58482 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -359,6 +359,7 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>  	struct mmc_host *host = card->host;
> +	struct device *dev = mmc_dev(host);
>  	unsigned block_size = 512;
>  
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
> @@ -366,13 +367,12 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  	if (mmc_can_erase(card))
>  		mmc_queue_setup_discard(mq->queue, card);
>  
> -	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +	if (!dev->dma_mask || !*dev->dma_mask)
>  		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>  	blk_queue_max_hw_sectors(mq->queue,
>  		min(host->max_blk_count, host->max_req_size / 512));
>  	if (host->can_dma_map_merge)
> -		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
> -							mmc_dev(host)),
> +		WARN(!blk_queue_can_use_dma_map_merging(mq->queue, dev),
>  		     "merging was advertised but not possible");
>  	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>  
> @@ -389,7 +389,8 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  		blk_queue_max_segment_size(mq->queue,
>  			round_down(host->max_seg_size, block_size));
>  
> -	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
> +	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);

Wouldn't it be more logical to keep existing dma_parms? i.e.

	if (!dev->dma_parms)
		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);

> +	dma_set_max_seg_size(dev, queue_max_segment_size(mq->queue));
>  
>  	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>  	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> 

