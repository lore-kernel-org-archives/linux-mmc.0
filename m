From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 3/5] mmc: card: Add eMMC command queuing support in mmc
 block layer
Date: Fri, 16 Jan 2015 09:15:32 +0530
Message-ID: <54B8895C.5070500@codeaurora.org>
References: <20141202115821.GA27658@asutoshd-ics.in.qualcomm.com> <CAPDyKFr+os_1zN=RRM2tGJhH89ULf6ZK5YgOGkFtgiO=oT5cPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr+os_1zN=RRM2tGJhH89ULf6ZK5YgOGkFtgiO=oT5cPg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf
Thanks for reviewing the patchset.

On 1/15/2015 7:26 PM, Ulf Hansson wrote:
> On 2 December 2014 at 12:58, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> Command queueing is defined in eMMC-5.1. It is designed for
>> higher performance by ensuring upto 32 requests to be serviced
>> at a time.
>> All non-data commands are referred as DCMD commands and are handled
>> differently than conventional eMMCs.
>>
>> Adds support for:
>>          - read/write
>>          - DCMD support
>>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> ---
>>   drivers/mmc/card/block.c   | 375 ++++++++++++++++++++++++++++++++++++++++++++-
>>   drivers/mmc/card/queue.c   |  95 +++++++++++-
>>   drivers/mmc/card/queue.h   |   3 +-
>>   drivers/mmc/core/core.c    |  87 +++++++++++
>>   drivers/mmc/core/mmc.c     |   6 +-
>>   drivers/mmc/core/mmc_ops.c |  45 ++++--
>>   include/linux/mmc/card.h   |   5 +-
>>   include/linux/mmc/core.h   |  14 ++
>>   include/linux/mmc/host.h   |  71 +++++++++
>>   include/linux/mmc/mmc.h    |   5 +-
>>   10 files changed, 677 insertions(+), 29 deletions(-)
>
> Considering the above changelog, I just can't review this patch.
> Please split it up.
OK. I'll split it.
>
> Still, I browsed through it quickly and found TODOs, ifdefs, out
> commented code etc. Now, I have seen worse code than this, but please
> try to look it from my perspective. I would like to invest my time in
> reviewing patches from a technical and not from an adminstrative
> perspective.
I understand, sorry about that. I'll recheck & correct it.

>
> Please go back and re-work this patchset. I will happily give it
> another try, hoping for increased quality!
>
> Also, please don't forget to provide some perfomance numbers.
I can provide some performance numbers in the last week of february or 
in the beginning of March. Is that fine ?
Do you want the comments addressed before I publish the performance 
numbers or do you prefer the comments to be addressed first ?

