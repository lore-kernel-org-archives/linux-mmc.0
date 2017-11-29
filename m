From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc : implement REQ_OP_WRITE_ZEROES
Date: Wed, 29 Nov 2017 14:00:08 +0100
Message-ID: <CAPDyKFpU8_E6pN+7iJSxqpc8WZkEkTVORLdLgA8OpMYVq=6esQ@mail.gmail.com>
References: <CGME20171109125101eucas1p2c824f0baade3fef0f15cea043e77caa5@eucas1p2.samsung.com>
 <20171109125051.12772-1-js07.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36371 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbdK2NAK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 08:00:10 -0500
Received: by mail-io0-f176.google.com with SMTP id 81so3604055iof.3
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 05:00:09 -0800 (PST)
In-Reply-To: <20171109125051.12772-1-js07.lee@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jungseung Lee <js07.lee@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jungseung Lee <js07.lee@gmail.com>, Christoph Hellwig <hch@lst.de>

On 9 November 2017 at 13:50, Jungseung Lee <js07.lee@samsung.com> wrote:
> The contents of a write block where the trim function has been applied
> shall be '0' or '1' and so some of eMMC devices return zeroes on read to
> the trimmed blocks.
>
> Use the behavior to implement REQ_OP_WRITES_ZEROES. We can only know the
> behavior based on individual device modles, so this patch adds a flag to
> the mmc quirk list for devices works that way. It also sets the new flag
> for one such known device.

Implementing this for trim make sense to me and is a good start.

However, perhaps as a next step, we should also consider implementing
this for erase!? For erase we need to make sure that we write '0's to
those sectors that was not aligned with the erase group size, but that
should be doable.

Regarding the card quirk, I don't think it's needed. Because the are
registers in the SD/eMMC cards, telling whether the device returns '1'
or '0' for erased/trimmed sectors.
eMMC: EXT_CSD register -> ERASED_MEM_CONT [181]
SD: SCR register -> DATA_STAT_AFTER_ERASE [55].

Some additional comments below.

>
> Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
> ---
>  drivers/mmc/core/block.c  | 8 ++++++--
>  drivers/mmc/core/queue.c  | 4 ++++
>  drivers/mmc/core/quirks.h | 7 +++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ea80ff4..41c4ec1 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1273,9 +1273,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>         struct mmc_card *card = md->queue.card;
>         unsigned int from, nr, arg;
>         int err = 0, type = MMC_BLK_DISCARD;
> +       int force_trim = (req_op(req) == REQ_OP_WRITE_ZEROES);
>         blk_status_t status = BLK_STS_OK;
>
> -       if (!mmc_can_erase(card)) {
> +       if (!mmc_can_erase(card) || (!mmc_can_trim(card) && force_trim)) {

Please no. This becomes to hard to understand - and folding in changes
in mmc_blk_issue_discard_rq() for REQ_OP_WRITE_ZEROES seems prone to
also inventing errors. I may be wrong, by still.

Then I think it's better to re-factor mmc_blk_issue_discard_rq() such
parts needed for both REQ_OP_WRITE_ZEROES and REQ_OP_DISCARD, can be
shared via some new helper function(s).

>                 status = BLK_STS_NOTSUPP;
>                 goto fail;
>         }
> @@ -1283,7 +1284,9 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>         from = blk_rq_pos(req);
>         nr = blk_rq_sectors(req);
>
> -       if (mmc_can_discard(card))
> +       if (force_trim)
> +               arg = MMC_TRIM_ARG;
> +       else if (mmc_can_discard(card))
>                 arg = MMC_DISCARD_ARG;
>         else if (mmc_can_trim(card))
>                 arg = MMC_TRIM_ARG;
> @@ -2032,6 +2035,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>                                 mmc_blk_issue_rw_rq(mq, NULL);
>                         mmc_blk_issue_drv_op(mq, req);
>                         break;
> +               case REQ_OP_WRITE_ZEROES:
>                 case REQ_OP_DISCARD:

[...]

Finally, we just about converting the mmc block to use the blkmq
interface and adding support for eMMC CMD. I am expecting that really
soon to happen, and so I prefer if you could hold off posting a new
version of this until this is taken care of.

That also means, you will need to adopt your changes to the new mmc
blkmq code, which I think should be rather easy.

Kind regards
Uffe
