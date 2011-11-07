From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Mon, 07 Nov 2011 12:45:13 +0900
Message-ID: <000c01cc9cff$a851abe0$f8f503a0$%jun@samsung.com>
References: <1320220990-13378-1-git-send-email-tgih.jun@samsung.com>
 <CANfBPZ_mF7XLGc=f7dohHvEnQOQ4cxSpcx0My_pMWFqa+HzP-g@mail.gmail.com>
 <001e01cc99cb$5a144370$0e3cca50$%jun@samsung.com>
 <CANfBPZ9A3XpVn6QBxDGpqJdzfx7fPywyrYMWWRYgUuBmPmxPQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CANfBPZ9A3XpVn6QBxDGpqJdzfx7fPywyrYMWWRYgUuBmPmxPQQ@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: "'S, Venkatraman'" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

S, Venkatraman <svenkatr@ti.com> wrote:=20
> On Thu, Nov 3, 2011 at 7:23 AM, Seungwon Jeon <tgih.jun@samsung.com> =
wrote:
> > S, Venkatraman <svenkatr@ti.com> wrote:
> >> On Wed, Nov 2, 2011 at 1:33 PM, Seungwon Jeon <tgih.jun@samsung.co=
m> wrote:
> >> > This patch supports packed command of eMMC4.5 device.
> >> > Several reads(or writes) can be grouped in packed command
> >> > and all data of the individual commands can be sent in a
> >> > single transfer on the bus.
> >> >
> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> > ---
> >> > =A0drivers/mmc/card/block.c | =A0355 +++++++++++++++++++++++++++=
+++++++++++++++++--
> >> > =A0drivers/mmc/card/queue.c | =A0 48 ++++++-
> >> > =A0drivers/mmc/card/queue.h | =A0 12 ++
> >> > =A0include/linux/mmc/core.h | =A0 =A03 +
> >> > =A04 files changed, 404 insertions(+), 14 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >> > index a1cb21f..6c49656 100644
> >> > --- a/drivers/mmc/card/block.c
> >> > +++ b/drivers/mmc/card/block.c
> >> > @@ -59,6 +59,13 @@ MODULE_ALIAS("mmc:block");
> >> > =A0#define INAND_CMD38_ARG_SECTRIM1 0x81
> >> > =A0#define INAND_CMD38_ARG_SECTRIM2 0x88
> >> >
> >> > +#define mmc_req_rel_wr(req) =A0 =A0(((req->cmd_flags & REQ_FUA)=
 || \
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & =
REQ_META)) && \
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =
=3D=3D WRITE))
> >> > +#define PACKED_CMD_VER =A0 =A0 =A0 =A0 0x01
> >> > +#define PACKED_CMD_RD =A0 =A0 =A0 =A0 =A00x01
> >> > +#define PACKED_CMD_WR =A0 =A0 =A0 =A0 =A00x02
> >> > +
> >> > =A0static DEFINE_MUTEX(block_mutex);
> >> >
> >> > =A0/*
> >> > @@ -943,7 +950,8 @@ static int mmc_blk_err_check(struct mmc_card=
 *card,
> >> > =A0 =A0 =A0 =A0 * kind. =A0If it was a write, we may have transi=
tioned to
> >> > =A0 =A0 =A0 =A0 * program mode, which we have to wait for it to =
complete.
> >> > =A0 =A0 =A0 =A0 */
> >> > - =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && rq_data_dir(re=
q) !=3D READ) {
> >> > + =A0 =A0 =A0 if ((!mmc_host_is_spi(card->host) && rq_data_dir(r=
eq) !=3D READ) ||
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mq_mrq->packed_cm=
d =3D=3D MMC_PACKED_WR_HDR)) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 status;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err =3D get_c=
ard_status(card, &status, 5);
> >> > @@ -980,12 +988,67 @@ static int mmc_blk_err_check(struct mmc_ca=
rd *card,
> >> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
> >> >
> >> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks << 9=
 !=3D brq->data.bytes_xfered))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PAR=
