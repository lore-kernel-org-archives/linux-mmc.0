From: "Yaniv Gardi" <ygardi@codeaurora.org>
Subject: RE: [PATCH V2] mmc: card: IOCTL support for Sanitize feature of eMMC v4.5
Date: Wed, 28 Dec 2011 17:42:13 +0200
Message-ID: <000301ccc577$466a8d70$d33fa850$@org>
References: <1324992782-1004-1-git-send-email-ygardi@codeaurora.org>	<1324992782-1004-2-git-send-email-ygardi@codeaurora.org> <CAH9JG2Uan6-EUmJo8gtGFEWUN-JKvtNnbZxYGqsXg49qEVpPtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAH9JG2Uan6-EUmJo8gtGFEWUN-JKvtNnbZxYGqsXg49qEVpPtQ@mail.gmail.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 'open list' <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kyungmin,

Probably I will split this patch into 2 dependent uploads.
Thanks,
Yaniv

=3D > -----Original Message-----
=3D > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
=3D > owner@vger.kernel.org] On Behalf Of Kyungmin Park
=3D > Sent: Tuesday, December 27, 2011 3:54 PM
=3D > To: Yaniv Gardi
=3D > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; ope=
n
=3D > list
=3D > Subject: Re: [PATCH V2] mmc: card: IOCTL support for Sanitize fea=
ture
=3D > of eMMC v4.5
=3D >=20
=3D > Hi Yaniv,
=3D >=20
=3D > You maybe split the patch into block and mmc parts.
=3D > Please see the comments inlined.
=3D >=20
=3D > Thank you,
=3D > Kyungmin Park
=3D >=20
=3D > On Tue, Dec 27, 2011 at 10:33 PM, Yaniv Gardi <ygardi@codeaurora.=
org>
=3D > wrote:
=3D > > Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
=3D > >
=3D > > ---
=3D > > =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0| =A0 15 ++++++++++--
=3D > > =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0 44
=3D > +++++++++++++++++++++++++++++++++++++++
=3D > > =A0block/blk-merge.c =A0 =A0 =A0 =A0 | =A0 =A06 +++++
=3D > > =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++++++-
=3D > > =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 ++++++++
=3D > > =A0drivers/mmc/card/block.c =A0| =A0 50
=3D > ++++++++++++++++++++++++++++++++++++--------
=3D > > =A0drivers/mmc/card/queue.c =A0| =A0 =A07 +++++-
=3D > > =A0include/linux/blk_types.h | =A0 =A07 ++++-
=3D > > =A0include/linux/blkdev.h =A0 =A0| =A0 =A03 ++
=3D > > =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0 =A01 +
=3D > > =A0include/linux/mmc/card.h =A0| =A0 =A07 ++++++
=3D > > =A0kernel/trace/blktrace.c =A0 | =A0 =A02 +
=3D > > =A012 files changed, 143 insertions(+), 16 deletions(-)
=3D > >
=3D > > diff --git a/block/blk-core.c b/block/blk-core.c
=3D > > index e6c05a9..e3512a4 100644
=3D > > --- a/block/blk-core.c
=3D > > +++ b/block/blk-core.c
=3D > > @@ -1544,7 +1544,7 @@ generic_make_request_checks(struct bio *b=
io)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto end_io;
=3D > > =A0 =A0 =A0 =A0}
=3D > >
=3D > > - =A0 =A0 =A0 if (unlikely(!(bio->bi_rw & REQ_DISCARD) &&
=3D > > + =A0 =A0 =A0 if (unlikely(!(bio->bi_rw & (REQ_DISCARD | REQ_SA=
NITIZE))
=3D > &&
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_sectors > queue_max_=
hw_sectors(q))) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "bio too big dev=
ice %s (%u > %u)\n",
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdevname(bio->bi_bd=
ev, b),
=3D > > @@ -1592,6 +1592,14 @@ generic_make_request_checks(struct bio *=
bio)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto end_io;
=3D > > =A0 =A0 =A0 =A0}
=3D > >
=3D > > + =A0 =A0 =A0 if ((bio->bi_rw & REQ_SANITIZE) &&
=3D > > + =A0 =A0 =A0 =A0 =A0 (!blk_queue_sanitize(q))) {
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s - SANITIZE request but=
 queue "
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"doesn't support s=
anitize", __func__);
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_io;
=3D > > + =A0 =A0 =A0 }
=3D > > +
=3D > > =A0 =A0 =A0 =A0if (blk_throtl_bio(q, bio))
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return false; =A0 /* throttled, =
will be resubmitted
=3D > later */
=3D > >
=3D > > @@ -1697,7 +1705,8 @@ void submit_bio(int rw, struct bio *bio)
=3D > > =A0 =A0 =A0 =A0 * If it's a regular read/write or a barrier wit=
h data
=3D > attached,
=3D > > =A0 =A0 =A0 =A0 * go through the normal accounting stuff before=
 submission.
=3D > > =A0 =A0 =A0 =A0 */
=3D > > - =A0 =A0 =A0 if (bio_has_data(bio) && !(rw & REQ_DISCARD)) {
=3D > > + =A0 =A0 =A0 if (bio_has_data(bio) &&
=3D > > + =A0 =A0 =A0 =A0 =A0 (!(rw & (REQ_DISCARD | REQ_SANITIZE)))) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rw & WRITE) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count_vm_events(=
PGPGOUT, count);
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
=3D > > @@ -1743,7 +1752,7 @@ EXPORT_SYMBOL(submit_bio);
=3D > > =A0*/
=3D > > =A0int blk_rq_check_limits(struct request_queue *q, struct requ=
est
=3D > *rq)
=3D > > =A0{
=3D > > - =A0 =A0 =A0 if (rq->cmd_flags & REQ_DISCARD)
=3D > > + =A0 =A0 =A0 if ((rq->cmd_flags & REQ_DISCARD) || (rq->cmd_fla=
gs &
=3D > REQ_SANITIZE))
=3D > (rq->cmd_flags & (REQ_DISCARD | REA_SANITIZE))?
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
=3D > >
=3D > > =A0 =A0 =A0 =A0if (blk_rq_sectors(rq) > queue_max_sectors(q) ||
=3D > > diff --git a/block/blk-lib.c b/block/blk-lib.c
=3D > > index 2b461b4..76ed930 100644
=3D > > --- a/block/blk-lib.c
=3D > > +++ b/block/blk-lib.c
=3D > > @@ -114,6 +114,50 @@ int blkdev_issue_discard(struct block_devi=
ce
=3D > *bdev, sector_t sector,
=3D > > =A0}
=3D > > =A0EXPORT_SYMBOL(blkdev_issue_discard);
=3D > >
=3D > > +int blkdev_issue_sanitize(struct block_device *bdev, gfp_t
=3D > gfp_mask)
=3D > > +{
=3D > > + =A0 =A0 =A0 DECLARE_COMPLETION_ONSTACK(wait);
=3D > > + =A0 =A0 =A0 struct request_queue *q =3D bdev_get_queue(bdev);
=3D > > + =A0 =A0 =A0 int type =3D REQ_WRITE | REQ_SANITIZE;
=3D > > +
=3D > > + =A0 =A0 =A0 struct bio_batch bb;
=3D > > + =A0 =A0 =A0 struct bio *bio;
=3D > > + =A0 =A0 =A0 int ret =3D 0;
=3D > > +
=3D > > + =A0 =A0 =A0 if (!q)
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
=3D > > +
=3D > > + =A0 =A0 =A0 bio =3D bio_alloc(gfp_mask, 1);
=3D > > + =A0 =A0 =A0 if (!bio)
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
=3D > > +
=3D > > + =A0 =A0 =A0 if (!blk_queue_sanitize(q)) {
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s - card doesn't support=
 sanitize",
=3D > __func__);
=3D > You should add the bio_free-like at here?
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
=3D > > + =A0 =A0 =A0 }
=3D > > +
=3D > > + =A0 =A0 =A0 atomic_set(&bb.done, 1);
=3D > > + =A0 =A0 =A0 bb.flags =3D 1 << BIO_UPTODATE;
=3D > > + =A0 =A0 =A0 bb.wait =3D &wait;
=3D > > +
=3D > > + =A0 =A0 =A0 bio->bi_end_io =3D bio_batch_end_io;
=3D > > + =A0 =A0 =A0 bio->bi_bdev =3D bdev;
=3D > > + =A0 =A0 =A0 bio->bi_private =3D &bb;
=3D > > +
=3D > > + =A0 =A0 =A0 atomic_inc(&bb.done);
=3D > > + =A0 =A0 =A0 submit_bio(type, bio);
=3D > > +
=3D > > + =A0 =A0 =A0 /* Wait for bios in-flight */
=3D > > + =A0 =A0 =A0 if (!atomic_dec_and_test(&bb.done))
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion(&wait);
=3D > > +
=3D > > + =A0 =A0 =A0 if (!test_bit(BIO_UPTODATE, &bb.flags))
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
=3D > > +
=3D > > + =A0 =A0 =A0 return ret;
=3D > > +}
=3D > > +EXPORT_SYMBOL(blkdev_issue_sanitize);
=3D > > +
=3D > > =A0/**
=3D > > =A0* blkdev_issue_zeroout - generate number of zero filed write=
 bios
=3D > > =A0* @bdev: =A0 =A0 =A0blockdev to issue
=3D > > diff --git a/block/blk-merge.c b/block/blk-merge.c
=3D > > index cfcc37c..f3ed15b 100644
=3D > > --- a/block/blk-merge.c
=3D > > +++ b/block/blk-merge.c
=3D > > @@ -383,6 +383,12 @@ static int attempt_merge(struct request_qu=
eue
=3D > *q, struct request *req,
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
=3D > >
=3D > > =A0 =A0 =A0 =A0/*
=3D > > + =A0 =A0 =A0 =A0* Don't merge file system requests and sanitiz=
e requests
=3D > > + =A0 =A0 =A0 =A0*/
=3D > > + =A0 =A0 =A0 if ((req->cmd_flags & REQ_SANITIZE) !=3D (next->c=
md_flags &
=3D > REQ_SANITIZE))
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
=3D > > +
=3D > > + =A0 =A0 =A0 /*
=3D > > =A0 =A0 =A0 =A0 * not contiguous
=3D > > =A0 =A0 =A0 =A0 */
=3D > > =A0 =A0 =A0 =A0if (blk_rq_pos(req) + blk_rq_sectors(req) !=3D
=3D > blk_rq_pos(next))
=3D > > diff --git a/block/elevator.c b/block/elevator.c
=3D > > index 99838f4..4255dd9 100644
=3D > > --- a/block/elevator.c
=3D > > +++ b/block/elevator.c
=3D > > @@ -88,6 +88,12 @@ int elv_rq_merge_ok(struct request *rq, stru=
ct
=3D > bio *bio)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
=3D > >
=3D > > =A0 =A0 =A0 =A0/*
=3D > > + =A0 =A0 =A0 =A0* Don't merge sanitize requests
=3D > > + =A0 =A0 =A0 =A0*/
=3D > > + =A0 =A0 =A0 if ((bio->bi_rw & REQ_SANITIZE) !=3D (rq->bio->bi=
_rw &
=3D > REQ_SANITIZE))
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
=3D > > +
=3D > > + =A0 =A0 =A0 /*
=3D > > =A0 =A0 =A0 =A0 * different data direction or already started, =
don't merge
=3D > > =A0 =A0 =A0 =A0 */
=3D > > =A0 =A0 =A0 =A0if (bio_data_dir(bio) !=3D rq_data_dir(rq))
=3D > > @@ -647,7 +653,7 @@ void __elv_add_request(struct request_queue=
 *q,
=3D > struct request *rq, int where)
=3D > > =A0 =A0 =A0 =A0if (rq->cmd_flags & REQ_SOFTBARRIER) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* barriers are scheduling bound=
ary, update
=3D > end_sector */
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rq->cmd_type =3D=3D REQ_TYPE=
_FS ||
=3D > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq->cmd_flags & REQ_DISC=
ARD)) {
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq->cmd_flags & (REQ_DIS=
CARD | REQ_SANITIZE)))
=3D > {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->end_sector =3D=
 rq_end_sector(rq);
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->boundary_rq =3D=
 rq;
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
=3D > > diff --git a/block/ioctl.c b/block/ioctl.c
=3D > > index ca939fc..112215d 100644
=3D > > --- a/block/ioctl.c
=3D > > +++ b/block/ioctl.c
=3D > > @@ -132,6 +132,11 @@ static int blk_ioctl_discard(struct
=3D > block_device *bdev, uint64_t start,
=3D > > =A0 =A0 =A0 =A0return blkdev_issue_discard(bdev, start, len, GF=
P_KERNEL,
=3D > flags);
=3D > > =A0}
=3D > >
=3D > > +static int blk_ioctl_sanitize(struct block_device *bdev)
=3D > > +{
=3D > > + =A0 =A0 =A0 return blkdev_issue_sanitize(bdev, GFP_KERNEL);
=3D > > +}
=3D > > +
=3D > > =A0static int put_ushort(unsigned long arg, unsigned short val)
=3D > > =A0{
=3D > > =A0 =A0 =A0 =A0return put_user(val, (unsigned short __user *)ar=
g);
=3D > > @@ -216,6 +221,10 @@ int blkdev_ioctl(struct block_device *bdev=
,
=3D > fmode_t mode, unsigned cmd,
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_device_ro(bdev, n);
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
=3D > >
=3D > > + =A0 =A0 =A0 case BLKSANITIZE:
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_ioctl_sanitize(bdev);
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
=3D > > +
=3D > > =A0 =A0 =A0 =A0case BLKDISCARD:
=3D > > =A0 =A0 =A0 =A0case BLKSECDISCARD: {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint64_t range[2];
=3D > > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.=
c
=3D > > index 0c959c9..06561b9 100644
=3D > > --- a/drivers/mmc/card/block.c
=3D > > +++ b/drivers/mmc/card/block.c
=3D > > @@ -868,18 +868,11 @@ static int mmc_blk_issue_secdiscard_rq(st=
ruct
=3D > mmc_queue *mq,
=3D > > =A0 =A0 =A0 =A0unsigned int from, nr, arg;
=3D > > =A0 =A0 =A0 =A0int err =3D 0, type =3D MMC_BLK_SECDISCARD;
=3D > >
=3D > > - =A0 =A0 =A0 if (!(mmc_can_secure_erase_trim(card) ||
=3D > mmc_can_sanitize(card))) {
=3D > > + =A0 =A0 =A0 if (!(mmc_can_secure_erase_trim(card))) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EOPNOTSUPP;
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
=3D > > =A0 =A0 =A0 =A0}
=3D > >
=3D > > - =A0 =A0 =A0 /* The sanitize operation is supported at v4.5 on=
ly */
=3D > > - =A0 =A0 =A0 if (mmc_can_sanitize(card)) {
=3D > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_=
CMD_SET_NORMAL,
=3D > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 E=
XT_CSD_SANITIZE_START, 1, 0);
=3D > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
=3D > > - =A0 =A0 =A0 }
=3D > > -
=3D > > =A0 =A0 =A0 =A0from =3D blk_rq_pos(req);
=3D > > =A0 =A0 =A0 =A0nr =3D blk_rq_sectors(req);
=3D > >
=3D > > @@ -922,6 +915,40 @@ out:
=3D > > =A0 =A0 =A0 =A0return err ? 0 : 1;
=3D > > =A0}
=3D > >
=3D > > +int mmc_blk_issue_sanitize_rq(struct mmc_queue *mq,
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
ruct request *req)
=3D > > +{
=3D > > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
=3D > > + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
=3D > > + =A0 =A0 =A0 int err =3D 0;
=3D > > +
=3D > > + =A0 =A0 =A0 if (!(mmc_can_sanitize(card))) {
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: SANITIZE is not suppo=
rted", __func__);
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EOPNOTSUPP;
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
=3D > > + =A0 =A0 =A0 }
=3D > > +
=3D > > + =A0 =A0 =A0 pr_debug("%s: SANITIZE is supported", __func__);
=3D > > +
=3D > > + =A0 =A0 =A0 mmc_sd_card_set_sanitize_in_progress(card);
=3D > > +
=3D > > + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0EXT_CSD_SANITIZE_START, 1,
=3D > 0);
=3D > > +
=3D > > + =A0 =A0 =A0 if (err)
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: mmcblk: mmc_switch() =
failed. err=3D%d\n",
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, err);
=3D > > +
=3D > > + =A0 =A0 =A0 mmc_sd_card_set_sanitize_completed(card);
=3D > > +
=3D > > +out:
=3D > > + =A0 =A0 =A0 spin_lock_irq(&md->lock);
=3D > > + =A0 =A0 =A0 __blk_end_request(req, err, blk_rq_bytes(req));
=3D > > + =A0 =A0 =A0 spin_unlock_irq(&md->lock);
=3D > > +
=3D > > + =A0 =A0 =A0 return err ? 0 : 1;
=3D > > +}
=3D > > +
=3D > > =A0static int mmc_blk_issue_flush(struct mmc_queue *mq, struct
=3D > request *req)
=3D > > =A0{
=3D > > =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
=3D > > @@ -1379,7 +1406,12 @@ static int mmc_blk_issue_rq(struct mmc_q=
ueue
=3D > *mq, struct request *req)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
=3D > > =A0 =A0 =A0 =A0}
=3D > >
=3D > > - =A0 =A0 =A0 if (req && req->cmd_flags & REQ_DISCARD) {
=3D > > + =A0 =A0 =A0 if (req && req->cmd_flags & REQ_SANITIZE) {
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* complete ongoing async transfe=
r before issuing
=3D > discard */
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->host && card->host->are=
q)
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_issue_rw_=
rq(mq, NULL);
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_issue_sanitize_rq=
(mq, req);
=3D > > + =A0 =A0 =A0 } else if (req && req->cmd_flags & REQ_DISCARD) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* complete ongoing async transf=
er before issuing
=3D > discard */
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (card->host->areq)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_issue_rw=
_rq(mq, NULL);
=3D > > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.=
c
=3D > > index dcad59c..642a80d 100644
=3D > > --- a/drivers/mmc/card/queue.c
=3D > > +++ b/drivers/mmc/card/queue.c
=3D > > @@ -140,7 +140,7 @@ static void mmc_queue_setup_discard(struct
=3D > request_queue *q,
=3D > > =A0 =A0 =A0 =A0/* granularity must not be greater than max. dis=
card */
=3D > > =A0 =A0 =A0 =A0if (card->pref_erase > max_discard)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q->limits.discard_granularity =3D=
 0;
=3D > > - =A0 =A0 =A0 if (mmc_can_secure_erase_trim(card) ||
=3D > mmc_can_sanitize(card))
=3D > > + =A0 =A0 =A0 if (mmc_can_secure_erase_trim(card))
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_flag_set_unlocked(QUEUE_FL=
AG_SECDISCARD, q);
=3D > Please add the QUEUE_FLAG_SANITIZE at here as other.
=3D > > =A0}
=3D > >
=3D > > @@ -181,6 +181,11 @@ int mmc_init_queue(struct mmc_queue *mq,
=3D > struct mmc_card *card,
=3D > > =A0 =A0 =A0 =A0if (mmc_can_erase(card))
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_setup_discard(mq->queu=
e, card);
=3D > >
=3D > > + =A0 =A0 =A0 if (mmc_can_sanitize(card))
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_flag_set_unlocked(QUEUE_FLA=
G_SANITIZE, mq-
=3D > >queue);
=3D > > + =A0 =A0 =A0 else
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s - card doesn't suppor=
t sanitize",
=3D > __func__);
=3D > Please move to it as above
=3D > > +
=3D > > =A0#ifdef CONFIG_MMC_BLOCK_BOUNCE
=3D > > =A0 =A0 =A0 =A0if (host->max_segs =3D=3D 1) {
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int bouncesz;
=3D > > diff --git a/include/linux/blk_types.h b/include/linux/blk_type=
s.h
=3D > > index 4053cbd..826c724 100644
=3D > > --- a/include/linux/blk_types.h
=3D > > +++ b/include/linux/blk_types.h
=3D > > @@ -150,6 +150,7 @@ enum rq_flag_bits {
=3D > > =A0 =A0 =A0 =A0__REQ_FLUSH_SEQ, =A0 =A0 =A0 =A0/* request for f=
lush sequence */
=3D > > =A0 =A0 =A0 =A0__REQ_IO_STAT, =A0 =A0 =A0 =A0 =A0/* account I/O=
 stat */
=3D > > =A0 =A0 =A0 =A0__REQ_MIXED_MERGE, =A0 =A0 =A0/* merge of differ=
ent types, fail
=3D > separately */
=3D > > + =A0 =A0 =A0 __REQ_SANITIZE, =A0 =A0 =A0 =A0 /* sanitize */
=3D > > =A0 =A0 =A0 =A0__REQ_NR_BITS, =A0 =A0 =A0 =A0 =A0/* stops here =
*/
=3D > > =A0};
=3D > >
=3D > > @@ -161,13 +162,15 @@ enum rq_flag_bits {
=3D > > =A0#define REQ_META =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_MET=
A)
=3D > > =A0#define REQ_PRIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_PRI=
O)
=3D > > =A0#define REQ_DISCARD =A0 =A0 =A0 =A0 =A0 =A0(1 << __REQ_DISCA=
RD)
=3D > > +#define REQ_SANITIZE =A0 =A0 =A0 =A0 =A0 (1 << __REQ_SANITIZE)
=3D > > =A0#define REQ_NOIDLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_NOIDL=
E)
=3D > >
=3D > > =A0#define REQ_FAILFAST_MASK \
=3D > > =A0 =A0 =A0 =A0(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
=3D > REQ_FAILFAST_DRIVER)
=3D > > =A0#define REQ_COMMON_MASK \
=3D > > =A0 =A0 =A0 =A0(REQ_WRITE | REQ_FAILFAST_MASK | REQ_SYNC | REQ_=
META |
=3D > REQ_PRIO | \
=3D > > - =A0 =A0 =A0 =A0REQ_DISCARD | REQ_NOIDLE | REQ_FLUSH | REQ_FUA=
 |
=3D > REQ_SECURE)
=3D > > + =A0 =A0 =A0 =A0REQ_DISCARD | REQ_NOIDLE | REQ_FLUSH | REQ_FUA=
 |
