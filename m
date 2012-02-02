From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Thu, 02 Feb 2012 18:50:59 +0900
Message-ID: <004201cce190$2ae40ab0$80ac2010$%jun@samsung.com>
References: <002701ccd728$edab9350$c902b9f0$%jun@samsung.com>
 <CAKLKtzddDXhbT6o8XUsMxad9+_a_StJCQz+eBnfQ+q+xLuJQKg@mail.gmail.com>
 <002401ccdb20$ad662250$083266f0$%jun@samsung.com>
 <CAKLKtzfpH1mD9a=KzAzDxw5H5-pqoRNwdwCqQhP+4i-7OyEs7w@mail.gmail.com>
 <001501ccdcc0$b35e6040$1a1b20c0$%jun@samsung.com>
 <CAKLKtzeyL5cqKNW9OM1b1DLqXz6Xj=1D4Q_+ByEn9QJW_pfknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12974 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab2BBJve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2012 04:51:34 -0500
In-reply-to: <CAKLKtzeyL5cqKNW9OM1b1DLqXz6Xj=1D4Q_+ByEn9QJW_pfknw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org

Dear all,

Is there any review for this patch-set?

Thanks.
Seungwon Jeon.

Saugata Das <saugata.das@linaro.org> wrote:
> On 27 January 2012 12:25, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Saugata Das <saugata.das@linaro.org> wrote:
> >> On 25 January 2012 10:47, Seungwon Jeon <tgih.jun@samsung.com> wro=
te:
> >> > Hi, Saugata Das.
> >> >
> >> > Saugata Das <saugata.das@linaro.org> wrote:
> >> >> On 20 January 2012 09:36, Seungwon Jeon <tgih.jun@samsung.com> =
wrote:
> >> >> > This patch supports packed command of eMMC4.5 device.
> >> >> > Several reads(or writes) can be grouped in packed command
> >> >> > and all data of the individual commands can be sent in a
> >> >> > single transfer on the bus.
> >> >> >
> >> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> >> > ---
> >> >> > =A0drivers/mmc/card/block.c =A0 | =A0469 ++++++++++++++++++++=
+++++++++++++++++++++---
> >> >> > =A0drivers/mmc/card/queue.c =A0 | =A0 48 +++++-
> >> >> > =A0drivers/mmc/card/queue.h =A0 | =A0 13 ++
> >> >> > =A0drivers/mmc/core/host.c =A0 =A0| =A0 =A02 +
> >> >> > =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 +
> >> >> > =A0include/linux/mmc/core.h =A0 | =A0 =A03 +
> >> >> > =A0include/linux/mmc/host.h =A0 | =A0 =A03 +
> >> >> > =A07 files changed, 512 insertions(+), 27 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/bloc=
k.c
> >> >> > index 176b78e..77d457e 100644
> >> >> > --- a/drivers/mmc/card/block.c
> >> >> > +++ b/drivers/mmc/card/block.c
> >> >> > @@ -59,6 +59,13 @@ MODULE_ALIAS("mmc:block");
> >> >> > =A0#define INAND_CMD38_ARG_SECTRIM1 0x81
> >> >> > =A0#define INAND_CMD38_ARG_SECTRIM2 0x88
> >> >> >
> >> >> > +#define mmc_req_rel_wr(req) =A0 =A0(((req->cmd_flags & REQ_F=
UA) || \
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags=
 & REQ_META)) && \
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(re=
q) =3D=3D WRITE))
> >> >> > +#define PACKED_CMD_VER =A0 =A0 =A0 =A0 0x01
> >> >> > +#define PACKED_CMD_RD =A0 =A0 =A0 =A0 =A00x01
> >> >> > +#define PACKED_CMD_WR =A0 =A0 =A0 =A0 =A00x02
> >> >> > +
> >> >> > =A0static DEFINE_MUTEX(block_mutex);
> >> >> >
> >> >> > =A0/*
> >> >> > @@ -99,6 +106,7 @@ struct mmc_blk_data {
> >> >> > =A0#define MMC_BLK_WRITE =A0 =A0 =A0 =A0 =A0BIT(1)
> >> >> > =A0#define MMC_BLK_DISCARD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT=
(2)
> >> >> > =A0#define MMC_BLK_SECDISCARD =A0 =A0 BIT(3)
> >> >> > +#define MMC_BLK_WR_HDR =A0 =A0 =A0 =A0 BIT(4)
> >> >> >
> >> >> > =A0 =A0 =A0 =A0/*
> >> >> > =A0 =A0 =A0 =A0 * Only set in main mmc_blk_data associated
> >> >> > @@ -1028,7 +1036,8 @@ static int mmc_blk_err_check(struct mmc=
_card *card,
> >> >> > =A0 =A0 =A0 =A0 * kind. =A0If it was a write, we may have tra=
nsitioned to
> >> >> > =A0 =A0 =A0 =A0 * program mode, which we have to wait for it =
to complete.
> >> >> > =A0 =A0 =A0 =A0 */
> >> >> > - =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && rq_data_dir=
(req) !=3D READ) {
> >> >> > + =A0 =A0 =A0 if ((!mmc_host_is_spi(card->host) && rq_data_di=
r(req) !=3D READ) ||
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mq_mrq->packed=
_cmd =3D=3D MMC_PACKED_WR_HDR)) {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 status;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err =3D ge=
t_card_status(card, &status, 5);
> >> >> > @@ -1053,7 +1062,8 @@ static int mmc_blk_err_check(struct mmc=
_card *card,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned)blk_rq_=
sectors(req),
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.resp[0],=
 brq->stop.resp[0]);