>
> Kind regards
> Uffe
>
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 452782b..d8826f2 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/capability.h>
>>   #include <linux/compat.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/ioprio.h>
>>
>>   #include <linux/mmc/ioctl.h>
>>   #include <linux/mmc/card.h>
>> @@ -99,6 +100,7 @@ struct mmc_blk_data {
>>   #define MMC_BLK_CMD23  (1 << 0)        /* Can do SET_BLOCK_COUNT for multiblock */
>>   #define MMC_BLK_REL_WR (1 << 1)        /* MMC Reliable write support */
>>   #define MMC_BLK_PACKED_CMD     (1 << 2)        /* MMC packed command support */
>> +#define MMC_BLK_CMD_QUEUE      (1 << 3) /* MMC command queue support */
>>
>>          unsigned int    usage;
>>          unsigned int    read_only;
>> @@ -638,6 +640,66 @@ static const struct block_device_operations mmc_bdops = {
>>   #endif
>>   };
>>
>> +static int mmc_blk_cmdq_switch(struct mmc_card *card,
>> +                       struct mmc_blk_data *md, bool enable)
>> +{
>> +       int ret = 0;
>> +       bool cmdq_mode = !!mmc_card_cmdq(card);
>> +       struct mmc_host *host = card->host;
>> +
>> +       if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE) ||
>> +           !card->ext_csd.cmdq_support ||
>> +           (enable && !(md->flags & MMC_BLK_CMD_QUEUE)) ||
>> +           (cmdq_mode == enable))
>> +               return 0;
>> +
>> +       if (host->cmdq_ops) {
>> +               if (enable) {
>> +                       ret = mmc_set_blocklen(card, MMC_CARD_CMDQ_BLK_SIZE);
>> +                       if (ret) {
>> +                               pr_err("%s: failed to set block-size to 512\n",
>> +                                      __func__);
>> +                               BUG();
>> +                       }
>> +               }
>> +
>> +               ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                                EXT_CSD_CMDQ, enable,
>> +                                card->ext_csd.generic_cmd6_time);
>> +               if (ret) {
>> +                       pr_err("%s: cmdq mode %sable failed %d\n",
>> +                              md->disk->disk_name, enable ? "en" : "dis", ret);
>> +                       goto out;
>> +               }
>> +               /* enable host controller command queue engine */
>> +               if (enable)
>> +                       ret = host->cmdq_ops->enable(card->host);
>> +               else
>> +                       host->cmdq_ops->disable(card->host, true);
>> +               if (ret) {
>> +                       pr_err("%s: failed to enable host controller cqe %d\n",
>> +                                       md->disk->disk_name,
>> +                                       ret);
>> +
>> +                       /* disable CQ mode in card */
>> +                       ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                                       EXT_CSD_CMDQ, 0,
>> +                                       card->ext_csd.generic_cmd6_time);
>> +                       goto out;
>> +               }
>> +       } else {
>> +               pr_err("%s: No cmdq ops defined !!!\n", __func__);
>> +               BUG();
>> +       }
>> +
>> +       if (enable)
>> +               mmc_card_set_cmdq(card);
>> +       else
>> +               mmc_card_clr_cmdq(card);
>> +out:
>> +       return ret;
>> +}
>> +
>>   static inline int mmc_blk_part_switch(struct mmc_card *card,
>>                                        struct mmc_blk_data *md)
>>   {
>> @@ -650,6 +712,13 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
>>          if (mmc_card_mmc(card)) {
>>                  u8 part_config = card->ext_csd.part_config;
>>
>> +               if (md->part_type) {
>> +                       /* disable CQ mode for non-user data partitions */
>> +                       ret = mmc_blk_cmdq_switch(card, md, false);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +
>>                  part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
>>                  part_config |= md->part_type;
>>
>> @@ -1813,6 +1882,254 @@ static void mmc_blk_revert_packed_req(struct mmc_queue *mq,
>>          mmc_blk_clear_packed(mq_rq);
>>   }
>>
>> +static int mmc_blk_cmdq_start_req(struct mmc_host *host,
>> +                                  struct mmc_cmdq_req *cmdq_req)
>> +{
>> +       struct mmc_request *mrq = &cmdq_req->mrq;
>> +
>> +       mrq->done = mmc_blk_cmdq_req_done;
>> +       return mmc_cmdq_start_req(host, cmdq_req);
>> +}
>> +
>> +/* prepare for non-data commands */
>> +static struct mmc_cmdq_req *mmc_cmdq_prep_dcmd(
>> +               struct mmc_queue_req *mqrq, struct mmc_queue *mq)
>> +{
>> +       struct request *req = mqrq->req;
>> +       struct mmc_cmdq_req *cmdq_req = &mqrq->mmc_cmdq_req;
>> +
>> +       memset(&mqrq->mmc_cmdq_req, 0, sizeof(struct mmc_cmdq_req));
>> +
>> +       cmdq_req->mrq.data = NULL;
>> +       cmdq_req->cmd_flags = req->cmd_flags;
>> +       cmdq_req->mrq.req = mqrq->req;
>> +       req->special = mqrq;
>> +       cmdq_req->cmdq_req_flags |= DCMD;
>> +       cmdq_req->mrq.cmdq_req = cmdq_req;
>> +
>> +       return &mqrq->mmc_cmdq_req;
>> +}
>> +
>> +
>> +#define IS_RT_CLASS_REQ(x)     \
>> +       (IOPRIO_PRIO_CLASS(req_get_ioprio(x)) == IOPRIO_CLASS_RT)
>> +
>> +static struct mmc_cmdq_req *mmc_blk_cmdq_rw_prep(
>> +               struct mmc_queue_req *mqrq, struct mmc_queue *mq)
>> +{
>> +       struct mmc_card *card = mq->card;
>> +       struct request *req = mqrq->req;
>> +       struct mmc_blk_data *md = mq->data;
>> +       bool do_rel_wr = mmc_req_rel_wr(req) && (md->flags & MMC_BLK_REL_WR);
>> +       bool do_data_tag;
>> +       bool read_dir = (rq_data_dir(req) == READ);
>> +       bool prio = IS_RT_CLASS_REQ(req);
>> +       struct mmc_cmdq_req *cmdq_rq = &mqrq->mmc_cmdq_req;
>> +
>> +       memset(&mqrq->mmc_cmdq_req, 0, sizeof(struct mmc_cmdq_req));
>> +
>> +       cmdq_rq->tag = req->tag;
>> +       if (read_dir) {
>> +               cmdq_rq->cmdq_req_flags |= DIR;
>> +               cmdq_rq->data.flags = MMC_DATA_READ;
>> +       } else {
>> +               cmdq_rq->data.flags = MMC_DATA_WRITE;
>> +       }
>> +       if (prio)
>> +               cmdq_rq->cmdq_req_flags |= PRIO;
>> +
>> +       if (do_rel_wr)
>> +               cmdq_rq->cmdq_req_flags |= REL_WR;
>> +
>> +       cmdq_rq->data.blocks = blk_rq_sectors(req);
>> +       cmdq_rq->blk_addr = blk_rq_pos(req);
>> +       cmdq_rq->data.blksz = MMC_CARD_CMDQ_BLK_SIZE;
>> +
>> +       mmc_set_data_timeout(&cmdq_rq->data, card);
>> +
>> +       do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>> +               (req->cmd_flags & REQ_META) &&
>> +               (rq_data_dir(req) == WRITE) &&
>> +               ((cmdq_rq->data.blocks * cmdq_rq->data.blksz) >=
>> +                card->ext_csd.data_tag_unit_size);
>> +       if (do_data_tag)
>> +               cmdq_rq->cmdq_req_flags |= DAT_TAG;
>> +       cmdq_rq->data.sg = mqrq->sg;
>> +       cmdq_rq->data.sg_len = mmc_queue_map_sg(mq, mqrq);
>> +
>> +       /*
>> +        * Adjust the sg list so it is the same size as the
>> +        * request.
>> +        */
>> +       if (cmdq_rq->data.blocks > card->host->max_blk_count)
>> +               cmdq_rq->data.blocks = card->host->max_blk_count;
>> +
>> +       if (cmdq_rq->data.blocks != blk_rq_sectors(req)) {
>> +               int i, data_size = cmdq_rq->data.blocks << 9;
>> +               struct scatterlist *sg;
>> +
>> +               for_each_sg(cmdq_rq->data.sg, sg, cmdq_rq->data.sg_len, i) {
>> +                       data_size -= sg->length;
>> +                       if (data_size <= 0) {
>> +                               sg->length += data_size;
>> +                               i++;
>> +                               break;
>> +                       }
>> +               }
>> +               cmdq_rq->data.sg_len = i;
>> +       }
>> +
>> +       mqrq->mmc_cmdq_req.cmd_flags = req->cmd_flags;
>> +       mqrq->mmc_cmdq_req.mrq.req = mqrq->req;
>> +       mqrq->mmc_cmdq_req.mrq.cmdq_req = &mqrq->mmc_cmdq_req;
>> +       mqrq->mmc_cmdq_req.mrq.data = &mqrq->mmc_cmdq_req.data;
>> +       mqrq->req->special = mqrq;
>> +
>> +       pr_debug("%s: %s: mrq: 0x%p req: 0x%p mqrq: 0x%p bytes to xf: %d mmc_cmdq_req: 0x%p card-addr: 0x%08x dir(r-1/w-0): %d\n",
>> +                mmc_hostname(card->host), __func__, &mqrq->mmc_cmdq_req.mrq,
>> +                mqrq->req, mqrq, (cmdq_rq->data.blocks * cmdq_rq->data.blksz),
>> +                cmdq_rq, cmdq_rq->blk_addr,
>> +                (cmdq_rq->cmdq_req_flags & DIR) ? 1 : 0);
>> +
>> +       return &mqrq->mmc_cmdq_req;
>> +}
>> +
>> +static int mmc_blk_cmdq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       struct mmc_queue_req *active_mqrq;
>> +       struct mmc_card *card = mq->card;
>> +       struct mmc_host *host = card->host;
>> +       struct mmc_cmdq_req *mc_rq;
>> +       int ret = 0;
>> +
>> +       BUG_ON((req->tag < 0) || (req->tag > card->ext_csd.cmdq_depth));
>> +       BUG_ON(test_and_set_bit(req->tag, &host->cmdq_ctx.active_reqs));
>> +
>> +       active_mqrq = &mq->mqrq_cmdq[req->tag];
>> +       active_mqrq->req = req;
>> +
>> +       mc_rq = mmc_blk_cmdq_rw_prep(active_mqrq, mq);
>> +
>> +       ret = mmc_blk_cmdq_start_req(card->host, mc_rq);
>> +       return ret;
>> +}
>> +
>> +/*
>> + * FIXME: handle discard as a dcmd request as well
>> + */
>> +int mmc_blk_cmdq_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       struct mmc_card *card = mq->card;
>> +       struct mmc_host *host = card->host;
>> +
>> +       pr_debug("%s: %s: invoked ###\n", mmc_hostname(host), __func__);
>> +
>> +       return -ENOSYS;
>> +}
>> +EXPORT_SYMBOL(mmc_blk_cmdq_issue_discard_rq);
>> +
>> +/*
>> + * Issues a dcmd request
>> + * FIXME:
>> + *     Try to pull another request from queue and prepare it in the
>> + *     meantime. If its not a dcmd it can be issued as well.
>> + */
>> +int mmc_blk_cmdq_issue_flush_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       int err;
>> +       struct mmc_queue_req *active_mqrq;
>> +       struct mmc_card *card = mq->card;
>> +       struct mmc_host *host;
>> +       struct mmc_cmdq_req *cmdq_req;
>> +       struct mmc_cmdq_context_info *ctx_info;
>> +
>> +       BUG_ON(!card);
>> +       host = card->host;
>> +       BUG_ON(!host);
>> +       BUG_ON((req->tag < 0) || (req->tag > card->ext_csd.cmdq_depth));
>> +       BUG_ON(test_and_set_bit(req->tag, &host->cmdq_ctx.active_reqs));
>> +
>> +       ctx_info = &host->cmdq_ctx;
>> +
>> +       spin_lock_bh(&ctx_info->cmdq_ctx_lock);
>> +       ctx_info->active_dcmd = true;
>> +       spin_unlock_bh(&ctx_info->cmdq_ctx_lock);
>> +
>> +       active_mqrq = &mq->mqrq_cmdq[req->tag];
>> +       active_mqrq->req = req;
>> +
>> +       cmdq_req = mmc_cmdq_prep_dcmd(active_mqrq, mq);
>> +       cmdq_req->cmdq_req_flags |= QBR;
>> +       cmdq_req->mrq.cmd = &cmdq_req->cmd;
>> +       cmdq_req->tag = req->tag;
>> +
>> +       err = __mmc_switch_cmdq_mode(cmdq_req->mrq.cmd, EXT_CSD_CMD_SET_NORMAL,
>> +                                       EXT_CSD_FLUSH_CACHE, 1,
>> +                                    MMC_FLUSH_REQ_TIMEOUT_MS, true, true);
>> +       if (err)
>> +               return err;
>> +
>> +       err = mmc_blk_cmdq_start_req(card->host, cmdq_req);
>> +       return err;
>> +}
>> +EXPORT_SYMBOL(mmc_blk_cmdq_issue_flush_rq);
>> +
>> +/* invoked by block layer in softirq context */
>> +void mmc_blk_cmdq_complete_rq(struct request *rq)
>> +{
>> +       struct mmc_queue_req *mq_rq = rq->special;
>> +       struct mmc_request *mrq = &mq_rq->mmc_cmdq_req.mrq;
>> +       struct mmc_host *host = mrq->host;
>> +       struct mmc_cmdq_context_info *ctx_info = &host->cmdq_ctx;
>> +       struct mmc_cmdq_req *cmdq_req = &mq_rq->mmc_cmdq_req;
>> +       int err = 0;
>> +
>> +       spin_lock(&ctx_info->cmdq_ctx_lock);
>> +       if (mrq->cmd && mrq->cmd->error)
>> +               err = mrq->cmd->error;
>> +       else if (mrq->data && mrq->data->error)
>> +               err = mrq->data->error;
>> +
>> +       mmc_cmdq_post_req(host, mrq, err);
>> +       if (err) {
>> +               pr_err("%s: %s: txfr error: %d\n", mmc_hostname(mrq->host),
>> +                      __func__, err);
>> +
>> +               if (mmc_cmdq_halt(host, true))
>> +                       BUG();
>> +               ctx_info->curr_state |= CMDQ_STATE_ERR;
>> +               /* TODO: wake-up kernel thread to handle error */
>> +       }
>> +
>> +       BUG_ON(!test_and_clear_bit(cmdq_req->tag,
>> +                                  &ctx_info->active_reqs));
>> +       if (cmdq_req->cmdq_req_flags & DCMD) {
>> +               ctx_info->active_dcmd = false;
>> +               spin_unlock(&ctx_info->cmdq_ctx_lock);
>> +               blk_end_request_all(rq, 0);
>> +               return;
>> +       }
>> +
>> +       spin_unlock(&ctx_info->cmdq_ctx_lock);
>> +
>> +       blk_end_request(rq, 0, cmdq_req->data.bytes_xfered);
>> +
>> +       if (test_and_clear_bit(0, &ctx_info->req_starved))
>> +               blk_run_queue(rq->q);
>> +}
>> +
>> +/*
>> + * Complete reqs from block layer softirq context
>> + * Invoked in irq context
>> + */
>> +void mmc_blk_cmdq_req_done(struct mmc_request *mrq)
>> +{
>> +       struct request *req = mrq->req;
>> +
>> +       blk_complete_request(req);
>> +}
>> +EXPORT_SYMBOL(mmc_blk_cmdq_req_done);
>> +
>>   static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>   {
>>          struct mmc_blk_data *md = mq->data;
>> @@ -2001,6 +2318,52 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>          return 0;
>>   }
>>
>> +static int mmc_blk_cmdq_issue_rq(struct mmc_queue *mq, struct request *req)
>> +{
>> +       int ret;
>> +       struct mmc_blk_data *md = mq->data;
>> +       struct mmc_card *card = md->queue.card;
>> +       unsigned int cmd_flags = req->cmd_flags;
>> +
>> +#ifdef CONFIG_MMC_BLOCK_DEFERRED_RESUME
>> +       if (mmc_bus_needs_resume(card->host))
>> +               mmc_resume_bus(card->host);
>> +#endif
>> +       ret = mmc_blk_part_switch(card, md);
>> +       if (ret) {
>> +               pr_err("%s: %s: partition switch failed %d\n",
>> +                               md->disk->disk_name, __func__, ret);
>> +               blk_end_request_all(req, ret);
>> +               goto switch_failure;
>> +       }
>> +
>> +       ret = mmc_blk_cmdq_switch(card, md, true);
>> +       if (ret) {
>> +               /* TODO: put a limit on the number of requeues if switch fails
>> +                * and if possible disable cmd queing for buggy cards.
>> +                */
>> +               spin_lock_irq(mq->queue->queue_lock);
>> +               blk_requeue_request(mq->queue, req);
>> +               spin_unlock_irq(mq->queue->queue_lock);
>> +               goto switch_failure;
>> +       }
>> +
>> +       if (cmd_flags & REQ_DISCARD) {
>> +               /* if (req->cmd_flags & REQ_SECURE && */
>> +               /*      !(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN)) */
>> +               /*      ret = mmc_blk_issue_secdiscard_rq(mq, req); */
>> +               /* else */
>> +               ret = mmc_blk_cmdq_issue_discard_rq(mq, req);
>> +       } else if (cmd_flags & REQ_FLUSH) {
>> +               ret = mmc_blk_cmdq_issue_flush_rq(mq, req);
>> +       } else {
>> +               ret = mmc_blk_cmdq_issue_rw_rq(mq, req);
>> +       }
>> +
>> +switch_failure:
>> +       return ret;
>> +}
>> +
>>   static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>>   {
>>          int ret;
>> @@ -2118,7 +2481,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>          INIT_LIST_HEAD(&md->part);
>>          md->usage = 1;
>>
>> -       ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
>> +       ret = mmc_init_queue(&md->queue, card, &md->lock, subname, area_type);
>>          if (ret)
>>                  goto err_putdisk;
>>
>> @@ -2173,7 +2536,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>                  blk_queue_flush(md->queue.queue, REQ_FLUSH | REQ_FUA);
>>          }
>>
>> -       if (mmc_card_mmc(card) &&
>> +       if (card->cmdq_init) {
>> +               md->flags |= MMC_BLK_CMD_QUEUE;
>> +               md->queue.cmdq_complete_fn = mmc_blk_cmdq_complete_rq;
>> +               md->queue.cmdq_issue_fn = mmc_blk_cmdq_issue_rq;
>> +       }
>> +
>> +       if (mmc_card_mmc(card) && !card->cmdq_init &&
>>              (area_type == MMC_BLK_DATA_AREA_MAIN) &&
>>              (md->flags & MMC_BLK_CMD23) &&
>>              card->ext_csd.packed_event_en) {
>> @@ -2284,6 +2653,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>>                  mmc_cleanup_queue(&md->queue);
>>                  if (md->flags & MMC_BLK_PACKED_CMD)
>>                          mmc_packed_clean(&md->queue);
>> +               if (md->flags & MMC_BLK_CMD_QUEUE)
>> +                       mmc_cmdq_clean(&md->queue, card);
>>                  if (md->disk->flags & GENHD_FL_UP) {
>>                          device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>>                          if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index c99e385..71b6717 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -104,6 +104,54 @@ static int mmc_queue_thread(void *d)
>>          return 0;
>>   }
>>
>> +static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host,
>> +                                       struct mmc_cmdq_context_info *ctx)
>> +{
>> +       spin_lock_bh(&ctx->cmdq_ctx_lock);
>> +       if (ctx->active_dcmd || ctx->rpmb_in_wait) {
>> +               if ((ctx->curr_state != CMDQ_STATE_HALT) ||
>> +                       (ctx->curr_state != CMDQ_STATE_ERR)) {
>> +                       pr_debug("%s: %s: skip pulling reqs: dcmd: %d rpmb: %d state: %d\n",
>> +                                mmc_hostname(host), __func__, ctx->active_dcmd,
>> +                                ctx->rpmb_in_wait, ctx->curr_state);
>> +                       spin_unlock_bh(&ctx->cmdq_ctx_lock);
>> +                       return false;
>> +               }
>> +       } else {
>> +               spin_unlock_bh(&ctx->cmdq_ctx_lock);
>> +               return true;
>> +       }
>> +}
>> +
>> +static void mmc_cmdq_dispatch_req(struct request_queue *q)
>> +{
>> +       struct request *req;
>> +       struct mmc_queue *mq = q->queuedata;
>> +       struct mmc_card *card = mq->card;
>> +       struct mmc_host *host = card->host;
>> +       struct mmc_cmdq_context_info *ctx = &host->cmdq_ctx;
>> +
>> +       while (1) {
>> +               if (!mmc_cmdq_should_pull_reqs(host, ctx)) {
>> +                       test_and_set_bit(0, &ctx->req_starved);
>> +                       return;
>> +               }
>> +
>> +               req = blk_peek_request(q);
>> +               if (!req)
>> +                       return;
>> +
>> +               if (blk_queue_start_tag(q, req)) {
>> +                       test_and_set_bit(0, &ctx->req_starved);
>> +                       return;
>> +               }
>> +
>> +               spin_unlock_irq(q->queue_lock);
>> +               mq->cmdq_issue_fn(mq, req);
>> +               spin_lock_irq(q->queue_lock);
>> +       }
>> +}
>> +
>>   /*
>>    * Generic MMC request handler.  This is called for any queue on a
>>    * particular host.  When the host is not busy, we look for a request
>> @@ -179,6 +227,29 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>>   }
>>
>>   /**
>> + * mmc_blk_cmdq_setup_queue
>> + * @mq: mmc queue
>> + * @card: card to attach to this queue
>> + *
>> + * Setup queue for CMDQ supporting MMC card
>> + */
>> +void mmc_blk_cmdq_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>> +{
>> +       u64 limit = BLK_BOUNCE_HIGH;
>> +       struct mmc_host *host = card->host;
>> +
>> +       queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
>> +       if (mmc_can_erase(card))
>> +               mmc_queue_setup_discard(mq->queue, card);
>> +
>> +       blk_queue_bounce_limit(mq->queue, limit);
>> +       blk_queue_max_hw_sectors(mq->queue, min(host->max_blk_count,
>> +                                               host->max_req_size / 512));
>> +       blk_queue_max_segment_size(mq->queue, host->max_seg_size);
>> +       blk_queue_max_segments(mq->queue, host->max_segs);
>> +}
>> +
>> +/**
>>    * mmc_init_queue - initialise a queue structure.
>>    * @mq: mmc queue
>>    * @card: mmc card to attach this queue
>> @@ -188,7 +259,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>>    * Initialise a MMC card request queue.
>>    */
>>   int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>> -                  spinlock_t *lock, const char *subname)
>> +                  spinlock_t *lock, const char *subname, int area_type)
>>   {
>>          struct mmc_host *host = card->host;
>>          u64 limit = BLK_BOUNCE_HIGH;
>> @@ -200,6 +271,23 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>>                  limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>>
>>          mq->card = card;
>> +       if (card->ext_csd.cmdq_support &&
>> +           (area_type == MMC_BLK_DATA_AREA_MAIN)) {
>> +               mq->queue = blk_init_queue(mmc_cmdq_dispatch_req, lock);
>> +               if (!mq->queue)
>> +                       return -ENOMEM;
>> +               mmc_blk_cmdq_setup_queue(mq, card);
>> +               ret = mmc_cmdq_init(mq, card);
>> +               if (ret) {
>> +                       pr_err("%s: %d: cmdq: unable to set-up\n",
>> +                              mmc_hostname(card->host), ret);
>> +                       blk_cleanup_queue(mq->queue);
>> +               } else {
>> +                       mq->queue->queuedata = mq;
>> +                       return ret;
>> +               }
>> +       }
>> +
>>          mq->queue = blk_init_queue(mmc_request_fn, lock);
>>          if (!mq->queue)
>>                  return -ENOMEM;
>> @@ -417,10 +505,7 @@ int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
>>          int q_depth = card->ext_csd.cmdq_depth - 1;
>>
>>          card->cmdq_init = false;
>> -       if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE)) {
>> -               ret = -ENOTSUPP;
>> -               goto out;
>> -       }
>> +       spin_lock_init(&card->host->cmdq_ctx.cmdq_ctx_lock);
>>
>>          mq->mqrq_cmdq = kzalloc(
>>                          sizeof(struct mmc_queue_req) * q_depth, GFP_KERNEL);
>> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
>> index 36a8d64..c971148 100644
>> --- a/drivers/mmc/card/queue.h
>> +++ b/drivers/mmc/card/queue.h
>> @@ -41,6 +41,7 @@ struct mmc_queue_req {
>>          struct mmc_async_req    mmc_active;
>>          enum mmc_packed_type    cmd_type;
>>          struct mmc_packed       *packed;
>> +       struct mmc_cmdq_req     mmc_cmdq_req;
>>   };
>>
>>   struct mmc_queue {
>> @@ -63,7 +64,7 @@ struct mmc_queue {
>>   };
>>
>>   extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
>> -                         const char *);
>> +                         const char *, int);
>>   extern void mmc_cleanup_queue(struct mmc_queue *);
>>   extern void mmc_queue_suspend(struct mmc_queue *);
>>   extern void mmc_queue_resume(struct mmc_queue *);
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index acbc3f2..79f7f89 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -241,6 +241,36 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>          host->ops->request(host, mrq);
>>   }
>>
>> +static void mmc_start_cmdq_request(struct mmc_host *host,
>> +                                  struct mmc_request *mrq)
>> +{
>> +       if (mrq->data) {
>> +               pr_debug("%s:     blksz %d blocks %d flags %08x tsac %lu ms nsac %d\n",
>> +                       mmc_hostname(host), mrq->data->blksz,
>> +                       mrq->data->blocks, mrq->data->flags,
>> +                       mrq->data->timeout_ns / NSEC_PER_MSEC,
>> +                       mrq->data->timeout_clks);
>> +       }
>> +
>> +       mrq->cmd->error = 0;
>> +       mrq->cmd->mrq = mrq;
>> +       if (mrq->data) {
>> +               BUG_ON(mrq->data->blksz > host->max_blk_size);
>> +               BUG_ON(mrq->data->blocks > host->max_blk_count);
>> +               BUG_ON(mrq->data->blocks * mrq->data->blksz >
>> +                       host->max_req_size);
>> +
>> +               mrq->cmd->data = mrq->data;
>> +               mrq->data->error = 0;
>> +               mrq->data->mrq = mrq;
>> +       }
>> +
>> +       mmc_host_clk_hold(host);
>> +       led_trigger_event(host->led, LED_FULL);
>> +
>> +       host->cmdq_ops->request(host, mrq);
>> +}
>> +
>>   /**
>>    *     mmc_start_bkops - start BKOPS for supported cards
>>    *     @card: MMC card to start BKOPS
>> @@ -495,6 +525,63 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
>>   }
>>
>>   /**
>> + *     mmc_cmdq_post_req - post process of a completed request
>> + *     @host: host instance
>> + *     @mrq: the request to be processed
>> + *     @err: non-zero is error, success otherwise
>> + */
>> +void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq, int err)
>> +{
>> +       if (host->cmdq_ops->post_req)
>> +               host->cmdq_ops->post_req(host, mrq, err);
>> +}
>> +EXPORT_SYMBOL(mmc_cmdq_post_req);
>> +
>> +/**
>> + *     mmc_cmdq_halt - halt/un-halt the command queue engine
>> + *     @host: host instance
>> + *     @halt: true - halt, un-halt otherwise
>> + *
>> + *     Host halts the command queue engine. It should complete
>> + *     the ongoing transfer and release the SD bus.
>> + *     All legacy SD commands can be sent upon successful
>> + *     completion of this function.
>> + *     Returns 0 on success, negative otherwise
>> + */
>> +int mmc_cmdq_halt(struct mmc_host *host, bool halt)
>> +{
>> +       int err = 0;
>> +
>> +       if ((halt && (host->cmdq_ctx.curr_state & CMDQ_STATE_HALT)) ||
>> +           (!halt && !(host->cmdq_ctx.curr_state & CMDQ_STATE_HALT)))
>> +               return 1;
>> +
>> +       if (host->cmdq_ops->halt) {
>> +               err = host->cmdq_ops->halt(host, halt);
>> +               if (!err && halt)
>> +                       host->cmdq_ctx.curr_state |= CMDQ_STATE_HALT;
>> +               else if (!err && !halt)
>> +                       host->cmdq_ctx.curr_state &= ~CMDQ_STATE_HALT;
>> +       }
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_cmdq_halt);
>> +
>> +int mmc_cmdq_start_req(struct mmc_host *host, struct mmc_cmdq_req *cmdq_req)
>> +{
>> +       struct mmc_request *mrq = &cmdq_req->mrq;
>> +
>> +       mrq->host = host;
>> +       if (mmc_card_removed(host->card)) {
>> +               mrq->cmd->error = -ENOMEDIUM;
>> +               return -ENOMEDIUM;
>> +       }
>> +       mmc_start_cmdq_request(host, mrq);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_cmdq_start_req);
>> +
>> +/**
>>    *     mmc_start_req - start a non-blocking request
>>    *     @host: MMC host to start command
>>    *     @areq: async request to start
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 0ef3af5..ec1bfcd 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -579,8 +579,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>
>>          if (card->ext_csd.rev >= 7) {
>>                  card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
>> -               if (card->ext_csd.cmdq_support)
>> +               if (card->ext_csd.cmdq_support) {
>> +                       pr_info("%s: %s: CMDQ supported: depth: %d\n",
>> +                               mmc_hostname(card->host), __func__,
>> +                               card->ext_csd.cmdq_depth);
>>                          card->ext_csd.cmdq_depth = ext_csd[EXT_CSD_CMDQ_DEPTH];
>> +               }
>>          } else {
>>                  card->ext_csd.cmdq_support = 0;
>>                  card->ext_csd.cmdq_depth = 0;
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index f51b5ba..554fb57 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -395,6 +395,33 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
>>          return err;
>>   }
>>
>> +
>> +static inline void mmc_prepare_switch(struct mmc_command *cmd, u8 index,
>> +                                     u8 value, u8 set, unsigned int tout_ms,
>> +                                     bool use_busy_signal)
>> +{
>> +       cmd->opcode = MMC_SWITCH;
>> +       cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>> +                 (index << 16) |
>> +                 (value << 8) |
>> +                 set;
>> +       cmd->flags = MMC_CMD_AC;
>> +       cmd->busy_timeout = tout_ms;
>> +       if (use_busy_signal)
>> +               cmd->flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>> +       else
>> +               cmd->flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>> +}
>> +
>> +int __mmc_switch_cmdq_mode(struct mmc_command *cmd, u8 set, u8 index, u8 value,
>> +                          unsigned int timeout_ms, bool use_busy_signal,
>> +                          bool ignore_timeout)
>> +{
>> +       mmc_prepare_switch(cmd, index, value, set, timeout_ms, use_busy_signal);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(__mmc_switch_cmdq_mode);
>> +
>>   /**
>>    *     __mmc_switch - modify EXT_CSD register
>>    *     @card: the MMC card associated with the data transfer
>> @@ -430,22 +457,8 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>                  (timeout_ms > host->max_busy_timeout))
>>                  use_r1b_resp = false;
>>
>> -       cmd.opcode = MMC_SWITCH;
>> -       cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>> -                 (index << 16) |
>> -                 (value << 8) |
>> -                 set;
>> -       cmd.flags = MMC_CMD_AC;
>> -       if (use_r1b_resp) {
>> -               cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>> -               /*
>> -                * A busy_timeout of zero means the host can decide to use
>> -                * whatever value it finds suitable.
>> -                */
>> -               cmd.busy_timeout = timeout_ms;
>> -       } else {
>> -               cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>> -       }
>> +       mmc_prepare_switch(&cmd, index, value, set, timeout_ms,
>> +                          use_r1b_resp);
>>
>>          if (index == EXT_CSD_SANITIZE_START)
>>                  cmd.sanitize_busy = true;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 41f368d..4bd0ab2 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/mmc/core.h>
>>   #include <linux/mod_devicetable.h>
>>
>> +#define MMC_CARD_CMDQ_BLK_SIZE 512
>>   struct mmc_cid {
>>          unsigned int            manfid;
>>          char                    prod_name[8];
>> @@ -112,7 +113,7 @@ struct mmc_ext_csd {
>>          u8                      raw_pwr_cl_ddr_52_360;  /* 239 */
>>          u8                      raw_bkops_status;       /* 246 */
>>          u8                      raw_sectors[4];         /* 212 - 4 bytes */
>> -       u8                      cmdq_mode_en;           /* 15 */
>> +       u8                      cmdq_en;                /* 15 */
>>          u8                      cmdq_depth;             /* 307 */
>>          u8                      cmdq_support;           /* 308 */
>>
>> @@ -545,6 +546,4 @@ extern void mmc_unregister_driver(struct mmc_driver *);
>>
>>   extern void mmc_fixup_device(struct mmc_card *card,
>>                               const struct mmc_fixup *table);
>> -
>> -extern void mmc_blk_cmdq_req_done(struct mmc_request *mrq);
>>   #endif /* LINUX_MMC_CARD_H */
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index f206e29..33403c3 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -131,19 +131,27 @@ struct mmc_request {
>>          struct mmc_command      *cmd;
>>          struct mmc_data         *data;
>>          struct mmc_command      *stop;
>> +       struct mmc_command      *task_mgmt;
>>
>>          struct completion       completion;
>>          void                    (*done)(struct mmc_request *);/* completion function */
>>          struct mmc_host         *host;
>> +       struct mmc_cmdq_req     *cmdq_req;
>> +       struct request          *req; /* associated block request */
>>   };
>>
>>   struct mmc_card;
>>   struct mmc_async_req;
>> +struct mmc_cmdq_req;
>>
>>   extern int mmc_stop_bkops(struct mmc_card *);
>>   extern int mmc_read_bkops_status(struct mmc_card *);
>>   extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>>                                             struct mmc_async_req *, int *);
>> +extern void mmc_wait_cmdq_empty(struct mmc_card *);
>> +extern int mmc_cmdq_start_req(struct mmc_host *host,
>> +                             struct mmc_cmdq_req *cmdq_req);
>> +extern void mmc_blk_cmdq_req_done(struct mmc_request *mrq);
>>   extern int mmc_interrupt_hpi(struct mmc_card *);
>>   extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>>   extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
>> @@ -155,6 +163,12 @@ extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
>>                          bool, bool);
>>   extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>>   extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
>> +extern int __mmc_switch_cmdq_mode(struct mmc_command *cmd, u8 set, u8 index,
>> +                                 u8 value, unsigned int timeout_ms,
>> +                                 bool use_busy_signal, bool ignore_timeout);
>> +extern int mmc_cmdq_halt(struct mmc_host *host, bool enable);
>> +extern void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq,
>> +                             int err);
>>
>>   #define MMC_ERASE_ARG          0x00000000
>>   #define MMC_SECURE_ERASE_ARG   0x80000000
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index f0edb36..1c51ecc 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -80,6 +80,15 @@ struct mmc_ios {
>>   #define MMC_SET_DRIVER_TYPE_D  3
>>   };
>>
>> +struct mmc_cmdq_host_ops {
>> +       int (*enable)(struct mmc_host *host);
>> +       void (*disable)(struct mmc_host *host, bool soft);
>> +       int (*request)(struct mmc_host *host, struct mmc_request *mrq);
>> +       int (*halt)(struct mmc_host *host, bool halt);
>> +       void (*post_req)(struct mmc_host *host, struct mmc_request *mrq,
>> +                        int err);
>> +};
>> +
>>   struct mmc_host_ops {
>>          /*
>>           * 'enable' is called when the host is claimed and 'disable' is called
>> @@ -144,6 +153,26 @@ struct mmc_host_ops {
>>   struct mmc_card;
>>   struct device;
>>
>> +struct mmc_cmdq_req {
>> +       unsigned int cmd_flags;
>> +       u32 blk_addr;
>> +       /* active mmc request */
>> +       struct mmc_request      mrq;
>> +       struct mmc_command      task_mgmt;
>> +       struct mmc_data         data;
>> +       struct mmc_command      cmd;
>> +#define DCMD   (1 << 0)
>> +#define QBR    (1 << 1)
>> +#define DIR    (1 << 2)
>> +#define PRIO   (1 << 3)
>> +#define REL_WR (1 << 4)
>> +#define DAT_TAG        (1 << 5)
>> +#define FORCED_PRG (1 << 6)
>> +       unsigned int            cmdq_req_flags;
>> +       int                     tag; /* used for command queuing */
>> +       u8                      ctx_id;
>> +};
>> +
>>   struct mmc_async_req {
>>          /* active mmc request */
>>          struct mmc_request      *mrq;
>> @@ -188,6 +217,33 @@ struct mmc_context_info {
>>          spinlock_t              lock;
>>   };
>>
>> +enum cmdq_states {
>> +       CMDQ_STATE_HALT,
>> +       CMDQ_STATE_ERR,
>> +};
>> +
>> +/**
>> + * mmc_cmdq_context_info - describes the contexts of cmdq
>> + * @active_reqs                requests being processed
>> + * @active_dcmd                dcmd in progress, don't issue any
>> + *                     more dcmd requests
>> + * @rpmb_in_wait       do not pull any more reqs till rpmb is handled
>> + * @cmdq_state         state of cmdq engine
>> + * @req_starved                completion should invoke the request_fn since
>> + *                     no tags were available
>> + * @cmdq_ctx_lock      acquire this before accessing this structure
>> + */
>> +struct mmc_cmdq_context_info {
>> +       unsigned long   active_reqs; /* in-flight requests */
>> +       bool            active_dcmd;
>> +       bool            rpmb_in_wait;
>> +       enum cmdq_states curr_state;
>> +
>> +       /* no free tag available */
>> +       unsigned long   req_starved;
>> +       spinlock_t      cmdq_ctx_lock;
>> +};
>> +
>>   struct regulator;
>>
>>   struct mmc_supply {
>> @@ -200,6 +256,7 @@ struct mmc_host {
>>          struct device           class_dev;
>>          int                     index;
>>          const struct mmc_host_ops *ops;
>> +       const struct mmc_cmdq_host_ops *cmdq_ops;
>>          unsigned int            f_min;
>>          unsigned int            f_max;
>>          unsigned int            f_init;
>> @@ -359,6 +416,15 @@ struct mmc_host {
>>
>>          unsigned int            slotno; /* used for sdio acpi binding */
>>
>> +       unsigned int    cmdq_slots;
>> +       struct mmc_cmdq_context_info    cmdq_ctx;
>> +       /*
>> +        * several cmdq supporting host controllers are extensions
>> +        * of legacy controllers. This variable can be used to store
>> +        * a reference to the cmdq extension of the existing host
>> +        * controller.
>> +        */
>> +       void *cmdq_private;
>>          unsigned long           private[0] ____cacheline_aligned;
>>   };
>>
>> @@ -368,6 +434,11 @@ void mmc_remove_host(struct mmc_host *);
>>   void mmc_free_host(struct mmc_host *);
>>   int mmc_of_parse(struct mmc_host *host);
>>
>> +static inline void *mmc_cmdq_private(struct mmc_host *host)
>> +{
>> +       return host->cmdq_private;
>> +}
>> +
>>   static inline void *mmc_priv(struct mmc_host *host)
>>   {
>>          return (void *)host->private;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index a893c84..1fb12e2 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -87,6 +87,9 @@
>>   /* MMC 5.1 - class 11: Command Queueing */
>>   #define MMC_CMDQ_TASK_MGMT        48  /* ac   [31:0] task ID     R1b */
>>
>> +/* Flushing a large amount of cached data may take a long time. */
>> +#define MMC_FLUSH_REQ_TIMEOUT_MS 90000 /* msec */
>> +
>>   static inline bool mmc_op_multi(u32 opcode)
>>   {
>>          return opcode == MMC_WRITE_MULTIPLE_BLOCK ||
>> @@ -275,7 +278,7 @@ struct _mmc_csd {
>>    * EXT_CSD fields
>>    */
>>
>> -#define EXT_CSD_CMDQ_MODE              15      /* R/W */
>> +#define EXT_CSD_CMDQ                   15      /* R/W */
>>   #define EXT_CSD_FLUSH_CACHE            32      /* W */
>>   #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>>   #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
>> --
>> 1.8.2.1
>>
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