=3D > REQ_SECURE | \
=3D > > + =A0 =A0 =A0 =A0REQ_SANITIZE)
=3D > > =A0#define REQ_CLONE_MASK =A0 =A0 =A0 =A0 REQ_COMMON_MASK
=3D > >
=3D > > =A0#define REQ_RAHEAD =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_RAHEA=
D)
=3D > > @@ -192,4 +195,4 @@ enum rq_flag_bits {
=3D > > =A0#define REQ_MIXED_MERGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 __REQ_MIXED_MERGE)
=3D > > =A0#define REQ_SECURE =A0 =A0 =A0 =A0 =A0 =A0 (1 << __REQ_SECUR=
E)
=3D > >
=3D > > -#endif /* __LINUX_BLK_TYPES_H */
=3D > > +#endif /* __LINUX_REQ__TYPES_H */
=3D > Why do you change this one?
=3D > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
=3D > > index 7084318..1197c31 100644
=3D > > --- a/include/linux/blkdev.h
=3D > > +++ b/include/linux/blkdev.h
=3D > > @@ -423,6 +423,7 @@ struct request_queue {
=3D > > =A0#define QUEUE_FLAG_ADD_RANDOM =A016 =A0 =A0 =A0/* Contribute=
s to random
=3D > pool */
=3D > > =A0#define QUEUE_FLAG_SECDISCARD =A017 =A0 =A0 =A0/* supports S=
ECDISCARD */
=3D > > =A0#define QUEUE_FLAG_SAME_FORCE =A018 =A0 =A0 =A0/* force comp=
lete on same
=3D > CPU */
=3D > > +#define QUEUE_FLAG_SANITIZE =A0 =A019 =A0 =A0 =A0/* supports S=
ANITIZE */
=3D > >
=3D > > =A0#define QUEUE_FLAG_DEFAULT =A0 =A0 ((1 << QUEUE_FLAG_IO_STAT=
) |
=3D > =A0 =A0 =A0\
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1 << QUEUE_FLAG_STACKABLE) =A0 =A0|
=3D > =A0 =A0 \
=3D > > @@ -506,6 +507,7 @@ static inline void queue_flag_clear(unsigne=
d
=3D > int flag, struct request_queue *q)
=3D > > =A0#define blk_queue_stackable(q) \
=3D > > =A0 =A0 =A0 =A0test_bit(QUEUE_FLAG_STACKABLE, &(q)->queue_flags=
)
=3D > > =A0#define blk_queue_discard(q) =A0 test_bit(QUEUE_FLAG_DISCARD=
, &(q)-
=3D > >queue_flags)
=3D > > +#define blk_queue_sanitize(q) =A0test_bit(QUEUE_FLAG_SANITIZE,=
 &(q)-
