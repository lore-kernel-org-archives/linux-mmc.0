From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH RESEND v7 2/3] mmc: core: Support packed write command for
 eMMC4.5 device
Date: Tue, 26 Jun 2012 18:27:37 +0900
Message-ID: <001d01cd537d$ecd54670$c67fd350$%jun@samsung.com>
References: <007b01cd4d15$40673510$c1359f30$%jun@samsung.com>
 <CANfBPZ-Rt-RqBgBCj9Y-p5jEOk8Xs9j6xS_pzu83U_rMr_2qCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20985 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab2FZJ1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jun 2012 05:27:43 -0400
In-reply-to: <CANfBPZ-Rt-RqBgBCj9Y-p5jEOk8Xs9j6xS_pzu83U_rMr_2qCQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'S, Venkatraman'" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>

S, Venkatraman <svenkatr@ti.com> wrote:
> On Mon, Jun 18, 2012 at 11:13 AM, Seungwon Jeon <tgih.jun@samsung.com=
> wrote:
> > This patch supports packed write command of eMMC4.5 device.
> > Several writes can be grouped in packed command and all data
> > of the individual commands can be sent in a single transfer
> > on the bus.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/card/block.c =A0 | =A0406 ++++++++++++++++++++++++++=
+++++++++++++++---
> > =A0drivers/mmc/card/queue.c =A0 | =A0 45 +++++-
> > =A0drivers/mmc/card/queue.h =A0 | =A0 12 ++
> > =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 +
> > =A0include/linux/mmc/core.h =A0 | =A0 =A04 +
> > =A05 files changed, 441 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index 7e3f453..eb99e35 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -58,6 +58,12 @@ MODULE_ALIAS("mmc:block");
> > =A0#define INAND_CMD38_ARG_SECTRIM1 0x81
> > =A0#define INAND_CMD38_ARG_SECTRIM2 0x88
> >
> > +#define mmc_req_rel_wr(req) =A0 =A0(((req->cmd_flags & REQ_FUA) ||=
 \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ=
_META)) && \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=
=3D WRITE))
> > +#define PACKED_CMD_VER =A0 =A0 =A0 =A0 0x01
> > +#define PACKED_CMD_WR =A0 =A0 =A0 =A0 =A00x02
> > +
> > =A0static DEFINE_MUTEX(block_mutex);
> >
> > =A0/*
> > @@ -123,9 +129,21 @@ enum mmc_blk_status {
> > =A0 =A0 =A0 =A0MMC_BLK_NOMEDIUM,
> > =A0};
> >
> > +enum {
> > + =A0 =A0 =A0 MMC_PACKED_N_IDX =3D -1,
> > + =A0 =A0 =A0 MMC_PACKED_N_ZERO,
> > + =A0 =A0 =A0 MMC_PACKED_N_SINGLE,
> > +};
> > +
> > =A0module_param(perdev_minors, int, 0444);
> > =A0MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per =
device");
> >
> > +static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq=
)
> > +{
> > + =A0 =A0 =A0 mqrq->packed_cmd =3D MMC_PACKED_NONE;
> > + =A0 =A0 =A0 mqrq->packed_num =3D MMC_PACKED_N_ZERO;
> > +}
> > +
> > =A0static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
> > =A0{
> > =A0 =A0 =A0 =A0struct mmc_blk_data *md;
> > @@ -1081,12 +1099,61 @@ static int mmc_blk_err_check(struct mmc_car=
d *card,
> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
> >
> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks << 9 !=3D=
 brq->data.bytes_xfered))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PARTIA=
L;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_SUCCES=
S;
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
> >
> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> > =A0}
> >
> > +static int mmc_blk_packed_err_check(struct mmc_card *card,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_async_req *areq)
> > +{
> > + =A0 =A0 =A0 struct mmc_queue_req *mq_rq =3D container_of(areq, st=
ruct mmc_queue_req,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> > + =A0 =A0 =A0 struct request *req =3D mq_rq->req;
> > + =A0 =A0 =A0 int err, check, status;
> > + =A0 =A0 =A0 u8 ext_csd[512];
> > +
> > + =A0 =A0 =A0 mq_rq->packed_retries--;
> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> > + =A0 =A0 =A0 err =3D get_card_status(card, &status, 0);
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: error %d sending status c=
ommand\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->=
rq_disk->disk_name, err);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_cs=
d);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: error %d =
sending ext_csd\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req->rq_disk->disk_name, err);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_EXP_EVENTS_STATU=
S] &
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PACKED_FAILURE) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_=
csd[EXT_CSD_PACKED_CMD_STATUS] &
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_PACKED_GENERIC_ERROR)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_P=
ACKED_CMD_STATUS] &
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PACKED_INDEXED_ERROR) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq=
->packed_fail_idx =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e=
xt_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n MMC_BLK_PARTIAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return check;
> > +}
> > +
> > =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mmc_card *card,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int dis=
able_multi,
> > @@ -1241,10 +1308,197 @@ static void mmc_blk_rw_rq_prep(struct mmc_=
queue_req *mqrq,
> > =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> > =A0}
> >
> > +static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct re=
quest *req)
> > +{
> > + =A0 =A0 =A0 struct request_queue *q =3D mq->queue;
> > + =A0 =A0 =A0 struct mmc_card *card =3D mq->card;
> > + =A0 =A0 =A0 struct request *cur =3D req, *next =3D NULL;
> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> > + =A0 =A0 =A0 bool en_rel_wr =3D card->ext_csd.rel_param & EXT_CSD_=
WR_REL_PARAM_EN;
> > + =A0 =A0 =A0 unsigned int req_sectors =3D 0, phys_segments =3D 0;
> > + =A0 =A0 =A0 unsigned int max_blk_count, max_phys_segs;
> > + =A0 =A0 =A0 u8 put_back =3D 0;
> > + =A0 =A0 =A0 u8 max_packed_rw =3D 0;
> > + =A0 =A0 =A0 u8 reqs =3D 0;
> > +
> > + =A0 =A0 =A0 mmc_blk_clear_packed(mq->mqrq_cur);
> > +
> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.packed=
_event_en)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > +
> > + =A0 =A0 =A0 if ((rq_data_dir(cur) =3D=3D WRITE) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->host->caps2 & =
MMC_CAP2_PACKED_WR))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.max_p=
acked_writes;
> > +
> > + =A0 =A0 =A0 if (max_packed_rw =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > +
> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MMC_BLK_=
REL_WR) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 max_blk_count =3D min(card->host->max_blk_count,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->max_req_s=
ize >> 9);
> > + =A0 =A0 =A0 if (unlikely(max_blk_count > 0xffff))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_blk_count =3D 0xffff;
> > +
> > + =A0 =A0 =A0 max_phys_segs =3D queue_max_segments(q);
> > + =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(cur);
> > + =A0 =A0 =A0 phys_segments +=3D cur->nr_phys_segments;
> > +
> > + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D WRITE) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments++;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 while (reqs < max_packed_rw - 1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D blk_fetch_request(q);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (next->cmd_flags & REQ_DISCARD ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next-=
>cmd_flags & REQ_FLUSH) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(cur) !=3D rq_data_dir=
(next)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_req_rel_wr(next) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->=
flags & MMC_BLK_REL_WR) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_r=
el_wr) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(next)=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req_sectors > max_blk_count) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_phys_s=
egments;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_segs) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&next->queuelist, &mq->=
mqrq_cur->packed_list);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D next;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs++;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (put_back) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, next);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (reqs > 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist, &mq->mqrq_c=
ur->packed_list);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->packed_num =3D ++reqs;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->packed_retries =3D reqs=
;
>=20
> ^^ This means that the number of times the packed command is retried
> is equal to the number of requests
> it packs ? How are they related ?
Retrying value is just  maximum by using the number of requests which i=
s packed.

Thanks,
Seungwon Jeon

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return reqs;
> > + =A0 =A0 =A0 }
> > +
> > +no_packed:
> > + =A0 =A0 =A0 mmc_blk_clear_packed(mq->mqrq_cur);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

