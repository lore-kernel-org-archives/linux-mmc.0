Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E40C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C4B60FBF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 05:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhJ0Fw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 01:52:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:4155 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238201AbhJ0Fw0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Oct 2021 01:52:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253626062"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="253626062"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 22:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="537402271"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2021 22:49:59 -0700
Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <34233159-2931-b02a-ef16-1029d8d7829a@intel.com>
Date:   Wed, 27 Oct 2021 08:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/10/2021 05:47, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> For ADMA with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it limit
> the max segment size as 64K-1. Currently, linux kernel support
> 4K/16K/64K PAGE_SIZE. If choose 64K PAGE_SIZE, sdhci in ADMA mode
> with the upper quirks will meet issue.
> 
> Though mmc driver give block layer the max segment size through
> blk_queue_max_segment_size(), but in this function, it will compare
> the argument with PAGE_SIZE, and will choose PAGE_SIZE if the argument
> is smaller than PAGE_SIZE. When PAGE_SIZE is 64K, finally the mmc
> request queue will get 64K as the max segment size. Once the sg data
> length=64K, ADMA will meet issue. For this case, need to disable ADMA
> mode.

Sorry, I didn't look closely enough at this.

For the 64K PAGE_SIZE case, did you try blk_queue_virt_boundary()
with a 32K mask instead of blk_queue_max_segment_size() ?
e.g. a hack for testing purposes like this:

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b15c034b42fb..4c3a9d999500 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -376,8 +376,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	 * both blk_queue_max_segment_size().
 	 */
 	if (!host->can_dma_map_merge)
-		blk_queue_max_segment_size(mq->queue,
-			round_down(host->max_seg_size, block_size));
+		blk_queue_virt_boundary(mq->queue, 0x7fff);
 
 	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
 



> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index dbe87995596c..47e0c0156b94 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4187,6 +4187,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		host->flags &= ~SDHCI_USE_ADMA;
>  	}
>  
> +	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) &&
> +		PAGE_SIZE >= 65536 && (host->flags & SDHCI_USE_ADMA)) {
> +		DBG("Disabling ADMA as it don't support >= 64K PAGE_SIZE\n");
> +		host->flags &= ~SDHCI_USE_ADMA;
> +	}
> +
>  	if (sdhci_can_64bit_dma(host))
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
> 

