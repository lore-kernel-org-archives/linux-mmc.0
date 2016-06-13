From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: Fix tag condition with packed writes
Date: Mon, 13 Jun 2016 10:42:34 +0800
Message-ID: <7b6b85e2-4439-f091-3319-9f5ceeb72e82@rock-chips.com>
References: <575ABF08.4010102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:40471 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbcFMCmo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Jun 2016 22:42:44 -0400
In-Reply-To: <575ABF08.4010102@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On 2016/6/10 21:22, Adrian Hunter wrote:
> Apparently a cut-and-paste error, 'do_data_tag' is using 'brq' for data
> size even though 'brq' has not been set up. Instead use blk_rq_sectors().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
>
> Hi
>
> I don't know if anyone is actually using packed writes, but this is
> something I noticed.


I think if brq has not been set up, the we could meet another problem
of checking the case of whether 4KB native sector is enabled.
When fetching blk req from the queue, mmc_blk_issue_rw_rq already
use brq there which is the same from your case, namely
mq->mqrq_cur->brq, right?



>
> Regards
> Adrian
>
>
>  drivers/mmc/card/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index b954516739be..aa5cfaf1fdf0 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1834,8 +1834,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>  		do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>  			(prq->cmd_flags & REQ_META) &&
>  			(rq_data_dir(prq) == WRITE) &&
> -			((brq->data.blocks * brq->data.blksz) >=
> -			 card->ext_csd.data_tag_unit_size);
> +			blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
>  		/* Argument of CMD23 */
>  		packed_cmd_hdr[(i * 2)] =
>  			(do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
>


-- 
Best Regards
Shawn Lin

