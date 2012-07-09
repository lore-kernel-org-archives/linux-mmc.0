From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] Fix for checking block numbers in disable emulation mode
Date: Mon, 09 Jul 2012 10:51:10 +0900
Message-ID: <009f01cd5d75$506d9c90$f148d5b0$%jun@samsung.com>
References: <1341582904-31896-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56983 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2GIBv1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jul 2012 21:51:27 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6V009YVEH76A90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 10:51:10 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6V00HBDEHATZ30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 10:51:10 +0900 (KST)
In-reply-to: <1341582904-31896-1-git-send-email-saugata.das@stericsson.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org
Cc: patches@linaro.org, 'Saugata Das' <saugata.das@linaro.org>

Hi Saugata,

Could check the your worked base?
It can't be merged.
And there are some comments below.

Friday, July 06, 2012, Saugata Das <saugata.das@stericsson.com> wrote:
> From: Saugata Das <saugata.das@linaro.org>
> 
> In 512B disable emulation patch, a check is done to ensure that size
> of the data is multiple of 4KB within mmc_blk_issue_rw_rq. However,
> the check is done with brq->data.blocks, which is not initialized at
> the point of check. This is now changed to blk_rq_sectors.
> 
> In addition, when retrying read transfers, the current code retries
> with single block. This has been changed to 8 blocks if disable
> emulation is enabled.
> 
> For hosts which are not capable to handle transfer of multiple of 4KB,
> a check has been added in mmc_read_ext_csd. A check has been added for
> reliable write with EN_REL_WR=0, which is not allowed.
> 
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> 
> Changes in v2 :
> 	- Added check in mmc_read_ext_csd
It's not good way to add version history here.
> ---
>  drivers/mmc/card/block.c |   19 +++++++++++++------
>  drivers/mmc/core/mmc.c   |    9 +++++++--
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d628c5d..69b7b03 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1114,7 +1114,10 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
>  			  (req->cmd_flags & REQ_META)) &&
>  		(rq_data_dir(req) == WRITE) &&
> -		(md->flags & MMC_BLK_REL_WR);
> +		(md->flags & MMC_BLK_REL_WR) &&
> +		((card->ext_csd.data_sector_size == 512) ||
> +		 ((card->ext_csd.data_sector_size == 4096) &&
> +		  (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)));
> 
>  	memset(brq, 0, sizeof(struct mmc_blk_request));
>  	brq->mrq.cmd = &brq->cmd;
> @@ -1145,7 +1148,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  		 * sectors can be read successfully.
>  		 */
>  		if (disable_multi)
> -			brq->data.blocks = 1;
> +			brq->data.blocks =
> +				(card->ext_csd.data_sector_size == 4096) ?
> +					8 : 1;
> 
>  		/* Some controllers can't do multiblock reads due to hw bugs */
>  		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
> @@ -1296,10 +1301,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			 * When 4KB native sector is enabled, only 8 blocks
>  			 * multiple read or write is allowed
>  			 */
> -			if ((brq->data.blocks & 0x07) &&
> +			if ((blk_rq_sectors(req) & 0x07) &&
>  				(card->ext_csd.data_sector_size == 4096)) {
> -				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
> -					req->rq_disk->disk_name);
> +				pr_err("%s: Transfer size [%d] is not 4KB sector size aligned\n",
> +					req->rq_disk->disk_name,
> +					blk_rq_sectors(req));
rqc seems be proper instead of req.
In do-while loop for error-handling, req can be replaced with previous request.
Also, it would be better check the alignment in outer loop.
How about move to out of loop?

Best regards,
Seungwon Jeon

>  				goto cmd_abort;
>  			}
>  			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> @@ -1364,7 +1370,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  			/* Fall through */
>  		}
>  		case MMC_BLK_ECC_ERR:
> -			if (brq->data.blocks > 1) {
> +			if (brq->data.blocks >
> +				(card->ext_csd.data_sector_size >> 9)) {
>  				/* Redo read one sector at a time */
>  				pr_warning("%s: retrying using single block read\n",
>  					   req->rq_disk->disk_name);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 28fbd77..fb68f17 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -503,9 +503,14 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  			ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
>  			ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
> 
> -		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 1)
> +		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 1) {
> +			if ((card->host->caps2 & MMC_CAP2_NO_MULTI_READ) ||
> +				(card->host->max_blk_count & 0x07)) {
> +				err = -EINVAL;
> +				goto out;
> +			}
>  			card->ext_csd.data_sector_size = 4096;
> -		else
> +		} else
>  			card->ext_csd.data_sector_size = 512;
> 
>  		if ((ext_csd[EXT_CSD_DATA_TAG_SUPPORT] & 1) &&
> --
> 1.7.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

