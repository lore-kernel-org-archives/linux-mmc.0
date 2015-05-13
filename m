From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [V2 PATCH 4/5] mmc: core: add support for CMDQ feature in MMC Core
Date: Wed, 13 May 2015 14:47:56 +0200
Message-ID: <CAPDyKFqLKMaB=+j9-V=AtqCG8wjA31zocQX3WySB9mpkn_1F-Q@mail.gmail.com>
References: <20150403112624.GE29880@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34700 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbbEMMr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 08:47:57 -0400
Received: by qgfi89 with SMTP id i89so20447656qgf.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2015 05:47:56 -0700 (PDT)
In-Reply-To: <20150403112624.GE29880@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>

On 3 April 2015 at 13:26, Chuanxiao Dong <chuanxiao.dong@intel.com> wro=
te:
> CMDQ is a new feature introduced in eMMC5.1, which can be used
> for helping improve the read performance.

Is it only read performance that could be better?

>
> This patch adds support in mmc block layer and core layer.
>
> The CMDQ requires to send 4 CMDs and 5 interrupts, thus it has additi=
onal
> SW overhead. When CPU frequency is low, it may impact the random read
> performance. With ondemand CPU governor used in GMIN, it can improve
> the read performance a lot.

This isn't very clear. Could you please elaborate on the performance im=
pact.
In what cases shall we expect increased/decreased performance?

Moreover, you might want to elaborate a bit on the feature as such.
How does it actually work, just to get an overview of what the code
will be doing.