TIAL;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_SUC=
CESS;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfered=
)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
> >> >
> >> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> >> > =A0}
> >> >
> >> > +static int mmc_blk_packed_err_check(struct mmc_card *card,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
mmc_async_req *areq)
> >> > +{
> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(areq=
, struct mmc_queue_req,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> >> > + =A0 =A0 =A0 int err, check, status;
> >> > + =A0 =A0 =A0 u8 ext_csd[512];
> >> > +
> >> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> >> > +
> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_SUCCESS)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return check;
> >> > +
> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_PARTIAL) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_card_status(card, &sta=
tus, 0);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABO=
RT;
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_e=
xt_csd(card, ext_csd);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
turn MMC_BLK_ABORT;
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_C=
SD_EXP_EVENTS_STATUS + 0] &
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_FAILURE) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0EXT_CSD_PACKED_GENERIC_ERROR)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_INDEXED_ERROR) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* Make be 0-based */
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mq_mrq->packed_fail_idx =3D
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 return MMC_BLK_PARTIAL;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } =
else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 return MMC_BLK_RETRY;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_RET=
RY;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 if (check !=3D MMC_BLK_ABORT)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_RETRY;
> >> > + =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> >> > +}
> >> > +
> >> > =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stru=
ct mmc_card *card,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =
disable_multi,
> >> > @@ -1129,6 +1192,211 @@ static void mmc_blk_rw_rq_prep(struct mm=
c_queue_req *mqrq,
> >> > =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> >> > =A0}
> >> >
> >> > +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struct req=
uest *req)
> >> > +{
> >> > + =A0 =A0 =A0 struct request_queue *q =3D mq->queue;
> >> > + =A0 =A0 =A0 struct mmc_card *card =3D mq->card;
> >> > + =A0 =A0 =A0 struct request *cur =3D req, *next =3D NULL;
> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> > + =A0 =A0 =A0 bool en_rel_wr =3D card->ext_csd.rel_param & EXT_C=
SD_WR_REL_PARAM_EN;
> >> > + =A0 =A0 =A0 unsigned int req_sectors =3D 0, phys_segments =3D =
0;
> >> > + =A0 =A0 =A0 unsigned int max_blk_count, max_phys_segs;
> >> > + =A0 =A0 =A0 u8 max_packed_rw =3D 0;
> >> > + =A0 =A0 =A0 u8 reqs =3D 0;
> >> > +
> >> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.pac=
ked_event_en)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> > +
> >> > + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D READ)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.ma=
x_packed_reads;
> >> > + =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.ma=
x_packed_writes;
> >> > +
> >> > + =A0 =A0 =A0 if (max_packed_rw =3D=3D 0)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> > +
> >> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MMC_B=
LK_REL_WR) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 max_blk_count =3D min(card->host->max_blk_count,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->max_re=
q_size >> 9);
> >> > + =A0 =A0 =A0 if (unlikely(max_blk_count > 0xffff))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_blk_count =3D 0xffff;
> >> > +
> >> > + =A0 =A0 =A0 max_phys_segs =3D queue_max_segments(q);
> >> > + =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(cur);
> >> > + =A0 =A0 =A0 phys_segments +=3D req->nr_phys_segments;
> >> > +
> >> > + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D WRITE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors++;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments++;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 while (reqs < max_packed_rw - 1) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D blk_fetch_request(q);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(cur) !=3D rq_data_=
dir(next)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_reques=
t(q, next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_req_rel_wr(next) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (m=
d->flags & MMC_BLK_REL_WR) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !e=
n_rel_wr) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_reques=
t(q, next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(ne=
xt);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req_sectors > max_blk_count) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_reques=
t(q, next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_phy=
s_segments;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_segs)=
 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_reques=