> >> >> >
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(req) =3D=3D REA=
D) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(req) =3D=3D REA=
D &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mq_mrq->packed_cmd !=3D MMC_PACKED_WR_HDR) {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ecc_err)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
return MMC_BLK_ECC_ERR;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK=
_DATA_ERR;
> >> >> > @@ -1065,12 +1075,60 @@ static int mmc_blk_err_check(struct m=
mc_card *card,
> >> >> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
> >> >> >
> >> >> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks <=
< 9 !=3D brq->data.bytes_xfered))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
PARTIAL;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
SUCCESS;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfe=
red)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
> >> >> >
> >> >> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> >> >> > =A0}
> >> >> >
> >> >> > +static int mmc_blk_packed_err_check(struct mmc_card *card,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct mmc_async_req *areq)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_rq =3D container_of(ar=
eq, struct mmc_queue_req,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> >> >> > + =A0 =A0 =A0 struct request *req =3D mq_rq->req;
> >> >> > + =A0 =A0 =A0 int err, check, status;
> >> >> > + =A0 =A0 =A0 u8 ext_csd[512];
> >> >> > +
> >> >> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> >> >> > + =A0 =A0 =A0 err =3D get_card_status(card, &status, 0);
> >> >> > + =A0 =A0 =A0 if (err) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: error %d sending st=
atus command\n",
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 req->rq_disk->disk_name, err);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, =
ext_csd);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: err=
or %d sending ext_csd\n",
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 req->rq_disk->disk_name, err);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
ABORT;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_EXP_EVENTS=
_STATUS] &
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_FAILURE) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0EXT_CSD_PACKED_GENERIC_ERROR)) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT=
_CSD_PACKED_CMD_STATUS] &
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_INDEXED_ERROR) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mq_rq->packed_fail_idx =3D
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 return MMC_BLK_PARTIAL;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 return check;
> >> >> > +}
> >> >> > +
> >> >> > =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct mmc_card *card,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
nt disable_multi,
> >> >> > @@ -1225,10 +1283,238 @@ static void mmc_blk_rw_rq_prep(struc=
t mmc_queue_req *mqrq,
> >> >> > =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> >> >> > =A0}
> >> >> >
> >> >> > +static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, str=
uct request *req)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct request_queue *q =3D mq->queue;
> >> >> > + =A0 =A0 =A0 struct mmc_card *card =3D mq->card;
> >> >> > + =A0 =A0 =A0 struct request *cur =3D req, *next =3D NULL;
> >> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> >> > + =A0 =A0 =A0 bool en_rel_wr =3D card->ext_csd.rel_param & EX=
T_CSD_WR_REL_PARAM_EN;
> >> >> > + =A0 =A0 =A0 unsigned int req_sectors =3D 0, phys_segments =3D=
 0;
> >> >> > + =A0 =A0 =A0 unsigned int max_blk_count, max_phys_segs;
> >> >> > + =A0 =A0 =A0 u8 put_back =3D 0;
> >> >> > + =A0 =A0 =A0 u8 max_packed_rw =3D 0;
> >> >> > + =A0 =A0 =A0 u8 reqs =3D 0;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mq->mqrq_cur->packed_num =3D 0;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) ||
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.=
packed_event_en)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D READ)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd=
=2Emax_packed_reads;
> >> >> > + =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd=
=2Emax_packed_writes;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (max_packed_rw =3D=3D 0)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MM=
C_BLK_REL_WR) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> >> > + =A0 =A0 =A0 }
> >> >>
> >> >> Is there any reason of not allowing reliable write on packed co=
mmand ?
> >> >> I think, it may get benefit from the packed command since relia=
ble
> >> >> writes are typically very small transfer (e.g. meta-data).
> >> > In the case where reliable write is requested but enhanced relia=
ble write
> >> > is not supported, write access must be partial according to
> >> > reliable write sector count. Because even a single request can b=
e split,
> >> > packed command is not allowed in this case.
> >>
> >> Then, can you include the enhanced reliable writes in the packed c=
ommand ?
> > Yes, enhanced reliable writes will be packed.
> >
>=20
> Thanks. I missed the "!en_rel_wr" in the condition.
>=20
> >>
> >> >
> >> >> > +
> >> >> > + =A0 =A0 =A0 max_blk_count =3D min(card->host->max_blk_count=
,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->max=
_req_size >> 9);
> >> >> > + =A0 =A0 =A0 if (unlikely(max_blk_count > 0xffff))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_blk_count =3D 0xffff;
> >> >> > +
> >> >> > + =A0 =A0 =A0 max_phys_segs =3D queue_max_segments(q);
> >> >> > + =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(cur);
> >> >> > + =A0 =A0 =A0 phys_segments +=3D req->nr_phys_segments;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D WRITE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors++;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments++;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 while (reqs < max_packed_rw - 1) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D blk_fetch_request(q);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (next->cmd_flags & REQ_DISCA=
RD ||
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 next->cmd_flags & REQ_FLUSH) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(cur) !=3D rq_da=
ta_dir(next)) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_req_rel_wr(next) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (md->flags & MMC_BLK_REL_WR) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 !en_rel_wr) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors=
(next);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req_sectors > max_blk_count=
) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_=
phys_segments;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_se=
gs) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_back =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&next->queuelist,=
 &mq->mqrq_cur->packed_list);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D next;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs++;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (put_back) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, next);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (reqs > 0) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist, &mq->=
mqrq_cur->packed_list);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->packed_num =3D ++=
reqs;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return reqs;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > +no_packed:
> >> >> > + =A0 =A0 =A0 mq->mqrq_cur->packed_cmd =3D MMC_PACKED_NONE;
> >> >> > + =A0 =A0 =A0 mq->mqrq_cur->packed_num =3D 0;
> >> >> > + =A0 =A0 =A0 return 0;
> >> >> > +}
> >> >> > +
> >> >> > +static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req=
 *mqrq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mmc_card *card,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mmc_queue *mq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u8 reqs)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> >> >> > + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> >> >> > + =A0 =A0 =A0 struct request *prq;
