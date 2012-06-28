From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH RESEND v7 2/3] mmc: core: Support packed write command for
 eMMC4.5 device
Date: Thu, 28 Jun 2012 18:42:49 +0900
Message-ID: <005601cd5512$61b1ffc0$2515ff40$%jun@samsung.com>
References: <007b01cd4d15$40673510$c1359f30$%jun@samsung.com>
 <001201cd52ac$368857d0$a3990770$@codeaurora.org>
 <001101cd534e$8a054c90$9e0fe5b0$%jun@samsung.com>
 <CAKLKtzd_Rhi+zEEG4K1tzNnqh6ZM4_V4T3RVPKKP6NwD7M2snA@mail.gmail.com>
 <004d01cd5502$ef3f48d0$cdbdda70$%jun@samsung.com>
 <002701cd550e$1d6cdff0$58469fd0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <002701cd550e$1d6cdff0$58469fd0$@codeaurora.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Saugata Das' <saugata.das@linaro.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "'S, Venkatraman'" <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,

Subhash Jadavani <subhashj@codeaurora.org> wrote:
> Hi Seugwon, Saugata,
>=20
> Here the actual large sector size support had one issue and anyway as=
 of now
> large sector size is not supported on any of the eMMC4.5 devices, whe=
reas
> the packed commands are already supported on eMMC4.5 chips so I would=
 prefer
> not to hold this patch for issue which is really not created in this =
patch.
>=20
> Is this ok?
That means you want to keep this issue and expect to apply your last co=
mment?

Your comment:
So for each entry (which is for each request) in packed command header,=
 you need to make sure that
sector count is in multiple of 8 for CMD23 argument and also CMD18/CMD2=
5 arguments (sector address)
must be 4KB aligned.

Thanks,
Seungwon Jeon

>=20
> Regards,
> Subhash
>=20
> > -----Original Message-----
> > From: Seungwon Jeon [mailto:tgih.jun@samsung.com]
> > Sent: Thursday, June 28, 2012 1:22 PM
> > To: 'Saugata Das'
> > Cc: 'Subhash Jadavani'; linux-mmc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; 'Chris Ball'; 'Maya Erez'; 'S, Venkatraman'
> > Subject: RE: [PATCH RESEND v7 2/3] mmc: core: Support packed write
> > command for eMMC4.5 device
> >
> > Saugata Das <saugata.das@linaro.org> wrote:
> > > On 26 June 2012 09:18, Seungwon Jeon <tgih.jun@samsung.com> wrote=
:
> > > > Hi Subhash,
> > > >
> > > > Subhash Jadavani <subhashj@codeaurora.org> wrote:
> > > >> Hi Seungwon,
> > > >>
> > > >> Please one comment inline below related to large sector size h=
andling
> for
> > packed commands.
> > > >>
> > > >> Regards,
> > > >> Subhash
> > > >>
> > > >> > -----Original Message-----
> > > >> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > >> > owner@vger.kernel.org] On Behalf Of Seungwon Jeon
> > > >> > Sent: Monday, June 18, 2012 11:13 AM
> > > >> > To: linux-mmc@vger.kernel.org
> > > >> > Cc: linux-kernel@vger.kernel.org; 'Chris Ball'; 'Maya Erez';
> > > >> > 'Subhash Jadavani'; 'S, Venkatraman'
> > > >> > Subject: [PATCH RESEND v7 2/3] mmc: core: Support packed wri=
te
> > > >> > command for eMMC4.5 device
> > > >> >
> > > >> > This patch supports packed write command of eMMC4.5 device.
> > > >> > Several writes can be grouped in packed command and all data=
 of
> > > >> > the individual commands can be sent in a single transfer on =
the
> bus.
> > > >> >
> > > >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > > >> > ---
> > > >> > =A0drivers/mmc/card/block.c =A0 | =A0406
> > > >> > +++++++++++++++++++++++++++++++++++++++++---
> > > >> > =A0drivers/mmc/card/queue.c =A0 | =A0 45 +++++-
> > > >> > =A0drivers/mmc/card/queue.h =A0 | =A0 12 ++
> > > >> > =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 +
> > > >> > =A0include/linux/mmc/core.h =A0 | =A0 =A04 +
> > > >> > =A05 files changed, 441 insertions(+), 27 deletions(-)
> > > >> >
> > > >> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/blo=
ck.c
> > > >> > index
> > > >> > 7e3f453..eb99e35 100644
> > > >> > --- a/drivers/mmc/card/block.c
> > > >> > +++ b/drivers/mmc/card/block.c
> > > >> > @@ -58,6 +58,12 @@ MODULE_ALIAS("mmc:block"); =A0#define
> > > >> > INAND_CMD38_ARG_SECTRIM1 0x81 =A0#define
> > INAND_CMD38_ARG_SECTRIM2
> > > >> > 0x88
> > > >> >
> > > >> > +#define mmc_req_rel_wr(req) =A0 =A0 =A0 =A0(((req->cmd_flag=
s & REQ_FUA)
> > > >> > +|| \
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_=
META)) && \
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D=
 WRITE)) #define
