From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Wed, 25 Jan 2012 14:18:35 +0900
Message-ID: <002501ccdb20$c98b2e80$5ca18b80$%jun@samsung.com>
References: <002701ccd728$edab9350$c902b9f0$%jun@samsung.com>
 <CAKLKtzddDXhbT6o8XUsMxad9+_a_StJCQz+eBnfQ+q+xLuJQKg@mail.gmail.com>
 <CAKYAXd8A70X1gb-NFHVDMXd-aSG6+Y3PWvRTZDMT3-Ze3aF5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13235 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab2AYFTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2012 00:19:01 -0500
In-reply-to: <CAKYAXd8A70X1gb-NFHVDMXd-aSG6+Y3PWvRTZDMT3-Ze3aF5Yw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Namjae Jeon' <linkinjeon@gmail.com>
Cc: 'Saugata Das' <saugata.das@linaro.org>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org

Hi, Namjae Jeon.

Namjae Jeon <linkinjeon@gmail.com> wrote:
> 2012/1/23 Saugata Das <saugata.das@linaro.org>:
> > On 20 January 2012 09:36, Seungwon Jeon <tgih.jun@samsung.com> wrot=
e:
> >> This patch supports packed command of eMMC4.5 device.
> >> Several reads(or writes) can be grouped in packed command
> >> and all data of the individual commands can be sent in a
> >> single transfer on the bus.
> >>
> >> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> ---
> >>  drivers/mmc/card/block.c   |  469 +++++++++++++++++++++++++++++++=
++++++++++---
> >>  drivers/mmc/card/queue.c   |   48 +++++-
> >>  drivers/mmc/card/queue.h   |   13 ++
> >>  drivers/mmc/core/host.c    |    2 +
> >>  drivers/mmc/core/mmc_ops.c |    1 +
> >>  include/linux/mmc/core.h   |    3 +
> >>  include/linux/mmc/host.h   |    3 +
> >>  7 files changed, 512 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >> index 176b78e..77d457e 100644
> >> --- a/drivers/mmc/card/block.c
> >> +++ b/drivers/mmc/card/block.c
> >> @@ -59,6 +59,13 @@ MODULE_ALIAS("mmc:block");
> >>  #define INAND_CMD38_ARG_SECTRIM1 0x81
> >>  #define INAND_CMD38_ARG_SECTRIM2 0x88
> >>
> >> +#define mmc_req_rel_wr(req)    (((req->cmd_flags & REQ_FUA) || \
> >> +                       (req->cmd_flags & REQ_META)) && \
> >> +                       (rq_data_dir(req) =3D=3D WRITE))
> Hi. Seungwon.
> If you make this macro, you should replace this macro from code in
> other function.
> here is the point.
> ---------------------------------------------------------------------=
------
> static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_card *card,
>                                int disable_multi,
>                                struct mmc_queue *mq)
> ....
> ....
> /*
>          * Reliable writes are used to implement Forced Unit Access a=
nd
>          * REQ_META accesses, and are supported only on MMCs.
>          *
>          * XXX: this really needs a good explanation of why REQ_META
>          * is treated special.
>          */
> -        bool do_rel_wr =3D ((req->cmd_flags & REQ_FUA) ||
> -                          (req->cmd_flags & REQ_META)) &&
> -                (rq_data_dir(req) =3D=3D WRITE) &&
> +        bool do_rel_wr =3D mmc_req_rel_wr(req) &&
>                 (md->flags & MMC_BLK_REL_WR);
> ---------------------------------------------------------------------=
-------------------------------
Yes, it would be good.
It seems not directly related to patch of packed command.
I didn't want to touch this part in this commit.