> >> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> >> > + =A0 =A0 =A0 bool do_rel_wr;
> >> >> > + =A0 =A0 =A0 u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
> >> >> > + =A0 =A0 =A0 u8 i =3D 1;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mqrq->packed_cmd =3D (rq_data_dir(req) =3D=3D R=
EAD) ?
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_PACKED_WR_HDR : MMC_PACKED_=
WRITE;
> >> >> > + =A0 =A0 =A0 mqrq->packed_blocks =3D 0;
> >> >> > + =A0 =A0 =A0 mqrq->packed_fail_idx =3D -1;
> >> >> > +
> >> >> > + =A0 =A0 =A0 memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_c=
md_hdr));
> >> >> > + =A0 =A0 =A0 packed_cmd_hdr[0] =3D (reqs << 16) |
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((rq_data_dir(req) =3D=3D READ=
) ?
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PACKED_CMD_RD : PACKED_CMD_=
WR) << 8) |
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PACKED_CMD_VER;
> >> >> > +
> >> >> > + =A0 =A0 =A0 /*
> >> >> > + =A0 =A0 =A0 =A0* Argument for each entry of packed group
> >> >> > + =A0 =A0 =A0 =A0*/
> >> >> > + =A0 =A0 =A0 list_for_each_entry(prq, &mqrq->packed_list, qu=
euelist) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_rel_wr =3D mmc_req_rel_wr(pr=
q) && (md->flags & MMC_BLK_REL_WR);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD23*/
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[(i * 2)] =3D (do=
_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_sectors(=
prq);
> >> >>
> >> >> The data tag flag is missed here. I think, we can have a common
> >> >> function which sets the CMD23 flags in both
> >> >> mmc_blk_packed_hdr_wrq_prep and mmc_blk_rw_rq_prep. This will b=
e
> >> >> useful when intergrating the next features (e.g. context id)
> >> >>
> >> > Oh, you added Data tag feature. I'll apply this next version.
> >> > And Adding new function which is related to CMD23 would be good
> >> > in different patch not these commit.
> >> >
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD18 or CMD25 *=
/
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[((i * 2)) + 1] =3D=
 mmc_card_blockaddr(card) ?
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(prq)=
 : blk_rq_pos(prq) << 9;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqrq->packed_blocks +=3D blk_rq=
_sectors(prq);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> >> >> > + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> >> >> > + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> >> >> > + =A0 =A0 =A0 brq->mrq.sbc =3D &brq->sbc;
> >> >> > + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> >> >> > + =A0 =A0 =A0 brq->sbc.arg =3D MMC_CMD23_ARG_PACKED |
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((rq_data_dir(req) =3D=3D READ)=
 ? 1 : mqrq->packed_blocks + 1);
> >> >> > + =A0 =A0 =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> >> >> > + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> >> >> > + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> >> >> > + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 =
| MMC_CMD_ADTC;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->data.blksz =3D 512;
> >> >> > + =A0 =A0 =A0 /*
> >> >> > + =A0 =A0 =A0 =A0* Write separately the packd command header =
only for packed read.
> >> >> > + =A0 =A0 =A0 =A0* In case of packed write, header is sent wi=
th blocks of data.
> >> >> > + =A0 =A0 =A0 =A0*/
> >> >> > + =A0 =A0 =A0 brq->data.blocks =3D (rq_data_dir(req) =3D=3D R=
EAD) ?
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 : mqrq->packed_blocks + 1;
> >> >> > + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_WRITE;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> >> > + =A0 =A0 =A0 brq->stop.arg =3D 0;
> >> >> > + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R=
1B | MMC_CMD_AC;
> >> >> > +
> >> >>
> >> >> We do not need MMC_STOP_TRANSMISSION when we use MMC_SET_BLOCK_=
COUNT
> >> > If transfer is terminated with an error, stop command is require=
d.
> >> > MMC_STOP_TRANSMISSION is for this purpose.
> >>
> >> The mmc_blk_err_check achieves this objective in case of an error.
> >> There is no need of this additional command cycle when there is no
> >> error.
> > If an error doesn't happen, stop command is not issued.
> > Could you explain about additional command cycle more?
> >
>=20
> I understand your remark after checking the implementation of sdhci.c=
=2E
> No problem of additional command cycle here.
>=20
>=20
> > Thanks.
> > Seungwon Jeon.
> >>
> >> >
> >> >>
> >> >> > + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> >> >> > + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq)=
;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> >> >> > + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_e=
rr_check;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> >> >> > +}
> >> >> > +
> >> >> > +static void mmc_blk_packed_rrq_prep(struct mmc_queue_req *mq=
rq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mmc_card *card,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mmc_queue *mq)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> >> >> > + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mqrq->packed_cmd =3D MMC_PACKED_READ;
> >> >> > +
> >> >> > + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> >> >> > + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> >> >> > + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> >> >> > + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> >> >> > + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> >> >> > + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> >> >> > + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 =
| MMC_CMD_ADTC;
> >> >> > + =A0 =A0 =A0 brq->data.blksz =3D 512;
> >> >> > + =A0 =A0 =A0 brq->data.blocks =3D mqrq->packed_blocks;
> >> >> > + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_READ;
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> >> > + =A0 =A0 =A0 brq->stop.arg =3D 0;
> >> >> > + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R=
1B | MMC_CMD_AC;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> >> >> > +
> >> >> > + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> >> >> > + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq)=
;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> >> >> > + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_e=
rr_check;
> >> >> > +
> >> >> > + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> >> >> > +}
> >> >> > +
> >> >> > =A0static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct=
 mmc_card *card,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mm=
