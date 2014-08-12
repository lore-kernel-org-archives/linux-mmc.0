From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] [RFC] Implement eMMC RPMB feature in kernel space
Date: Tue, 12 Aug 2014 15:28:01 +0200
Message-ID: <CAPDyKFp7bioR7esJD5h9CYaQzqPxuxLwo5V13Wx556F5T=QY9g@mail.gmail.com>
References: <1407136559-22334-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:51791 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaHLN2D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 09:28:03 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so2812175qcx.10
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 06:28:01 -0700 (PDT)
In-Reply-To: <1407136559-22334-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 4 August 2014 09:15, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> In current kernel mmc driver stack, seems it
> expects all the RPMB operations handled by
> user space library or applications.
> In kernel space, the mmc driver only treat
> the RPMB ioctl as common eMMC CMD read/write.
>
> This is OK. But in some use cases, maybe it is
> still needed to implement most of the RPMB
> operations inside kernel space.
> For example, if security driver need to access
> RPMB partition and requires the eMMC driver
> providing an interface API to do so.

Isn't your security driver capable of interacting with user space?
I think that would be the proper solution.

Kind regards
Ulf Hansson

>
> This RFC patch implements eMMC RPMB partition data
> read/write and write counter reading.
> But not include Key programming since Key it is
> one time operation and should not be done by mmc driver.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/card/block.c       |  156 +++++++++++++++-
>  drivers/mmc/card/queue.c       |    2 +-
>  drivers/mmc/card/queue.h       |    1 +
>  drivers/mmc/core/mmc.c         |   17 ++
>  drivers/mmc/core/mmc_ops.c     |  396 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h       |    5 +
>  include/linux/mmc/core.h       |   34 ++++
>  include/uapi/linux/mmc/ioctl.h |   13 ++
>  8 files changed, 619 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..e185c9d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -99,6 +99,7 @@ struct mmc_blk_data {
>  #define MMC_BLK_CMD23  (1 << 0)        /* Can do SET_BLOCK_COUNT for multiblock */
>  #define MMC_BLK_REL_WR (1 << 1)        /* MMC Reliable write support */
>  #define MMC_BLK_PACKED_CMD     (1 << 2)        /* MMC packed command support */
> +#define MMC_BLK_SUSPENDED      (1 << 3)        /* MMC block device suspended */
>
>         unsigned int    usage;
>         unsigned int    read_only;
> @@ -109,6 +110,8 @@ struct mmc_blk_data {
>  #define MMC_BLK_WRITE          BIT(1)
>  #define MMC_BLK_DISCARD                BIT(2)
>  #define MMC_BLK_SECDISCARD     BIT(3)
> +#define MMC_BLK_RPMB           BIT(4)
> +#define MMC_BLK_USER           BIT(5)
>
>         /*
>          * Only set in main mmc_blk_data associated
> @@ -149,6 +152,9 @@ static inline void mmc_blk_clear_packed(struct mmc_queue_req *mqrq)
>         packed->blocks = 0;
>  }
>
> +static int mmc_rpmb_req_process(struct mmc_blk_data *,
> +               struct mmc_ioc_rpmb_req *);
> +
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
>         struct mmc_blk_data *md;
> @@ -1025,6 +1031,118 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>         md->reset_done &= ~type;
>  }
>
> +static int mmc_rpmb_req_process(struct mmc_blk_data *md,
> +               struct mmc_ioc_rpmb_req *req)
> +{
> +       struct mmc_core_rpmb_req rpmb_req;
> +       struct mmc_card *card = NULL;
> +       int ret;
> +
> +       if (!md || !req)
> +               return -EINVAL;
> +
> +       if (!(md->flags & MMC_BLK_CMD23) ||
> +                       (md->part_type != EXT_CSD_PART_CONFIG_ACC_RPMB))
> +               return -EOPNOTSUPP;
> +
> +       card = md->queue.card;
> +       if (!card || !mmc_card_mmc(card) || !card->ext_csd.rpmb_size)
> +               return -ENODEV;
> +
> +       memset(&rpmb_req, 0, sizeof(struct mmc_core_rpmb_req));
> +       rpmb_req.req = req;
> +       /* check request */
> +       ret = mmc_rpmb_pre_frame(&rpmb_req, card);
> +       if (ret) {
> +               pr_err("%s: prepare frame failed\n", mmc_hostname(card->host));
> +               return ret;
> +       }
> +
> +       mmc_claim_host(card->host);
> +
> +       if (md->flags & MMC_BLK_SUSPENDED) {
> +               pr_warn("%s: MMC block device is already suspended\n",
> +                               mmc_hostname(card->host));
> +               ret = -EPERM;
> +               goto out;
> +       }
> +
> +       /* wait for background operation finished */
> +       mmc_stop_bkops(card);
> +
> +       /*
> +        * before start, let's change to RPMB partition first
> +        */
> +       ret = mmc_blk_part_switch(card, md);
> +       if (ret) {
> +               pr_err("%s: Invalid RPMB partition switch (%d)!\n",
> +                               mmc_hostname(card->host), ret);
> +               /*
> +                * In case partition is not in user data area, make
> +                * a force partition switch.
> +                * we need reset eMMC card at here
> +                */
> +               ret = mmc_blk_reset(md, card->host, MMC_BLK_RPMB);
> +               if (!ret)
> +                       mmc_blk_reset_success(md, MMC_BLK_RPMB);
> +               else
> +                       pr_err("%s: eMMC card reset failed (%d)\n",
> +                                       mmc_hostname(card->host), ret);
> +               goto out;
> +       }
> +
> +       ret = mmc_rpmb_partition_ops(&rpmb_req, card);
> +       if (ret)
> +               pr_err("%s: failed (%d) to handle RPMB request type (%d)!\n",
> +                               mmc_hostname(card->host), ret, req->type);
> +out:
> +       mmc_release_host(card->host);
> +       mmc_rpmb_post_frame(&rpmb_req);
> +       return ret;
> +}
> +
> +int mmc_access_rpmb(struct mmc_queue *mq)
> +{
> +       struct mmc_blk_data *md = mq->data;
> +       /*
> +        * If this is a RPMB partition access, return ture
> +        */
> +       if (md && md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(mmc_access_rpmb);
> +
> +int mmc_rpmb_req_handle(struct device *emmc, struct mmc_ioc_rpmb_req *req)
> +{
> +       int ret = 0;
> +       struct gendisk *disk    = NULL;
> +       struct mmc_blk_data *md = NULL;
> +
> +       if (!emmc || !req)
> +               return -EINVAL;
> +
> +       disk = dev_to_disk(emmc);
> +       if (!disk) {
> +               pr_err("%s: NO eMMC disk found. Try it later\n",
> +                               __func__);
> +               return -ENODEV;
> +       }
> +
> +       md = mmc_blk_get(disk);
> +       if (!md) {
> +               pr_err("%s: NO eMMC block data. Try it later\n",
> +                               __func__);
> +               return -ENODEV;
> +       }
> +       ret = mmc_rpmb_req_process(md, req);
> +       mmc_blk_put(md);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(mmc_rpmb_req_handle);
> +
>  static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->data;
> @@ -2016,11 +2134,16 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>
>         ret = mmc_blk_part_switch(card, md);
>         if (ret) {
> -               if (req) {
> -                       blk_end_request_all(req, -EIO);
> +               pr_err("%s: switch part failed. Try to reset eMMC\n",
> +                               mmc_hostname(card->host));
> +               if (mmc_blk_reset(md, card->host, MMC_BLK_USER)) {
> +                       if (req)
> +                               blk_end_request_all(req, -EIO);
> +                       ret = 0;
> +                       goto out;
>                 }
> -               ret = 0;
> -               goto out;
> +               pr_info("%s: Reset eMMC success\n", mmc_hostname(card->host));
> +               mmc_blk_reset_success(md, MMC_BLK_USER);
>         }
>
>         mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> @@ -2501,6 +2624,19 @@ static int _mmc_blk_suspend(struct mmc_card *card)
>                 mmc_queue_suspend(&md->queue);
>                 list_for_each_entry(part_md, &md->part, part) {
>                         mmc_queue_suspend(&part_md->queue);
> +                       if (part_md->part_type ==
> +                               EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +                               /*
> +                                * RPMB partition is accessed by API directly.
> +                                * Driver need to set a flag when suspending
> +                                * MMC block device to notify API that the
> +                                * accessing of RPMB partition needs to be
> +                                * stopped
> +                                */
> +                               mmc_claim_host(card->host);
> +                               part_md->flags |= MMC_BLK_SUSPENDED;
> +                               mmc_release_host(card->host);
> +                       }
>                 }
>         }
>         return 0;
> @@ -2531,6 +2667,18 @@ static int mmc_blk_resume(struct mmc_card *card)
>                 mmc_queue_resume(&md->queue);
>                 list_for_each_entry(part_md, &md->part, part) {
>                         mmc_queue_resume(&part_md->queue);
> +                       if (part_md->part_type ==
> +                                       EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +                               /*
> +                                * RPMB partition is accessed by API directly.
> +                                * Driver need to clear MMC_BLK_SUSPENDED flag
> +                                * to make sure the next RPMB partition access
> +                                * request won't be blocked
> +                                */
> +                               mmc_claim_host(card->host);
> +                               part_md->flags &= ~MMC_BLK_SUSPENDED;
> +                               mmc_release_host(card->host);
> +                       }
>                 }
>         }
>         return 0;
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 3e049c1..6ceede0 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -38,7 +38,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>                 return BLKPREP_KILL;
>         }
>
> -       if (mq && mmc_card_removed(mq->card))
> +       if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
>                 return BLKPREP_KILL;
>
>         req->cmd_flags |= REQ_DONTPREP;
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 5752d50..3bbd4e6 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -73,4 +73,5 @@ extern void mmc_queue_bounce_post(struct mmc_queue_req *);
>  extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
>  extern void mmc_packed_clean(struct mmc_queue *);
>
> +extern int mmc_access_rpmb(struct mmc_queue *);
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7..59766ec 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -553,6 +553,9 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                  * RPMB regions are defined in multiples of 128K.
>                  */
>                 card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
> +               card->ext_csd.rpmb_size = 128 *
> +                       card->ext_csd.raw_rpmb_size_mult;
> +               card->ext_csd.rpmb_size <<= 2; /* Unit: half sector */
>                 if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
>                         mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
>                                 EXT_CSD_PART_CONFIG_ACC_RPMB,
> @@ -604,6 +607,18 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 card->ext_csd.data_sector_size = 512;
>         }
>
> +       /*
> +        * If use legacy relaible write, then the blk counts must not
> +        * big than the relaible write sectors
> +        */
> +       if (!(card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)) {
> +               if (card->ext_csd.rel_sectors < RPMB_AVALIABLE_SECTORS)
> +                       card->rpmb_max_req = card->ext_csd.rel_sectors;
> +               else
> +                       card->rpmb_max_req = RPMB_AVALIABLE_SECTORS;
> +       } else
> +               card->rpmb_max_req = RPMB_AVALIABLE_SECTORS;
> +
>  out:
>         return err;
>  }
> @@ -710,6 +725,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>  MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
> +MMC_DEV_ATTR(rpmb_size, "%d\n", card->ext_csd.rpmb_size);
>
>  static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_cid.attr,
> @@ -728,6 +744,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_enhanced_area_size.attr,
>         &dev_attr_raw_rpmb_size_mult.attr,
>         &dev_attr_rel_sectors.attr,
> +       &dev_attr_rpmb_size.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f51b5ba..8d9f921 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -655,3 +655,399 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
>
>         return 0;
>  }
> +
> +static int mmc_rpmb_send_command(struct mmc_card *card, u8 *buf, __u16 blks,
> +               __u16 type, u8 req_type)
> +{
> +       struct mmc_request mrq = {NULL};
> +       struct mmc_command cmd = {0};
> +       struct mmc_command sbc = {0};
> +       struct mmc_data data = {0};
> +       struct scatterlist sg;
> +       u8 *transfer_buf = NULL;
> +
> +       mrq.sbc = &sbc;
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +       mrq.stop = NULL;
> +       transfer_buf = kzalloc(512 * blks, GFP_KERNEL);
> +       if (!transfer_buf)
> +               return -ENOMEM;
> +
> +       /*
> +        * set CMD23
> +        */
> +       sbc.opcode = MMC_SET_BLOCK_COUNT;
> +       sbc.arg = blks;
> +       if ((req_type == RPMB_REQ) && type == RPMB_WRITE_DATA)
> +               sbc.arg |= 1 << 31;
> +       sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +
> +       /*
> +        * set CMD25/18
> +        */
> +       sg_init_one(&sg, transfer_buf, 512 * blks);
> +       if (req_type == RPMB_REQ) {
> +               cmd.opcode = MMC_WRITE_MULTIPLE_BLOCK;
> +               sg_copy_from_buffer(&sg, 1, buf, 512 * blks);
> +               data.flags |= MMC_DATA_WRITE;
> +       } else {
> +               cmd.opcode = MMC_READ_MULTIPLE_BLOCK;
> +               data.flags |= MMC_DATA_READ;
> +       }
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +       data.blksz = 512;
> +       data.blocks = blks;
> +       data.sg = &sg;
> +       data.sg_len = 1;
> +
> +       mmc_set_data_timeout(&data, card);
> +
> +       mmc_wait_for_req(card->host, &mrq);
> +
> +       if (req_type != RPMB_REQ)
> +               sg_copy_to_buffer(&sg, 1, buf, 512 * blks);
> +
> +       kfree(transfer_buf);
> +
> +       if (cmd.error)
> +               return cmd.error;
> +       if (data.error)
> +               return data.error;
> +       return 0;
> +}
> +
> +void mmc_rpmb_post_frame(struct mmc_core_rpmb_req *rpmb_req)
> +{
> +       int i;
> +       struct mmc_ioc_rpmb_req *p_req;
> +       __u8 *buf_frame;
> +
> +       if (!rpmb_req || !rpmb_req->ready)
> +               return;
> +
> +       p_req = rpmb_req->req;
> +       buf_frame = rpmb_req->frame;
> +
> +       if (!p_req || !buf_frame)
> +               return;
> +       /*
> +        * Regarding to the check rules, here is the post
> +        * rules
> +        * All will return result.
> +        * GET_WRITE_COUNTER:
> +        *              must: write counter, nonce
> +        *              optional: MAC
> +        * WRITE_DATA:
> +        *              must: MAC, write counter
> +        * READ_DATA:
> +        *              must: nonce, data
> +        *              optional: MAC
> +        * PROGRAM_KEY:
> +        *              must: Nothing
> +        *
> +        * Except READ_DATA, all of these operations only need to parse
> +        * one frame. READ_DATA needs blks frames to get DATA
> +        */
> +
> +       memcpy(p_req->result, buf_frame + RPMB_RES_BEG, 2);
> +       *p_req->result = be16_to_cpup(p_req->result);
> +
> +       if (p_req->type == RPMB_PROGRAM_KEY)
> +               goto out;
> +
> +       if (p_req->type == RPMB_GET_WRITE_COUNTER ||
> +                       p_req->type == RPMB_WRITE_DATA) {
> +               memcpy(p_req->wc, buf_frame + RPMB_WCOUNTER_BEG, 4);
> +               *p_req->wc = be32_to_cpup(p_req->wc);
> +       }
> +
> +       if (p_req->type == RPMB_GET_WRITE_COUNTER ||
> +                       p_req->type == RPMB_READ_DATA) {
> +               /* nonce copy */
> +               memcpy(p_req->nonce, buf_frame + RPMB_NONCE_BEG, 16);
> +       }
> +       /*
> +        * Take MAC within the last package
> +        */
> +       if (p_req->type == RPMB_READ_DATA) {
> +               __u8 *data = p_req->data;
> +               for (i = 0; i < p_req->blk_cnt; i++) {
> +                       memcpy(data, buf_frame + i * 512 + RPMB_DATA_BEG, 256);
> +                       data += 256;
> +               }
> +               /*
> +                * MAC stored in the last package
> +                */
> +               if (p_req->mac) {
> +                       i--;
> +                       memcpy(p_req->mac, buf_frame + i * 512 + RPMB_MAC_BEG,
> +                                       32);
> +               }
> +       } else if (p_req->mac)
> +               memcpy(p_req->mac, buf_frame + RPMB_MAC_BEG, 32);
> +out:
> +       kfree(buf_frame);
> +       rpmb_req->frame = NULL;
> +       return;
> +}
> +EXPORT_SYMBOL_GPL(mmc_rpmb_post_frame);
> +
> +static int mmc_rpmb_request_check(struct mmc_card *card,
> +               struct mmc_ioc_rpmb_req *p_req)
> +{
> +       /*
> +        * Some paramter is a must for the operation. Different
> +        * operation expect different paramters. Below code is
> +        * used for checking this.
> +        *
> +        * All operations will need result.
> +        * GET_WRITE_COUNTER:
> +        *              must: write counter, nonce
> +        *              optional: MAC
> +        * WRITE_DATA:
> +        *              must: MAC, data, write counter
> +        * READ_DATA:
> +        *              must: nonce, data
> +        *              optional: MAC
> +        * PROGRAM_KEY:
> +        *              must: MAC
> +        *
> +        * So here, we only check the 'must' paramters
> +        */
> +       if (!p_req->result) {
> +               pr_err("%s: Type %d has NULL pointer for result\n",
> +                               mmc_hostname(card->host), p_req->type);
> +               return -EINVAL;
> +       }
> +
> +       if (p_req->type == RPMB_GET_WRITE_COUNTER) {
> +               if (!p_req->nonce || !p_req->wc) {
> +                       pr_err("%s: Type %d has NULL pointer for nonce/wc\n",
> +                                       mmc_hostname(card->host), p_req->type);
> +                       return -EINVAL;
> +               }
> +               /*
> +                * used to allocate frame
> +                */
> +               p_req->blk_cnt = 1;
> +       } else if (p_req->type == RPMB_WRITE_DATA ||
> +                       p_req->type == RPMB_READ_DATA) {
> +               if ((__u32)(p_req->addr + p_req->blk_cnt) >
> +                               card->ext_csd.rpmb_size) {
> +                       pr_err("%s Type %d: beyond the RPMB partition rang addr %d, blk_cnt %d, rpmb_size %d\n",
> +                                       mmc_hostname(card->host),
> +                                       p_req->type,
> +                                       p_req->addr,
> +                                       p_req->blk_cnt,
> +                                       card->ext_csd.rpmb_size);
> +                       /*
> +                        * Not return error here since we want device to handle
> +                        * such errors
> +                        */
> +               }
> +               if (p_req->blk_cnt == 0) {
> +                       pr_err("%s: Type %d has zero block count\n",
> +                                       mmc_hostname(card->host),
> +                                       p_req->blk_cnt);
> +                       return -EINVAL;
> +               } else if (p_req->blk_cnt > card->rpmb_max_req) {
> +                       pr_err("%s: Type %d has invalid block count, cannot large than %d\n",
> +                                       mmc_hostname(card->host),
> +                                       p_req->blk_cnt,
> +                                       card->rpmb_max_req);
> +                       return -EINVAL;
> +               }
> +               if (!p_req->data) {
> +                       pr_err("%s: Type %d has NULL pointer for data\n",
> +                                       mmc_hostname(card->host), p_req->type);
> +                       return -EINVAL;
> +               }
> +               if (p_req->type == RPMB_WRITE_DATA) {
> +                       if (!p_req->wc || !p_req->mac) {
> +                               pr_err("%s: Type %d has NULL pointer for write counter/MAC\n",
> +                                               mmc_hostname(card->host),
> +                                               p_req->type);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       if (!p_req->nonce) {
> +                               pr_err("%s: Type %d has NULL pointer for nonce\n",
> +                                               mmc_hostname(card->host),
> +                                               p_req->type);
> +                               return -EINVAL;
> +                       }
> +               }
> +       } else
> +               return -EOPNOTSUPP;
> +
> +       return 0;
> +}
> +
> +/*
> + * prepare the request of RPMB frame
> + * RPMB frame is MSB first
> + * convert needed bytes
> + * return how many frames will be prepared
> + */
> +int mmc_rpmb_pre_frame(struct mmc_core_rpmb_req *rpmb_req,
> +               struct mmc_card *card)
> +{
> +       int i, ret;
> +       struct mmc_ioc_rpmb_req *p_req;
> +       __u8 *buf_frame;
> +       __u16 blk_cnt, addr, type;
> +       __u32 w_counter;
> +
> +       if (!rpmb_req || !card)
> +               return -EINVAL;
> +
> +       p_req = rpmb_req->req;
> +       if (!p_req) {
> +               pr_err("%s: mmc_ioc_rpmb_req is NULL. Wrong parameter\n",
> +                               mmc_hostname(card->host));
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * make sure these two items are clear
> +        */
> +       rpmb_req->ready = 0;
> +       rpmb_req->frame = NULL;
> +
> +       ret = mmc_rpmb_request_check(card, p_req);
> +       if (ret)
> +               return ret;
> +
> +       buf_frame = kzalloc(512 * p_req->blk_cnt, GFP_KERNEL);
> +       if (!buf_frame) {
> +               pr_err("%s: cannot allocate frame for type %d\n",
> +                               mmc_hostname(card->host), p_req->type);
> +               return -ENOMEM;
> +       }
> +
> +       type = cpu_to_be16p(&p_req->type);
> +       if (p_req->type == RPMB_GET_WRITE_COUNTER ||
> +                       p_req->type == RPMB_READ_DATA) {
> +               /*
> +                * One package prepared
> +                * This request needs Nonce and type
> +                * If is data read, then also need addr
> +                */
> +               memcpy(buf_frame + RPMB_TYPE_BEG, &type, 2);
> +               if (p_req->type == RPMB_READ_DATA) {
> +                       addr = cpu_to_be16p(&p_req->addr);
> +                       memcpy(buf_frame + RPMB_ADDR_BEG, &addr, 2);
> +               }
> +               /* convert Nonce code */
> +               memcpy(buf_frame + RPMB_NONCE_BEG, p_req->nonce, 16);
> +       } else if (p_req->type == RPMB_WRITE_DATA) {
> +               __u8 *data = p_req->data;
> +               /*
> +                * multiple package prepared
> +                * This request nees blk_cnt, addr, write_counter,
> +                * data and mac
> +                */
> +               blk_cnt = cpu_to_be16p(&p_req->blk_cnt);
> +               addr = cpu_to_be16p(&p_req->addr);
> +               w_counter = cpu_to_be32p(p_req->wc);
> +               for (i = 0; i < p_req->blk_cnt; i++) {
> +                       memcpy(buf_frame + i * 512 + RPMB_TYPE_BEG,
> +                                       &type, 2);
> +                       memcpy(buf_frame + i * 512 + RPMB_BLKS_BEG,
> +                                       &blk_cnt, 2);
> +                       memcpy(buf_frame + i * 512 + RPMB_ADDR_BEG,
> +                                       &addr, 2);
> +                       memcpy(buf_frame + i * 512 + RPMB_WCOUNTER_BEG,
> +                                       &w_counter, 4);
> +                       memcpy(buf_frame + i * 512 + RPMB_DATA_BEG,
> +                                       data, 256);
> +                       data += 256;
> +               }
> +               /* convert MAC code */
> +               memcpy(buf_frame + 512 * (i - 1) + RPMB_MAC_BEG,
> +                               p_req->mac, 32);
> +       } else {
> +               pr_err("%s: We shouldn't be here\n", mmc_hostname(card->host));
> +               kfree(buf_frame);
> +               return -EINVAL;
> +       }
> +       rpmb_req->ready = 1;
> +       rpmb_req->frame = buf_frame;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_rpmb_pre_frame);
> +
> +int mmc_rpmb_partition_ops(struct mmc_core_rpmb_req *rpmb_req,
> +               struct mmc_card *card)
> +{
> +       int err = 0;
> +       struct mmc_ioc_rpmb_req *p_req;
> +       __u16 type, blks;
> +       __u8 *buf_frame;
> +
> +       if (!rpmb_req || !card)
> +               return -EINVAL;
> +
> +       p_req = rpmb_req->req;
> +       buf_frame = rpmb_req->frame;
> +
> +       if (!p_req || !rpmb_req->ready || !buf_frame) {
> +               pr_err("%s: mmc_ioc_rpmb_req is not prepared\n",
> +                               mmc_hostname(card->host));
> +               return -EINVAL;
> +       }
> +
> +       type = p_req->type;
> +       blks = p_req->blk_cnt;
> +
> +       /*
> +        * STEP 1: send request to RPMB partition
> +        */
> +       if (type == RPMB_WRITE_DATA)
> +               err = mmc_rpmb_send_command(card, buf_frame, blks,
> +                               type, RPMB_REQ);
> +       else
> +               err = mmc_rpmb_send_command(card, buf_frame, 1, type, RPMB_REQ);
> +
> +       if (err) {
> +               pr_err("%s: request write counter failed (%d)\n",
> +                               mmc_hostname(card->host), err);
> +               goto out;
> +       }
> +
> +       memset(buf_frame, 0, 512 * blks);
> +       /*
> +        * STEP 2: check write result
> +        * Only for WRITE_DATA or Program key
> +        */
> +       if (type == RPMB_WRITE_DATA) {
> +               buf_frame[RPMB_TYPE_BEG + 1] = RPMB_RESULT_READ;
> +               err = mmc_rpmb_send_command(card, buf_frame, 1,
> +                               RPMB_RESULT_READ, RPMB_REQ);
> +               if (err) {
> +                       pr_err("%s: request write counter failed (%d)\n",
> +                                       mmc_hostname(card->host), err);
> +                       goto out;
> +               }
> +       }
> +
> +       /*
> +        * STEP 3: get response from RPMB partition
> +        */
> +
> +       if (type == RPMB_READ_DATA)
> +               err = mmc_rpmb_send_command(card, buf_frame,
> +                               blks, type, RPMB_RESP);
> +       else
> +               err = mmc_rpmb_send_command(card, buf_frame,
> +                               1, type, RPMB_RESP);
> +       if (err) {
> +               pr_err("%s: response write counter failed (%d)\n",
> +                               mmc_hostname(card->host), err);
> +       }
> +out:
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mmc_rpmb_partition_ops);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d424b9d..971404a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -83,6 +83,7 @@ struct mmc_ext_csd {
>         unsigned int            hpi_cmd;                /* cmd used as HPI */
>         bool                    bkops;          /* background support bit */
>         bool                    bkops_en;       /* background enable bit */
> +       unsigned int            rpmb_size;              /* Units: half sector */
>         unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>         unsigned int            boot_ro_lock;           /* ro lock support */
> @@ -304,6 +305,7 @@ struct mmc_card {
>         struct dentry           *debugfs_root;
>         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
>         unsigned int    nr_parts;
> +       unsigned int            rpmb_max_req;
>  };
>
>  /*
> @@ -529,4 +531,7 @@ extern void mmc_unregister_driver(struct mmc_driver *);
>  extern void mmc_fixup_device(struct mmc_card *card,
>                              const struct mmc_fixup *table);
>
> +extern int mmc_rpmb_req_handle(struct device *emmc,
> +               struct mmc_ioc_rpmb_req *req);
> +
>  #endif /* LINUX_MMC_CARD_H */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index f206e29..5e07733 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -10,6 +10,8 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/mmc/ioctl.h>
>
>  struct request;
>  struct mmc_data;
> @@ -137,6 +139,34 @@ struct mmc_request {
>         struct mmc_host         *host;
>  };
>
> +/*
> + * RPMB frame structure for MMC core stack
> + */
> +struct mmc_core_rpmb_req {
> +       struct mmc_ioc_rpmb_req *req;
> +       __u8 *frame;
> +       bool ready;
> +};
> +
> +#define RPMB_PROGRAM_KEY       1       /* Program RPMB Authentication Key */
> +#define RPMB_GET_WRITE_COUNTER 2       /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA                3       /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         4       /* Read data from RPMB partition */
> +#define RPMB_RESULT_READ       5       /* Read result request */
> +#define RPMB_REQ               1       /* RPMB request mark */
> +#define RPMB_RESP              (1 << 1)/* RPMB response mark */
> +#define RPMB_AVALIABLE_SECTORS 8       /* 4K page size */
> +
> +#define RPMB_TYPE_BEG          510
> +#define RPMB_RES_BEG           508
> +#define RPMB_BLKS_BEG          506
> +#define RPMB_ADDR_BEG          504
> +#define RPMB_WCOUNTER_BEG      500
> +
> +#define RPMB_NONCE_BEG         484
> +#define RPMB_DATA_BEG          228
> +#define RPMB_MAC_BEG           196
> +
>  struct mmc_card;
>  struct mmc_async_req;
>
> @@ -155,6 +185,10 @@ extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
>                         bool, bool);
>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>  extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
> +extern int mmc_rpmb_partition_ops(struct mmc_core_rpmb_req *,
> +               struct mmc_card *);
> +extern int mmc_rpmb_pre_frame(struct mmc_core_rpmb_req *, struct mmc_card *);
> +extern void mmc_rpmb_post_frame(struct mmc_core_rpmb_req *);
>
>  #define MMC_ERASE_ARG          0x00000000
>  #define MMC_SECURE_ERASE_ARG   0x80000000
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 1f5e689..98ad956 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -47,6 +47,19 @@ struct mmc_ioc_cmd {
>
>  #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
>
> +struct mmc_ioc_rpmb_req {
> +       __u16 type;                     /* RPMB request type */
> +       __u16 *result;                  /* response or request result */
> +       __u16 blk_cnt;                  /* Number of blocks(half sector 256B) */
> +       __u16 addr;                     /* data address */
> +       __u32 *wc;                      /* write counter */
> +       __u8 *nonce;                    /* Ramdom number */
> +       __u8 *data;                     /* Buffer of the user data */
> +       __u8 *mac;                      /* Message Authentication Code */
> +};
> +
> +#define MMC_IOC_RPMB_REQ _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_rpmb_req)
> +
>  /*
>   * Since this ioctl is only meant to enhance (and not replace) normal access
>   * to the mmc bus device, an upper data transfer limit of MMC_IOC_MAX_BYTES
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
