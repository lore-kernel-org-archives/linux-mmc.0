From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Fri, 03 Feb 2012 11:45:57 +0900
Message-ID: <4F2B4A65.3090405@samsung.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
 <CANfBPZ96jSe8rUr2Mvif-F76v0xPP=2Rg7-eOCxP8L3j481WTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:62259 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab2BCCqP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2012 21:46:15 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYS00LAEQBSXZJ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Feb 2012 11:46:13 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYS00AH0QCYDQ10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 03 Feb 2012 11:46:11 +0900 (KST)
In-reply-to: <CANfBPZ96jSe8rUr2Mvif-F76v0xPP=2Rg7-eOCxP8L3j481WTg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 02/03/2012 01:08 AM, S, Venkatraman wrote:

> On Wed, Feb 1, 2012 at 8:57 PM, Saugata Das <saugata.das@stericsson.com> wrote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> This patch groups the read or write transfers to eMMC in different contexts
>> based on the block number. Transfers to consecutive blocks are grouped to a
>> common context. So several small transfers combine to give performance like
>> a large multi block transfer.
>>
>> The patch creates a context of 1MB multiple in non-large unit mode. Reliable
>> mode is enabled in the context based on whether reliable write is enabled.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> ---
> The patch subject could be better off as "mmc: eMMC4.5 context ID support"
> 
>>  drivers/mmc/card/block.c |  263 ++++++++++++++++++++++++++++++++++++++++++----
>>  drivers/mmc/core/mmc.c   |    6 +
>>  include/linux/mmc/card.h |   13 +++
>>  include/linux/mmc/core.h |    9 ++
>>  include/linux/mmc/host.h |    1 +
>>  include/linux/mmc/mmc.h  |    3 +
>>  6 files changed, 275 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 176b78e..161174a 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -127,6 +127,8 @@ enum mmc_blk_status {
>>  module_param(perdev_minors, int, 0444);
>>  MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
>>
>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *, struct request *);
>> +
>>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>>  {
>>        struct mmc_blk_data *md;
>> @@ -1071,6 +1073,192 @@ static int mmc_blk_err_check(struct mmc_card *card,
>>        return MMC_BLK_SUCCESS;
>>  }
>>
>> +/*
>> + * Update the context information in the ext. CSD
> 
> Mixed case
> 
>> + */
>> +static int mmc_context_modify(struct mmc_queue *mq,
>> +                               struct mmc_card *card,
>> +                               unsigned int context_id,
>> +                               unsigned char context_conf)
>> +{
>> +       /*
>> +        * Wait for any ongoing transfer
>> +        */
>> +       if (card->host->areq)
>> +               mmc_blk_issue_rw_rq(mq, NULL);
>> +
>> +       /*
>> +        * CONTEXT_CONF array starts from context id 1
>> +        */
>> +       return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                       EXT_CSD_CONTEXT_CONF + context_id - 1,
>> +                       context_conf,
>> +                       card->ext_csd.generic_cmd6_time);
>> +}
>> +
>> +/*
>> + * Update timestamp, size and close context if needed
>> + */
>> +static int mmc_check_close_context(struct mmc_queue *mq,
>> +                               struct mmc_card *card,
>> +                               unsigned int context_id,
>> +                               unsigned int status)
>> +{
>> +       /*
>> +        * Check only for valid contexts
>> +        */
>> +       if ((context_id > 0) &&
>> +               (context_id <= card->ext_csd.max_context_id) &&
>> +               (card->mmc_context[context_id].valid)) {
>> +
>> +               /*
>> +                * Incase of an error or we are multiple of erase block then
>> +                * close the context
>> +                */
>> +               if ((status) ||
>> +                       ((card->mmc_context[context_id].size %
>> +                               card->ext_csd.lu_size) == 0)) {
>> +                       if (mmc_context_modify(mq, card, context_id,
>> +                                       MMC_CONTEXT_CLOSE))
>> +                               return -1;
> Should propagate the error code instead of returning -1
> 
>> +                       card->mmc_context[context_id].valid = 0;
>> +               }
>> +               return 0;
>> +       }
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Update timestamp, size and close context if needed
>> + */
>> +static int mmc_force_close_all_write_context(struct mmc_queue *mq,
>> +                               struct mmc_card *card)
>> +{
>> +       int i, ret = 0;
>> +       for (i = 1; i <= card->ext_csd.max_context_id; i++) {
>> +               if (card->mmc_context[i].direction != MMC_CONTEXT_READ) {
>> +                       ret = mmc_check_close_context(mq, card, i,
>> +                                       MMC_CONTEXT_FORCE_CLOSE);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +       return ret;
>> +}
>> +
>> +/*
>> + * Search for a context which is in the same direction and
>> + * continuous in block numbers. If no matching context is
>> + * found then take up an unused context. If all contexts are
>> + * used then close the context which is least recently used,
>> + * close it and the use it for the new transfer
>> + */
>> +static int mmc_get_context_id(struct mmc_queue *mq,
>> +                               struct mmc_card *card,
>> +                               unsigned int offset,
>> +                               unsigned int size,
>> +                               unsigned int direction,
>> +                               unsigned int rel_wr)
>> +{
>> +       int i, free_index = -1, lru_index = -1, ret_index;
>> +       unsigned int old_timestamp = -1;
>> +       unsigned int reliability_mode = rel_wr ? (0x01<<5) : 0;
>> +       struct mmc_context *context_ptr = &card->mmc_context[1];
>> +
>> +       /*
>> +        * For older than 4.5 eMMC, there is no context ID
>> +        */
>> +       if (card->ext_csd.max_context_id == 0)
>> +               return 0;
>> +
>> +       if (card->host->caps2 & MMC_CAP2_NO_CONTEXT)
>> +               return 0;
>> +
>> +       /*
>> +        * If the request is LU size multiple then avoid
>> +        * using any context
>> +        */
>> +       if ((size % card->ext_csd.lu_size) == 0)
>> +               return 0;
>> +
>> +       /*
>> +        * Context 0 is unused
>> +        */
>> +       for (i = 1; i <= card->ext_csd.max_context_id; i++, context_ptr++) {
>> +
>> +               unsigned int context_start_blk;
>> +
>> +               if (!context_ptr->valid) {
>> +                       if (free_index == -1)
>> +                               free_index = i;
>> +                       continue;
>> +               }
>> +
>> +               context_start_blk = context_ptr->offset -
>> +                       context_ptr->size;
>> +
>> +               if ((context_start_blk <= offset) &&
>> +                       (context_ptr->offset > offset)) {
> 
> How would this condition ever match ? The starting offset of the
> previous request is usually less than the current request or it is
> more, but not both.
> 
>> +                       int ret = mmc_check_close_context(mq, card, i,
>> +                                       MMC_CONTEXT_FORCE_CLOSE);
>> +                       if (ret < 0)
>> +                               return ret;
>> +                       if (free_index == -1)
>> +                               free_index = i;
>> +                       break;
>> +               }
>> +
>> +               if ((lru_index == -1) ||
>> +                       (context_ptr->timestamp < old_timestamp)) {
>> +                       old_timestamp = context_ptr->timestamp;
>> +                       lru_index = i;
>> +               }
>> +
>> +               if ((context_ptr->direction != direction) ||
>> +                       (context_ptr->offset != offset) ||
>> +                       (context_ptr->reliability_mode !=
>> +                               reliability_mode))
>> +                       continue;
> 
> I think the reliability mode match shouldn't matter. If the writes to
> the same section of the device, the best of the reliability modes can
> be applied.
> This section should be moved above the context_start_blk and offset
> checking code.
> Why close an ongoing context if the directions don't match eventually ?
> 
>> +
>> +               context_ptr->timestamp = jiffies;
>> +               context_ptr->offset += size;
>> +               context_ptr->size += size;
>> +               return i;
>> +       }
>> +
>> +       if (free_index != -1) {
>> +               /*
>> +                * Open a free context
>> +                */
>> +               if (mmc_context_modify(mq, card, free_index,
>> +                               (direction & 0x03) | reliability_mode))
>> +                       return -1;
>> +               ret_index = free_index;
>> +       } else if (lru_index != -1) {
>> +               /*
>> +                * Close and reopen the LRU context
>> +                */
>> +               if (mmc_context_modify(mq, card, lru_index, MMC_CONTEXT_CLOSE))
>> +                       return -1;
>> +
>> +               if (mmc_context_modify(mq, card, lru_index,
>> +                               (direction & 0x03) | reliability_mode))
>> +                       return -1;
>> +               ret_index = lru_index;
>> +       } else
>> +               return -1;
>> +
>> +       context_ptr = &card->mmc_context[ret_index];
>> +       context_ptr->offset = offset+size;
>> +       context_ptr->size = size;
>> +       context_ptr->direction = direction;
>> +       context_ptr->timestamp = jiffies;
>> +       context_ptr->reliability_mode = reliability_mode;
>> +       context_ptr->valid = 1;
>> +
>> +       return ret_index;
>> +}
>> +
>>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>                               struct mmc_card *card,
>>                               int disable_multi,
>> @@ -1080,7 +1268,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>        struct mmc_blk_request *brq = &mqrq->brq;
>>        struct request *req = mqrq->req;
>>        struct mmc_blk_data *md = mq->data;
>> -       bool do_data_tag;
>>
>>        /*
>>         * Reliable writes are used to implement Forced Unit Access and
>> @@ -1157,16 +1344,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>                mmc_apply_rel_rw(brq, card, req);
>>
>>        /*
>> -        * Data tag is used only during writing meta data to speed
>> -        * up write and any subsequent read of this meta data
>> -        */
>> -       do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>> -               (req->cmd_flags & REQ_META) &&
>> -               (rq_data_dir(req) == WRITE) &&
>> -               ((brq->data.blocks * brq->data.blksz) >=
>> -                card->ext_csd.data_tag_unit_size);
>> -
>> -       /*
>>         * Pre-defined multi-block transfers are preferable to
>>         * open ended-ones (and necessary for reliable writes).
>>         * However, it is not sufficient to just send CMD23,
>> @@ -1184,15 +1361,54 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>         * We'll avoid using CMD23-bounded multiblock writes for
>>         * these, while retaining features like reliable writes.
>>         */
>> -       if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
>> -           (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
>> -            do_data_tag)) {
>> -               brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
>> -               brq->sbc.arg = brq->data.blocks |
>> -                       (do_rel_wr ? (1 << 31) : 0) |
>> -                       (do_data_tag ? (1 << 29) : 0);
>> -               brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> -               brq->mrq.sbc = &brq->sbc;
>> +       if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode)) {
>> +               /*
>> +                * Context ID is used for non-large unit and non-reliable
>> +                * write transfers provided the start block number
>> +                * sequentially follows any of the open contexts
>> +                */
>> +               int context_id;
>> +
>> +               /*
>> +                * Data tag is used only during writing meta data to speed
>> +                * up write and any subsequent read of this meta data
>> +                */
>> +               bool do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>> +                       (req->cmd_flags & REQ_META) &&
>> +                       (rq_data_dir(req) == WRITE) &&
>> +                       ((brq->data.blocks * brq->data.blksz) >=
>> +                       card->ext_csd.data_tag_unit_size);
>> +
>> +               /*
>> +                * During fsync, ensure that data is committed to storage
>> +                */
>> +               if (req->cmd_flags & (REQ_FLUSH | REQ_SYNC))
>> +                       mmc_force_close_all_write_context(mq, card);
>> +
>> +               /*
>> +                * Context ID is used for non-large unit and non-reliable
>> +                * write transfers provided the start block number
>> +                * sequentially follows any of the open contexts
>> +                */
>> +               context_id = mmc_get_context_id(mq,
>> +                       card,
>> +                       blk_rq_pos(req),
>> +                       brq->data.blocks,
>> +                       (rq_data_dir(req) == WRITE) ? MMC_CONTEXT_WRITE :
>> +                               MMC_CONTEXT_READ,
>> +                       do_rel_wr);
>> +
>> +           if (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
>> +                       do_data_tag || (context_id > 0)) {
>> +                       brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
>> +                       brq->sbc.arg = brq->data.blocks |
>> +                               (do_rel_wr ? (1 << 31) : 0) |
>> +                               (do_data_tag ? (1 << 29) : 0) |
>> +                               (((context_id > 0) && (!do_rel_wr)) ?
>> +                                       ((context_id & 0x0f) << 25) : 0);
>> +                       brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> +                       brq->mrq.sbc = &brq->sbc;
>> +               }

Can Data-tag & context-Id use together?

Best Regards,
Jaehoon Chung
