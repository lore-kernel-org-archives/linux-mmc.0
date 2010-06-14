From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH V2 3/4] mmc_block: Add discard and secure discard support
Date: Mon, 14 Jun 2010 18:58:20 +0900
Message-ID: <AANLkTin3YFhsi_2nsOKqweOIcBYeBXHuJDJsXjD1o8mS@mail.gmail.com>
References: <4C14AC8D.50702@nokia.com>
	<4C14B5FB.1000909@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33284 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915Ab0FNJ6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jun 2010 05:58:21 -0400
In-Reply-To: <4C14B5FB.1000909@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, Madhusudhan Chikkature <madhu.cr@ti.com>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I tested it and get the same result from my implementation. at current
time no performance improvement.

Thank you,
Kyungmin Park

On Sun, Jun 13, 2010 at 7:42 PM, Adrian Hunter <adrian.hunter@nokia.com=
> wrote:
> From a86fc83da7c3d4f9f39a267841b8cb73c30ad7ac Mon Sep 17 00:00:00 200=
1
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Thu, 3 Jun 2010 10:47:12 +0300
> Subject: [PATCH 3/4] mmc_block: Add discard and secure discard suppor=
t
>
> Enable MMC to service discard requests. =A0In the case of SD
> and MMC cards that do not support trim, discards become
> erases. =A0In the case of cards (MMC) that only allow erases
> in multiples of erase group size, round to the nearest
> completely discarded erase group.
>
> Also implement BLKSECDISCARD using MMC secure erase and
> trim operations.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> drivers/mmc/card/block.c | =A0125
> +++++++++++++++++++++++++++++++++++++++++++++-
> drivers/mmc/card/queue.c | =A0 16 +++++-
> 2 files changed, 138 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cb9fbc8..f7129b3 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -31,6 +31,7 @@
> #include <linux/mutex.h>
> #include <linux/scatterlist.h>
> #include <linux/string_helpers.h>
> +#include <linux/delay.h>
>
> #include <linux/mmc/card.h>
> #include <linux/mmc/host.h>
> @@ -138,9 +139,91 @@ mmc_blk_getgeo(struct block_device *bdev, struct
> hd_geometry *geo)
> =A0 =A0 =A0 =A0return 0;
> }
>
> +static int mmc_blk_check_eod(struct block_device *bdev, unsigned int=
 from,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 nr)
> +{
> + =A0 =A0 =A0 unsigned int maxsector;
> +
> + =A0 =A0 =A0 if (!nr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 maxsector =3D bdev->bd_inode->i_size >> 9;
> + =A0 =A0 =A0 if (maxsector && (maxsector < nr || maxsector - nr < fr=
om))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mmc_blk_secure_erase(struct mmc_blk_data *md, unsigned in=
t from,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int nr)
> +{
> + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
> + =A0 =A0 =A0 unsigned int arg;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (!mmc_can_secure_erase_trim(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> +
> + =A0 =A0 =A0 if (mmc_can_trim(card) && !mmc_erase_group_aligned(card=
, from, nr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg =3D MMC_SECURE_TRIM1_ARG;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg =3D MMC_SECURE_ERASE_ARG;
> +
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 err =3D mmc_erase(card, from, nr, arg);
> + =A0 =A0 =A0 if (!err && arg =3D=3D MMC_SECURE_TRIM1_ARG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_erase(card, from, nr, MMC_S=
ECURE_TRIM2_ARG);
> + =A0 =A0 =A0 mmc_release_host(card->host);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int mmc_blk_ioctl_secdiscard(struct block_device *bdev, uint6=
4_t
> start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint=
64_t len)
> +{
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D bdev->bd_disk->private_data=
;
> + =A0 =A0 =A0 unsigned int from, nr;
> +
> + =A0 =A0 =A0 if ((start & 511) || (len & 511))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 start >>=3D 9;
> + =A0 =A0 =A0 len >>=3D 9;
> +
> + =A0 =A0 =A0 if (start > UINT_MAX || len > UINT_MAX)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 from =3D start;
> + =A0 =A0 =A0 nr =3D len;
> +
> + =A0 =A0 =A0 if (mmc_blk_check_eod(bdev, from, nr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (bdev !=3D bdev->bd_contains)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 from +=3D bdev->bd_part->start_sect;
> +
> + =A0 =A0 =A0 return mmc_blk_secure_erase(md, from, nr);
> +}
> +
> +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned cmd, unsign=
ed long arg)
> +{
> + =A0 =A0 =A0 uint64_t range[2];
> +
> + =A0 =A0 =A0 switch (cmd) {
> + =A0 =A0 =A0 case BLKSECDISCARD:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(range, (void __user =
*)arg,
> sizeof(range)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_blk_ioctl_secdiscard(bdev, r=
ange[0], range[1]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -ENOTTY;
> +}
> +
> static const struct block_device_operations mmc_bdops =3D {
> =A0 =A0 =A0 =A0.open =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_blk_=
open,
> =A0 =A0 =A0 =A0.release =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_blk_re=
lease,
> + =A0 =A0 =A0 .ioctl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_blk_i=
octl,
> =A0 =A0 =A0 =A0.getgeo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_blk_ge=
tgeo,
> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D THIS_MOD=
ULE,
> };
> @@ -242,7 +325,40 @@ static u32 get_card_status(struct mmc_card *card=
,
> struct request *req)
> =A0 =A0 =A0 =A0return cmd.resp[0];
> }
>
> -static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *re=
q)
> +static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct req=
uest
> *req)
> +{
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
> + =A0 =A0 =A0 unsigned int from, nr, arg;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> +
> + =A0 =A0 =A0 if (!mmc_can_erase(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 from =3D blk_rq_pos(req);
> + =A0 =A0 =A0 nr =3D blk_rq_sectors(req);
> +
> + =A0 =A0 =A0 if (mmc_can_trim(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg =3D MMC_TRIM_ARG;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg =3D MMC_ERASE_ARG;
> +
> + =A0 =A0 =A0 err =3D mmc_erase(card, from, nr, arg);
> +out:
> + =A0 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 __blk_end_request(req, err, blk_rq_bytes(req));
> + =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> +
> + =A0 =A0 =A0 mmc_release_host(card->host);
> +
> + =A0 =A0 =A0 return err ? 0 : 1;
> +}
> +
> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request =
*req)
> {
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
> @@ -470,6 +586,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq=
,
> struct request *req)
> =A0 =A0 =A0 =A0return 0;
> }
>
> +static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *re=
q)
> +{
> + =A0 =A0 =A0 if (blk_discard_rq(req))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_blk_issue_discard_rq(mq, req=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_blk_issue_rw_rq(mq, req);
> +}
>
> static inline int mmc_blk_readonly(struct mmc_card *card)
> {
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index d6ded24..37f648f 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -30,9 +30,9 @@
> static int mmc_prep_request(struct request_queue *q, struct request *=
req)
> {
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* We only like normal block requests.
> + =A0 =A0 =A0 =A0* We only like normal block requests and discards.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!blk_fs_request(req)) {
> + =A0 =A0 =A0 if (!blk_fs_request(req) && !blk_discard_rq(req)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blk_dump_rq_flags(req, "MMC bad reques=
t");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return BLKPREP_KILL;
> =A0 =A0 =A0 =A0}
> @@ -130,6 +130,18 @@ int mmc_init_queue(struct mmc_queue *mq, struct
> mmc_card *card, spinlock_t *lock
> =A0 =A0 =A0 =A0blk_queue_prep_rq(mq->queue, mmc_prep_request);
> =A0 =A0 =A0 =A0blk_queue_ordered(mq->queue, QUEUE_ORDERED_DRAIN, NULL=
);
> =A0 =A0 =A0 =A0queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
> + =A0 =A0 =A0 if (mmc_can_erase(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_flag_set_unlocked(QUEUE_FLAG_DISC=
ARD, mq->queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->queue->limits.max_discard_sectors =3D=
 UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->erased_byte =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->queue->limits.disca=
rd_zeroes_data =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mmc_can_trim(card) && is_power_of_=
2(card->erase_size))
> {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->queue->limits.disca=
rd_granularity =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_size <<
> 9;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->queue->limits.disca=
rd_alignment =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erase_size <<
> 9;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> #ifdef CONFIG_MMC_BLOCK_BOUNCE
> =A0 =A0 =A0 =A0if (host->max_hw_segs =3D=3D 1) {
> --
> 1.6.3.3
>
>