c_blk_request *brq, struct request *req,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret)
> >> >> > =A0{
> >> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
> >> >> > + =A0 =A0 =A0 mq_rq =3D container_of(brq, struct mmc_queue_re=
q, brq);
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0/*
> >> >> > =A0 =A0 =A0 =A0 * If this is an SD card and we're writing, we=
 can first
> >> >> > =A0 =A0 =A0 =A0 * mark the known good sectors as ok.
> >> >> > @@ -1247,13 +1533,65 @@ static int mmc_blk_cmd_err(struct mmc=
_blk_data *md, struct mmc_card
> *card,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_ir=
q(&md->lock);
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> >> > =A0 =A0 =A0 =A0} else {
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, =
0, brq->data.bytes_xfered);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_cmd =3D=3D MM=
C_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&=
md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_e=
nd_request(req, 0, brq->data.bytes_xfered);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq=
(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > =A0 =A0 =A0 =A0}
> >> >> > =A0 =A0 =A0 =A0return ret;
> >> >> > =A0}
> >> >> >
> >> >> > +static int mmc_blk_chk_hdr_err(struct mmc_queue *mq, int sta=
tus)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> >> > + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
> >> >> > + =A0 =A0 =A0 int type =3D MMC_BLK_WR_HDR, err =3D 0;
> >> >> > +
> >> >> > + =A0 =A0 =A0 switch (status) {
> >> >> > + =A0 =A0 =A0 case MMC_BLK_PARTIAL:
> >> >> > + =A0 =A0 =A0 case MMC_BLK_RETRY:
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 case MMC_BLK_CMD_ERR:
> >> >> > + =A0 =A0 =A0 case MMC_BLK_ABORT:
> >> >> > + =A0 =A0 =A0 case MMC_BLK_DATA_ERR:
> >> >> > + =A0 =A0 =A0 case MMC_BLK_ECC_ERR:
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_blk_reset(md, card-=
>host, type);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_reset_s=
uccess(md, type);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 return err;
> >> >> > +}
> >> >> > +
> >> >> > +static int mmc_blk_issue_packed_rd(struct mmc_queue *mq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_queue_req *mq_rq)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> >> > + =A0 =A0 =A0 struct mmc_card *card =3D md->queue.card;
> >> >> > + =A0 =A0 =A0 int status, ret =3D -EIO, retry =3D 2;
> >> >> > +
> >> >> > + =A0 =A0 =A0 do {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->host, NULL,=
 (int *) &status);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk=
_chk_hdr_err(mq, status);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_packed_=
hdr_wrq_prep(mq_rq, card, mq, mq_rq->packed_num);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(c=
ard->host, &mq_rq->mmc_active, NULL);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_packed_=
rrq_prep(mq_rq, card, mq);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(c=
ard->host, &mq_rq->mmc_active, NULL);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 } while (retry-- > 0);
> >> >> > +
> >> >> > + =A0 =A0 =A0 return ret;
> >> >> > +}
> >> >> > +
> >> >> > =A0static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struc=
t request *rqc)
> >> >> > =A0{
> >> >> > =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> >> >> > @@ -1262,21 +1600,32 @@ static int mmc_blk_issue_rw_rq(struct=
 mmc_queue *mq, struct request
> *rqc)
> >> >> > =A0 =A0 =A0 =A0int ret =3D 1, disable_multi =3D 0, retry =3D =
0, type;
> >> >> > =A0 =A0 =A0 =A0enum mmc_blk_status status;
> >> >> > =A0 =A0 =A0 =A0struct mmc_queue_req *mq_rq;
> >> >> > - =A0 =A0 =A0 struct request *req;
> >> >> > + =A0 =A0 =A0 struct request *req, *prq;
> >> >> > =A0 =A0 =A0 =A0struct mmc_async_req *areq;
> >> >> > + =A0 =A0 =A0 u8 reqs =3D 0;
> >> >> >
> >> >> > =A0 =A0 =A0 =A0if (!rqc && !mq->mqrq_prev->req)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> >> >> >
> >> >> > + =A0 =A0 =A0 if (rqc)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_prep_packed_li=
st(mq, rqc);
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0do {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rqc) {
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_p=
rep(mq->mqrq_cur, card, 0, mq);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs >=3D c=
ard->host->packed_min)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cur, card, mq, reqs);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D &mq->=
mqrq_cur->mmc_active;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D NULL;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D mmc_start_req(card->h=
ost, areq, (int *) &status);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!areq)
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!areq) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->mqrq_cu=
r->packed_cmd =3D=3D MMC_PACKED_WR_HDR)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 goto snd_packed_rd;
> >> >>
> >> >> How the condition, when (areq is not NULL) and
> >> >> (mq->mqrq_cur->packed_cmd =3D MMC_PACKED_WR_HDR) handled ?
> >> > That case(areq =3D=3D NULL && mq->mqrq_cur->packed_cmd =3D=3D MM=
C_PACKED_WR_HDR)
> >> > will be handled with escape from do~while.
> >> > snd_packed_rd:
> >> > =A0 =A0 =A0 =A0if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PACKED_WR=
_HDR) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_blk_issue_packed_rd(mq, m=
q->mqrq_cur))
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto start_new_re=
q;
> >> > =A0 =A0 =A0 =A0}
> >> >
> >> >>
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 return 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> >
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_rq =3D container_of(areq, s=
truct mmc_queue_req, mmc_active);
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq =3D &mq_rq->brq;
> >> >> > @@ -1291,10 +1640,38 @@ static int mmc_blk_issue_rw_rq(struct=
 mmc_queue *mq, struct request
> *rqc)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was=
 successfully transferred.
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_reset_=
success(md, type);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&=
md->lock);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_e=
nd_request(req, 0,
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->pack=
ed_cmd !=3D MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int idx =3D mq_rq->packed_fail_idx, i =3D 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 while (!list_empty(&mq_rq->packed_list)) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_list.next);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 if (idx =3D=3D i) {
> >> >>
> >> >> I think, in case of no error (packed_fail_idx=3D0) and when (i=3D=
0), this
> >> >> above "if" condition will satisfy and subsequently wrongly retr=
y.
> >> > packed_failed_idx is '-1' not '0' with no error.
> >> >
> >> >>
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* retry from error index */
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->packed_num -=3D idx;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_num =3D=3D 1) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->packed_cmd =3D =
MMC_PACKED_NONE;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->packed_num =3D =
0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->req =3D prq;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(prq, 0, blk_rq_bytes(prq));
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 i++;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 if (idx =3D=3D -1)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 mq_rq->packed_num =3D 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 spin_lock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ret =3D __blk_end_request(req, 0,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->data.bytes_xfered);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq=
(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If the blk_=
end_request function returns non-zero even
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * though all =
data has been transferred and no errors
> >> >> > @@ -1329,6 +1706,8 @@ static int mmc_blk_issue_rw_rq(struct m=
mc_queue *mq, struct request *rqc)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
break;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err =3D=3D=
 -ENODEV)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
goto cmd_abort;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->pack=
ed_cmd !=3D MMC_PACKED_NONE)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 break;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fall throug=
h */
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_ECC_ERR:
> >> >> > @@ -1356,27 +1735,69 @@ static int mmc_blk_issue_rw_rq(struct=
 mmc_queue *mq, struct request
> *rqc)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> >> >
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case of=
 a incomplete request
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prepare it=
 again and resend.
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_p=
rep(mq_rq, card, disable_multi, mq);
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(c=
ard->host, &mq_rq->mmc_active, NULL);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->pack=
ed_cmd =3D=3D MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /*
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0* In case of a incomplete request
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0* prepare it again and resend.
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*/
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_blk_packed_hdr_wrq_prep(mq_rq, card, mq, mq_rq->packed_num);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 if (mq_rq->packed_cmd =3D=3D MMC_PACKED_WR_HDR) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 if (mmc_blk_issue_packed_rd(mq, mq_rq))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_abort;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> >> > =A0 =A0 =A0 =A0} while (ret);
> >> >> >
> >> >> > +snd_packed_rd:
> >> >> > + =A0 =A0 =A0 if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PACKED_=
WR_HDR) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_blk_issue_packed_rd(mq,=
 mq->mqrq_cur))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto start_new_=
req;
> >> >> > + =A0 =A0 =A0 }
> >> >> > =A0 =A0 =A0 =A0return 1;
> >> >> >
> >> >> > =A0cmd_abort:
> >> >> > - =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > - =A0 =A0 =A0 if (mmc_card_removed(card))
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D REQ_QUIET;
> >> >> > - =A0 =A0 =A0 while (ret)
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, =
-EIO, blk_rq_cur_bytes(req));
> >> >> > - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 if (mq_rq->packed_cmd =3D=3D MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_removed(card))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags =
|=3D REQ_QUIET;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_e=
nd_request(req, -EIO, blk_rq_cur_bytes(req));
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 } else {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_empty(&mq_rq->pack=
ed_list)) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prq =3D list_en=
try_rq(mq_rq->packed_list.next);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&=
prq->queuelist);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&=
md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __blk_end_reque=
st(prq, -EIO, blk_rq_bytes(prq));
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq=
(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 }
> >> >> >
> >> >> > =A0start_new_req:
> >> >> > =A0 =A0 =A0 =A0if (rqc) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If current request is pack=
ed, it need to put back.
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->mqrq_cur->packed_cmd !=3D=
 MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_em=
pty(&mq->mqrq_cur->packed_list)) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 prq =3D list_entry_rq(mq->mqrq_cur->packed_list.prev);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 if (prq->queuelist.prev !=3D &mq->mqrq_cur->packed_list) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 spin_lock_irq(mq->queue->queue_lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 blk_requeue_request(mq->queue, prq);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 spin_unlock_irq(mq->queue->queue_lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 } else {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->p=
acked_cmd =3D MMC_PACKED_NONE;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mqrq_cur->p=
acked_num =3D 0;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_rw_rq_prep(mq->mqrq_cu=
r, card, 0, mq);
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_start_req(card->host, &mq-=
>mqrq_cur->mmc_active, NULL);
> >> >> > =A0 =A0 =A0 =A0}
> >> >> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queu=
e.c
> >> >> > index 2517547..af7aee5 100644
> >> >> > --- a/drivers/mmc/card/queue.c
> >> >> > +++ b/drivers/mmc/card/queue.c
> >> >> > @@ -177,6 +177,8 @@ int mmc_init_queue(struct mmc_queue *mq, =
struct mmc_card *card,
> >> >> >
> >> >> > =A0 =A0 =A0 =A0memset(&mq->mqrq_cur, 0, sizeof(mq->mqrq_cur))=
;
> >> >> > =A0 =A0 =A0 =A0memset(&mq->mqrq_prev, 0, sizeof(mq->mqrq_prev=
));
> >> >> > + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_cur->packed_list);
> >> >> > + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_prev->packed_list);
> >> >> > =A0 =A0 =A0 =A0mq->mqrq_cur =3D mqrq_cur;
> >> >> > =A0 =A0 =A0 =A0mq->mqrq_prev =3D mqrq_prev;
> >> >> > =A0 =A0 =A0 =A0mq->queue->queuedata =3D mq;
> >> >> > @@ -377,6 +379,39 @@ void mmc_queue_resume(struct mmc_queue *=
mq)
> >> >> > =A0 =A0 =A0 =A0}
> >> >> > =A0}
> >> >> >
> >> >> > +static unsigned int mmc_queue_packed_map_sg(struct mmc_queue=
 *mq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_queue_req *mqrq,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct scatterlist *sg)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct scatterlist *__sg;