=3D > >queue_flags)
=3D > > =A0#define blk_queue_secdiscard(q) =A0 =A0 =A0 =A0(blk_queue_di=
scard(q) && \
=3D > > =A0 =A0 =A0 =A0test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flag=
s))
=3D > >
=3D > > @@ -955,6 +957,7 @@ static inline struct request
=3D > *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
=3D > > =A0extern int blkdev_issue_flush(struct block_device *, gfp_t,
=3D > sector_t *);
=3D > > =A0extern int blkdev_issue_discard(struct block_device *bdev,
=3D > sector_t sector,
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sector_t nr_sects, gfp_t gfp_mas=
k, unsigned long
=3D > flags);
=3D > > +extern int blkdev_issue_sanitize(struct block_device *bdev, gf=
p_t
=3D > gfp_mask);
=3D > > =A0extern int blkdev_issue_zeroout(struct block_device *bdev,
=3D > sector_t sector,
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sector_t nr_sect=
s, gfp_t gfp_mask);
=3D > > =A0static inline int sb_issue_discard(struct super_block *sb,
=3D > sector_t block,
=3D > > diff --git a/include/linux/fs.h b/include/linux/fs.h
=3D > > index 057434a..3680eef 100644
=3D > > --- a/include/linux/fs.h
=3D > > +++ b/include/linux/fs.h
=3D > > @@ -319,6 +319,7 @@ struct inodes_stat_t {
=3D > > =A0#define BLKPBSZGET _IO(0x12,123)
=3D > > =A0#define BLKDISCARDZEROES _IO(0x12,124)
=3D > > =A0#define BLKSECDISCARD _IO(0x12,125)
=3D > > +#define BLKSANITIZE _IO(0x12, 126)
=3D > >
=3D > > =A0#define BMAP_IOCTL 1 =A0 =A0 =A0 =A0 =A0 /* obsolete - kept =
for
=3D > compatibility */
=3D > > =A0#define FIBMAP =A0 =A0_IO(0x00,1) =A0/* bmap access */
=3D > > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.=
h
=3D > > index 9478a6b..0890e9c 100644
=3D > > --- a/include/linux/mmc/card.h
=3D > > +++ b/include/linux/mmc/card.h
=3D > > @@ -236,6 +236,9 @@ struct mmc_card {
=3D > > =A0#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 =A0 2
=3D > > =A0#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A03
=3D > >
=3D > > +/* card is in sanitize progress */
=3D > > +#define MMC_STATE_SANITIZE_IN_PROGRESS (1<<9)
=3D > > +
=3D > > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =
=A0 =A0 /* erase size in
=3D > sectors */
=3D > > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift;=
 =A0 =A0/* if erase unit is
=3D > power 2 */
=3D > > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0pref_erase; =
=A0 =A0 /* in sectors */
=3D > > @@ -388,6 +391,10 @@ static inline void __maybe_unused
=3D > remove_quirk(struct mmc_card *card, int data)
=3D > > =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D
=3D > MMC_STATE_HIGHSPEED_DDR)
=3D > > =A0#define mmc_card_set_uhs(c) ((c)->state |=3D
=3D > MMC_STATE_ULTRAHIGHSPEED)
=3D > > =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D
=3D > MMC_STATE_ULTRAHIGHSPEED)
=3D > > +#define mmc_sd_card_set_sanitize_in_progress(c) ((c)->state |=3D=
 \
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_STATE_SANITIZE_IN_PROGRESS)
=3D > > +#define mmc_sd_card_set_sanitize_completed(c) ((c)->state &=3D=
 \
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~MMC_STATE_SANITIZE_IN_PROGRESS)
=3D > > =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CA=
RD_SDXC)
=3D > > =A0#define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_RE=
MOVED)
=3D > >
=3D > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
=3D > > index 16fc34a..2c2efc6 100644
=3D > > --- a/kernel/trace/blktrace.c
=3D > > +++ b/kernel/trace/blktrace.c
=3D > > @@ -1802,6 +1802,8 @@ void blk_fill_rwbs(char *rwbs, u32 rw, in=
t
=3D > bytes)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'W';
=3D > > =A0 =A0 =A0 =A0else if (rw & REQ_DISCARD)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'D';
=3D > > + =A0 =A0 =A0 else if (rw & REQ_SANITIZE)
=3D > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rwbs[i++] =3D 'Z';
=3D > > =A0 =A0 =A0 =A0else if (bytes)
=3D > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rwbs[i++] =3D 'R';
=3D > > =A0 =A0 =A0 =A0else
=3D > > --
=3D > > 1.7.6
=3D > > --
=3D > > Sent by a consultant of the Qualcomm Innovation Center, Inc.
=3D > > The Qualcomm Innovation Center, Inc. is a member of the Code Au=
rora
=3D > Forum
=3D > > --
=3D > > To unsubscribe from this list: send the line "unsubscribe linux=
-
=3D > mmc" in
=3D > > the body of a message to majordomo@vger.kernel.org
=3D > > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
=3D > --
=3D > To unsubscribe from this list: send the line "unsubscribe linux-m=
mc"
=3D > in
=3D > the body of a message to majordomo@vger.kernel.org
=3D > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