> > > >> > +PACKED_CMD_VER =A0 =A0 =A0 =A0 =A0 =A0 0x01 #define PACKED_=
CMD_WR
> > > >> > +0x02
> > > >> > +
> > > >> > =A0static DEFINE_MUTEX(block_mutex);
> > > >> >
> > > >> > =A0/*
> > > >> > @@ -123,9 +129,21 @@ enum mmc_blk_status {
> > > >> > =A0 =A0 MMC_BLK_NOMEDIUM,
> > > >> > =A0};
> > > >> >
> > > >> > +enum {
> > > >> > + =A0 MMC_PACKED_N_IDX =3D -1,
> > > >> > + =A0 MMC_PACKED_N_ZERO,
> > > >> > + =A0 MMC_PACKED_N_SINGLE,
> > > >> > +};
> > > >> > +
> > > >> > =A0module_param(perdev_minors, int, 0444);
> > > >> > MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate =
per
> > > >> > device");
> > > >> >
> > > >> > +static inline void mmc_blk_clear_packed(struct mmc_queue_re=
q
> > > >> > +*mqrq) {
> > > >> > + =A0 mqrq->packed_cmd =3D MMC_PACKED_NONE;
> > > >> > + =A0 mqrq->packed_num =3D MMC_PACKED_N_ZERO; }
> > > >> > +
> > > >> > =A0static struct mmc_blk_data *mmc_blk_get(struct gendisk *d=
isk) =A0{
> > > >> > =A0 =A0 struct mmc_blk_data *md;
> > > >> > @@ -1081,12 +1099,61 @@ static int mmc_blk_err_check(struct
> > > >> > mmc_card *card,
> > > >> > =A0 =A0 if (!brq->data.bytes_xfered)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_RETRY;
> > > >> >
> > > >> > + =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks << 9 !=3D
> > > >> > + brq->data.bytes_xfered))
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PARTIAL=
;
> > > >> > + =A0 =A0 =A0 =A0 =A0 else
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_SUCCESS=
;
> > > >> > + =A0 }
> > > >> > +
> > > >> > =A0 =A0 if (blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PARTIAL;
> > > >> >
> > > >> > =A0 =A0 return MMC_BLK_SUCCESS;
> > > >> > =A0}
> > > >> >
> > > >> > +static int mmc_blk_packed_err_check(struct mmc_card *card,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_async_req *areq) {
> > > >> > + =A0 struct mmc_queue_req *mq_rq =3D container_of(areq, str=
uct
> > > >> > mmc_queue_req,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> > > >> > + =A0 struct request *req =3D mq_rq->req;
> > > >> > + =A0 int err, check, status;
> > > >> > + =A0 u8 ext_csd[512];
> > > >> > +
> > > >> > + =A0 mq_rq->packed_retries--;
> > > >> > + =A0 check =3D mmc_blk_err_check(card, areq);
> > > >> > + =A0 err =3D get_card_status(card, &status, 0);
> > > >> > + =A0 if (err) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 pr_err("%s: error %d sending status co=
mmand\n",
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->r=
q_disk->disk_name, err);
> > > >> > + =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 if (status & R1_EXP_EVENT) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd=
);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (err) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: error %d s=
ending ext_csd\n",
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req->rq_disk->disk_name,
> > > >> > + err);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS=
] &
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PACKED_FAILURE) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_c=
sd[EXT_CSD_PACKED_CMD_STATUS] &
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_PACKED_GENERIC_ERROR)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_PA=
CKED_CMD_STATUS] &
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PACKED_INDEXED_ERROR)
> > > >> > + {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq-=
>packed_fail_idx =3D
> > > >> > +
> > > >> > + ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] -
> > > >> > 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 MMC_BLK_PARTIAL;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 return check;
> > > >> > +}
> > > >> > +
> > > >> > =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq=
,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t mmc_card *card,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int d=
isable_multi, @@ -1241,10
> > > >> > +1308,197 @@ static void mmc_blk_rw_rq_prep(struct
> > mmc_queue_req
> > > >> > *mqrq,
> > > >> > =A0 =A0 mmc_queue_bounce_pre(mqrq);
> > > >> > =A0}
> > > >> >
> > > >> > +static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, st=
ruct
> > > >> > +request
> > > >> > +*req) {
> > > >> > + =A0 struct request_queue *q =3D mq->queue;
> > > >> > + =A0 struct mmc_card *card =3D mq->card;
> > > >> > + =A0 struct request *cur =3D req, *next =3D NULL;
> > > >> > + =A0 struct mmc_blk_data *md =3D mq->data;
> > > >> > + =A0 bool en_rel_wr =3D card->ext_csd.rel_param &
> > > >> > EXT_CSD_WR_REL_PARAM_EN;
> > > >> > + =A0 unsigned int req_sectors =3D 0, phys_segments =3D 0;
> > > >> > + =A0 unsigned int max_blk_count, max_phys_segs;
> > > >> > + =A0 u8 put_back =3D 0;
> > > >> > + =A0 u8 max_packed_rw =3D 0;
> > > >> > + =A0 u8 reqs =3D 0;
> > > >> > +
> > > >> > + =A0 mmc_blk_clear_packed(mq->mqrq_cur);
> > > >> > +
> > > >> > + =A0 if (!(md->flags & MMC_BLK_CMD23) ||
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.packed_=
event_en)
> > > >> > + =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > > >> > +
> > > >> > + =A0 if ((rq_data_dir(cur) =3D=3D WRITE) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->host->caps2 & M=
MC_CAP2_PACKED_WR))
> > > >> > + =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.max_pa=
cked_writes;
> > > >> > +
> > > >> > + =A0 if (max_packed_rw =3D=3D 0)
> > > >> > + =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > > >> > +
> > > >> > + =A0 if (mmc_req_rel_wr(cur) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MMC_BLK_R=
EL_WR) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 max_blk_count =3D min(card->host->max_blk_count,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->max_req_si=
ze >> 9);
> > > >> > + =A0 if (unlikely(max_blk_count > 0xffff))
> > > >> > + =A0 =A0 =A0 =A0 =A0 max_blk_count =3D 0xffff;
> > > >> > +
> > > >> > + =A0 max_phys_segs =3D queue_max_segments(q);
> > > >> > + =A0 req_sectors +=3D blk_rq_sectors(cur);
> > > >> > + =A0 phys_segments +=3D cur->nr_phys_segments;
> > > >> > +
> > > >> > + =A0 if (rq_data_dir(cur) =3D=3D WRITE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 req_sectors++;
> > > >> > + =A0 =A0 =A0 =A0 =A0 phys_segments++;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 while (reqs < max_packed_rw - 1) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> > > >> > + =A0 =A0 =A0 =A0 =A0 next =3D blk_fetch_request(q);
> > > >> > + =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (!next)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (next->cmd_flags & REQ_DISCARD ||
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next->=
cmd_flags & REQ_FLUSH) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(cur) !=3D rq_data_dir(=
next)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (mmc_req_rel_wr(next) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->f=
lags & MMC_BLK_REL_WR) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_re=
l_wr) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(next);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (req_sectors > max_blk_count) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_phys_se=
gments;
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_segs) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 list_add_tail(&next->queuelist,
> > > >> > + &mq->mqrq_cur->packed_list);
> > > >> > + =A0 =A0 =A0 =A0 =A0 cur =3D next;
> > > >> > + =A0 =A0 =A0 =A0 =A0 reqs++;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 if (put_back) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> > > >> > + =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, next);
> > > >> > + =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 if (reqs > 0) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist,
> > > >> > + &mq->mqrq_cur->packed_list);
> > > >> > + =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->packed_num =3D ++reqs;
> > > >> > + =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->packed_retries =3D reqs;
> > > >> > + =A0 =A0 =A0 =A0 =A0 return reqs;
> > > >> > + =A0 }
> > > >> > +
> > > >> > +no_packed:
> > > >> > + =A0 mmc_blk_clear_packed(mq->mqrq_cur);
> > > >> > + =A0 return 0;
> > > >> > +}
> > > >> > +
> > > >> > +static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_re=
q
> > > >> > +*mqrq,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct mmc_card *card,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct mmc_queue *mq) {
> > > >> > + =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> > > >> > + =A0 struct request *req =3D mqrq->req;
> > > >> > + =A0 struct request *prq;
> > > >> > + =A0 struct mmc_blk_data *md =3D mq->data;
> > > >> > + =A0 bool do_rel_wr, do_data_tag;
> > > >> > + =A0 u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
> > > >> > + =A0 u8 i =3D 1;
> > > >> > +
> > > >> > + =A0 mqrq->packed_cmd =3D MMC_PACKED_WRITE;
> > > >> > + =A0 mqrq->packed_blocks =3D 0;
> > > >> > + =A0 mqrq->packed_fail_idx =3D MMC_PACKED_N_IDX;
> > > >> > +
> > > >> > + =A0 memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_cmd_hdr)=
);
> > > >> > + =A0 packed_cmd_hdr[0] =3D (mqrq->packed_num << 16) |
> > > >> > + =A0 =A0 =A0 =A0 =A0 (PACKED_CMD_WR << 8) | PACKED_CMD_VER;
> > > >> > +
> > > >> > + =A0 /*
> > > >> > + =A0 =A0* Argument for each entry of packed group
> > > >> > + =A0 =A0*/
> > > >> > + =A0 list_for_each_entry(prq, &mqrq->packed_list, queuelist=
) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 do_rel_wr =3D mmc_req_rel_wr(prq) && (=
md->flags &
> > > >> > MMC_BLK_REL_WR);
> > > >> > + =A0 =A0 =A0 =A0 =A0 do_data_tag =3D (card->ext_csd.data_ta=
g_unit_size) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (prq->cmd_flags & REQ_=
META) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(prq) =3D=3D=
 WRITE) &&
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * b=
rq->data.blksz) >=3D
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_=
tag_unit_size);
> > > >> > + =A0 =A0 =A0 =A0 =A0 /* Argument of CMD23 */
> > > >> > + =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[(i * 2)] =3D
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? MMC_CMD23=
_ARG_REL_WR : 0) |
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_data_tag ? MMC_CMD=
23_ARG_TAG_REQ : 0) |
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_sectors(prq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 /* Argument of CMD18 or CMD25 */
> > > >> > + =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[((i * 2)) + 1] =3D
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_blockaddr(car=
d) ?
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(prq) : blk_=
rq_pos(prq) << 9;
> > > >> > + =A0 =A0 =A0 =A0 =A0 mqrq->packed_blocks +=3D blk_rq_sector=
s(prq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 i++;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> > > >> > + =A0 brq->mrq.cmd =3D &brq->cmd;
> > > >> > + =A0 brq->mrq.data =3D &brq->data;
> > > >> > + =A0 brq->mrq.sbc =3D &brq->sbc;
> > > >> > + =A0 brq->mrq.stop =3D &brq->stop;
> > > >> > +
> > > >> > + =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> > > >> > + =A0 brq->sbc.arg =3D MMC_CMD23_ARG_PACKED | (mqrq->packed_=
blocks
> > +
> > > >> > 1);
> > > >> > + =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > > >> > +
> > > >> > + =A0 brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> > > >> > + =A0 brq->cmd.arg =3D blk_rq_pos(req);
> > > >> > + =A0 if (!mmc_card_blockaddr(card))
> > > >> > + =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> > > >> > + =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> > > >> > MMC_CMD_ADTC;
> > > >> > +
> > > >> > + =A0 brq->data.blksz =3D 512;
> > > >> > + =A0 brq->data.blocks =3D mqrq->packed_blocks + 1;
> > > >> > + =A0 brq->data.flags |=3D MMC_DATA_WRITE;
> > > >> > +
> > > >> > + =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> > > >> > + =A0 brq->stop.arg =3D 0;
> > > >> > + =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > > >> > MMC_CMD_AC;
> > > >> > +
> > > >> > + =A0 mmc_set_data_timeout(&brq->data, card);
> > > >> > +
> > > >> > + =A0 brq->data.sg =3D mqrq->sg;
> > > >> > + =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> > > >> > +
> > > >> > + =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> > > >> > + =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_err_chec=
k;
> > > >> > +
> > > >> > + =A0 mmc_queue_bounce_pre(mqrq);
> > > >> > +}
> > > >> > +
> > > >> > =A0static int mmc_blk_cmd_err(struct mmc_blk_data *md, struc=
t
> > > >> > mmc_card *card,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_bl=
k_request *brq, struct
> > > >> > request *req,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ret)
> > > >> > =A0{
> > > >> > + =A0 struct mmc_queue_req *mq_rq;
> > > >> > + =A0 mq_rq =3D container_of(brq, struct mmc_queue_req, brq)=
;
> > > >> > +
> > > >> > =A0 =A0 /*
> > > >> > =A0 =A0 =A0* If this is an SD card and we're writing, we can=
 first
> > > >> > =A0 =A0 =A0* mark the known good sectors as ok.
> > > >> > @@ -1261,10 +1515,73 @@ static int mmc_blk_cmd_err(struct
> > > >> > mmc_blk_data *md, struct mmc_card *card,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_requ=
est(req, 0, blocks << 9);
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > =A0 =A0 } else {
> > > >> > - =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_request(req, 0,
> > > >> > brq->data.bytes_xfered);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_cmd =3D=3D MMC_PACKE=
D_NONE)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_reques=
t(req, 0,
> > > >> > +brq->data.bytes_xfered);
> > > >> > + =A0 }
> > > >> > + =A0 return ret;
> > > >> > +}
> > > >> > +
> > > >> > +static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_=
rq) {
> > > >> > + =A0 struct request *prq;
> > > >> > + =A0 int idx =3D mq_rq->packed_fail_idx, i =3D 0;
> > > >> > + =A0 int ret =3D 0;
> > > >> > +
> > > >> > + =A0 while (!list_empty(&mq_rq->packed_list)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_li=
st.next);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (idx =3D=3D i) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* retry from error in=
dex */
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->packed_num -=3D=
 idx;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->req =3D prq;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_num =
=3D=3D MMC_PACKED_N_SINGLE)
> > > >> > {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_d=
el_init(&prq->queuelist);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_bl=
k_clear_packed(mq_rq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > + =A0 =A0 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> > > >> > + =A0 =A0 =A0 =A0 =A0 blk_end_request(prq, 0, blk_rq_bytes(p=
rq));
> > > >> > + =A0 =A0 =A0 =A0 =A0 i++;
> > > >> > =A0 =A0 }
> > > >> > +
> > > >> > + =A0 mmc_blk_clear_packed(mq_rq);
> > > >> > =A0 =A0 return ret;
> > > >> > =A0}
> > > >> > +static void mmc_blk_abort_packed_req(struct mmc_queue_req
> > > >> > +*mq_rq) {
> > > >> > + =A0 struct request *prq;
> > > >> > +
> > > >> > + =A0 while (!list_empty(&mq_rq->packed_list)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_li=
st.next);
> > > >> > + =A0 =A0 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> > > >> > + =A0 =A0 =A0 =A0 =A0 blk_end_request(prq, -EIO, blk_rq_byte=
s(prq));
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 mmc_blk_clear_packed(mq_rq);
> > > >> > +}
> > > >> > +
> > > >> > +static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct mmc_queue_req *mq_rq) {
> > > >> > + =A0 struct request *prq;
> > > >> > + =A0 struct request_queue *q =3D mq->queue;
> > > >> > +
> > > >> > + =A0 while (!list_empty(&mq_rq->packed_list)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_li=
st.prev);
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (prq->queuelist.prev !=3D &mq_rq->p=
acked_list) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&prq->qu=
euelist);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue=
_lock);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(mq=
->queue, prq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->que=
ue_lock);
> > > >> > + =A0 =A0 =A0 =A0 =A0 } else {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&prq->qu=
euelist);
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 mmc_blk_clear_packed(mq_rq);
> > > >> > +}
> > > >> >
> > > >> > =A0static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, stru=
ct
> > > >> > request *rqc) { @@ -1276,23 +1593,35 @@ static int
> > > >> > mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rq=
c)
> > > >> > =A0 =A0 struct mmc_queue_req *mq_rq;
> > > >> > =A0 =A0 struct request *req =3D rqc;
> > > >> > =A0 =A0 struct mmc_async_req *areq;
> > > >> > + =A0 const u8 packed_num =3D 2;
> > > >> > + =A0 u8 reqs =3D 0;
> > > >> >
> > > >> > =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > > >> >
> > > >> > + =A0 if (rqc) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 /*
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0* When 4KB native sector is enabled=
, only 8 blocks
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0* multiple read or write is allowed
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > + =A0 =A0 =A0 =A0 =A0 if ((brq->data.blocks & 0x07) &&
> > > >>
> > > >> What will be the value of "brq->data.blocks" here? I don't thi=
nk
> > > >> this has been even initialized
> > > here.
> > > > Right, "brq->data.blocks" doesn't have the value.
> > > > This have been already introduced in "mmc: block: Allow disabli=
ng 512B
> > sector size emulation"
> > > > but it seems to have the same problem. I'll fix this for next v=
ersion.
> > >
> > > Thanks for pointing it out.
> > >
> > > Should I submit the correction for this part separately (changing
> > > (brq->data.blocks & 0x07) to (blk_rq_sectors(req) & 0x07) ?
> > Course you can. I'm waiting.
> >
> > Thanks,
> > Seungwon Jeon
> > >
> > >
> > > >
> > > >> Also this is what specification (6.6.30.2 =A0Native 4KB sector
> > > >> behavior) mandates for large sector
> > > size
> > > >> native:
> > > >> =A0 =A0 =A0 - Sector counts shall be multiples of 8 (4KB), e.g=
=2E in
> > > >> SET_BLOCK_COUNT (CMD23), and CORRECTLY_PRG_SECTORS_NUM field
> > in
> > > >> EXT_CSD
> > > >> =A0 =A0 =A0 - Arguments for read commands (CMD17/18) and write=
 commands
> > > >> (CMD24/25) shall always be aligned to 8 (4KB)
> > > >>
> > > >> So for each entry (which is for each request) in packed comman=
d
> > > >> header, you need to make sure that sector count is in multiple=
 of 8
> > > >> for CMD23 argument and also CMD18/CMD25 arguments (sector
> > address) must be 4KB aligned.
> > > > I'll also apply this.
> > > >
> > > > Best regard,
> > > > Seungwon Jeon
> > > >>
> > > >> Regards,
> > > >> Subhash
> > > >>
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card-=
>ext_csd.data_sector_size =3D=3D
> > > >> > + 4096)) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Transfer s=
ize is not 4KB sector
> > > >> > + size
> > > >> > aligned\n",
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req->rq_disk->disk_name);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq =3D mq->mqrq_cur=
;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_abort;
> > > >> > + =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_prep_packed_list(mq, =
rqc);
> > > >> > + =A0 }
> > > >> > +
> > > >> > =A0 =A0 do {
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 if (rqc) {
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* When 4KB native s=
ector is enabled, only 8
> > > >> > blocks
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* multiple read or =
write is allowed
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((brq->data.blocks =
& 0x07) &&
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd=
=2Edata_sector_size =3D=3D 4096))
> > > >> > {
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err=
("%s: Transfer size is not 4KB
> > > >> > sector size aligned\n",
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req->rq_disk->disk_name);
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto c=
md_abort;
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq-=
>mqrq_cur, card, 0,
> > > >> > mq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs >=3D packed_n=
um)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_bl=
k_packed_hdr_wrq_prep(mq-
> > > >> > >mqrq_cur,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 card, mq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_bl=
k_rw_rq_prep(mq->mqrq_cur,
> > > >> > + card, 0,
> > > >> > mq);
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D &mq->mqrq_c=
ur->mmc_active;
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 } else
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D NULL;
> > > >> > @@ -1313,8 +1642,15 @@ static int mmc_blk_issue_rw_rq(struct
> > > >> > mmc_queue *mq, struct request *rqc)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A block was suc=
cessfully transferred.
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_reset_succes=
s(md, type);
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_reques=
t(req, 0,
> > > >> > +
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_cmd =
!=3D MMC_PACKED_NONE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 mmc_blk_end_packed_req(mq_rq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 blk_end_request(req, 0,
> > > >> >
> > > >> > brq->data.bytes_xfered);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > +
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the blk_end_=
request function returns
> > > >> > non-zero even
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* though all data=
 has been transferred and
> > > >> > no errors @@ -1347,7 +1683,8 @@ static int
> > > >> > mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rq=
c)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_blk_rese=
t(md, card->host, type);
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brea=
k;
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err =3D=3D -ENODEV=
)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err =3D=3D -ENODEV=
 ||
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq-=
>packed_cmd !=3D
> > > >> > MMC_PACKED_NONE)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto=
 cmd_abort;
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fall through */
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > @@ -1374,25 +1711,46 @@ static int mmc_blk_issue_rw_rq(struc=
t
> > > >> > mmc_queue *mq, struct request *rqc)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> >
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case of a inco=
mplete request
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prepare it again =
and resend.
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq_=
rq, card,
> > > >> > disable_multi, mq);
> > > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->ho=
st, &mq_rq->mmc_active,
> > > >> > NULL);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_cmd =
=3D=3D MMC_PACKED_NONE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* I=
n case of a incomplete request
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* p=
repare it again and resend.
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_bl=
k_rw_rq_prep(mq_rq, card,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 disable_multi, mq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_st=
art_req(card->host,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &mq_rq->mmc_active,
> > > >> > + NULL);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!m=
q_rq->packed_retries)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 goto cmd_abort;
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_bl=
k_packed_hdr_wrq_prep(mq_rq,
> > > >> > + card,
> > > >> > mq);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_st=
art_req(card->host,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &mq_rq->mmc_active,
> > > >> > + NULL);
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 }
> > > >> > =A0 =A0 } while (ret);
> > > >> >
> > > >> > =A0 =A0 return 1;
> > > >> >
> > > >> > =A0 cmd_abort:
> > > >> > - =A0 if (mmc_card_removed(card))
> > > >> > - =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D REQ_QUIET;
> > > >> > - =A0 while (ret)
> > > >> > - =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_request(req, -EIO,
> > > >> > blk_rq_cur_bytes(req));
> > > >> > + =A0 if (mq_rq->packed_cmd =3D=3D MMC_PACKED_NONE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (mmc_card_removed(card))
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D RE=
Q_QUIET;
> > > >> > + =A0 =A0 =A0 =A0 =A0 while (ret)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blk_end_reques=
t(req, -EIO,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 blk_rq_cur_bytes(req));
> > > >> > + =A0 } else {
> > > >> > + =A0 =A0 =A0 =A0 =A0 mmc_blk_abort_packed_req(mq_rq);
> > > >> > + =A0 }
> > > >> >
> > > >> > =A0 start_new_req:
> > > >> > =A0 =A0 if (rqc) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 /*
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0* If current request is packed, it =
needs to put back.
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0*/
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (mq->mqrq_cur->packed_cmd !=3D MMC_=
PACKED_NONE)
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_revert_packed_=
req(mq, mq->mqrq_cur);
> > > >> > +
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, car=
d, 0, mq);
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->host, &mq->mqrq_=
cur->mmc_active,
> > > >> > NULL);
> > > >> > =A0 =A0 }
> > > >> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/que=
ue.c
> > > >> > index e360a97..165d85a 100644
> > > >> > --- a/drivers/mmc/card/queue.c
> > > >> > +++ b/drivers/mmc/card/queue.c
> > > >> > @@ -175,6 +175,9 @@ int mmc_init_queue(struct mmc_queue *mq,
> > > >> > struct mmc_card *card,
> > > >> > =A0 =A0 if (!mq->queue)
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > > >> >
> > > >> > + =A0 INIT_LIST_HEAD(&mqrq_cur->packed_list);
> > > >> > + =A0 INIT_LIST_HEAD(&mqrq_prev->packed_list);
> > > >> > +
> > > >> > =A0 =A0 mq->mqrq_cur =3D mqrq_cur;
> > > >> > =A0 =A0 mq->mqrq_prev =3D mqrq_prev;
> > > >> > =A0 =A0 mq->queue->queuedata =3D mq;
> > > >> > @@ -375,6 +378,35 @@ void mmc_queue_resume(struct mmc_queue
> > *mq)
> > > >> > =A0 =A0 }
> > > >> > =A0}
> > > >> >
> > > >> > +static unsigned int mmc_queue_packed_map_sg(struct mmc_queu=
e
> > > >> > +*mq,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct mmc_queue_req
> > > >> > +*mqrq,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct scatterlist *sg) {
> > > >> > + =A0 struct scatterlist *__sg;
> > > >> > + =A0 unsigned int sg_len =3D 0;
> > > >> > + =A0 struct request *req;
> > > >> > + =A0 enum mmc_packed_cmd cmd;
> > > >> > +
> > > >> > + =A0 cmd =3D mqrq->packed_cmd;
> > > >> > +
> > > >> > + =A0 if (cmd =3D=3D MMC_PACKED_WRITE) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 __sg =3D sg;
> > > >> > + =A0 =A0 =A0 =A0 =A0 sg_set_buf(__sg, mqrq->packed_cmd_hdr,
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof=
(mqrq->packed_cmd_hdr));
> > > >> > + =A0 =A0 =A0 =A0 =A0 sg_len++;
> > > >> > + =A0 =A0 =A0 =A0 =A0 __sg->page_link &=3D ~0x02;
> > > >> > + =A0 }
> > > >> > +
> > > >> > + =A0 __sg =3D sg + sg_len;
> > > >> > + =A0 list_for_each_entry(req, &mqrq->packed_list, queuelist=
) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 sg_len +=3D blk_rq_map_sg(mq->queue, r=
eq, __sg);
> > > >> > + =A0 =A0 =A0 =A0 =A0 __sg =3D sg + (sg_len - 1);
> > > >> > + =A0 =A0 =A0 =A0 =A0 (__sg++)->page_link &=3D ~0x02;
> > > >> > + =A0 }
> > > >> > + =A0 sg_mark_end(sg + (sg_len - 1));
> > > >> > + =A0 return sg_len;
> > > >> > +}
> > > >> > +
> > > >> > =A0/*
> > > >> > =A0 * Prepare the sg list(s) to be handed of to the host dri=
ver
> > > >> > =A0 */
> > > >> > @@ -385,12 +417,19 @@ unsigned int mmc_queue_map_sg(struct
> > > >> > mmc_queue *mq, struct mmc_queue_req *mqrq)
> > > >> > =A0 =A0 struct scatterlist *sg;
> > > >> > =A0 =A0 int i;
> > > >> >
> > > >> > - =A0 if (!mqrq->bounce_buf)
> > > >> > - =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(mq->queue, mqrq->=
req, mqrq->sg);
> > > >> > + =A0 if (!mqrq->bounce_buf) {
> > > >> > + =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list))
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_queue_packe=
d_map_sg(mq, mqrq,
> > > >> > + mqrq-
> > > >> > >sg);
> > > >> > + =A0 =A0 =A0 =A0 =A0 else
> > > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(m=
q->queue, mqrq->req,
> > > >> > + mqrq-
> > > >> > >sg);
> > > >> > + =A0 }
> > > >> >
> > > >> > =A0 =A0 BUG_ON(!mqrq->bounce_sg);
> > > >> >
> > > >> > - =A0 sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req,
> > > >> > mqrq->bounce_sg);
> > > >> > + =A0 if (!list_empty(&mqrq->packed_list))
> > > >> > + =A0 =A0 =A0 =A0 =A0 sg_len =3D mmc_queue_packed_map_sg(mq,=
 mqrq, mqrq-
> > > >> > >bounce_sg);
> > > >> > + =A0 else
> > > >> > + =A0 =A0 =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue, mq=
rq->req, mqrq-
> > > >> > >bounce_sg);
> > > >> >
> > > >> > =A0 =A0 mqrq->bounce_sg_len =3D sg_len;
> > > >> >
> > > >> > diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/que=
ue.h
> > > >> > index
> > > >> > d2a1eb4..5e04938 100644
> > > >> > --- a/drivers/mmc/card/queue.h
> > > >> > +++ b/drivers/mmc/card/queue.h
> > > >> > @@ -12,6 +12,11 @@ struct mmc_blk_request {
> > > >> > =A0 =A0 struct mmc_data =A0 =A0 =A0 =A0 data;
> > > >> > =A0};
> > > >> >
> > > >> > +enum mmc_packed_cmd {
> > > >> > + =A0 MMC_PACKED_NONE =3D 0,
> > > >> > + =A0 MMC_PACKED_WRITE,
> > > >> > +};
> > > >> > +
> > > >> > =A0struct mmc_queue_req {
> > > >> > =A0 =A0 struct request =A0 =A0 =A0 =A0 =A0*req;
> > > >> > =A0 =A0 struct mmc_blk_request =A0brq;
> > > >> > @@ -20,6 +25,13 @@ struct mmc_queue_req {
> > > >> > =A0 =A0 struct scatterlist =A0 =A0 =A0*bounce_sg;
> > > >> > =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0bounce_sg_len;
> > > >> > =A0 =A0 struct mmc_async_req =A0 =A0mmc_active;
> > > >> > + =A0 struct list_head =A0 =A0 =A0 =A0packed_list;
> > > >> > + =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd=
_hdr[128];
> > > >> > + =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0packed_blocks;
> > > >> > + =A0 enum mmc_packed_cmd =A0 =A0 packed_cmd;
> > > >> > + =A0 int =A0 =A0 =A0 =A0 =A0 =A0 packed_retries;
> > > >> > + =A0 int =A0 =A0 =A0 =A0 =A0 =A0 packed_fail_idx;
> > > >> > + =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0packed_num;
> > > >> > =A0};
> > > >> >
> > > >> > =A0struct mmc_queue {
> > > >> > diff --git a/drivers/mmc/core/mmc_ops.c
> > > >> > b/drivers/mmc/core/mmc_ops.c index 69370f4..2a2fed8 100644
> > > >> > --- a/drivers/mmc/core/mmc_ops.c
> > > >> > +++ b/drivers/mmc/core/mmc_ops.c
> > > >> > @@ -335,6 +335,7 @@ int mmc_send_ext_csd(struct mmc_card *ca=
rd,
> > > >> > u8
> > > >> > *ext_csd)
> > > >> > =A0 =A0 return mmc_send_cxd_data(card, card->host, MMC_SEND_=
EXT_CSD,
> > > >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd, 512);
> > > >> > =A0}
> > > >> > +EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
> > > >> >
> > > >> > =A0int mmc_spi_read_ocr(struct mmc_host *host, int highcap, =
u32
> > > >> > *ocrp) =A0{ diff -- git a/include/linux/mmc/core.h
> > > >> > b/include/linux/mmc/core.h index
> > > >> > 1b431c7..d787037 100644
> > > >> > --- a/include/linux/mmc/core.h
> > > >> > +++ b/include/linux/mmc/core.h
> > > >> > @@ -18,6 +18,9 @@ struct mmc_request;
> > > >> > =A0struct mmc_command {
> > > >> > =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opcode;
> > > >> > =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg;
> > > >> > +#define MMC_CMD23_ARG_REL_WR =A0 =A0 =A0 (1 << 31) #define
> > > >> > +MMC_CMD23_ARG_PACKED =A0 =A0 =A0 ((0 << 31) | (1 << 30)) #d=
efine
> > > >> > +MMC_CMD23_ARG_TAG_REQ =A0 =A0 =A0(1 << 29)
> > > >> > =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resp[4];
> > > >> > =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0flags; =A0 =A0 =A0=
 =A0 =A0/* expected response
> > > >> > type */
> > > >> > =A0#define MMC_RSP_PRESENT =A0 =A0(1 << 0) @@ -143,6 +146,7 =
@@ extern
> > > >> > int mmc_app_cmd(struct mmc_host *, struct mmc_card *); =A0ex=
tern
> > > >> > int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card =
*,
> > > >> > =A0 =A0 struct mmc_command *, int);
> > > >> > =A0extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsi=
gned
> > > >> > int);
> > > >> > +extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_=
csd);
> > > >> >
> > > >> > =A0#define MMC_ERASE_ARG =A0 =A0 =A0 =A0 =A0 =A0 =A00x000000=
00
> > > >> > =A0#define MMC_SECURE_ERASE_ARG =A0 =A0 =A0 0x80000000
> > > >> > --
> > > >> > 1.7.0.4
> > > >> >
> > > >> >
> > > >> > --
> > > >> > To unsubscribe from this list: send the line "unsubscribe
> > > >> > linux-mmc" in the body of a message to majordomo@vger.kernel=
=2Eorg
> > > >> > More majordomo info at
> > > >> > http://vger.kernel.org/majordomo-info.html
> > > >>
> > > >> --
> > > >> To unsubscribe from this list: send the line "unsubscribe
> > > >> linux-mmc" in the body of a message to majordomo@vger.kernel.o=
rg
> > > >> More majordomo info at =A0http://vger.kernel.org/majordomo-inf=
o.html
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-mmc"
> > > > in the body of a message to majordomo@vger.kernel.org More majo=
rdomo
> > > > info at =A0http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-m=
mc"
> > > in the body of a message to majordomo@vger.kernel.org More majord=
omo
> > > info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
