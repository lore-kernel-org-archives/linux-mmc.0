From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: correct 4KB alignment check
Date: Fri, 3 Jun 2016 10:33:25 +0200
Message-ID: <CAPDyKFp-pPo0TTt_QR+YkWi6WUAKX97sbTHP5g-UkBcFxY8FuA@mail.gmail.com>
References: <588D8A7789B2934A9950BF189ED6F50A2007FF09@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38131 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcFCId2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 04:33:28 -0400
Received: by mail-wm0-f41.google.com with SMTP id a20so96627859wma.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2016 01:33:27 -0700 (PDT)
In-Reply-To: <588D8A7789B2934A9950BF189ED6F50A2007FF09@shsmsx102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Yuan, Juntao" <juntao.yuan@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 13 May 2016 at 09:59, Yuan, Juntao <juntao.yuan@intel.com> wrote:
>
> In sectors alignment check, brq->data.blocks means sectors of the
> previous mqrq since data.blocks for mqrq_cur hasn't been updated yet.
> data.blocks will be updated later in mmc_blk_packed_hdr_wrq_prep or
> mmc_blk_rw_rq_prep.
>
> static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, ......
>         ......
>     struct mmc_blk_request *brq = &mq->mqrq_cur->brq;
>
> Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 3bdbe50..cc0189f 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1950,8 +1950,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>              * When 4KB native sector is enabled, only 8 blocks
>              * multiple read or write is allowed
>              */
> -           if ((brq->data.blocks & 0x07) &&
> -               (card->ext_csd.data_sector_size == 4096)) {
> +           if (mmc_large_sector(card) &&
> +               !IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
>                 pr_err("%s: Transfer size is not 4KB sector size aligned\n",
>                     req->rq_disk->disk_name);
>                 mq_rq = mq->mqrq_cur;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
