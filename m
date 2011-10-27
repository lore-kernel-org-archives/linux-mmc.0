From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: core: Add packed command for eMMC4.5 device
Date: Thu, 27 Oct 2011 18:52:59 +0530
Message-ID: <CANfBPZ_i3wcPkBnv-wOYbSUib=0k9bpem3ZGWg4TcjNE9NZywg@mail.gmail.com>
References: <1319712841-28579-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1319712841-28579-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 27, 2011 at 4:24 PM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> This patch supports packed command feature of eMMC4.5 Spec.
> Several reads(or writes) can be grouped in packed command
> and all data of the individual commands can be sent in one
> transfer on the bus.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/card/block.c | =A0349 ++++++++++++++++++++++++++++++++=
++++++++++++--
> =A0drivers/mmc/card/queue.c | =A0 48 ++++++-
> =A0drivers/mmc/card/queue.h | =A0 12 ++
> =A0drivers/mmc/core/mmc.c =A0 | =A0 20 +++
> =A0include/linux/mmc/card.h | =A0 =A03 +
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0| =A0 15 ++
> =A07 files changed, 434 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4fd5723..0258a81 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -45,6 +45,7 @@
> =A0#include <asm/uaccess.h>
>
> =A0#include "queue.h"
> +#include "../core/mmc_ops.h"

I don't think this is the right way to include files.  The core
directory should be in the include path already.

>
> =A0MODULE_ALIAS("mmc:block");
> =A0#ifdef MODULE_PARAM_PREFIX
> @@ -59,6 +60,10 @@ MODULE_ALIAS("mmc:block");
> =A0#define INAND_CMD38_ARG_SECTRIM1 0x81
> =A0#define INAND_CMD38_ARG_SECTRIM2 0x88
>
> +#define mmc_req_rel_wr(req) =A0 =A0(((req->cmd_flags & REQ_FUA) || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_M=
ETA)) && \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D=
 WRITE))