Thanks,
Seungwon Jeon.
>=20
>=20
> >> +#define PACKED_CMD_VER         0x01
> >> +#define PACKED_CMD_RD          0x01
> >> +#define PACKED_CMD_WR          0x02
> >> +
> >>  static DEFINE_MUTEX(block_mutex);
> >>
> >>  /*
> >> @@ -99,6 +106,7 @@ struct mmc_blk_data {
> >>  #define MMC_BLK_WRITE          BIT(1)
> >>  #define MMC_BLK_DISCARD                BIT(2)
> >>  #define MMC_BLK_SECDISCARD     BIT(3)
> >> +#define MMC_BLK_WR_HDR         BIT(4)
> >>
> >>        /*
> >>         * Only set in main mmc_blk_data associated
> >> @@ -1028,7 +1036,8 @@ static int mmc_blk_err_check(struct mmc_card=
 *card,
> >>         * kind.  If it was a write, we may have transitioned to
> >>         * program mode, which we have to wait for it to complete.
> >>         */
> >> -       if (!mmc_host_is_spi(card->host) && rq_data_dir(req) !=3D =
READ) {
> >> +       if ((!mmc_host_is_spi(card->host) && rq_data_dir(req) !=3D=
 READ) ||
> >> +                       (mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_H=
DR)) {
> >>                u32 status;
> >>                do {
> >>                        int err =3D get_card_status(card, &status, =
5);
> >> @@ -1053,7 +1062,8 @@ static int mmc_blk_err_check(struct mmc_card=
 *card,
> >>                       (unsigned)blk_rq_sectors(req),
> >>                       brq->cmd.resp[0], brq->stop.resp[0]);
> >>
> >> -               if (rq_data_dir(req) =3D=3D READ) {
> >> +               if (rq_data_dir(req) =3D=3D READ &&
> >> +                               mq_mrq->packed_cmd !=3D MMC_PACKED=
_WR_HDR) {
> >>                        if (ecc_err)
> >>                                return MMC_BLK_ECC_ERR;
> >>                        return MMC_BLK_DATA_ERR;
> >> @@ -1065,12 +1075,60 @@ static int mmc_blk_err_check(struct mmc_ca=
rd *card,
> >>        if (!brq->data.bytes_xfered)
> >>                return MMC_BLK_RETRY;
> >>
> >> +       if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> >> +               if (unlikely(brq->data.blocks << 9 !=3D brq->data.=
bytes_xfered))
> >> +                       return MMC_BLK_PARTIAL;
> >> +               else
> >> +                       return MMC_BLK_SUCCESS;
> >> +       }
> >> +
> >>        if (blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
> >>                return MMC_BLK_PARTIAL;
> >>
> >>        return MMC_BLK_SUCCESS;
> >>  }
> >>
> >> +static int mmc_blk_packed_err_check(struct mmc_card *card,
> >> +                            struct mmc_async_req *areq)
> >> +{
> >> +       struct mmc_queue_req *mq_rq =3D container_of(areq, struct =
mmc_queue_req,
> >> +                       mmc_active);
> >> +       struct request *req =3D mq_rq->req;
> >> +       int err, check, status;
> >> +       u8 ext_csd[512];
> >> +
> >> +       check =3D mmc_blk_err_check(card, areq);
> >> +       err =3D get_card_status(card, &status, 0);
> >> +       if (err) {
> >> +               pr_err("%s: error %d sending status command\n",
> >> +                               req->rq_disk->disk_name, err);
> >> +               return MMC_BLK_ABORT;
> >> +       }
> >> +
> >> +       if (status & R1_EXP_EVENT) {
> >> +               err =3D mmc_send_ext_csd(card, ext_csd);
> >> +               if (err) {
> >> +                       pr_err("%s: error %d sending ext_csd\n",
> >> +                                       req->rq_disk->disk_name, e=
rr);
> >> +                       return MMC_BLK_ABORT;
> >> +               }
> >> +
> >> +               if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS] &
> >> +                                       EXT_CSD_PACKED_FAILURE) &&
> >> +                               (ext_csd[EXT_CSD_PACKED_CMD_STATUS=
] &
> >> +                                EXT_CSD_PACKED_GENERIC_ERROR)) {
> >> +                       if (ext_csd[EXT_CSD_PACKED_CMD_STATUS] &
> >> +                                       EXT_CSD_PACKED_INDEXED_ERR=
OR) {
> >> +                               mq_rq->packed_fail_idx =3D
> >> +                                       ext_csd[EXT_CSD_PACKED_FAI=
LURE_INDEX] - 1;
> >> +                               return MMC_BLK_PARTIAL;
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       return check;
> >> +}
> >> +
> >>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >>                               struct mmc_card *card,
> >>                               int disable_multi,
> >> @@ -1225,10 +1283,238 @@ static void mmc_blk_rw_rq_prep(struct mmc=
_queue_req *mqrq,
> >>        mmc_queue_bounce_pre(mqrq);
> >>  }
> >>
> >> +static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct r=
equest *req)
> >> +{
> >> +       struct request_queue *q =3D mq->queue;
> >> +       struct mmc_card *card =3D mq->card;
> >> +       struct request *cur =3D req, *next =3D NULL;
> >> +       struct mmc_blk_data *md =3D mq->data;
> >> +       bool en_rel_wr =3D card->ext_csd.rel_param & EXT_CSD_WR_RE=
L_PARAM_EN;
> >> +       unsigned int req_sectors =3D 0, phys_segments =3D 0;
> >> +       unsigned int max_blk_count, max_phys_segs;
> >> +       u8 put_back =3D 0;
> >> +       u8 max_packed_rw =3D 0;
> >> +       u8 reqs =3D 0;
> >> +
> >> +       mq->mqrq_cur->packed_num =3D 0;
> >> +
> >> +       if (!(md->flags & MMC_BLK_CMD23) ||
> >> +                       !card->ext_csd.packed_event_en)
> >> +               goto no_packed;
> >> +
> >> +       if (rq_data_dir(cur) =3D=3D READ)
> >> +               max_packed_rw =3D card->ext_csd.max_packed_reads;
> >> +       else
> >> +               max_packed_rw =3D card->ext_csd.max_packed_writes;
> >> +
> >> +       if (max_packed_rw =3D=3D 0)
> >> +               goto no_packed;
> >> +
> >> +       if (mmc_req_rel_wr(cur) &&
> >> +                       (md->flags & MMC_BLK_REL_WR) &&
> >> +                       !en_rel_wr) {
> >> +               goto no_packed;
> >> +       }
> >
> > Is there any reason of not allowing reliable write on packed comman=
d ?
> > I think, it may get benefit from the packed command since reliable
> > writes are typically very small transfer (e.g. meta-data).
> >
> >> +
> >> +       max_blk_count =3D min(card->host->max_blk_count,
> >> +                       card->host->max_req_size >> 9);
> >> +       if (unlikely(max_blk_count > 0xffff))
> >> +               max_blk_count =3D 0xffff;
> >> +
> >> +       max_phys_segs =3D queue_max_segments(q);
> >> +       req_sectors +=3D blk_rq_sectors(cur);
> >> +       phys_segments +=3D req->nr_phys_segments;
> >> +
> >> +       if (rq_data_dir(cur) =3D=3D WRITE) {
> >> +               req_sectors++;
> >> +               phys_segments++;
> >> +       }
> >> +
> >> +       while (reqs < max_packed_rw - 1) {
> >> +               spin_lock_irq(q->queue_lock);
> >> +               next =3D blk_fetch_request(q);
> >> +               spin_unlock_irq(q->queue_lock);
> >> +               if (!next)
> >> +                       break;
> >> +
> >> +               if (next->cmd_flags & REQ_DISCARD ||
> >> +                               next->cmd_flags & REQ_FLUSH) {
> >> +                       put_back =3D 1;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (rq_data_dir(cur) !=3D rq_data_dir(next)) {
> >> +                       put_back =3D 1;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (mmc_req_rel_wr(next) &&
> >> +                               (md->flags & MMC_BLK_REL_WR) &&
> >> +                               !en_rel_wr) {
> >> +                       put_back =3D 1;
> >> +                       break;
> >> +               }
> >> +
> >> +               req_sectors +=3D blk_rq_sectors(next);
> >> +               if (req_sectors > max_blk_count) {
> >> +                       put_back =3D 1;
> >> +                       break;
> >> +               }
> >> +
> >> +               phys_segments +=3D  next->nr_phys_segments;
> >> +               if (phys_segments > max_phys_segs) {
> >> +                       put_back =3D 1;
> >> +                       break;
> >> +               }
> >> +
> >> +               list_add_tail(&next->queuelist, &mq->mqrq_cur->pac=
ked_list);
> >> +               cur =3D next;
> >> +               reqs++;
> >> +       }
> >> +
> >> +       if (put_back) {
> >> +               spin_lock_irq(q->queue_lock);
> >> +               blk_requeue_request(q, next);
> >> +               spin_unlock_irq(q->queue_lock);
> >> +       }
> >> +
> >> +       if (reqs > 0) {
> >> +               list_add(&req->queuelist, &mq->mqrq_cur->packed_li=
st);
> >> +               mq->mqrq_cur->packed_num =3D ++reqs;
> >> +               return reqs;
> >> +       }
> >> +
> >> +no_packed:
> >> +       mq->mqrq_cur->packed_cmd =3D MMC_PACKED_NONE;
> >> +       mq->mqrq_cur->packed_num =3D 0;
> >> +       return 0;
> >> +}
> >> +
> >> +static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqr=
q,
> >> +                              struct mmc_card *card,
> >> +                              struct mmc_queue *mq,
> >> +                              u8 reqs)
> >> +{
> >> +       struct mmc_blk_request *brq =3D &mqrq->brq;
> >> +       struct request *req =3D mqrq->req;
> >> +       struct request *prq;
> >> +       struct mmc_blk_data *md =3D mq->data;
> >> +       bool do_rel_wr;
> >> +       u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
> >> +       u8 i =3D 1;
> >> +
> >> +       mqrq->packed_cmd =3D (rq_data_dir(req) =3D=3D READ) ?
> >> +               MMC_PACKED_WR_HDR : MMC_PACKED_WRITE;
> >> +       mqrq->packed_blocks =3D 0;
> >> +       mqrq->packed_fail_idx =3D -1;
> >> +
> >> +       memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_cmd_hdr));
> >> +       packed_cmd_hdr[0] =3D (reqs << 16) |
> >> +               (((rq_data_dir(req) =3D=3D READ) ?
> >> +                 PACKED_CMD_RD : PACKED_CMD_WR) << 8) |
> >> +               PACKED_CMD_VER;
> >> +
> >> +       /*
> >> +        * Argument for each entry of packed group
> >> +        */
> >> +       list_for_each_entry(prq, &mqrq->packed_list, queuelist) {
> >> +               do_rel_wr =3D mmc_req_rel_wr(prq) && (md->flags & =
MMC_BLK_REL_WR);
> >> +               /* Argument of CMD23*/
> >> +               packed_cmd_hdr[(i * 2)] =3D (do_rel_wr ? MMC_CMD23=
_ARG_REL_WR : 0) |
> >> +                       blk_rq_sectors(prq);
> >
> > The data tag flag is missed here. I think, we can have a common
> > function which sets the CMD23 flags in both
> > mmc_blk_packed_hdr_wrq_prep and mmc_blk_rw_rq_prep. This will be
> > useful when intergrating the next features (e.g. context id)
> >
> >> +               /* Argument of CMD18 or CMD25 */
> >> +               packed_cmd_hdr[((i * 2)) + 1] =3D mmc_card_blockad=
dr(card) ?
> >> +                       blk_rq_pos(prq) : blk_rq_pos(prq) << 9;
> >> +               mqrq->packed_blocks +=3D blk_rq_sectors(prq);
> >> +               i++;
> >> +       }
> >> +
> >> +       memset(brq, 0, sizeof(struct mmc_blk_request));
> >> +       brq->mrq.cmd =3D &brq->cmd;
> >> +       brq->mrq.data =3D &brq->data;
> >> +       brq->mrq.sbc =3D &brq->sbc;
> >> +       brq->mrq.stop =3D &brq->stop;
> >> +
> >> +       brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> >> +       brq->sbc.arg =3D MMC_CMD23_ARG_PACKED |
> >> +               ((rq_data_dir(req) =3D=3D READ) ? 1 : mqrq->packed=
_blocks + 1);
> >> +       brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> >> +
> >> +       brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> >> +       brq->cmd.arg =3D blk_rq_pos(req);
> >> +       if (!mmc_card_blockaddr(card))
> >> +               brq->cmd.arg <<=3D 9;
> >> +       brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_A=
DTC;
> >> +
> >> +       brq->data.blksz =3D 512;
> >> +       /*
> >> +        * Write separately the packd command header only for pack=
ed read.
> >> +        * In case of packed write, header is sent with blocks of =
data.
> >> +        */
> >> +       brq->data.blocks =3D (rq_data_dir(req) =3D=3D READ) ?
> >> +               1 : mqrq->packed_blocks + 1;
> >> +       brq->data.flags |=3D MMC_DATA_WRITE;
> >> +
> >> +       brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> +       brq->stop.arg =3D 0;
> >> +       brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CM=
D_AC;
> >> +
> >
> > We do not need MMC_STOP_TRANSMISSION when we use MMC_SET_BLOCK_COUN=
T
> >
> >> +       mmc_set_data_timeout(&brq->data, card);
> >> +
> >> +       brq->data.sg =3D mqrq->sg;
> >> +       brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> >> +
> >> +       mqrq->mmc_active.mrq =3D &brq->mrq;
> >> +       mqrq->mmc_active.err_check =3D mmc_blk_packed_err_check;
> >> +
> >> +       mmc_queue_bounce_pre(mqrq);
> >> +}
> >> +
> >> +static void mmc_blk_packed_rrq_prep(struct mmc_queue_req *mqrq,
> >> +                              struct mmc_card *card,
> >> +                              struct mmc_queue *mq)
> >> +{
> >> +       struct mmc_blk_request *brq =3D &mqrq->brq;
> >> +       struct request *req =3D mqrq->req;
> >> +
> >> +       mqrq->packed_cmd =3D MMC_PACKED_READ;
> >> +
> >> +       memset(brq, 0, sizeof(struct mmc_blk_request));
> >> +       brq->mrq.cmd =3D &brq->cmd;
> >> +       brq->mrq.data =3D &brq->data;
> >> +       brq->mrq.stop =3D &brq->stop;
> >> +
> >> +       brq->cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> >> +       brq->cmd.arg =3D blk_rq_pos(req);
> >> +       if (!mmc_card_blockaddr(card))
> >> +               brq->cmd.arg <<=3D 9;
> >> +       brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_A=
DTC;
> >> +       brq->data.blksz =3D 512;
> >> +       brq->data.blocks =3D mqrq->packed_blocks;
> >> +       brq->data.flags |=3D MMC_DATA_READ;
> >> +
> >> +       brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
> >> +       brq->stop.arg =3D 0;
> >> +       brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CM=
D_AC;
> >> +
> >> +       mmc_set_data_timeout(&brq->data, card);
> >> +
> >> +       brq->data.sg =3D mqrq->sg;
> >> +       brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
> >> +
> >> +       mqrq->mmc_active.mrq =3D &brq->mrq;
> >> +       mqrq->mmc_active.err_check =3D mmc_blk_packed_err_check;
> >> +
> >> +       mmc_queue_bounce_pre(mqrq);
> >> +}
> >> +
> >>  static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_ca=
rd *card,
> >>                           struct mmc_blk_request *brq, struct requ=
est *req,
> >>                           int ret)
> >>  {
> >> +       struct mmc_queue_req *mq_rq;
> >> +       mq_rq =3D container_of(brq, struct mmc_queue_req, brq);
> >> +
> >>        /*
> >>         * If this is an SD card and we're writing, we can first
> >>         * mark the known good sectors as ok.
> >> @@ -1247,13 +1533,65 @@ static int mmc_blk_cmd_err(struct mmc_blk_=
data *md, struct mmc_card *card,
> >>                        spin_unlock_irq(&md->lock);
> >>                }
> >>        } else {
> >> -               spin_lock_irq(&md->lock);
> >> -               ret =3D __blk_end_request(req, 0, brq->data.bytes_=
xfered);
> >> -               spin_unlock_irq(&md->lock);
> >> +               if (mq_rq->packed_cmd =3D=3D MMC_PACKED_NONE) {
> >> +                       spin_lock_irq(&md->lock);
> >> +                       ret =3D __blk_end_request(req, 0, brq->dat=
a.bytes_xfered);
> >> +                       spin_unlock_irq(&md->lock);
> >> +               }
> >>        }
> >>        return ret;
> >>  }
> >>
> >> +static int mmc_blk_chk_hdr_err(struct mmc_queue *mq, int status)
> >> +{
> >> +       struct mmc_blk_data *md =3D mq->data;
> >> +       struct mmc_card *card =3D md->queue.card;
> >> +       int type =3D MMC_BLK_WR_HDR, err =3D 0;
> >> +
> >> +       switch (status) {
> >> +       case MMC_BLK_PARTIAL:
> >> +       case MMC_BLK_RETRY:
> >> +               err =3D 0;
> >> +               break;
> >> +       case MMC_BLK_CMD_ERR:
> >> +       case MMC_BLK_ABORT:
> >> +       case MMC_BLK_DATA_ERR:
> >> +       case MMC_BLK_ECC_ERR:
> >> +               err =3D mmc_blk_reset(md, card->host, type);
> >> +               if (!err)
> >> +                       mmc_blk_reset_success(md, type);
> >> +               break;
> >> +       }
> >> +
> >> +       return err;
> >> +}
> >> +
> >> +static int mmc_blk_issue_packed_rd(struct mmc_queue *mq,
> >> +               struct mmc_queue_req *mq_rq)
> >> +{
> >> +       struct mmc_blk_data *md =3D mq->data;
> >> +       struct mmc_card *card =3D md->queue.card;
> >> +       int status, ret =3D -EIO, retry =3D 2;
> I think that EIO of ret is not needed. there is no case to be skipped
> if/ese condition in do while loop.
>=20
> >> +
> >> +       do {
> >> +               mmc_start_req(card->host, NULL, (int *) &status);
> >> +               if (status) {
> >> +                       ret =3D mmc_blk_chk_hdr_err(mq, status);
> >> +                       if (ret)
> >> +                               break;
> >> +                       mmc_blk_packed_hdr_wrq_prep(mq_rq, card, m=
q, mq_rq->packed_num);
> >> +                       mmc_start_req(card->host, &mq_rq->mmc_acti=
ve, NULL);
> >> +               } else {
> >> +                       mmc_blk_packed_rrq_prep(mq_rq, card, mq);
> >> +                       mmc_start_req(card->host, &mq_rq->mmc_acti=
ve, NULL);
> >> +                       ret =3D 0;
> >> +                       break;
> >> +               }
> >> +       } while (retry-- > 0);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>  static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct reque=
st *rqc)
> >>  {
> >>        struct mmc_blk_data *md =3D mq->data;
> >> @@ -1262,21 +1600,32 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
> >>        int ret =3D 1, disable_multi =3D 0, retry =3D 0, type;
> >>        enum mmc_blk_status status;
> >>        struct mmc_queue_req *mq_rq;
> >> -       struct request *req;
> >> +       struct request *req, *prq;
> >>        struct mmc_async_req *areq;
> >> +       u8 reqs =3D 0;
> >>
> >>        if (!rqc && !mq->mqrq_prev->req)
> >>                return 0;
> >>
> >> +       if (rqc)
> >> +               reqs =3D mmc_blk_prep_packed_list(mq, rqc);
> >> +
> >>        do {
> >>                if (rqc) {
> >> -                       mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, =
mq);
> >> +                       if (reqs >=3D card->host->packed_min)
> >> +                               mmc_blk_packed_hdr_wrq_prep(mq->mq=
rq_cur, card, mq, reqs);
> >> +                       else
> >> +                               mmc_blk_rw_rq_prep(mq->mqrq_cur, c=
ard, 0, mq);
> >>                        areq =3D &mq->mqrq_cur->mmc_active;
> >>                } else
> >>                        areq =3D NULL;
> >>                areq =3D mmc_start_req(card->host, areq, (int *) &s=
tatus);
> >> -               if (!areq)
> >> -                       return 0;
> >> +               if (!areq) {
> >> +                       if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PA=
CKED_WR_HDR)
> >> +                               goto snd_packed_rd;
> >
> > How the condition, when (areq is not NULL) and
> > (mq->mqrq_cur->packed_cmd =3D MMC_PACKED_WR_HDR) handled ?
> >
> >> +                       else
> >> +                               return 0;
> >> +               }
> >>
> >>                mq_rq =3D container_of(areq, struct mmc_queue_req, =
mmc_active);
> >>                brq =3D &mq_rq->brq;
> >> @@ -1291,10 +1640,38 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
> >>                         * A block was successfully transferred.
> >>                         */
> >>                        mmc_blk_reset_success(md, type);
> >> -                       spin_lock_irq(&md->lock);
> >> -                       ret =3D __blk_end_request(req, 0,
> >> +
> >> +                       if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE=
) {
> >> +                               int idx =3D mq_rq->packed_fail_idx=
, i =3D 0;
> >> +                               while (!list_empty(&mq_rq->packed_=
list)) {
> >> +                                       prq =3D list_entry_rq(mq_r=
q->packed_list.next);
> >> +                                       list_del_init(&prq->queuel=
ist);
> >> +                                       if (idx =3D=3D i) {
> >
> > I think, in case of no error (packed_fail_idx=3D0) and when (i=3D0)=
, this
> > above "if" condition will satisfy and subsequently wrongly retry.
> >
> >> +                                               /* retry from erro=
r index */
> >> +                                               mq_rq->packed_num =
-=3D idx;
> >> +                                               if (mq_rq->packed_=
num =3D=3D 1) {
> >> +                                                       mq_rq->pac=
ked_cmd =3D MMC_PACKED_NONE;
> >> +                                                       mq_rq->pac=
ked_num =3D 0;
> >> +                                               }
> >> +                                               mq_rq->req =3D prq=
;
> >> +                                               ret =3D 1;
> >> +                                               break;
> >> +                                       }
> >> +                                       spin_lock_irq(&md->lock);
> >> +                                       ret =3D __blk_end_request(=
prq, 0, blk_rq_bytes(prq));
> >> +                                       spin_unlock_irq(&md->lock)=
;
> >> +                                       i++;
> >> +                               }
> >> +                               if (idx =3D=3D -1)
> >> +                                       mq_rq->packed_num =3D 0;
> >> +                               break;
> >> +                       } else {
> >> +                               spin_lock_irq(&md->lock);
> >> +                               ret =3D __blk_end_request(req, 0,
> >>                                                brq->data.bytes_xfe=
red);
> >> -                       spin_unlock_irq(&md->lock);
> >> +                               spin_unlock_irq(&md->lock);
> >> +                       }
> >> +
> >>                        /*
> >>                         * If the blk_end_request function returns =
non-zero even
> >>                         * though all data has been transferred and=
 no errors
> >> @@ -1329,6 +1706,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue *mq, struct request *rqc)
> >>                                break;
> >>                        if (err =3D=3D -ENODEV)
> >>                                goto cmd_abort;
> >> +                       if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE=
)
> >> +                               break;
> >>                        /* Fall through */
> >>                }
> >>                case MMC_BLK_ECC_ERR:
> >> @@ -1356,27 +1735,69 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
> >>                }
> >>
> >>                if (ret) {
> >> -                       /*
> >> -                        * In case of a incomplete request
> >> -                        * prepare it again and resend.
> >> -                        */
> >> -                       mmc_blk_rw_rq_prep(mq_rq, card, disable_mu=
lti, mq);
> >> -                       mmc_start_req(card->host, &mq_rq->mmc_acti=
ve, NULL);
> >> +                       if (mq_rq->packed_cmd =3D=3D MMC_PACKED_NO=
NE) {
> >> +                               /*
> >> +                                * In case of a incomplete request
> >> +                                * prepare it again and resend.
> >> +                                */
> >> +                               mmc_blk_rw_rq_prep(mq_rq, card, di=
sable_multi, mq);
> >> +                               mmc_start_req(card->host, &mq_rq->=
mmc_active, NULL);
> >> +                       } else {
> >> +                               mmc_blk_packed_hdr_wrq_prep(mq_rq,=
 card, mq, mq_rq->packed_num);
> >> +                               mmc_start_req(card->host, &mq_rq->=
mmc_active, NULL);
> >> +                               if (mq_rq->packed_cmd =3D=3D MMC_P=
ACKED_WR_HDR) {
> >> +                                       if (mmc_blk_issue_packed_r=
d(mq, mq_rq))
> >> +                                               goto cmd_abort;
> >> +                               }
> >> +                       }
> >>                }
> >>        } while (ret);
> >>
> >> +snd_packed_rd:
> >> +       if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PACKED_WR_HDR) {
> >> +               if (mmc_blk_issue_packed_rd(mq, mq->mqrq_cur))
> >> +                       goto start_new_req;
> >> +       }
> >>        return 1;
> >>
> >>  cmd_abort:
> >> -       spin_lock_irq(&md->lock);
> >> -       if (mmc_card_removed(card))
> >> -               req->cmd_flags |=3D REQ_QUIET;
> >> -       while (ret)
> >> -               ret =3D __blk_end_request(req, -EIO, blk_rq_cur_by=
tes(req));
> >> -       spin_unlock_irq(&md->lock);
> >> +       if (mq_rq->packed_cmd =3D=3D MMC_PACKED_NONE) {
> >> +               spin_lock_irq(&md->lock);
> >> +               if (mmc_card_removed(card))
> >> +                       req->cmd_flags |=3D REQ_QUIET;
> >> +               while (ret)
> >> +                       ret =3D __blk_end_request(req, -EIO, blk_r=
q_cur_bytes(req));
> >> +               spin_unlock_irq(&md->lock);
> >> +       } else {
> >> +               while (!list_empty(&mq_rq->packed_list)) {
> >> +                       prq =3D list_entry_rq(mq_rq->packed_list.n=
ext);
> >> +                       list_del_init(&prq->queuelist);
> >> +                       spin_lock_irq(&md->lock);
> >> +                       __blk_end_request(prq, -EIO, blk_rq_bytes(=
prq));
> >> +                       spin_unlock_irq(&md->lock);
> >> +               }
> >> +       }
> >>
> >>  start_new_req:
> >>        if (rqc) {
> >> +               /*
> >> +                * If current request is packed, it need to put ba=
ck.
> >> +                */
> >> +               if (mq->mqrq_cur->packed_cmd !=3D MMC_PACKED_NONE)=
 {
> >> +                       while (!list_empty(&mq->mqrq_cur->packed_l=
ist)) {
> >> +                               prq =3D list_entry_rq(mq->mqrq_cur=
->packed_list.prev);
> >> +                               if (prq->queuelist.prev !=3D &mq->=
mqrq_cur->packed_list) {
> >> +                                       list_del_init(&prq->queuel=
ist);
> >> +                                       spin_lock_irq(mq->queue->q=
ueue_lock);
> >> +                                       blk_requeue_request(mq->qu=
eue, prq);
> >> +                                       spin_unlock_irq(mq->queue-=
>queue_lock);
> >> +                               } else {
> >> +                                       list_del_init(&prq->queuel=
ist);
> >> +                               }
> >> +                       }
> >> +                       mq->mqrq_cur->packed_cmd =3D MMC_PACKED_NO=
NE;
> >> +                       mq->mqrq_cur->packed_num =3D 0;
> >> +               }
> >>                mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
> >>                mmc_start_req(card->host, &mq->mqrq_cur->mmc_active=
, NULL);
> >>        }
> >> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> >> index 2517547..af7aee5 100644
> >> --- a/drivers/mmc/card/queue.c
> >> +++ b/drivers/mmc/card/queue.c
> >> @@ -177,6 +177,8 @@ int mmc_init_queue(struct mmc_queue *mq, struc=
t mmc_card *card,
> >>
> >>        memset(&mq->mqrq_cur, 0, sizeof(mq->mqrq_cur));
> >>        memset(&mq->mqrq_prev, 0, sizeof(mq->mqrq_prev));
> >> +       INIT_LIST_HEAD(&mqrq_cur->packed_list);
> >> +       INIT_LIST_HEAD(&mqrq_prev->packed_list);
> >>        mq->mqrq_cur =3D mqrq_cur;
> >>        mq->mqrq_prev =3D mqrq_prev;
> >>        mq->queue->queuedata =3D mq;
> >> @@ -377,6 +379,39 @@ void mmc_queue_resume(struct mmc_queue *mq)
> >>        }
> >>  }
> >>
> >> +static unsigned int mmc_queue_packed_map_sg(struct mmc_queue *mq,
> >> +                               struct mmc_queue_req *mqrq,
> >> +                               struct scatterlist *sg)
> >> +{
> >> +       struct scatterlist *__sg;
> >> +       unsigned int sg_len =3D 0;
> >> +       struct request *req;
> >> +       enum mmc_packed_cmd cmd;
> >> +
> >> +       cmd =3D mqrq->packed_cmd;
> >> +
> >> +       if (cmd =3D=3D MMC_PACKED_WR_HDR || cmd =3D=3D MMC_PACKED_=
WRITE) {
> >
> > Why we do not need to handle MMC_PACKED_READ case ?
> >
> >> +               __sg =3D sg;
> >> +               sg_set_buf(__sg, mqrq->packed_cmd_hdr,
> >> +                               sizeof(mqrq->packed_cmd_hdr));
> >> +               sg_len++;
> >> +               if (cmd =3D=3D MMC_PACKED_WR_HDR) {
> >> +                       sg_mark_end(__sg);
> >> +                       return sg_len;
> >> +               }
> >> +               __sg->page_link &=3D ~0x02;
> >> +       }
> >> +
> >> +       __sg =3D sg + sg_len;
> >> +       list_for_each_entry(req, &mqrq->packed_list, queuelist) {
> >> +               sg_len +=3D blk_rq_map_sg(mq->queue, req, __sg);
> >> +               __sg =3D sg + (sg_len - 1);
> >> +               (__sg++)->page_link &=3D ~0x02;
> >> +       }
> >> +       sg_mark_end(sg + (sg_len - 1));
> >> +       return sg_len;
> >> +}
> >> +
> >>  /*
> >>  * Prepare the sg list(s) to be handed of to the host driver
> >>  */
> >> @@ -387,12 +422,19 @@ unsigned int mmc_queue_map_sg(struct mmc_que=
ue *mq, struct mmc_queue_req
> *mqrq)
> >>        struct scatterlist *sg;
> >>        int i;
> >>
> >> -       if (!mqrq->bounce_buf)
> >> -               return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->s=
g);
> >> +       if (!mqrq->bounce_buf) {
> >> +               if (!list_empty(&mqrq->packed_list))
> >> +                       return mmc_queue_packed_map_sg(mq, mqrq, m=
qrq->sg);
> >> +               else
> >> +                       return blk_rq_map_sg(mq->queue, mqrq->req,=
 mqrq->sg);
> >> +       }
> >>
> >>        BUG_ON(!mqrq->bounce_sg);
> >>
> >> -       sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounc=
e_sg);
> >> +       if (!list_empty(&mqrq->packed_list))
> >> +               sg_len =3D mmc_queue_packed_map_sg(mq, mqrq, mqrq-=
>bounce_sg);
> >> +       else
> >> +               sg_len =3D blk_rq_map_sg(mq->queue, mqrq->req, mqr=
q->bounce_sg);
> >>
> >>        mqrq->bounce_sg_len =3D sg_len;
> >>
> >> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> >> index d2a1eb4..be58b3c 100644
> >> --- a/drivers/mmc/card/queue.h
> >> +++ b/drivers/mmc/card/queue.h
> >> @@ -12,6 +12,13 @@ struct mmc_blk_request {
> >>        struct mmc_data         data;
> >>  };
> >>
> >> +enum mmc_packed_cmd {
> >> +       MMC_PACKED_NONE =3D 0,
> >> +       MMC_PACKED_WR_HDR,
> >> +       MMC_PACKED_WRITE,
> >> +       MMC_PACKED_READ,
> >> +};
> >> +
> >>  struct mmc_queue_req {
> >>        struct request          *req;
> >>        struct mmc_blk_request  brq;
> >> @@ -20,6 +27,12 @@ struct mmc_queue_req {
> >>        struct scatterlist      *bounce_sg;
> >>        unsigned int            bounce_sg_len;
> >>        struct mmc_async_req    mmc_active;
> >> +       struct list_head        packed_list;
> >> +       u32                     packed_cmd_hdr[128];
> >> +       unsigned int            packed_blocks;
> >> +       enum mmc_packed_cmd     packed_cmd;
> >> +       int             packed_fail_idx;
> >> +       u8              packed_num;
> >>  };
> >>
> >>  struct mmc_queue {
> >> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >> index 30055f2..10350ce 100644
> >> --- a/drivers/mmc/core/host.c
> >> +++ b/drivers/mmc/core/host.c
> >> @@ -346,6 +346,8 @@ struct mmc_host *mmc_alloc_host(int extra, str=
uct device *dev)
> >>        host->max_blk_size =3D 512;
> >>        host->max_blk_count =3D PAGE_CACHE_SIZE / 512;
> >>
> >> +       host->packed_min =3D 2;
> >> +
> >>        return host;
> >>
> >>  free:
> >> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops=
=2Ec
> >> index 4d41fa9..1e17bd7 100644
> >> --- a/drivers/mmc/core/mmc_ops.c
> >> +++ b/drivers/mmc/core/mmc_ops.c
> >> @@ -335,6 +335,7 @@ int mmc_send_ext_csd(struct mmc_card *card, u8=
 *ext_csd)
> >>        return mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD=
,
> >>                        ext_csd, 512);
> >>  }
> >> +EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
> >>
> >>  int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocr=
p)
> >>  {
> >> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> >> index 87a976c..07a4149 100644
> >> --- a/include/linux/mmc/core.h
> >> +++ b/include/linux/mmc/core.h
> >> @@ -18,6 +18,8 @@ struct mmc_request;
> >>  struct mmc_command {
> >>        u32                     opcode;
> >>        u32                     arg;
> >> +#define MMC_CMD23_ARG_REL_WR   (1 << 31)
> >> +#define MMC_CMD23_ARG_PACKED   ((0 << 31) | (1 << 30))
> >>        u32                     resp[4];
> >>        unsigned int            flags;          /* expected respons=
e type */
> >>  #define MMC_RSP_PRESENT        (1 << 0)
> >> @@ -143,6 +145,7 @@ extern int mmc_app_cmd(struct mmc_host *, stru=
ct mmc_card *);
> >>  extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_car=
d *,
> >>        struct mmc_command *, int);
> >>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int=
);
> >> +extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
> >>
> >>  #define MMC_ERASE_ARG          0x00000000
> >>  #define MMC_SECURE_ERASE_ARG   0x80000000
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >> index e22f541..8984259 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -286,6 +286,9 @@ struct mmc_host {
> >>        unsigned int            max_blk_count;  /* maximum number o=
f blocks in one req */
> >>        unsigned int            max_discard_to; /* max. discard tim=
eout in ms */
> >>
> >> +       u8                      packed_min;     /* minimum number =
of packed entries */
> >> +
> >> +
> >>        /* private data */
> >>        spinlock_t              lock;           /* lock for claim a=
nd bus ops */
> >>
> >> --
> >> 1.7.0.4
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BDg"=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=
=BF=BD=1A=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=
=BD=EF=BF=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=03(=EF=BF=
=BD=E9=9A=8E
> =EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=1Bm=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BDf=
=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDm

