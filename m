From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH V2] mmc: card: IOCTL support for Sanitize feature of eMMC v4.5
Date: Tue, 27 Dec 2011 22:54:28 +0900
Message-ID: <CAH9JG2Uan6-EUmJo8gtGFEWUN-JKvtNnbZxYGqsXg49qEVpPtQ@mail.gmail.com>
References: <1324992782-1004-1-git-send-email-ygardi@codeaurora.org>
	<1324992782-1004-2-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51597 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab1L0Ny3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2011 08:54:29 -0500
In-Reply-To: <1324992782-1004-2-git-send-email-ygardi@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

Hi Yaniv,

You maybe split the patch into block and mmc parts.
Please see the comments inlined.

Thank you,
Kyungmin Park

On Tue, Dec 27, 2011 at 10:33 PM, Yaniv Gardi <ygardi@codeaurora.org> w=
rote:
> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
>
> ---
> =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0| =A0 15 ++++++++++--
> =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0 44 +++++++++++++++++++++=
++++++++++++++++++
> =A0block/blk-merge.c =A0 =A0 =A0 =A0 | =A0 =A06 +++++
> =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++++++-
> =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 ++++++++
> =A0drivers/mmc/card/block.c =A0| =A0 50 +++++++++++++++++++++++++++++=
+++++++--------
> =A0drivers/mmc/card/queue.c =A0| =A0 =A07 +++++-
> =A0include/linux/blk_types.h | =A0 =A07 ++++-
> =A0include/linux/blkdev.h =A0 =A0| =A0 =A03 ++
> =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0include/linux/mmc/card.h =A0| =A0 =A07 ++++++
> =A0kernel/trace/blktrace.c =A0 | =A0 =A02 +
> =A012 files changed, 143 insertions(+), 16 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index e6c05a9..e3512a4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1544,7 +1544,7 @@ generic_make_request_checks(struct bio *bio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto end_io;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (unlikely(!(bio->bi_rw & REQ_DISCARD) &&
> + =A0 =A0 =A0 if (unlikely(!(bio->bi_rw & (REQ_DISCARD | REQ_SANITIZE=
)) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_sectors > queue_max_hw_sec=
tors(q))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "bio too big device %s=
 (%u > %u)\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdevname(bio->bi_bdev, b)=
,
> @@ -1592,6 +1592,14 @@ generic_make_request_checks(struct bio *bio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto end_io;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if ((bio->bi_rw & REQ_SANITIZE) &&
> + =A0 =A0 =A0 =A0 =A0 (!blk_queue_sanitize(q))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s - SANITIZE request but queue=
 "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"doesn't support sanitiz=
e", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_io;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (blk_throtl_bio(q, bio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return false; =A0 /* throttled, will b=
e resubmitted later */
>
> @@ -1697,7 +1705,8 @@ void submit_bio(int rw, struct bio *bio)
> =A0 =A0 =A0 =A0 * If it's a regular read/write or a barrier with data=
 attached,
> =A0 =A0 =A0 =A0 * go through the normal accounting stuff before submi=
ssion.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (bio_has_data(bio) && !(rw & REQ_DISCARD)) {
> + =A0 =A0 =A0 if (bio_has_data(bio) &&
> + =A0 =A0 =A0 =A0 =A0 (!(rw & (REQ_DISCARD | REQ_SANITIZE)))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rw & WRITE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count_vm_events(PGPGOU=
T, count);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> @@ -1743,7 +1752,7 @@ EXPORT_SYMBOL(submit_bio);
> =A0*/
> =A0int blk_rq_check_limits(struct request_queue *q, struct request *r=
q)
> =A0{
> - =A0 =A0 =A0 if (rq->cmd_flags & REQ_DISCARD)
> + =A0 =A0 =A0 if ((rq->cmd_flags & REQ_DISCARD) || (rq->cmd_flags & R=
EQ_SANITIZE))
(rq->cmd_flags & (REQ_DISCARD | REA_SANITIZE))?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (blk_rq_sectors(rq) > queue_max_sectors(q) ||
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 2b461b4..76ed930 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -114,6 +114,50 @@ int blkdev_issue_discard(struct block_device *bd=
ev, sector_t sector,
> =A0}
> =A0EXPORT_SYMBOL(blkdev_issue_discard);
>
> +int blkdev_issue_sanitize(struct block_device *bdev, gfp_t gfp_mask)
> +{
> + =A0 =A0 =A0 DECLARE_COMPLETION_ONSTACK(wait);
> + =A0 =A0 =A0 struct request_queue *q =3D bdev_get_queue(bdev);
> + =A0 =A0 =A0 int type =3D REQ_WRITE | REQ_SANITIZE;
> +
> + =A0 =A0 =A0 struct bio_batch bb;
> + =A0 =A0 =A0 struct bio *bio;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!q)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> +
> + =A0 =A0 =A0 bio =3D bio_alloc(gfp_mask, 1);
> + =A0 =A0 =A0 if (!bio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 if (!blk_queue_sanitize(q)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s - card doesn't support sanit=
ize", __func__);
You should add the bio_free-like at here?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 atomic_set(&bb.done, 1);
> + =A0 =A0 =A0 bb.flags =3D 1 << BIO_UPTODATE;
> + =A0 =A0 =A0 bb.wait =3D &wait;
> +
> + =A0 =A0 =A0 bio->bi_end_io =3D bio_batch_end_io;
> + =A0 =A0 =A0 bio->bi_bdev =3D bdev;
> + =A0 =A0 =A0 bio->bi_private =3D &bb;
> +
> + =A0 =A0 =A0 atomic_inc(&bb.done);
> + =A0 =A0 =A0 submit_bio(type, bio);
> +
> + =A0 =A0 =A0 /* Wait for bios in-flight */
> + =A0 =A0 =A0 if (!atomic_dec_and_test(&bb.done))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion(&wait);
> +
> + =A0 =A0 =A0 if (!test_bit(BIO_UPTODATE, &bb.flags))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(blkdev_issue_sanitize);
> +
> =A0/**
> =A0* blkdev_issue_zeroout - generate number of zero filed write bios
> =A0* @bdev: =A0 =A0 =A0blockdev to issue
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index cfcc37c..f3ed15b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -383,6 +383,12 @@ static int attempt_merge(struct request_queue *q=
, struct request *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Don't merge file system requests and sanitize requ=
ests
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((req->cmd_flags & REQ_SANITIZE) !=3D (next->cmd_fla=
gs & REQ_SANITIZE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * not contiguous
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (blk_rq_pos(req) + blk_rq_sectors(req) !=3D blk_rq_=
pos(next))
> diff --git a/block/elevator.c b/block/elevator.c
> index 99838f4..4255dd9 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -88,6 +88,12 @@ int elv_rq_merge_ok(struct request *rq, struct bio=
 *bio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Don't merge sanitize requests
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if ((bio->bi_rw & REQ_SANITIZE) !=3D (rq->bio->bi_rw & =
REQ_SANITIZE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * different data direction or already started, don't =
merge
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (bio_data_dir(bio) !=3D rq_data_dir(rq))
> @@ -647,7 +653,7 @@ void __elv_add_request(struct request_queue *q, s=
truct request *rq, int where)
> =A0 =A0 =A0 =A0if (rq->cmd_flags & REQ_SOFTBARRIER) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* barriers are scheduling boundary, u=
pdate end_sector */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rq->cmd_type =3D=3D REQ_TYPE_FS ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq->cmd_flags & REQ_DISCARD)) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq->cmd_flags & (REQ_DISCARD |=
 REQ_SANITIZE))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->end_sector =3D rq_e=
nd_sector(rq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->boundary_rq =3D rq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> diff --git a/block/ioctl.c b/block/ioctl.c
> index ca939fc..112215d 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -132,6 +132,11 @@ static int blk_ioctl_discard(struct block_device=
 *bdev, uint64_t start,
> =A0 =A0 =A0 =A0return blkdev_issue_discard(bdev, start, len, GFP_KERN=
EL, flags);
> =A0}
>
> +static int blk_ioctl_sanitize(struct block_device *bdev)
> +{
> + =A0 =A0 =A0 return blkdev_issue_sanitize(bdev, GFP_KERNEL);
> +}
> +
> =A0static int put_ushort(unsigned long arg, unsigned short val)
> =A0{
> =A0 =A0 =A0 =A0return put_user(val, (unsigned short __user *)arg);
> @@ -216,6 +221,10 @@ int blkdev_ioctl(struct block_device *bdev, fmod=
e_t mode, unsigned cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_device_ro(bdev, n);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 case BLKSANITIZE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_ioctl_sanitize(bdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case BLKDISCARD:
> =A0 =A0 =A0 =A0case BLKSECDISCARD: {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint64_t range[2];
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 0c959c9..06561b9 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -868,18 +868,11 @@ static int mmc_blk_issue_secdiscard_rq(struct m=
mc_queue *mq,
> =A0 =A0 =A0 =A0unsigned int from, nr, arg;
> =A0 =A0 =A0 =A0int err =3D 0, type =3D MMC_BLK_SECDISCARD;
>
> - =A0 =A0 =A0 if (!(mmc_can_secure_erase_trim(card) || mmc_can_saniti=
ze(card))) {
> + =A0 =A0 =A0 if (!(mmc_can_secure_erase_trim(card))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EOPNOTSUPP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* The sanitize operation is supported at v4.5 only */
> - =A0 =A0 =A0 if (mmc_can_sanitize(card)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_SANITIZE_START, 1, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0from =3D blk_rq_pos(req);
> =A0 =A0 =A0 =A0nr =3D blk_rq_sectors(req);
>
> @@ -922,6 +915,40 @@ out:
> =A0 =A0 =A0 =A0return err ? 0 : 1;
> =A0}
>
> +int mmc_blk_issue_sanitize_rq(struct mmc_queue *mq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct r=
equest *req)
> +{
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (!(mmc_can_sanitize(card))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: SANITIZE is not supported",=
 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("%s: SANITIZE is supported", __func__);
> +
> + =A0 =A0 =A0 mmc_sd_card_set_sanitize_in_progress(card);
> +
> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_SANITIZE_START, 1, 0);
> +
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: mmcblk: mmc_switch() failed=
=2E err=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, err);
> +
> + =A0 =A0 =A0 mmc_sd_card_set_sanitize_completed(card);
> +
> +out:
> + =A0 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 __blk_end_request(req, err, blk_rq_bytes(req));
> + =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> +
> + =A0 =A0 =A0 return err ? 0 : 1;
> +}
> +
> =A0static int mmc_blk_issue_flush(struct mmc_queue *mq, struct reques=
t *req)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> @@ -1379,7 +1406,12 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (req && req->cmd_flags & REQ_DISCARD) {
> + =A0 =A0 =A0 if (req && req->cmd_flags & REQ_SANITIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* complete ongoing async transfer befo=
re issuing discard */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->host && card->host->areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_issue_rw_rq(mq,=
 NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_issue_sanitize_rq(mq, r=
eq);
> + =A0 =A0 =A0 } else if (req && req->cmd_flags & REQ_DISCARD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* complete ongoing async transfer bef=
ore issuing discard */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (card->host->areq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_issue_rw_rq(mq=
, NULL);
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index dcad59c..642a80d 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -140,7 +140,7 @@ static void mmc_queue_setup_discard(struct reques=
t_queue *q,
> =A0 =A0 =A0 =A0/* granularity must not be greater than max. discard *=
/
> =A0 =A0 =A0 =A0if (card->pref_erase > max_discard)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->limits.discard_granularity =3D 0;
> - =A0 =A0 =A0 if (mmc_can_secure_erase_trim(card) || mmc_can_sanitize=
(card))
> + =A0 =A0 =A0 if (mmc_can_secure_erase_trim(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_flag_set_unlocked(QUEUE_FLAG_SEC=
DISCARD, q);
Please add the QUEUE_FLAG_SANITIZE at here as other.
> =A0}
>
> @@ -181,6 +181,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct =
mmc_card *card,
> =A0 =A0 =A0 =A0if (mmc_can_erase(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_setup_discard(mq->queue, car=
d);
>
> + =A0 =A0 =A0 if (mmc_can_sanitize(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_flag_set_unlocked(QUEUE_FLAG_SANI=
TIZE, mq->queue);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s - card doesn't support sani=
tize", __func__);
Please move to it as above
> +
> =A0#ifdef CONFIG_MMC_BLOCK_BOUNCE
> =A0 =A0 =A0 =A0if (host->max_segs =3D=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int bouncesz;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 4053cbd..826c724 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -150,6 +150,7 @@ enum rq_flag_bits {
> =A0 =A0 =A0 =A0__REQ_FLUSH_SEQ, =A0 =A0 =A0 =A0/* request for flush s=
equence */
> =A0 =A0 =A0 =A0__REQ_IO_STAT, =A0 =A0 =A0 =A0 =A0/* account I/O stat =
*/
> =A0 =A0 =A0 =A0__REQ_MIXED_MERGE, =A0 =A0 =A0/* merge of different ty=
pes, fail separately */
> + =A0 =A0 =A0 __REQ_SANITIZE, =A0 =A0 =A0 =A0 /* sanitize */
> =A0 =A0 =A0 =A0__REQ_NR_BITS, =A0 =A0 =A0 =A0 =A0/* stops here */
> =A0};
>
> @@ -161,13 +162,15 @@ enum rq_flag_bits {
> =A0#define REQ_META =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_META)
> =A0#define REQ_PRIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_PRIO)
> =A0#define REQ_DISCARD =A0 =A0 =A0 =A0 =A0 =A0(1 << __REQ_DISCARD)
> +#define REQ_SANITIZE =A0 =A0 =A0 =A0 =A0 (1 << __REQ_SANITIZE)
> =A0#define REQ_NOIDLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_NOIDLE)
>
> =A0#define REQ_FAILFAST_MASK \
> =A0 =A0 =A0 =A0(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILF=
AST_DRIVER)
> =A0#define REQ_COMMON_MASK \
> =A0 =A0 =A0 =A0(REQ_WRITE | REQ_FAILFAST_MASK | REQ_SYNC | REQ_META |=
 REQ_PRIO | \
> - =A0 =A0 =A0 =A0REQ_DISCARD | REQ_NOIDLE | REQ_FLUSH | REQ_FUA | REQ=
_SECURE)
> + =A0 =A0 =A0 =A0REQ_DISCARD | REQ_NOIDLE | REQ_FLUSH | REQ_FUA | REQ=
_SECURE | \
> + =A0 =A0 =A0 =A0REQ_SANITIZE)
> =A0#define REQ_CLONE_MASK =A0 =A0 =A0 =A0 REQ_COMMON_MASK
>
> =A0#define REQ_RAHEAD =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_RAHEAD)
> @@ -192,4 +195,4 @@ enum rq_flag_bits {
> =A0#define REQ_MIXED_MERGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << __REQ=
_MIXED_MERGE)
> =A0#define REQ_SECURE =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_SECURE)
>
> -#endif /* __LINUX_BLK_TYPES_H */
> +#endif /* __LINUX_REQ__TYPES_H */
Why do you change this one?
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 7084318..1197c31 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -423,6 +423,7 @@ struct request_queue {
> =A0#define QUEUE_FLAG_ADD_RANDOM =A016 =A0 =A0 =A0/* Contributes to r=
andom pool */
> =A0#define QUEUE_FLAG_SECDISCARD =A017 =A0 =A0 =A0/* supports SECDISC=
ARD */
> =A0#define QUEUE_FLAG_SAME_FORCE =A018 =A0 =A0 =A0/* force complete o=
n same CPU */
> +#define QUEUE_FLAG_SANITIZE =A0 =A019 =A0 =A0 =A0/* supports SANITIZ=
E */
>
> =A0#define QUEUE_FLAG_DEFAULT =A0 =A0 ((1 << QUEUE_FLAG_IO_STAT) | =A0=
 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 QUEUE_FLAG_STACKABLE) =A0 =A0| =A0 =A0 =A0 \
> @@ -506,6 +507,7 @@ static inline void queue_flag_clear(unsigned int =
flag, struct request_queue *q)
> =A0#define blk_queue_stackable(q) \
> =A0 =A0 =A0 =A0test_bit(QUEUE_FLAG_STACKABLE, &(q)->queue_flags)
> =A0#define blk_queue_discard(q) =A0 test_bit(QUEUE_FLAG_DISCARD, &(q)=
->queue_flags)
> +#define blk_queue_sanitize(q) =A0test_bit(QUEUE_FLAG_SANITIZE, &(q)-=
>queue_flags)
> =A0#define blk_queue_secdiscard(q) =A0 =A0 =A0 =A0(blk_queue_discard(=
q) && \
> =A0 =A0 =A0 =A0test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flags))
>
> @@ -955,6 +957,7 @@ static inline struct request *blk_map_queue_find_=
tag(struct blk_queue_tag *bqt,
> =A0extern int blkdev_issue_flush(struct block_device *, gfp_t, sector=
_t *);
> =A0extern int blkdev_issue_discard(struct block_device *bdev, sector_=
t sector,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sector_t nr_sects, gfp_t gfp_mask, uns=
igned long flags);
> +extern int blkdev_issue_sanitize(struct block_device *bdev, gfp_t gf=
p_mask);
> =A0extern int blkdev_issue_zeroout(struct block_device *bdev, sector_=
t sector,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sector_t nr_sects, gfp=
_t gfp_mask);
> =A0static inline int sb_issue_discard(struct super_block *sb, sector_=
t block,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 057434a..3680eef 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -319,6 +319,7 @@ struct inodes_stat_t {
> =A0#define BLKPBSZGET _IO(0x12,123)
> =A0#define BLKDISCARDZEROES _IO(0x12,124)
> =A0#define BLKSECDISCARD _IO(0x12,125)
> +#define BLKSANITIZE _IO(0x12, 126)
>
> =A0#define BMAP_IOCTL 1 =A0 =A0 =A0 =A0 =A0 /* obsolete - kept for co=
mpatibility */
> =A0#define FIBMAP =A0 =A0_IO(0x00,1) =A0/* bmap access */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9478a6b..0890e9c 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -236,6 +236,9 @@ struct mmc_card {
> =A0#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 =A0 2
> =A0#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A03
>
> +/* card is in sanitize progress */
> +#define MMC_STATE_SANITIZE_IN_PROGRESS (1<<9)
> +
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0pref_erase; =A0 =A0=
 /* in sectors */
> @@ -388,6 +391,10 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSP=
EED_DDR)
> =A0#define mmc_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIGHSP=
EED)
> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIG=
HSPEED)
> +#define mmc_sd_card_set_sanitize_in_progress(c) ((c)->state |=3D \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_STATE_SANITIZE_IN_PROGRESS)
> +#define mmc_sd_card_set_sanitize_completed(c) ((c)->state &=3D \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~MMC_STATE_SANITIZE_IN_PROGRESS)
> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDX=
C)
> =A0#define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_REMOVED)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 16fc34a..2c2efc6 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1802,6 +1802,8 @@ void blk_fill_rwbs(char *rwbs, u32 rw, int byte=
s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'W';
> =A0 =A0 =A0 =A0else if (rw & REQ_DISCARD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'D';
> + =A0 =A0 =A0 else if (rw & REQ_SANITIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rwbs[i++] =3D 'Z';
> =A0 =A0 =A0 =A0else if (bytes)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'R';
> =A0 =A0 =A0 =A0else
> --
> 1.7.6
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