> >> >> > + =A0 =A0 =A0 unsigned int sg_len =3D 0;
> >> >> > + =A0 =A0 =A0 struct request *req;
> >> >> > + =A0 =A0 =A0 enum mmc_packed_cmd cmd;
> >> >> > +
> >> >> > + =A0 =A0 =A0 cmd =3D mqrq->packed_cmd;
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HDR || cmd =3D=3D =
MMC_PACKED_WRITE) {
> >> >>
> >> >> Why we do not need to handle MMC_PACKED_READ case ?
> >> > This conditions is for the packed header.
> >> > MMC_PACKED_READ is related with MMC_PACKED_WR_HDR.
> >> >
> >> > Thanks.
> >> > Seungwon Jeon.
> >> >>
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3D sg;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_buf(__sg, mqrq->packed_c=
md_hdr,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 sizeof(mqrq->packed_cmd_hdr));
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len++;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HD=
R) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_mark_end(__s=
g);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sg_len;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg->page_link &=3D ~0x02;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > + =A0 =A0 =A0 __sg =3D sg + sg_len;
> >> >> > + =A0 =A0 =A0 list_for_each_entry(req, &mqrq->packed_list, qu=
euelist) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len +=3D blk_rq_map_sg(mq->q=
ueue, req, __sg);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3D sg + (sg_len - 1);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (__sg++)->page_link &=3D ~0x02;
> >> >> > + =A0 =A0 =A0 }
> >> >> > + =A0 =A0 =A0 sg_mark_end(sg + (sg_len - 1));
> >> >> > + =A0 =A0 =A0 return sg_len;
> >> >> > +}
> >> >> > +
> >> >> > =A0/*
> >> >> > =A0* Prepare the sg list(s) to be handed of to the host drive=
r
> >> >> > =A0*/
> >> >> > @@ -387,12 +422,19 @@ unsigned int mmc_queue_map_sg(struct mm=
c_queue *mq, struct mmc_queue_req
> >> *mqrq)
> >> >> > =A0 =A0 =A0 =A0struct scatterlist *sg;
> >> >> > =A0 =A0 =A0 =A0int i;
> >> >> >
> >> >> > - =A0 =A0 =A0 if (!mqrq->bounce_buf)
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(mq->queue,=
 mqrq->req, mqrq->sg);
