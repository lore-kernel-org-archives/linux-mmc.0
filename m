From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix the wrong max_blk_size
Date: Wed, 4 May 2016 10:55:00 +0800
Message-ID: <9ca328f2-7ab7-3c28-e70e-cb3b22523f94@rock-chips.com>
References: <1462328654-5165-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:57240 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcEDCzb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 22:55:31 -0400
In-Reply-To: <1462328654-5165-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

On 2016/5/4 10:24, Jaehoon Chung wrote:
> According to DesignWare TRM, BLKSIZ is 16bits.
> Then it's correct that max_blk_size should be 0xFFFF, not 0x10000.
>

Seems a long pre-existing mistake.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9dd1bd3..829a6ee 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2595,13 +2595,13 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	/* Useful defaults if platform data is unset. */
>  	if (host->use_dma == TRANS_MODE_IDMAC) {
>  		mmc->max_segs = host->ring_size;
> -		mmc->max_blk_size = 65536;
> +		mmc->max_blk_size = 65535;
>  		mmc->max_seg_size = 0x1000;
>  		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
>  		mmc->max_blk_count = mmc->max_req_size / 512;
>  	} else if (host->use_dma == TRANS_MODE_EDMAC) {
>  		mmc->max_segs = 64;
> -		mmc->max_blk_size = 65536;
> +		mmc->max_blk_size = 65535;
>  		mmc->max_blk_count = 65535;
>  		mmc->max_req_size =
>  				mmc->max_blk_size * mmc->max_blk_count;
> @@ -2609,7 +2609,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	} else {
>  		/* TRANS_MODE_PIO */
>  		mmc->max_segs = 64;
> -		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> +		mmc->max_blk_size = 65535; /* BLKSIZ is 16 bits */
>  		mmc->max_blk_count = 512;
>  		mmc->max_req_size = mmc->max_blk_size *
>  				    mmc->max_blk_count;
>


-- 
Best Regards
Shawn Lin