>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/card/block.c |  501 ++++++++++++++++++++++++++++++++++++=
++++++++--
>  drivers/mmc/card/queue.c |   23 ++-
>  drivers/mmc/card/queue.h |    3 +-
>  drivers/mmc/core/core.c  |   59 +++++-
>  drivers/mmc/core/mmc.c   |   37 +++-
>  include/linux/mmc/card.h |    3 +
>  include/linux/mmc/core.h |    2 +
>  include/linux/mmc/host.h |    4 +
>  include/linux/mmc/mmc.h  |   21 ++
>  include/linux/mmc/pm.h   |    1 +
>  10 files changed, 631 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2407f52..6af8b9a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -112,6 +112,7 @@ struct mmc_blk_data {
>  #define MMC_BLK_WRITE          BIT(1)
>  #define MMC_BLK_DISCARD                BIT(2)
>  #define MMC_BLK_SECDISCARD     BIT(3)
> +#define MMC_BLK_CMDQ           BIT(4)
>
>         /*
>          * Only set in main mmc_blk_data associated
> @@ -139,7 +140,10 @@ MODULE_PARM_DESC(perdev_minors, "Minors numbers =
to allocate per device");
>  static inline int mmc_blk_part_switch(struct mmc_card *card,
>                                       struct mmc_blk_data *md);
>  static int get_card_status(struct mmc_card *card, u32 *status, int r=
etries);
> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request =
*rqc);
> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> +               struct request *rqc, bool urgent);
> +static int mmc_blk_queue_cmdq_req(struct mmc_queue *mq,
> +               struct mmc_queue_req *mqrq, unsigned long *);
>
>  static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
>  {
> @@ -654,13 +658,50 @@ static inline int mmc_blk_part_switch(struct mm=
c_card *card,
>
>         if (mmc_card_mmc(card)) {
>                 u8 part_config =3D card->ext_csd.part_config;
> +               struct mmc_host *host =3D card->host;
>
>                 /*
> -                * before switching partition, needs to make
> -                * sure there is no active transferring in previous
> -                * queue
> +                * Before swithcing the partition, need to do followi=
ng

/s /swithcing /switching

> +                * checks:
> +                * 1. there is no on going request in previous queue

/s /on going /ongoing

> +                * 2. if switch to RPMB partition, CMDQ should be dis=
abled
> +                * 3. if switch to other partition, CMDQ should be ba=
ck to
> +                * previous status
>                  */
> -               mmc_blk_issue_rw_rq(main_md->mq_curr, NULL);
> +               mmc_blk_issue_rw_rq(main_md->mq_curr, NULL, false);
> +
> +               if ((md->part_type !=3D EXT_CSD_PART_CONFIG_USER) &&
> +                               card->ext_csd.cmdq_en) {
> +                       /* disable CMDQ mode */
> +                       ret =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
> +                                       EXT_CSD_CMDQ_MODE_EN,
> +                                       EXT_CSD_CMDQ_MODE_OFF,
> +                                       card->ext_csd.generic_cmd6_ti=
me);
> +                       if (ret)
> +                               return ret;
> +                       card->ext_csd.cmdq_en =3D 0;
> +                       pm_suspend_ignore_children(&host->class_dev, =
true);
> +               } else if ((md->part_type =3D=3D EXT_CSD_PART_CONFIG_=
USER) &&
> +                                       card->ext_csd.cmdq_support &&
> +                                       (host->caps2 & MMC_CAP2_CAN_D=
O_CMDQ) &&

Maybe rename MMC_CAP2_CAN_DO_CMDQ to MMC_CAP2_CMDQ?

> +                                       !card->ext_csd.cmdq_en) {
> +                       /* enable CMDQ mode */
> +                       ret =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
> +                                       EXT_CSD_CMDQ_MODE_EN,
> +                                       EXT_CSD_CMDQ_MODE_ON,
> +                                       card->ext_csd.generic_cmd6_ti=
me);
> +                       /*
> +                        * if err during turning on CMDQ mode, contin=
ue with
> +                        * CMDQ disabled mode
> +                        */
> +                       if (!ret)
> +                               card->ext_csd.cmdq_en =3D 1;
> +               }
> +
> +               if ((card->host->pm_caps & MMC_PM_TUNING_AFTER_RTRESU=
ME) &&

MMC_PM_TUNING_AFTER_RTRESUME?

Are this patch adding PM features as well? I think we want to do that
separately.

> +                               card->ext_csd.cmdq_en)
> +                       pm_suspend_ignore_children(&card->host->class=
_dev,

I guess this is related to patch2, so likely we will come back to why
this is needed.

> +                                       false);
>
>                 part_config &=3D ~EXT_CSD_PART_CONFIG_ACC_MASK;
>                 part_config |=3D md->part_type;
> @@ -1373,6 +1414,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue=
_req *mqrq,
>                           (req->cmd_flags & REQ_META)) &&
>                 (rq_data_dir(req) =3D=3D WRITE) &&
>                 (md->flags & MMC_BLK_REL_WR);
> +       bool cmdq_en  =3D card->ext_csd.cmdq_en ? true : false;
>
>         memset(brq, 0, sizeof(struct mmc_blk_request));
>         brq->mrq.cmd =3D &brq->cmd;
> @@ -1381,11 +1423,14 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>         brq->cmd.arg =3D blk_rq_pos(req);
>         if (!mmc_card_blockaddr(card))
>                 brq->cmd.arg <<=3D 9;
> -       brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC=
;
> -       brq->data.blksz =3D 512;
> +       if (!cmdq_en)
> +               brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_=
CMD_ADTC;
> +       else
> +               brq->cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>         brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
>         brq->stop.arg =3D 0;
>         brq->data.blocks =3D blk_rq_sectors(req);
> +       brq->data.blksz =3D 512;
>
>         /*
>          * The block layer doesn't support all sector count
> @@ -1415,7 +1460,11 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
>                                                 brq->data.blocks);
>         }
>
> -       if (brq->data.blocks > 1 || do_rel_wr) {
> +       /* CMDQ doesn't require stop cmd, and use CMD45 for mrq.cmd *=
/
> +       if (cmdq_en) {
> +               brq->mrq.stop =3D NULL;
> +               readcmd =3D writecmd =3D MMC_QUE_TASK_ADDR;
> +       } else if (brq->data.blocks > 1 || do_rel_wr) {
>                 /* SPI multiblock writes terminate using a special
>                  * token, not a STOP_TRANSMISSION request.
>                  */
> @@ -1473,8 +1522,35 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
>          * N.B: Some MMC cards experience perf degradation.
>          * We'll avoid using CMD23-bounded multiblock writes for
>          * these, while retaining features like reliable writes.
> +        *
> +        * If CMDQ is enabled, then we use CMD44 for precmd, and
> +        * CMD46/47 for postcmd
>          */
> -       if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opco=
de) &&
> +       if (cmdq_en) {
> +               brq->precmd.opcode =3D MMC_QUE_TASK_PARAMS;
> +               brq->precmd.arg =3D brq->data.blocks |
> +                       (do_rel_wr ? (1 << 31) : 0) |
> +                       ((rq_data_dir(req) =3D=3D READ) ? (1 << 30) :=
 0) |
> +                       (do_data_tag ? (1 << 29) : 0) |
> +                       mqrq->task_id << 16;
> +               brq->precmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +               brq->mrq.precmd =3D &brq->precmd;
> +
> +               if (rq_data_dir(req) =3D=3D READ)
> +                       brq->postcmd.opcode =3D MMC_EXECUTE_READ_TASK=
;
> +               else
> +                       brq->postcmd.opcode =3D MMC_EXECUTE_WRITE_TAS=
K;
> +               brq->postcmd.arg =3D mqrq->task_id << 16;
> +               brq->postcmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | =
MMC_CMD_ADTC;
> +               brq->mrq.postcmd =3D &brq->postcmd;
> +
> +               brq->cmd2.opcode =3D MMC_SEND_STATUS;

cmd2?

> +               if (!mmc_host_is_spi(card->host))
> +                       brq->cmd2.arg =3D card->rca << 16 | 1 << 15;
> +               brq->cmd2.flags =3D MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC=
_CMD_AC;
> +               brq->mrq.cmd2 =3D &brq->cmd2;
> +       } else if ((md->flags & MMC_BLK_CMD23) &&
> +                       mmc_op_multi(brq->cmd.opcode) &&
>             (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
>              do_data_tag)) {
>                 brq->precmd.opcode =3D MMC_SET_BLOCK_COUNT;
> @@ -1824,7 +1900,7 @@ static void mmc_blk_revert_packed_req(struct mm=
c_queue *mq,
>         mmc_blk_clear_packed(mq_rq);
>  }
>
> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request =
*rqc)
> +static int mmc_blk_issue_normal_rw_rq(struct mmc_queue *mq, struct r=
equest *rqc)
>  {
>         struct mmc_blk_data *md =3D mq->data;
>         struct mmc_card *card =3D md->queue.card;
> @@ -2018,7 +2094,400 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq, struct request *rqc)
>         return 0;
>  }
>
> -static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *re=
q)
> +static void mmc_blk_wait_cmdq_data(struct mmc_request *mrq)
> +{
> +       struct mmc_host         *host =3D mrq->host;
> +       struct mmc_queue_req    *mqrq;
> +       struct request          *req;
> +       int error;
> +       unsigned int bytes;
> +
> +       BUG_ON(!mrq->data);
> +       BUG_ON(!host->areq);
> +
> +       mqrq =3D container_of(host->areq, struct mmc_queue_req, mmc_a=
ctive);
> +       req =3D mqrq->req;
> +       /* Not sure if this req is successfully transferred, let's ch=
eck! */
> +       mqrq->mmc_active.success =3D false;
> +       /* when it is done, clear cmdqslot */
> +       mmc_queue_bounce_post(mqrq);
> +       error =3D mrq->data->error;
> +       bytes =3D mrq->data->bytes_xfered;
> +       if (blk_rq_bytes(req) =3D=3D bytes)
> +               mqrq->mmc_active.success =3D true;
> +       host->context_info.is_done_rcv =3D true;
> +       wake_up_interruptible(&mrq->host->context_info.wait);
> +       if (error) {
> +               pr_err("%s: data err %d for id %d\n",
> +                               __func__, error, mqrq->task_id);
> +       } else if (mqrq->mmc_active.success)
> +               blk_end_request(req, 0, bytes);
> +}
> +
> +static int mmc_blk_cmdq_check(struct mmc_card *card, unsigned long *=
status)
> +{
> +       struct mmc_command cmd =3D {0};
> +       int err, retries =3D 3;
> +
> +       cmd.opcode =3D MMC_SEND_STATUS;
> +       if (!mmc_host_is_spi(card->host))
> +               cmd.arg =3D card->rca << 16 | 1 << 15;
> +       cmd.flags =3D MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +       err =3D mmc_wait_for_cmd(card->host, &cmd, retries);
> +       if (err =3D=3D 0)
> +               *status =3D (unsigned long)cmd.resp[0];
> +       else
> +               pr_err("%s: err %d\n", __func__, err);
> +
> +       return err;
> +}
> +
> +/*
> + * return:
> + * 0 for success;
> + * MMC_BLK_NEW_REQUEST: interrupted for fetching new request;
> + * negative value: failure
> + */
> +static int mmc_blk_execute_cmdq(struct mmc_queue *mq,
> +               unsigned long slots)
> +{
> +       struct mmc_card *card =3D mq->card;
> +       struct mmc_blk_data *md =3D mq->data;
> +       struct mmc_host *host =3D card->host;
> +       struct mmc_async_req    *areq;
> +       struct mmc_queue_req    *prev_mqrq;
> +       int err, status =3D 0;
> +       unsigned long id;
> +       struct mmc_context_info *cntx;
> +
> +       cntx =3D &host->context_info;
> +
> +       do {
> +               if (slots) {
> +                       id =3D find_first_bit(&slots, mq->qdepth);
> +                       BUG_ON(id >=3D mq->qdepth);
> +                       __clear_bit(id, &slots);
> +                       areq =3D &mq->mqrq[id].mmc_active;
> +                       if (host->areq =3D=3D areq)
> +                               continue;
> +               } else
> +                       areq =3D NULL;
> +
> +               if (host->areq)
> +                       prev_mqrq =3D container_of(host->areq,
> +                                       struct mmc_queue_req,
> +                                       mmc_active);
> +               else
> +                       prev_mqrq =3D NULL;
> +
> +               err =3D mmc_execute_cmdq(host, areq, &status);
> +               if (prev_mqrq && (status =3D=3D MMC_BLK_SUCCESS)) {
> +                       clear_bit_unlock(prev_mqrq->task_id, &mq->cmd=
qslot);
> +                       if (atomic_dec_and_test(&mq->active_slots))
> +                               cntx->is_cmdq_busy =3D false;
> +               }
> +               if (err)
> +                       return err;
> +
> +               switch (status) {
> +               case MMC_BLK_SUCCESS:
> +                       mmc_blk_reset_success(md, MMC_BLK_CMDQ);
> +                       break;
> +               case MMC_BLK_PARTIAL:
> +                       mmc_blk_reset_success(md, MMC_BLK_CMDQ);
> +                       /* re-queue */
> +                       if (prev_mqrq) {
> +                               blk_end_request(prev_mqrq->req, 0,
> +                                       prev_mqrq->brq.data.bytes_xfe=
red);
> +                               err =3D mmc_blk_queue_cmdq_req(mq, pr=
ev_mqrq,
> +                                               NULL);
> +                               if (err)
> +                                       return err;
> +                       } else
> +                               pr_err("%s: no previous mrq\n",
> +                                               mmc_hostname(host));
> +                       break;
> +               case MMC_BLK_NEW_REQUEST:
> +                       cntx->is_pending_cmdq =3D true;
> +                       return MMC_BLK_NEW_REQUEST;
> +               default:
> +                       pr_err("%s: err blk status 0x%x\n", __func__,=
 status);
> +                       return -EIO;
> +               }
> +
> +       } while (slots);
> +
> +       return 0;
> +}
> +
> +static int mmc_blk_flush_cmdq(struct mmc_queue *mq, bool urgent)
> +{
> +       int err;
> +       unsigned long status;
> +       struct mmc_host *host;
> +       unsigned long timeout;
> +
> +       if (!mq || !mq->card)
> +               return 0;
> +
> +       host =3D mq->card->host;
> +
> +       if (host->context_info.is_pending_cmdq) {
> +               host->context_info.is_pending_cmdq =3D false;
> +               err =3D mmc_blk_execute_cmdq(mq, 0);
> +               if (err)
> +                       return err;
> +       }
> +
> +       while (mq->cmdqslot) {
> +               /*
> +                * As eMMC5.1 spec mentioned, when the device, in its=
 response
> +                * to CMD13, indicates that one or more tasks are
> +                * ready for execution, the host should select one of=
 these
> +                * tasks for execution, and not send additional CMD13=
s in
> +                * expectation that additional tasks would become =E2=
=80=98ready for
> +                * execution=E2=80=99. Thus if there is areq, we shou=
ld wait here
> +                */
> +               if (host->areq) {
> +                       err =3D mmc_blk_execute_cmdq(mq, 0);
> +                       if (err)
> +                               return err;
> +                       if (!mq->cmdqslot)
> +                               break;
> +               }
> +
> +               /*
> +                * send CMD13 to check QSR
> +                * Max to wait for 10s for a CMDQ request
> +                * getting ready
> +                */
> +               status =3D 0;
> +               timeout =3D jiffies + msecs_to_jiffies(10 * 1000);
> +               while (!status) {
> +                       err =3D mmc_blk_cmdq_check(mq->card, &status)=
;
> +                       if (err)
> +                               return err;
> +                       /*
> +                        * Timeout if the device never becomes ready =
for data
> +                        * and never leaves the program state.
> +                        */
> +                       if (time_after(jiffies, timeout)) {
> +                               pr_err("%s: Card stuck in checking CM=
DQ state!\n",
> +                                       mmc_hostname(host));
> +                               pr_err("%s: cmdqslot 0x%lx\n",
> +                                       mmc_hostname(host), mq->cmdqs=
lot);
> +                               return -ETIMEDOUT;
> +                       }
> +               }
> +               err =3D mmc_blk_execute_cmdq(mq, status);
> +               if (err)
> +                       return err;
> +
> +               if (urgent)
> +                       return mmc_blk_execute_cmdq(mq, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mmc_blk_cmdq_data_err_check(struct mmc_card *card,
> +               struct mmc_async_req *areq)
> +{
> +       struct mmc_queue_req *mqrq =3D container_of(areq, struct mmc_=
queue_req,
> +                                                   mmc_active);
> +       struct mmc_blk_request *brq =3D &mqrq->brq;
> +
> +       if (areq->success)
> +               return MMC_BLK_SUCCESS;
> +
> +       if (brq->data.error)
> +               return MMC_BLK_ABORT;
> +
> +       if (blk_rq_bytes(mqrq->req) !=3D brq->data.bytes_xfered)
> +               return MMC_BLK_PARTIAL;
> +
> +       return MMC_BLK_SUCCESS;
> +}
> +
> +static int mmc_blk_queue_cmdq_req(struct mmc_queue *mq,
> +               struct mmc_queue_req *mqrq, unsigned long *status)
> +{
> +       struct mmc_card *card;
> +       struct mmc_request mrq =3D {NULL};
> +       struct mmc_async_req *areq;
> +       int err;
> +
> +       if (!mq || !mqrq)
> +               return -EPERM;
> +
> +       card =3D mq->card;
> +       mmc_blk_rw_rq_prep(mqrq, card, 0, mq);
> +
> +       areq =3D &mqrq->mmc_active;
> +       areq->mrq->host =3D card->host;
> +       areq->mrq->done =3D mmc_blk_wait_cmdq_data;
> +       areq->err_check =3D mmc_blk_cmdq_data_err_check;
> +
> +       mrq.precmd =3D areq->mrq->precmd;
> +       mrq.cmd =3D areq->mrq->cmd;
> +       if (status)
> +               mrq.cmd2 =3D areq->mrq->cmd2;
> +
> +       mmc_wait_for_req(card->host, &mrq);
> +       if (mrq.cmd->error) {
> +               pr_err("%s: error %d for cmd %d\n", __func__,
> +                               mrq.cmd->error, mrq.cmd->opcode);
> +               return mrq.cmd->error;
> +       } else if (mrq.precmd->error) {
> +               pr_err("%s: error %d for precmd %d\n", __func__,
> +                               mrq.cmd->error, mrq.cmd->opcode);
> +               return mrq.precmd->error;
> +       }
> +
> +       card->host->context_info.is_cmdq_busy =3D true;
> +
> +       if (card->host->context_info.is_pending_cmdq) {
> +               card->host->context_info.is_pending_cmdq =3D false;
> +               err =3D mmc_blk_execute_cmdq(mq, 0);
> +               if (err && (err !=3D MMC_BLK_NEW_REQUEST)) {
> +                       pr_err("%s: error %d when flushing pending da=
ta\n",
> +                                       __func__, err);
> +                       return err;
> +               }
> +       }
> +
> +       if (status && mrq.cmd2)
> +               *status =3D (unsigned long)mrq.cmd2->resp[0];
> +
> +       return 0;
> +}
> +
> +static int mmc_blk_requeue_cmdq_reqs(struct mmc_host *host,
> +               struct mmc_queue *mq)
> +{
> +       int err;
> +       unsigned int slot;
> +       unsigned long cmdqslot;
> +
> +       cmdqslot =3D mq->cmdqslot;
> +
> +       while (cmdqslot) {
> +               slot =3D find_first_bit(&cmdqslot, mq->qdepth);
> +               err =3D mmc_blk_queue_cmdq_req(mq, &mq->mqrq[slot], N=
ULL);
> +               if (err)
> +                       return err;
> +               __clear_bit(slot, &cmdqslot);
> +       }
> +
> +       return 0;
> +}
> +
> +static void mmc_blk_discard_cmdq(struct mmc_card *card)
> +{
> +       struct mmc_command cmd =3D {0};
> +
> +       cmd.opcode =3D MMC_DISCARD_CMDQ;
> +       cmd.arg =3D 1;
> +       cmd.flags =3D MMC_RSP_R1B | MMC_CMD_AC;
> +
> +       mmc_wait_for_cmd(card->host, &cmd, 0);
> +}
> +
> +static inline void mmc_blk_clear_cmdq_context(struct mmc_host *host)
> +{
> +       host->context_info.is_pending_cmdq =3D false;
> +       host->context_info.is_cmdq_busy =3D false;
> +}
> +
> +static int mmc_blk_issue_cmdq_rw_rq(struct mmc_queue *mq,
> +               struct request *rqc, bool urgent)
> +{
> +       struct mmc_card *card =3D mq->card;
> +       struct mmc_blk_data *md =3D mq->data;
> +       struct request *req;
> +       int err, type =3D MMC_BLK_CMDQ;
> +       unsigned long status =3D 0, i;
> +
> +flush:
> +       if (!rqc) {
> +               /* there are some CMDQ data pending, flush them */
> +               err =3D mmc_blk_flush_cmdq(mq, urgent);
> +               if (err && (err !=3D MMC_BLK_NEW_REQUEST)) {
> +                       pr_err("%s: error %d when flushing cmdq\n", _=
_func__,
> +                                       err);
> +                       goto requeue;
> +               }
> +               return 0;
> +       }
> +
> +       atomic_inc(&mq->active_slots);
> +
> +       if (mmc_blk_queue_cmdq_req(mq, mq->mqrq_cur, &status))
> +               goto requeue;
> +
> +       if (!status)
> +               return 0;
> +recheck:
> +       err =3D mmc_blk_execute_cmdq(mq, status);
> +       if (!err || (err =3D=3D MMC_BLK_NEW_REQUEST))
> +               return 0;
> +requeue:
> +       /*
> +        * error handling
> +        */
> +       pr_err("%s: requeue happens\n", __func__);
> +       if (card->host->areq)
> +               mmc_blk_execute_cmdq(mq, 0);
> +       BUG_ON(card->host->areq);
> +       /*
> +        * discard the CMDQ
> +        */
> +       mmc_blk_discard_cmdq(card);
> +
> +       mmc_blk_clear_cmdq_context(card->host);
> +       if (!mmc_blk_reset(md, card->host, type)
> +                       && !mmc_blk_requeue_cmdq_reqs(card->host, mq)=
) {
> +               /* flush error handling */
> +               if (!rqc)
> +                       goto flush;
> +               /* normal cmdq error handling */
> +               else {
> +                       if (mmc_blk_cmdq_check(card, &status))
> +                               goto requeue;
> +                       if (!status)
> +                               return 0;
> +                       goto recheck;
> +               }
> +       }
> +
> +       pr_err("%s: failed to recover eMMC\n", __func__);
> +
> +       while (mq->cmdqslot) {
> +               i =3D find_first_bit(&mq->cmdqslot, mq->qdepth);
> +               req =3D mq->mqrq[i].req;
> +               blk_end_request(req, -EIO, blk_rq_bytes(req));
> +               clear_bit_unlock(i, &mq->cmdqslot);
> +               atomic_dec(&mq->active_slots);
> +       }
> +       BUG_ON(atomic_read(&mq->active_slots) !=3D 0);
> +       mmc_blk_clear_cmdq_context(card->host);
> +       return 0;
> +}
> +
> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> +               struct request *rqc, bool urgent)
> +{
> +       struct mmc_blk_data *md =3D mq->data;
> +       struct mmc_card *card =3D md->queue.card;
> +
> +       if (!card->ext_csd.cmdq_en)
> +               return mmc_blk_issue_normal_rw_rq(mq, rqc);
> +       else
> +               return mmc_blk_issue_cmdq_rw_rq(mq, rqc, urgent);
> +}
> +
> +static int mmc_blk_issue_rq(struct mmc_queue *mq,
> +               struct request *req, bool urgent)
>  {
>         int ret;
>         struct mmc_blk_data *md =3D mq->data;
> @@ -2043,7 +2512,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
>         if (cmd_flags & REQ_DISCARD) {
>                 /* complete ongoing async transfer before issuing dis=
card */
>                 if (atomic_read(&mq->active_slots))
> -                       mmc_blk_issue_rw_rq(mq, NULL);
> +                       mmc_blk_issue_rw_rq(mq, NULL, urgent);
>                 if (req->cmd_flags & REQ_SECURE)
>                         ret =3D mmc_blk_issue_secdiscard_rq(mq, req);
>                 else
> @@ -2051,7 +2520,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
>         } else if (cmd_flags & REQ_FLUSH) {
>                 /* complete ongoing async transfer before issuing flu=
sh */
>                 if (atomic_read(&mq->active_slots))
> -                       mmc_blk_issue_rw_rq(mq, NULL);
> +                       mmc_blk_issue_rw_rq(mq, NULL, urgent);
>                 ret =3D mmc_blk_issue_flush(mq, req);
>         } else {
>                 if (!req && (atomic_read(&mq->active_slots) =3D=3D 1)=
) {
> @@ -2059,7 +2528,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
>                         host->context_info.is_waiting_last_req =3D tr=
ue;
>                         spin_unlock_irqrestore(&host->context_info.lo=
ck, flags);
>                 }
> -               ret =3D mmc_blk_issue_rw_rq(mq, req);
> +               ret =3D mmc_blk_issue_rw_rq(mq, req, urgent);
>         }
>
>  out:
> @@ -2481,6 +2950,10 @@ static int mmc_blk_probe(struct device *dev)
>         if (card->type !=3D MMC_TYPE_SD_COMBO) {
>                 pm_runtime_set_active(&card->dev);
>                 pm_runtime_enable(&card->dev);
> +               if ((card->host->pm_caps & MMC_PM_TUNING_AFTER_RTRESU=
ME) &&
> +                               card->ext_csd.cmdq_en)
> +                       pm_suspend_ignore_children(&card->host->class=
_dev,
> +                                       false);
>         }
>
>         return 0;
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index c2d32e2..059cc90 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -84,16 +84,21 @@ static int mmc_queue_thread(void *d)
>                 req =3D blk_fetch_request(q);
>                 spin_unlock_irq(q->queue_lock);
>
> +               /*
> +                * For the request which doesn't have data to transfe=
r,
> +                * we don't need to allocate a mqrq slot for it as it=
 doesn't
> +                * need the sg to map data
> +                */
>                 if (req && !(req->cmd_flags & (REQ_DISCARD | REQ_FLUS=
H))) {
>                         while (!mmc_queue_get_free_slot(mq, &i))
> -                               mq->issue_fn(mq, NULL);
> +                               mq->issue_fn(mq, NULL, true);
>                         mq->mqrq_cur =3D &mq->mqrq[i];
>                         mq->mqrq_cur->req =3D req;
>                 }
>
>                 if (req || atomic_read(&mq->active_slots)) {
>                         set_current_state(TASK_RUNNING);
> -                       mq->issue_fn(mq, req);
> +                       mq->issue_fn(mq, req, false);
>                 } else {
>                         if (kthread_should_stop()) {
>                                 set_current_state(TASK_RUNNING);
> @@ -209,11 +214,17 @@ int mmc_init_queue(struct mmc_queue *mq, struct=
 mmc_card *card,
>         if (!mq->queue)
>                 return -ENOMEM;
>
> -       mq->qdepth =3D 2;
> +       if (card->ext_csd.cmdq_en)
> +               mq->qdepth =3D card->ext_csd.cmdq_depth;
> +       else
> +               mq->qdepth =3D 2;
> +
>         mq->mqrq =3D kcalloc(mq->qdepth, sizeof(struct mmc_queue_req)=
,
>                         GFP_KERNEL);
> -       if (!mq->mqrq)
> -               return -ENOMEM;
> +       if (!mq->mqrq) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
>
>         mqrq =3D mq->mqrq;
>         for (i =3D 0; i < mq->qdepth; i++)
> @@ -322,6 +333,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct m=
mc_card *card,
>                 mqrq[i].bounce_buf =3D NULL;
>         }
>
> +       kfree(mq->mqrq);
> +out:
>         blk_cleanup_queue(mq->queue);
>         return ret;
>  }
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 4f590bc..2b5db5d 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -10,6 +10,7 @@ struct mmc_blk_request {
>         struct mmc_request      mrq;
>         struct mmc_command      precmd;
>         struct mmc_command      cmd;
> +       struct mmc_command      cmd2;

What's this? Maybe a better name than cmd2 would explain that?

>         struct mmc_command      postcmd;
>         struct mmc_command      stop;
>         struct mmc_data         data;
> @@ -52,7 +53,7 @@ struct mmc_queue {
>         unsigned int            flags;
>  #define MMC_QUEUE_SUSPENDED    (1 << 0)
>
> -       int                     (*issue_fn)(struct mmc_queue *, struc=
t request *);
> +       int     (*issue_fn)(struct mmc_queue *, struct request *, boo=
l);
>         void                    *data;
>         struct request_queue    *queue;
>         struct mmc_queue_req    *mqrq;
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 75c67d9..e256373 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -148,8 +148,6 @@ void mmc_request_done(struct mmc_host *host, stru=
ct mmc_request *mrq)
>         } else {
>                 mmc_should_fail_request(host, mrq);
>
> -               led_trigger_event(host->led, LED_OFF);
> -
>                 if (mrq->precmd) {
>                         pr_debug("%s: req done <CMD%u>: %d: %08x %08x=
 %08x %08x\n",
>                                 mmc_hostname(host), mrq->precmd->opco=
de,
> @@ -177,6 +175,14 @@ void mmc_request_done(struct mmc_host *host, str=
uct mmc_request *mrq)
>                                 mrq->stop->resp[2], mrq->stop->resp[3=
]);
>                 }
>
> +               if (mmc_op_cmdq_execute_task(cmd->opcode) && !mrq->da=
ta) {
> +                       if (mrq->done)
> +                               mrq->done(mrq);
> +                       return;
> +               }
> +
> +               led_trigger_event(host->led, LED_OFF);
> +
>                 if (mrq->done)
>                         mrq->done(mrq);
>
> @@ -369,6 +375,7 @@ static int __mmc_start_req(struct mmc_host *host,=
 struct mmc_request *mrq)
>
>         init_completion(&mrq->completion);
>         mrq->done =3D mmc_wait_done;
> +       mrq->host =3D host;
>
>         err =3D mmc_start_request(host, mrq);
>         if (err) {
> @@ -594,6 +601,54 @@ struct mmc_async_req *mmc_start_req(struct mmc_h=
ost *host,
>  }
>  EXPORT_SYMBOL(mmc_start_req);
>
> +int mmc_execute_cmdq(struct mmc_host *host,
> +               struct mmc_async_req *areq,
> +               int *status)
> +{
> +       struct mmc_request mrq =3D {NULL};
> +       struct mmc_command cmd =3D {0};
> +
> +       *status =3D MMC_BLK_SUCCESS;
> +
> +       /* Prepare a new request */
> +       if (areq)
> +               mmc_pre_req(host, areq->mrq, !host->areq);
> +
> +       if (host->areq) {
> +               *status =3D mmc_wait_for_data_req_done(host,
> +                               host->areq->mrq, areq);
> +               switch (*status) {
> +               case MMC_BLK_SUCCESS:
> +               case MMC_BLK_PARTIAL:
> +                       break;
> +               case MMC_BLK_NEW_REQUEST:
> +                       return 0;
> +               default:
> +                       mmc_post_req(host, host->areq->mrq, 0);
> +                       if (areq)
> +                               mmc_post_req(host, areq->mrq, -EINVAL=
);
> +                       host->areq =3D NULL;
> +                       return 0;
> +               }
> +               mmc_post_req(host, host->areq->mrq, 0);
> +       }
> +
> +       host->areq =3D areq;
> +       if (!host->areq)
> +               return 0;
> +       /*
> +        * If previous request is success, update host->areq
> +        */
> +       memcpy(&cmd, areq->mrq->postcmd, sizeof(cmd));
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D areq->mrq->data;
> +       /* CMD complete only */
> +       mmc_wait_for_req(host, &mrq);
> +
> +       return mrq.cmd->error;
> +}
> +EXPORT_SYMBOL(mmc_execute_cmdq);
> +
>  /**
>   *     mmc_wait_for_req - start a request and wait for completion
>   *     @host: MMC host to start command
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d41e85..0cc88b4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -573,6 +573,17 @@ static int mmc_decode_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
>                 card->ext_csd.ffu_capable =3D
>                         (ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>                         !(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> +               /* check CQ capability */
> +               if (ext_csd[EXT_CSD_CMDQ_SUPPORT] &&
> +                               ext_csd[EXT_CSD_CMDQ_DEPTH]) {
> +                       card->ext_csd.cmdq_support =3D
> +                               ext_csd[EXT_CSD_CMDQ_SUPPORT];
> +                       card->ext_csd.cmdq_depth =3D ext_csd[EXT_CSD_=
CMDQ_DEPTH];
> +                       if (card->ext_csd.cmdq_depth <=3D 2) {
> +                               card->ext_csd.cmdq_support =3D 0;
> +                               card->ext_csd.cmdq_depth =3D 0;
> +                       }
> +               }
>         }
>  out:
>         return err;
> @@ -708,6 +719,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>  MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area=
_size);
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_siz=
e_mult);
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
> +MMC_DEV_ATTR(cmdq_en, "%#x\n", card->ext_csd.cmdq_en);
>
>  static ssize_t mmc_fwrev_show(struct device *dev,
>                               struct device_attribute *attr,
> @@ -743,6 +755,7 @@ static struct attribute *mmc_std_attrs[] =3D {
>         &dev_attr_enhanced_area_size.attr,
>         &dev_attr_raw_rpmb_size_mult.attr,
>         &dev_attr_rel_sectors.attr,
> +       &dev_attr_cmdq_en.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> @@ -1457,12 +1470,34 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>         }
>
>         /*
> +        * enable Command queue if supported
> +        */
> +       if (card->ext_csd.cmdq_support &&
> +                       (host->caps2 & MMC_CAP2_CAN_DO_CMDQ)) {
> +               err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +                               EXT_CSD_CMDQ_MODE_EN,
> +                               EXT_CSD_CMDQ_MODE_ON,
> +                               card->ext_csd.generic_cmd6_time);
> +               if (err && err !=3D -EBADMSG)
> +                       goto free_card;
> +               if (err) {
> +                       pr_warn("%s: Enabling CMDQ failed\n",
> +                               mmc_hostname(card->host));
> +                       card->ext_csd.cmdq_en =3D 0;
> +                       card->ext_csd.cmdq_depth =3D 0;
> +                       err =3D 0;
> +               } else
> +                       card->ext_csd.cmdq_en =3D 1;
> +       }
> +
> +       /*
>          * The mandatory minimum values are defined for packed comman=
d.
>          * read: 5, write: 3
>          */
>         if (card->ext_csd.max_packed_writes >=3D 3 &&
>             card->ext_csd.max_packed_reads >=3D 5 &&
> -           host->caps2 & MMC_CAP2_PACKED_CMD) {
> +           (host->caps2 & MMC_CAP2_PACKED_CMD) &&
> +           !card->ext_csd.cmdq_en) {
>                 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_EXP_EVENTS_CTRL,
>                                 EXT_CSD_PACKED_EVENT_EN,

It is a quite big patch, so all we can do to split it up in more
pieces would be nice. It helps the reviewers.

I am thinking that the parsing of the EXT_CSD can be done in a
separate patch. That also includes adding the MMC_CAP* for CMDQ. Could
you please consider that?

> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index a6cf4c0..5be9539 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -120,6 +120,9 @@ struct mmc_ext_csd {
>
>         unsigned int            feature_support;
>  #define MMC_DISCARD_FEATURE    BIT(0)                  /* CMD38 feat=
ure */
> +       u8                      cmdq_support;           /* 308 */
> +       bool                    cmdq_en;
> +       u8                      cmdq_depth;             /* 307 */
>  };
>
>  struct sd_scr {
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 8445ecb..63812f9 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -130,6 +130,7 @@ struct mmc_request {
>         struct mmc_command      *precmd;
>         struct mmc_command      *cmd;
>         struct mmc_command      *postcmd;
> +       struct mmc_command      *cmd2;

Same comment as earlier. A better name please!?

>         struct mmc_data         *data;
>         struct mmc_command      *stop;
>
> @@ -145,6 +146,7 @@ extern int mmc_stop_bkops(struct mmc_card *);
>  extern int mmc_read_bkops_status(struct mmc_card *);
>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>                                            struct mmc_async_req *, in=
t *);
> +extern int mmc_execute_cmdq(struct mmc_host *, struct mmc_async_req =
*, int *);
>  extern int mmc_interrupt_hpi(struct mmc_card *);
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *=
);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *,=
 int);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index b5bedae..25377c3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -149,6 +149,7 @@ struct device;
>  struct mmc_async_req {
>         /* active mmc request */
>         struct mmc_request      *mrq;
> +       bool    success;
>         /*
>          * Check error status of completed mmc request.
>          * Returns 0 if success otherwise non zero.
> @@ -184,6 +185,8 @@ struct mmc_context_info {
>         bool                    is_done_rcv;
>         bool                    is_new_req;
>         bool                    is_waiting_last_req;
> +       bool                    is_cmdq_busy;
> +       bool                    is_pending_cmdq;
>         wait_queue_head_t       wait;
>         spinlock_t              lock;
>  };
> @@ -285,6 +288,7 @@ struct mmc_host {
>                                  MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_HSX00_1_2V    (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_H=
S400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
> +#define MMC_CAP2_CAN_DO_CMDQ   (1 << 18)
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm featu=
res */
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 124f562..bdfc394 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -84,12 +84,25 @@
>  #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1 =
 */
>  #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1 =
 */
>
> +/* class 11 */
> +#define MMC_QUE_TASK_PARAMS    44      /* ac R1 */
> +#define MMC_QUE_TASK_ADDR      45      /* ac R1 */
> +#define MMC_EXECUTE_READ_TASK  46      /* adtc R1 */
> +#define MMC_EXECUTE_WRITE_TASK 47      /* adtc R1 */
> +#define MMC_DISCARD_CMDQ       48      /* ac R1B */
> +
>  static inline bool mmc_op_multi(u32 opcode)
>  {
>         return opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
>                opcode =3D=3D MMC_READ_MULTIPLE_BLOCK;
>  }
>
> +static inline bool mmc_op_cmdq_execute_task(u32 opcode)
> +{
> +       return opcode =3D=3D MMC_EXECUTE_READ_TASK ||
> +               opcode =3D=3D MMC_EXECUTE_WRITE_TASK;
> +}
> +
>  /*
>   * MMC_SWITCH argument format:
>   *
> @@ -272,6 +285,7 @@ struct _mmc_csd {
>   * EXT_CSD fields
>   */
>
> +#define EXT_CSD_CMDQ_MODE_EN           15      /* R/W/E_P */
>  #define EXT_CSD_FLUSH_CACHE            32      /* W */
>  #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>  #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
> @@ -328,6 +342,8 @@ struct _mmc_csd {
>  #define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
>  #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
>  #define EXT_CSD_PWR_CL_DDR_200_360     253     /* RO */
> +#define EXT_CSD_CMDQ_SUPPORT           308     /* RO */
> +#define EXT_CSD_CMDQ_DEPTH             307     /* RO */
>  #define EXT_CSD_FIRMWARE_VERSION       254     /* RO, 8 bytes */
>  #define EXT_CSD_SUPPORTED_MODE         493     /* RO */
>  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
> @@ -349,6 +365,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BOOT_WP_B_PWR_WP_EN    (0x01)
>
>  #define EXT_CSD_PART_CONFIG_ACC_MASK   (0x7)
> +#define EXT_CSD_PART_CONFIG_USER       (0x0)
>  #define EXT_CSD_PART_CONFIG_ACC_BOOT0  (0x1)
>  #define EXT_CSD_PART_CONFIG_ACC_RPMB   (0x3)
>  #define EXT_CSD_PART_CONFIG_ACC_GP0    (0x4)
> @@ -427,6 +444,10 @@ struct _mmc_csd {
>   */
>  #define EXT_CSD_BKOPS_LEVEL_2          0x2
>
> +/* CMDQ enable level */
> +#define EXT_CSD_CMDQ_MODE_OFF          0
> +#define EXT_CSD_CMDQ_MODE_ON           1
> +
>  /*
>   * BKOPS modes
>   */
> diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
> index 4a13920..436f6d2 100644
> --- a/include/linux/mmc/pm.h
> +++ b/include/linux/mmc/pm.h
> @@ -26,5 +26,6 @@ typedef unsigned int mmc_pm_flag_t;
>
>  #define MMC_PM_KEEP_POWER      (1 << 0)        /* preserve card powe=
r during suspend */
>  #define MMC_PM_WAKE_SDIO_IRQ   (1 << 1)        /* wake up host syste=
m on SDIO IRQ assertion */
> +#define MMC_PM_TUNING_AFTER_RTRESUME   (1 << 2)

Regarding periodic re-tuning for HS200/HS400, I have recently queued
patches for this. Besides that these patches likely needs a rebase, I
think you need to consider if there are command seqeunces for which
you need to hold re-tuning.

Possibly Adrian, who wrote the re-tuning patches can help to answer
that as well.

Kind regards
Uffe