t(q, next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> I mentioned this before - if the next request is not packable and =
requeued,
> >> blk_fetch_request will retrieve it again and this while loop will
> >> never terminate.
> >>
> > If next request is not packable, it is requeued and 'break' termina=
tes this loop.
> > So it not infinite.
>=20
> Right !! But that doesn't help finding the commands that are packable=
=2E
> Ideally, you'd need to pack all neighbouring requests into one packed=
 command.
> The way CFQ works, it is not necessary that the fetch would return al=
l
> outstanding
> requests that are packable (unless you invoke a forced dispatch)
>=20
> It would be good to see some numbers on the number of pack hits / mis=
ses that
> you would encounter with this logic, on a typical usecase.
>=20
Is it considered only for CFQ scheduler? How about other I/O scheduler?
If all requests are drained from scheduler queue forcedly,
the number of candidate to be packed can be increased.
However we may lose the unique CFQ's strength and MMC D/D may take the =
CFQ's duty.
Basically, this patch accommodates the origin order requests from I/O s=
cheduler.

> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&next->queuelist, &m=
q->mqrq_cur->packed_list);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D next;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs++;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 if (reqs > 0) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist, &mq->mqr=
q_cur->packed_list);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (reqs + 1);
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > +no_packed:
> >> > + =A0 =A0 =A0 mq->mqrq_cur->packed_cmd =3D MMC_PACKED_NONE;
> >> > + =A0 =A0 =A0 return reqs;
> >> > +}
> >> > +
> >> > +static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *m=
qrq,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct mmc_card *card,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct mmc_queue *mq,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 =
reqs)
> >> > +{
> >> > + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> >> > + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> >> > + =A0 =A0 =A0 struct request *prq;
> >> > + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> >> > + =A0 =A0 =A0 bool do_rel_wr;
> >> > + =A0 =A0 =A0 u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
> >> > + =A0 =A0 =A0 u8 i =3D1;
> >> > +
> >> > + =A0 =A0 =A0 mqrq->packed_cmd =3D (rq_data_dir(req) =3D=3D READ=
) ?
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_PACKED_WR_HDR : MMC_PACKED_WRI=
TE;
> >> > + =A0 =A0 =A0 mqrq->packed_blocks =3D 0;
> >> > + =A0 =A0 =A0 mqrq->packed_fail_idx =3D -1;
> >> > +
> >> > + =A0 =A0 =A0 memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_cmd_=
hdr));
> >> > + =A0 =A0 =A0 packed_cmd_hdr[0] =3D (reqs << 16) |
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((rq_data_dir(req) =3D=3D READ) ?=
 PACKED_CMD_RD: PACKED_CMD_WR) << 8) |
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PACKED_CMD_VER;
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Argument for each entry of packed group
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 list_for_each_entry(prq, &mqrq->packed_list, queue=
list) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_rel_wr =3D mmc_req_rel_wr(prq) =
&& (md->flags & MMC_BLK_REL_WR);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD23*/
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[(i * 2)] =3D (do_re=
l_wr ? MMC_CMD23_ARG_REL_WR : 0) |
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_sectors(prq=
);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD18 or CMD25 */
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[((i * 2)) + 1] =3D =
mmc_card_blockaddr(card) ?
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(prq) : =
blk_rq_pos(prq) << 9;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqrq->packed_blocks +=3D blk_rq_se=
ctors(prq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> >> > + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> >> > + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> >> > + =A0 =A0 =A0 brq->mrq.sbc =3D &brq->sbc;
> >> > + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> >> > +
> >> > + =A0 =A0 =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> >> > + =A0 =A0 =A0 brq->sbc.arg =3D MMC_CMD23_ARG_PACKED |
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((rq_data_dir(req) =3D=3D READ) ? =
1 : mqrq->packed_blocks + 1);
> >> > + =A0 =A0 =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> >> > +
> >> > + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> >> > + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> >> > + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> >> > + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | M=
MC_CMD_ADTC;
> >> > +
> >> > + =A0 =A0 =A0 brq->data.blksz =3D 512;
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Write separately the packd command header onl=
y for packed read.
> >> > + =A0 =A0 =A0 =A0* In case of packed write, header is sent with =
blocks of data.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 brq->data.blocks =3D (rq_data_dir(req) =3D=3D READ=
) ?
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 : mqrq->packed_blocks + 1;
> >> > + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_WRITE;
> >> > +
> >> > + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> > + =A0 =A0 =A0 brq->stop.arg =3D 0;
> >> > + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B =
| MMC_CMD_AC;
> >> > +
> >> > + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> >> > +
> >> > + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> >> > + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> >> > +
> >> > + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> >> > + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_err_=
check;
> >> > +
> >> > + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> >> > +}
> >> > +
> >> > +static void mmc_blk_packed_rrq_prep(struct mmc_queue_req *mqrq,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct mmc_card *card,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct mmc_queue *mq)
> >> > +{
> >> > + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> >> > + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> >> > +
> >> > + =A0 =A0 =A0 mqrq->packed_cmd =3D MMC_PACKED_READ;
> >> > +
> >> > + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> >> > + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> >> > + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> >> > + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> >> > +
> >> > + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> >> > + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> >> > + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> >> > + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | M=
MC_CMD_ADTC;
> >> > + =A0 =A0 =A0 brq->data.blksz =3D 512;
> >> > + =A0 =A0 =A0 brq->data.blocks =3D mqrq->packed_blocks;
> >> > + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_READ;
> >> > +
> >> > + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> > + =A0 =A0 =A0 brq->stop.arg =3D 0;
> >> > + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B =
| MMC_CMD_AC;
> >> > +
> >> > + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> >> > +
> >> > + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> >> > + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> >> > +
> >> > + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> >> > + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_err_=
check;
> >> > +
> >> > + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> >> > +}
> >> > +
> >> > =A0static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mm=
c_card *card,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_b=
lk_request *brq, struct request *req,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret)
> >> > @@ -1166,15 +1434,33 @@ static int mmc_blk_issue_rw_rq(struct mm=
c_queue *mq, struct request *rqc)
> >> > =A0 =A0 =A0 =A0int ret =3D 1, disable_multi =3D 0, retry =3D 0, =
type;
> >> > =A0 =A0 =A0 =A0enum mmc_blk_status status;
> >> > =A0 =A0 =A0 =A0struct mmc_queue_req *mq_rq;
> >> > - =A0 =A0 =A0 struct request *req;
> >> > + =A0 =A0 =A0 struct request *req, *prq;
> >> > =A0 =A0 =A0 =A0struct mmc_async_req *areq;
> >> > + =A0 =A0 =A0 u8 reqs =3D 0;
> >> >
> >> > =A0 =A0 =A0 =A0if (!rqc && !mq->mqrq_prev->req)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> >> >
> >> > + =A0 =A0 =A0 if (rqc)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packable(mq, =
rqc);
> >> > +
> >> > =A0 =A0 =A0 =A0do {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rqc) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep=
(mq->mqrq_cur, card, 0, mq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs >=3D 2) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mm=
c_blk_packed_hdr_wrq_prep(mq->mqrq_cur, card, mq, reqs);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (rq_data_dir(rqc) =3D=3D READ) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 areq =3D &mq->mqrq_cur->mmc_active;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc_wait_for_req(card->host, areq->mrq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 status =3D mmc_blk_packed_err_check(card, areq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 if (status =3D=3D MMC_BLK_SUCCESS) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_packed_rrq_prep(mq->mqrq_cur, card=
, mq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 } else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto check_status;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >>
> >> IIUC, the code in mmc_blk_chk_packable
> >> <snip>
> >> =A0=A0 =A0 =A0 if (reqs > 0) {
> >> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist, &mq->mqrq=
_cur->packed_list);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (reqs + 1);
> >> </snip>
> >> adds the request to the packed list, and needs to be reversed if i=
t's
> >> decided to not to do a packed request ?
> > Any condition or reason =A0not to do packed request after several r=
equests
> > is added in packed list? I didn't catch your comment exactly.
> >
> What I meant was that the request should be removed from queuelist
> when you decide not to pack.
>=20
After request is add to packed list, it needs to decide not to pack?
Could you explain that case?
mmc_blk_chk_packable decides whether packing is possible or not.
If possible, it returns non-zero value.
If not, it return zero. Of course, packed_list is empty in this time.
I don't know what you concern.
> >>
> >>
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mm=
c_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D &mq->mqr=
q_cur->mmc_active;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D NULL;
> >> > @@ -1182,6 +1468,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!areq)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> >> >
> >> > +check_status:
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_rq =3D container_of(areq, stru=
ct mmc_queue_req, mmc_active);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq =3D &mq_rq->brq;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req =3D mq_rq->req;
> >> > @@ -1195,10 +1482,32 @@ static int mmc_blk_issue_rw_rq(struct mm=
c_queue *mq, struct request *rqc)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was su=
ccessfully transferred.
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_reset_suc=
cess(md, type);
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md-=
>lock);
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_=
request(req, 0,
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_=
cmd !=3D MMC_PACKED_NONE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in=
t idx =3D mq_rq->packed_fail_idx, i =3D 0;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wh=
ile (!list_empty(&mq_rq->packed_list)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_list.next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 if (idx =3D=3D i) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* retry from error index */
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs -=3D idx;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->req =3D prq;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ret =3D __blk_end_request(prq, 0, blk_rq_bytes(prq));
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 i++;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 br=
eak;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp=
in_lock_irq(&md->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
t =3D __blk_end_request(req, 0,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->data.bytes_xfered);
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&m=
d->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp=
in_unlock_irq(&md->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > +
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If the blk_end=
_request function returns non-zero even
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * though all dat=
a has been transferred and no errors
> >> > @@ -1257,7 +1566,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >> >
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret && (mq_rq->packed_cmd =3D=3D=
 MMC_PACKED_NONE)) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * In case of a i=
ncomplete request
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * prepare it aga=
in and resend.
> >> > @@ -1270,13 +1579,37 @@ static int mmc_blk_issue_rw_rq(struct mm=
c_queue *mq, struct request *rqc)
> >> > =A0 =A0 =A0 =A0return 1;
> >> >
> >> > =A0cmd_abort:
> >> > - =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> > - =A0 =A0 =A0 while (ret)
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, -EI=
O, blk_rq_cur_bytes(req));
> >> > - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> > + =A0 =A0 =A0 if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_=
request(req, -EIO, blk_rq_cur_bytes(req));
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> > + =A0 =A0 =A0 } else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_empty(&mq_rq->packed_=
list)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prq =3D list_entry=
_rq(mq_rq->packed_list.next);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&prq=
->queuelist);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md-=
>lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __blk_end_request(=
prq, -EIO, blk_rq_bytes(prq));
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&m=
d->lock);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 }
> >> >
> >> > =A0start_new_req:
> >> > =A0 =A0 =A0 =A0if (rqc) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If current request is packed,=
 it need to put back.
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->mqrq_cur->packed_cmd !=3D =
MMC_PACKED_NONE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_empty=
(&mq->mqrq_cur->packed_list)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr=
q =3D list_entry_rq(mq->mqrq_cur->packed_list.prev);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if=
 (prq->queuelist.prev !=3D &mq->mqrq_cur->packed_list) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 blk_requeue_request(mq->queue, prq);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } =
else {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 list_del_init(&prq->queuelist);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_rw_rq_prep(mq->mqrq_cur, =
card, 0, mq);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_start_req(card->host, &mq->mq=
rq_cur->mmc_active, NULL);
> >> > =A0 =A0 =A0 =A0}
> >> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> >> > index dcad59c..3a4542e 100644
> >> > --- a/drivers/mmc/card/queue.c
> >> > +++ b/drivers/mmc/card/queue.c
> >> > @@ -172,6 +172,8 @@ int mmc_init_queue(struct mmc_queue *mq, str=
uct mmc_card *card,
> >> >
> >> > =A0 =A0 =A0 =A0memset(&mq->mqrq_cur, 0, sizeof(mq->mqrq_cur));
> >> > =A0 =A0 =A0 =A0memset(&mq->mqrq_prev, 0, sizeof(mq->mqrq_prev));
> >> > + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_cur->packed_list);
> >> > + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_prev->packed_list);
> >> > =A0 =A0 =A0 =A0mq->mqrq_cur =3D mqrq_cur;
> >> > =A0 =A0 =A0 =A0mq->mqrq_prev =3D mqrq_prev;
> >> > =A0 =A0 =A0 =A0mq->queue->queuedata =3D mq;
> >> > @@ -372,6 +374,39 @@ void mmc_queue_resume(struct mmc_queue *mq)
> >> > =A0 =A0 =A0 =A0}
> >> > =A0}
> >> >
> >> > +static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *m=
q,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct mmc_queue_req *mqrq,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct scatterlist *sg)
> >> > +{
> >> > + =A0 =A0 =A0 struct scatterlist *__sg;
> >> > + =A0 =A0 =A0 unsigned int sg_len =3D 0;
> >> > + =A0 =A0 =A0 struct request *req;
> >> > + =A0 =A0 =A0 enum mmc_packed_cmd cmd;
> >> > +
> >> > + =A0 =A0 =A0 cmd =3D mqrq->packed_cmd;
> >> > +
> >> > + =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HDR || cmd =3D=3D MMC=
_PACKED_WRITE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3Dsg;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_buf(__sg, mqrq->packed_cmd_=
hdr,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 si=
zeof(mqrq->packed_cmd_hdr));
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len++;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HDR) =
{
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_mark_end(__sg);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sg_len;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg->page_link &=3D ~0x02;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 __sg =3D sg + sg_len;
> >> > + =A0 =A0 =A0 list_for_each_entry(req, &mqrq->packed_list, queue=
list) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len +=3D blk_rq_map_sg(mq->queu=
e, req, __sg);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3D sg + (sg_len - 1);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (__sg++)->page_link &=3D ~0x02;
> >> > + =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 sg_mark_end(sg + (sg_len - 1));
> >> > + =A0 =A0 =A0 return sg_len;
> >> > +}
> >> > +
> >> > =A0/*
> >> > =A0* Prepare the sg list(s) to be handed of to the host driver
> >> > =A0*/
> >> > @@ -382,12 +417,19 @@ unsigned int mmc_queue_map_sg(struct mmc_q=
ueue *mq, struct mmc_queue_req
> *mqrq)
> >> > =A0 =A0 =A0 =A0struct scatterlist *sg;
> >> > =A0 =A0 =A0 =A0int i;
> >> >
> >> > - =A0 =A0 =A0 if (!mqrq->bounce_buf)
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(mq->queue, mq=
rq->req, mqrq->sg);
> >> > + =A0 =A0 =A0 if (!mqrq->bounce_buf) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list=
))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_queue_p=
acked_map_sg(mq, mqrq, mqrq->sg);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_=
sg(mq->queue, mqrq->req, mqrq->sg);
> >> > + =A0 =A0 =A0 }
> >> >
> >> > =A0 =A0 =A0 =A0BUG_ON(!mqrq->bounce_sg);
> >> >
> >> > - =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req, mqr=
q->bounce_sg);
> >> > + =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D mmc_queue_packed_map_sg=
(mq, mqrq, mqrq->bounce_sg);
> >> > + =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue=
, mqrq->req, mqrq->bounce_sg);
> >> >
> >> > =A0 =A0 =A0 =A0mqrq->bounce_sg_len =3D sg_len;
> >> >
> >> > diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> >> > index d2a1eb4..5d0131e 100644
> >> > --- a/drivers/mmc/card/queue.h
> >> > +++ b/drivers/mmc/card/queue.h
> >> > @@ -12,6 +12,13 @@ struct mmc_blk_request {
> >> > =A0 =A0 =A0 =A0struct mmc_data =A0 =A0 =A0 =A0 data;
> >> > =A0};
> >> >
> >> > +enum mmc_packed_cmd {
> >> > + =A0 =A0 =A0 MMC_PACKED_NONE =3D 0,
> >> > + =A0 =A0 =A0 MMC_PACKED_WR_HDR,
> >> > + =A0 =A0 =A0 MMC_PACKED_WRITE,
> >> > + =A0 =A0 =A0 MMC_PACKED_READ,
> >> > +};
> >> > +
> >> > =A0struct mmc_queue_req {
> >> > =A0 =A0 =A0 =A0struct request =A0 =A0 =A0 =A0 =A0*req;
> >> > =A0 =A0 =A0 =A0struct mmc_blk_request =A0brq;
> >> > @@ -20,6 +27,11 @@ struct mmc_queue_req {
> >> > =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0*bounce_sg;
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bounce_sg_len=
;
> >> > =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0mmc_active;
> >> > + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0packed_list;
> >> > + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed=
_cmd_hdr[128];
> >> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0packed_blocks;
> >> > + =A0 =A0 =A0 enum mmc_packed_cmd =A0 =A0 packed_cmd;
> >> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 packed_fail_idx;
> >> > =A0};
> >> >
> >> > =A0struct mmc_queue {
> >> > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> >> > index 174a844..3c61d5a 100644
> >> > --- a/include/linux/mmc/core.h
> >> > +++ b/include/linux/mmc/core.h
> >> > @@ -18,6 +18,8 @@ struct mmc_request;
> >> > =A0struct mmc_command {
> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 opcod=
e;
> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arg;
> >> > +#define MMC_CMD23_ARG_REL_WR =A0 (1 << 31)
> >> > +#define MMC_CMD23_ARG_PACKED =A0 ((0 << 31) | (1 << 30))
> >> > =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resp[=
4];
> >> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0flags; =A0 =A0=
 =A0 =A0 =A0/* expected response type */
> >> > =A0#define MMC_RSP_PRESENT =A0 =A0 =A0 =A0(1 << 0)
> >> > @@ -143,6 +145,7 @@ extern int mmc_app_cmd(struct mmc_host *, st=
ruct mmc_card *);
> >> > =A0extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc=
_card *,
> >> > =A0 =A0 =A0 =A0struct mmc_command *, int);
> >> > =A0extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned=
 int);
> >> > +extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)=
;
> >>
> >> Stray change / doesn't belong to this patch.
> > Do you mean to split this in another patch?
> >
> Yes. In fact all the changes to the header files are independent of
> the implementation, so they belong to a separate patch.

I considered your opinion.
But it seems not big trouble even though being kept.

Thanks.
Seungwon Jeon.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
