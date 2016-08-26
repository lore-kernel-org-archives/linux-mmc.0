From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/2] mmc: block: remove the check of packed for packed
 request routine
Date: Fri, 26 Aug 2016 09:49:21 +0200
Message-ID: <CAPDyKFprMG4fSAkm3P7fS3x6Ys5gsPz_PqN-KuRy83YG=cdeqA@mail.gmail.com>
References: <1472172596-16160-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37357 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcHZHtY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 03:49:24 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so106151275wmg.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2016 00:49:23 -0700 (PDT)
In-Reply-To: <1472172596-16160-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 26 August 2016 at 02:49, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> packed should always exist without calling its cleanup function
> explicitly. Moreover, we have use it when preparing packed list.
> So I don't believe we should ever fall into this check again when
> doing mmc_blk_packed_hdr_wrq_prep or mmc_blk_end_packed_req,etc.
> And the code of mmc_blk_end_packed_req is trying to use packed before
> checking it which makes it quite weird. This patch is trying to
> remove these two checks and move it to the mmc_blk_prep_packed_list.
> If we find packed is null, then we should never use MMC_BLK_PACKED_CMD.
> By doing this, we could fall back to non-packed request if finding null
> packed, though it's impossible theoretically.
>
> After removing these two BUG_ONs, we also remove all other similar
> checks within the routine of mmc_blk_issue_rw_rq which checks the
> error handling of packed request.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v4: None
> Changes in v3:
> - remove other similar BUG_ONs for packed routine
>
> Changes in v2:
> - remove BUG_ON and add fallback for packed instead of
>   panic it.
> - remove BUG_ON for mmc_io_rw_extened and add these into the
>   wrapper function of sdio_io_rw_ext_helper
> - remove the msg of failing to alloc packed and exlicitly
>   print we don't support packed request.
>
>  drivers/mmc/card/block.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 48a5dd7..ce822bb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -142,8 +142,6 @@ static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
>  {
>         struct mmc_packed *packed = mqrq->packed;
>
> -       BUG_ON(!packed);
> -
>         mqrq->cmd_type = MMC_PACKED_NONE;
>         packed->nr_entries = MMC_PACKED_NR_ZERO;
>         packed->idx_failure = MMC_PACKED_NR_IDX;
> @@ -1443,8 +1441,6 @@ static int mmc_blk_packed_err_check(struct mmc_card *card,
>         int err, check, status;
>         u8 *ext_csd;
>
> -       BUG_ON(!packed);
> -
>         packed->retries--;
>         check = mmc_blk_err_check(card, areq);
>         err = get_card_status(card, &status, 0);
> @@ -1673,6 +1669,18 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
>         u8 max_packed_rw = 0;
>         u8 reqs = 0;
>
> +       /*
> +        * We don't need to check packed for any further
> +        * operation of packed stuff as we set MMC_PACKED_NONE
> +        * and return zero for reqs if geting null packed. Also
> +        * we clean the flag of MMC_BLK_PACKED_CMD to avoid doing
> +        * it again when removing blk req.
> +        */
> +       if (!mqrq->packed) {
> +               md->flags &= (~MMC_BLK_PACKED_CMD);
> +               goto no_packed;
> +       }
> +
>         if (!(md->flags & MMC_BLK_PACKED_CMD))
>                 goto no_packed;
>
> @@ -1781,8 +1789,6 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>         u8 hdr_blocks;
>         u8 i = 1;
>
> -       BUG_ON(!packed);
> -
>         mqrq->cmd_type = MMC_PACKED_WRITE;
>         packed->blocks = 0;
>         packed->idx_failure = MMC_PACKED_NR_IDX;
> @@ -1886,8 +1892,6 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
>         int idx = packed->idx_failure, i = 0;
>         int ret = 0;
>
> -       BUG_ON(!packed);
> -
>         while (!list_empty(&packed->list)) {
>                 prq = list_entry_rq(packed->list.next);
>                 if (idx == i) {
> @@ -1916,8 +1920,6 @@ static void mmc_blk_abort_packed_req(struct mmc_queue_req *mq_rq)
>         struct request *prq;
>         struct mmc_packed *packed = mq_rq->packed;
>
> -       BUG_ON(!packed);
> -
>         while (!list_empty(&packed->list)) {
>                 prq = list_entry_rq(packed->list.next);
>                 list_del_init(&prq->queuelist);
> @@ -1934,8 +1936,6 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
>         struct request_queue *q = mq->queue;
>         struct mmc_packed *packed = mq_rq->packed;
>
> -       BUG_ON(!packed);
> -
>         while (!list_empty(&packed->list)) {
>                 prq = list_entry_rq(packed->list.prev);
>                 if (prq->queuelist.prev != &packed->list) {
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
