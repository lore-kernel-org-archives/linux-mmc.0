From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] [MMC 4.5] Fix for checking block numbers in disable
 emulation mode
Date: Fri, 29 Jun 2012 19:12:41 +0900
Message-ID: <008d01cd55df$b7bbab50$273301f0$%jun@samsung.com>
References: <1340951554-29504-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42533 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab2F2KMm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 06:12:42 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6D007Q0J12EBN0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jun 2012 19:12:41 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6D00E51J15EG60@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jun 2012 19:12:41 +0900 (KST)
In-reply-to: <1340951554-29504-1-git-send-email-saugata.das@stericsson.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org
Cc: patches@linaro.org, 'Saugata Das' <saugata.das@linaro.org>

Hi Saugata,

Could you check the comment below?

Friday, June 29, 2012, Saugata Das <saugata.das@linaro.org> wrote:
> From: Saugata Das <saugata.das@linaro.org>
> 
> In 512B disable emulation patch, a check is done to ensure that size
> of the data is multiple of 4KB. However, the check is done with
> brq->data.blocks, which is not initialized at the point of check.
> This is now changed to blk_rq_sectors.
> 
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d628c5d..ee8b3d6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1296,7 +1296,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			 * When 4KB native sector is enabled, only 8 blocks
>  			 * multiple read or write is allowed
>  			 */
> -			if ((brq->data.blocks & 0x07) &&
> +			if ((blk_rq_sectors(req) & 0x07) &&
>  				(card->ext_csd.data_sector_size == 4096)) {
>  				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
>  					req->rq_disk->disk_name);

In current error handling, multiple block read can be retried using single block read
with disable_multi. Then 4KB alignment will be broken.
Also,  there is some conditions to modify the number of blocks in mmc_blk_rw_rq_prep.
That means the alignment of blocks can be changed after mmc_blk_rw_rq_prep.
It needs to be considered.

And I have a question.
Spec mentioned that arguments for read commands (CMD17/18) shall always be aligned to 8(4KB)
in Native 4KB sector. In current implementation CMD17/18 is only used when data.blocks is 1.
If data.blocks is 8 in Native 4KB sector, then CMD17/18 should be taken instead of CMD24/25?

Thanks,
Seungwon Jeon
> --
> 1.7.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