> +
> =A0static DEFINE_MUTEX(block_mutex);
>
> =A0/*
> @@ -943,7 +948,8 @@ static int mmc_blk_err_check(struct mmc_card *car=
d,
> =A0 =A0 =A0 =A0 * kind. =A0If it was a write, we may have transitione=
d to
> =A0 =A0 =A0 =A0 * program mode, which we have to wait for it to compl=
ete.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && rq_data_dir(req) !=3D=
 READ) {
> + =A0 =A0 =A0 if ((!mmc_host_is_spi(card->host) && rq_data_dir(req) !=
=3D READ) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mq_mrq->packed_cmd =3D=
=3D MMC_PACKED_WR_HDR)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 status;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err =3D get_card_s=
tatus(card, &status, 5);
> @@ -980,12 +986,67 @@ static int mmc_blk_err_check(struct mmc_card *c=
ard,
> =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
>
> + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks << 9 !=3D=
 brq->data.bytes_xfered))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PARTIAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_SUCCESS;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
>
> =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> =A0}
>
> +static int mmc_blk_packed_err_check(struct mmc_card *card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_a=
sync_req *areq)
> +{
> + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(areq, str=
uct mmc_queue_req,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> + =A0 =A0 =A0 int err, check, status;
> + =A0 =A0 =A0 u8 ext_csd[512];
> +
> + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> +
> + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_SUCCESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return check;
> +
> + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_PARTIAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_card_status(card, &status, =
0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_ext_cs=
d(card, ext_csd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
MMC_BLK_ABORT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_EX=
P_EVENTS_STATUS + 0] &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_FAILURE) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_PACKED_GENERIC_ERROR)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext=
_csd[EXT_CSD_PACKED_CMD_STATUS] &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PACKED_INDEXED_ERROR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* Make be 0-based */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mq_mrq->packed_fail_idx =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_PACKED_FAILURE_INDEX] - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return MMC_BLK_PARTIAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return MMC_BLK_RETRY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_RETRY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (check !=3D MMC_BLK_ABORT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_RETRY;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_ABORT;
> +}
> +
> =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mm=
c_card *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disab=
le_multi,
> @@ -1126,6 +1187,207 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
> =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> =A0}
>
> +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struct request =
*req)
> +{
> + =A0 =A0 =A0 struct request_queue *q =3D mq->queue;
> + =A0 =A0 =A0 struct mmc_card *card =3D mq->card;
> + =A0 =A0 =A0 struct request *cur =3D req, *next =3D NULL;
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> + =A0 =A0 =A0 bool en_rel_wr =3D card->ext_csd.rel_param & EXT_CSD_WR=
_REL_PARAM_EN;
> + =A0 =A0 =A0 unsigned int req_sectors =3D 0, phys_segments =3D 0;
> + =A0 =A0 =A0 unsigned int max_blk_count, max_phys_segs;
> + =A0 =A0 =A0 u8 max_packed_rw =3D 0;
> + =A0 =A0 =A0 u8 reqs =3D 0;
> +
> + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.packed_e=
vent_en)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> +
> + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D READ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.max_pac=
ked_reads;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_packed_rw =3D card->ext_csd.max_pac=
ked_writes;
> +
> + =A0 =A0 =A0 if (max_packed_rw =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> +
> + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MMC_BLK_RE=
L_WR) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 max_blk_count =3D min(card->host->max_blk_count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->max_req_siz=
e >> 9);
> + =A0 =A0 =A0 max_phys_segs =3D queue_max_segments(q);
> + =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(cur);
> + =A0 =A0 =A0 phys_segments +=3D req->nr_phys_segments;
> +
> + =A0 =A0 =A0 if (rq_data_dir(cur) =3D=3D WRITE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 while (reqs < max_packed_rw - 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D blk_fetch_request(q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!next)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_data_dir(cur) !=3D rq_data_dir(n=
ext)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, =
next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_req_rel_wr(next) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->fl=
ags & MMC_BLK_REL_WR) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel=
_wr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, =
next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_sectors +=3D blk_rq_sectors(next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req_sectors > max_blk_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, =
next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_phys_seg=
ments;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_segs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, =
next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&next->queuelist, &mq->mq=
rq_cur->packed_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs++;
> + =A0 =A0 =A0 }

IIRC, blk_fetch_request gets it from the top of the request_queue and
blk_requeue_request puts it back to the top of the queue
(request_queue->queue_head). Hence, possibly, this loop will keep
fetching and requeing the same request repeatedly ?


> +
> + =A0 =A0 =A0 if (reqs > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&req->queuelist, &mq->mqrq_cur=
->packed_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (reqs + 1);
> + =A0 =A0 =A0 }
> +
> +no_packed:
> + =A0 =A0 =A0 mq->mqrq_cur->packed_cmd =3D MMC_PACKED_NONE;
> + =A0 =A0 =A0 return reqs;
> +}
> +
> +static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct m=
mc_card *card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct m=
mc_queue *mq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 reqs)
> +{
> + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> + =A0 =A0 =A0 struct request *prq;
> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mq->data;
> + =A0 =A0 =A0 bool do_rel_wr;
> + =A0 =A0 =A0 u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
> + =A0 =A0 =A0 u8 i =3D1;
> +
> + =A0 =A0 =A0 mqrq->packed_cmd =3D (rq_data_dir(req) =3D=3D READ) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_PACKED_WR_HDR : MMC_PACKED_WRITE;
> + =A0 =A0 =A0 mqrq->packed_blocks =3D 0;
> + =A0 =A0 =A0 mqrq->packed_fail_idx =3D -1;
> +
> + =A0 =A0 =A0 memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_cmd_hdr))=
;
> + =A0 =A0 =A0 packed_cmd_hdr[0] =3D (reqs << 16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((rq_data_dir(req) =3D=3D READ) ? 0x01=
 : 0x02) << 8) | (0x01 << 0);
> +
Too many magic numbers here.

> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Argument for each entry of packed group
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 list_for_each_entry(prq, &mqrq->packed_list, queuelist)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_rel_wr =3D mmc_req_rel_wr(prq) && (m=
d->flags & MMC_BLK_REL_WR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD23*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[(i * 2)] =3D (do_rel_wr =
? (1 << 31) : 0) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_sectors(prq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Argument of CMD18 or CMD25 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_hdr[((i * 2)) + 1] =3D mmc_c=
ard_blockaddr(card) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(prq) : blk_r=
q_pos(prq) << 9;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqrq->packed_blocks +=3D blk_rq_sectors=
(prq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> + =A0 =A0 =A0 brq->mrq.sbc =3D &brq->sbc;
> + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> +
> + =A0 =A0 =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> + =A0 =A0 =A0 brq->sbc.arg =3D (0 << 31) | (1 << 30) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((rq_data_dir(req) =3D=3D READ) ? 1 : m=
qrq->packed_blocks + 1);

=2E. and here ^^..

> + =A0 =A0 =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CM=
D_ADTC;
> +
> + =A0 =A0 =A0 brq->data.blksz =3D 512;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Write separately the packd command header only for=
 packed read.
> + =A0 =A0 =A0 =A0* In case of packed write, header is sent with block=
s of data.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 brq->data.blocks =3D (rq_data_dir(req) =3D=3D READ) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 : mqrq->packed_blocks + 1;
> + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_WRITE;
> +
> + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> + =A0 =A0 =A0 brq->stop.arg =3D 0;
> + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC=
_CMD_AC;
> +
> + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> +
> + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> +
> + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_err_check=
;
> +
> + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> +}
> +
> +static void mmc_blk_packed_rrq_prep(struct mmc_queue_req *mqrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct m=
mc_card *card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct m=
mc_queue *mq)
> +{
> + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mqrq->brq;
> + =A0 =A0 =A0 struct request *req =3D mqrq->req;
> +
> + =A0 =A0 =A0 mqrq->packed_cmd =3D MMC_PACKED_READ;
> +
> + =A0 =A0 =A0 memset(brq, 0, sizeof(struct mmc_blk_request));
> + =A0 =A0 =A0 brq->mrq.cmd =3D &brq->cmd;
> + =A0 =A0 =A0 brq->mrq.data =3D &brq->data;
> + =A0 =A0 =A0 brq->mrq.stop =3D &brq->stop;
> +
> + =A0 =A0 =A0 brq->cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> + =A0 =A0 =A0 brq->cmd.arg =3D blk_rq_pos(req);
> + =A0 =A0 =A0 if (!mmc_card_blockaddr(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->cmd.arg <<=3D 9;
> + =A0 =A0 =A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CM=
D_ADTC;
> + =A0 =A0 =A0 brq->data.blksz =3D 512;
> + =A0 =A0 =A0 brq->data.blocks =3D mqrq->packed_blocks;
> + =A0 =A0 =A0 brq->data.flags |=3D MMC_DATA_READ;
> +
> + =A0 =A0 =A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> + =A0 =A0 =A0 brq->stop.arg =3D 0;
> + =A0 =A0 =A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC=
_CMD_AC;
> +
> + =A0 =A0 =A0 mmc_set_data_timeout(&brq->data, card);
> +
> + =A0 =A0 =A0 brq->data.sg =3D mqrq->sg;
> + =A0 =A0 =A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> +
> + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_err_check=
;
> +
> + =A0 =A0 =A0 mmc_queue_bounce_pre(mqrq);
> +}
> +
> =A0static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_car=
d *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_blk_re=
quest *brq, struct request *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret)
> @@ -1163,15 +1425,33 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq, struct request *rqc)
> =A0 =A0 =A0 =A0int ret =3D 1, disable_multi =3D 0, retry =3D 0, type;
> =A0 =A0 =A0 =A0enum mmc_blk_status status;
> =A0 =A0 =A0 =A0struct mmc_queue_req *mq_rq;
> - =A0 =A0 =A0 struct request *req;
> + =A0 =A0 =A0 struct request *req, *prq;
> =A0 =A0 =A0 =A0struct mmc_async_req *areq;
> + =A0 =A0 =A0 u8 reqs =3D 0;
>
> =A0 =A0 =A0 =A0if (!rqc && !mq->mqrq_prev->req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 if (rqc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packable(mq, rqc);
> +
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rqc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->=
mqrq_cur, card, 0, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reqs >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk=
_packed_hdr_wrq_prep(mq->mqrq_cur, card, mq, reqs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_=
data_dir(rqc) =3D=3D READ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 areq =3D &mq->mqrq_cur->mmc_active;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_wait_for_req(card->host, areq->mrq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 status =3D mmc_blk_packed_err_check(card, areq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (status =3D=3D MMC_BLK_SUCCESS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_packed_rrq_prep(mq->mqrq_cur, card, mq=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 goto check_status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk=
_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D &mq->mqrq_cur=
->mmc_active;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0areq =3D NULL;
> @@ -1179,6 +1459,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue=
 *mq, struct request *rqc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!areq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> +check_status:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_rq =3D container_of(areq, struct mm=
c_queue_req, mmc_active);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq =3D &mq_rq->brq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req =3D mq_rq->req;
> @@ -1192,10 +1473,32 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq, struct request *rqc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was success=
fully transferred.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_reset_success(=
md, type);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, 0,
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq_rq->packed_cmd !=
=3D MMC_PACKED_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int idx=
 =3D mq_rq->packed_fail_idx, i =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (=
!list_empty(&mq_rq->packed_list)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 prq =3D list_entry_rq(mq_rq->packed_list.next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (idx =3D=3D i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* retry from error index */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 reqs -=3D idx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq->req =3D prq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 list_del_init(&prq->queuelist);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ret =3D __blk_end_request(prq, 0, blk_rq_bytes(prq));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 spin_unlock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lo=
ck_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 __blk_end_request(req, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0brq->data.bytes_xfered);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lo=
ck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If the blk_end_requ=
est function returns non-zero even
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * though all data has=
 been transferred and no errors
> @@ -1254,7 +1557,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue=
 *mq, struct request *rqc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret && (mq_rq->packed_cmd =3D=3D MM=
C_PACKED_NONE)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * In case of a incomp=
lete request
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * prepare it again an=
d resend.
> @@ -1267,13 +1570,37 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq, struct request *rqc)
> =A0 =A0 =A0 =A0return 1;
>
> =A0cmd_abort:
> - =A0 =A0 =A0 spin_lock_irq(&md->lock);
> - =A0 =A0 =A0 while (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, -EIO, bl=
k_rq_cur_bytes(req));
> - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> + =A0 =A0 =A0 if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, -EIO, blk_rq_cur_bytes(req));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_empty(&mq_rq->packed_list)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prq =3D list_entry_rq(m=
q_rq->packed_list.next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&prq->que=
uelist);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __blk_end_request(prq, =
-EIO, blk_rq_bytes(prq));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lo=
ck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0start_new_req:
> =A0 =A0 =A0 =A0if (rqc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If current request is packed, it n=
eed to put back.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->mqrq_cur->packed_cmd !=3D MMC_P=
ACKED_NONE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!list_empty(&mq-=
>mqrq_cur->packed_list)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prq =3D=
 list_entry_rq(mq->mqrq_cur->packed_list.prev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prq=
->queuelist.prev !=3D &mq->mqrq_cur->packed_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 list_del_init(&prq->queuelist);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 blk_requeue_request(mq->queue, prq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 list_del_init(&prq->queuelist);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_rw_rq_prep(mq->mqrq_cur, card,=
 0, mq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_start_req(card->host, &mq->mqrq_cu=
r->mmc_active, NULL);
> =A0 =A0 =A0 =A0}
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index dcad59c..3a4542e 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -172,6 +172,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct m=
mc_card *card,
>
> =A0 =A0 =A0 =A0memset(&mq->mqrq_cur, 0, sizeof(mq->mqrq_cur));
> =A0 =A0 =A0 =A0memset(&mq->mqrq_prev, 0, sizeof(mq->mqrq_prev));
> + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_cur->packed_list);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&mqrq_prev->packed_list);
> =A0 =A0 =A0 =A0mq->mqrq_cur =3D mqrq_cur;
> =A0 =A0 =A0 =A0mq->mqrq_prev =3D mqrq_prev;
> =A0 =A0 =A0 =A0mq->queue->queuedata =3D mq;
> @@ -372,6 +374,39 @@ void mmc_queue_resume(struct mmc_queue *mq)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *mq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mmc_queue_req *mqrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
scatterlist *sg)
> +{
> + =A0 =A0 =A0 struct scatterlist *__sg;
> + =A0 =A0 =A0 unsigned int sg_len =3D 0;
> + =A0 =A0 =A0 struct request *req;
> + =A0 =A0 =A0 enum mmc_packed_cmd cmd;
> +
> + =A0 =A0 =A0 cmd =3D mqrq->packed_cmd;
> +
> + =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HDR || cmd =3D=3D MMC_PACK=
ED_WRITE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3Dsg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_buf(__sg, mqrq->packed_cmd_hdr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
mqrq->packed_cmd_hdr));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd =3D=3D MMC_PACKED_WR_HDR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_mark_end(__sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sg_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg->page_link &=3D ~0x02;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 __sg =3D sg + sg_len;
> + =A0 =A0 =A0 list_for_each_entry(req, &mqrq->packed_list, queuelist)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len +=3D blk_rq_map_sg(mq->queue, re=
q, __sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sg =3D sg + (sg_len - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (__sg++)->page_link &=3D ~0x02;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 sg_mark_end(sg + (sg_len - 1));
> + =A0 =A0 =A0 return sg_len;
> +}
> +
> =A0/*
> =A0* Prepare the sg list(s) to be handed of to the host driver
> =A0*/
> @@ -382,12 +417,19 @@ unsigned int mmc_queue_map_sg(struct mmc_queue =
*mq, struct mmc_queue_req *mqrq)
> =A0 =A0 =A0 =A0struct scatterlist *sg;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (!mqrq->bounce_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(mq->queue, mqrq->r=
eq, mqrq->sg);
> + =A0 =A0 =A0 if (!mqrq->bounce_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_queue_packed=
_map_sg(mq, mqrq, mqrq->sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return blk_rq_map_sg(mq=
->queue, mqrq->req, mqrq->sg);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0BUG_ON(!mqrq->bounce_sg);
>
> - =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bo=
unce_sg);
> + =A0 =A0 =A0 if (!list_empty(&mqrq->packed_list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D mmc_queue_packed_map_sg(mq, =
mqrq, mqrq->bounce_sg);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_len =3D blk_rq_map_sg(mq->queue, mqr=
q->req, mqrq->bounce_sg);
>
> =A0 =A0 =A0 =A0mqrq->bounce_sg_len =3D sg_len;
>
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d2a1eb4..5d0131e 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -12,6 +12,13 @@ struct mmc_blk_request {
> =A0 =A0 =A0 =A0struct mmc_data =A0 =A0 =A0 =A0 data;
> =A0};
>
> +enum mmc_packed_cmd {
> + =A0 =A0 =A0 MMC_PACKED_NONE =3D 0,
> + =A0 =A0 =A0 MMC_PACKED_WR_HDR,
> + =A0 =A0 =A0 MMC_PACKED_WRITE,
> + =A0 =A0 =A0 MMC_PACKED_READ,
> +};
> +
> =A0struct mmc_queue_req {
> =A0 =A0 =A0 =A0struct request =A0 =A0 =A0 =A0 =A0*req;
> =A0 =A0 =A0 =A0struct mmc_blk_request =A0brq;
> @@ -20,6 +27,11 @@ struct mmc_queue_req {
> =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0*bounce_sg;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bounce_sg_len;
> =A0 =A0 =A0 =A0struct mmc_async_req =A0 =A0mmc_active;
> + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0packed_list;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packed_cmd_=
hdr[128];
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0packed_blocks;
> + =A0 =A0 =A0 enum mmc_packed_cmd =A0 =A0 packed_cmd;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 packed_fail_idx;
> =A0};
>
> =A0struct mmc_queue {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3627044..eab01c1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -487,6 +487,9 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 1] << 8 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 2] << 16 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 3] << 24;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_writes =3D ext=
_csd[EXT_CSD_MAX_PACKED_WRITES];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_reads =3D ext_=
csd[EXT_CSD_MAX_PACKED_READS];
> =A0 =A0 =A0 =A0}
>
> =A0out:
> @@ -1072,6 +1075,23 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.cache_ctrl =3D err ? 0 :=
 1;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pack=
ed_writes > 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pack=
ed_reads > 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_EXP_EVENTS_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_PACKED_EVENT_EN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.generic_cmd6_time);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enablin=
g packed event failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.packed_ev=
ent_en =3D 1;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (!oldcard)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->card =3D card;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 6e04e10..3ffd93f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -52,6 +52,9 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_con=
fig;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_ct=
rl;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rst_n_fu=
nction;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_packe=
d_writes;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_packe=
d_reads;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packed_ev=
ent_en;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time;=
 =A0 =A0 =A0/* Units: 10ms */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index a3ac9c4..d2e4210 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -242,6 +242,7 @@ struct mmc_host {
> =A0#define MMC_CAP2_CACHE_CTRL =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Allo=
w cache control */
> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify pow=
eroff supported */
> =A0#define MMC_CAP2_NO_MULTI_READ (1 << 3) =A0 =A0 =A0 =A0/* Multiblo=
ck reads don't work */
> +#define MMC_CAP2_PACKED_CMD =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* Allow =
packed command */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 0e71356..1988780 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx, =
b (4 bits) */
> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* sx=
, a */
> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* sx, c */
> +#define R1_EXP_EVENT =A0 =A0 =A0 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* =
sr, a */
> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0=
/* sr, c */
>
> =A0#define R1_STATE_IDLE =A00
> @@ -273,6 +274,10 @@ struct _mmc_csd {
> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0/=
* W */
> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0/=
* R/W */
> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
> +#define EXT_CSD_PACKED_FAILURE_INDEX =A0 35 =A0 =A0 =A0/* RO */
> +#define EXT_CSD_PACKED_CMD_STATUS =A0 =A0 =A036 =A0 =A0 =A0/* RO */
> +#define EXT_CSD_EXP_EVENTS_STATUS =A0 =A0 =A054 =A0 =A0 =A0/* RO, 2 =
bytes */
> +#define EXT_CSD_EXP_EVENTS_CTRL =A0 =A0 =A0 =A056 =A0 =A0 =A0/* R/W,=
 2 bytes */
> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/=
W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> @@ -313,6 +318,8 @@ struct _mmc_csd {
> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* =
RO, 4 bytes */
> +#define EXT_CSD_MAX_PACKED_WRITES =A0 =A0 =A0500 =A0 =A0 /* RO */
> +#define EXT_CSD_MAX_PACKED_READS =A0 =A0 =A0 501 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO=
 */
>
> =A0/*
> @@ -364,6 +371,14 @@ struct _mmc_csd {
> =A0#define EXT_CSD_PWR_CL_4BIT_MASK =A0 =A0 =A0 0x0F =A0 =A0/* 8 bit =
PWR CLS */
> =A0#define EXT_CSD_PWR_CL_8BIT_SHIFT =A0 =A0 =A04
> =A0#define EXT_CSD_PWR_CL_4BIT_SHIFT =A0 =A0 =A00
> +
> +#define EXT_CSD_PACKED_EVENT_EN =A0 =A0 =A0 =A0(1<<3)
> +
> +#define EXT_CSD_PACKED_FAILURE (1<<3)
> +
> +#define EXT_CSD_PACKED_GENERIC_ERROR =A0 (1<<0)
> +#define EXT_CSD_PACKED_INDEXED_ERROR =A0 (1<<1)
> +
> =A0/*
> =A0* MMC_SWITCH access modes
> =A0*/
> --
> 1.7.2.3
>

It'd be helpful if you split this patch into several smaller ones for
easier review.
Also please copy linux-kernel mailing list for wider review.