> >> >> > + =A0 =A0 =A0 if (!mqrq->bounce_buf) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mqrq->packed_l=
ist))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_queu=
e_packed_map_sg(mq, mqrq, mqrq->sg);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_m=
ap_sg(mq->queue, mqrq->req, mqrq->sg);
> >> >> > + =A0 =A0 =A0 }
> >> >> >
> >> >> > =A0 =A0 =A0 =A0BUG_ON(!mqrq->bounce_sg);
> >> >> >
> >> >> > - =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req, =
mqrq->bounce_sg);
> >> >> > + =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D mmc_queue_packed_map=
_sg(mq, mqrq, mqrq->bounce_sg);
> >> >> > + =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->qu=
eue, mqrq->req, mqrq->bounce_sg);
> >> >> >
> >> >> > =A0 =A0 =A0 =A0mqrq->bounce_sg_len =3D sg_len;
> >> >> >
> >> >> > diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queu=
e.h
> >> >> > index d2a1eb4..be58b3c 100644
> >> >> > --- a/drivers/mmc/card/queue.h
> >> >> > +++ b/drivers/mmc/card/queue.h
> >> >> > @@ -12,6 +12,13 @@ struct mmc_blk_request {
> >> >> > =A0 =A0 =A0 =A0struct mmc_data =A0 =A0 =A0 =A0 data;
> >> >> > =A0};
> >> >> >
> >> >> > +enum mmc_packed_cmd {
> >> >> > + =A0 =A0 =A0 MMC_PACKED_NONE =3D 0,
> >> >> > + =A0 =A0 =A0 MMC_PACKED_WR_HDR,
> >> >> > + =A0 =A0 =A0 MMC_PACKED_WRITE,
> >> >> > + =A0 =A0 =A0 MMC_PACKED_READ,
> >> >> > +};
> >> >> > +
> >> >> > =A0struct mmc_queue_req {
> >> >> > =A0 =A0 =A0 =A0struct request =A0 =A0 =A0 =A0 =A0*req;
> >> >> > =A0 =A0 =A0 =A0struct mmc_blk_request =A0brq;
> >> >> > @@ -20,6 +27,12 @@ struct mmc_queue_req {
> >> >> > =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0*bounce_sg;
> >> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bounce_sg_=
len;
> >> >> > =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0mmc_active;
> >> >> > + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0packed_list;
> >> >> > + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pac=
ked_cmd_hdr[128];
> >> >> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0packed_bloc=
ks;
> >> >> > + =A0 =A0 =A0 enum mmc_packed_cmd =A0 =A0 packed_cmd;
> >> >> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 packed_fail_idx;
> >> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0packed_num;
> >> >> > =A0};
> >> >> >
> >> >> > =A0struct mmc_queue {
> >> >> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.=
c
> >> >> > index 30055f2..10350ce 100644
> >> >> > --- a/drivers/mmc/core/host.c
> >> >> > +++ b/drivers/mmc/core/host.c
> >> >> > @@ -346,6 +346,8 @@ struct mmc_host *mmc_alloc_host(int extra=
, struct device *dev)
> >> >> > =A0 =A0 =A0 =A0host->max_blk_size =3D 512;
> >> >> > =A0 =A0 =A0 =A0host->max_blk_count =3D PAGE_CACHE_SIZE / 512;
> >> >> >
> >> >> > + =A0 =A0 =A0 host->packed_min =3D 2;
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0return host;
> >> >> >
> >> >> > =A0free:
> >> >> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mm=
c_ops.c
> >> >> > index 4d41fa9..1e17bd7 100644
> >> >> > --- a/drivers/mmc/core/mmc_ops.c
> >> >> > +++ b/drivers/mmc/core/mmc_ops.c
> >> >> > @@ -335,6 +335,7 @@ int mmc_send_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> >> >> > =A0 =A0 =A0 =A0return mmc_send_cxd_data(card, card->host, MMC=
_SEND_EXT_CSD,
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd, 512);
> >> >> > =A0}
> >> >> > +EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
> >> >> >
> >> >> > =A0int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u=
32 *ocrp)
> >> >> > =A0{
> >> >> > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/cor=
e.h
> >> >> > index 87a976c..07a4149 100644
> >> >> > --- a/include/linux/mmc/core.h
> >> >> > +++ b/include/linux/mmc/core.h
> >> >> > @@ -18,6 +18,8 @@ struct mmc_request;
> >> >> > =A0struct mmc_command {
> >> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 op=
code;
> >> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ar=
g;
> >> >> > +#define MMC_CMD23_ARG_REL_WR =A0 (1 << 31)
> >> >> > +#define MMC_CMD23_ARG_PACKED =A0 ((0 << 31) | (1 << 30))
> >> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
sp[4];
> >> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0flags; =A0=
 =A0 =A0 =A0 =A0/* expected response type */
> >> >> > =A0#define MMC_RSP_PRESENT =A0 =A0 =A0 =A0(1 << 0)
> >> >> > @@ -143,6 +145,7 @@ extern int mmc_app_cmd(struct mmc_host *,=
 struct mmc_card *);
> >> >> > =A0extern int mmc_wait_for_app_cmd(struct mmc_host *, struct =
mmc_card *,
> >> >> > =A0 =A0 =A0 =A0struct mmc_command *, int);
> >> >> > =A0extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsig=
ned int);
> >> >> > +extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_c=
sd);
> >> >> >
> >> >> > =A0#define MMC_ERASE_ARG =A0 =A0 =A0 =A0 =A00x00000000
> >> >> > =A0#define MMC_SECURE_ERASE_ARG =A0 0x80000000
> >> >> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/hos=
t.h
> >> >> > index e22f541..8984259 100644
> >> >> > --- a/include/linux/mmc/host.h
> >> >> > +++ b/include/linux/mmc/host.h
> >> >> > @@ -286,6 +286,9 @@ struct mmc_host {
> >> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_blk_co=
unt; =A0/* maximum number of blocks in one req */
> >> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_discar=
d_to; /* max. discard timeout in ms */
> >> >> >
> >> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p=
acked_min; =A0 =A0 /* minimum number of packed entries */
> >> >> > +
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0/* private data */
> >> >> > =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock; =A0=
 =A0 =A0 =A0 =A0 /* lock for claim and bus ops */
> >> >> >
> >> >> > --
> >> >> > 1.7.0.4
> >> >> >
> >> >> >
> >> >> > --
> >> >> > To unsubscribe from this list: send the line "unsubscribe lin=
ux-mmc" in
> >> >> > the body of a message to majordomo@vger.kernel.org
> >> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-in=
fo.html
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

