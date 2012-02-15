From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Wed, 15 Feb 2012 11:50:17 +0900
Message-ID: <4F3B1D69.8060308@samsung.com>
References: <4F190E26.4040909@samsung.com>
 <CAKLKtzcoOXJoZX7E87u-yfbYMCz26y3KWmqn-dA-UkJ=HiYW7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53125 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab2BOCuU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 21:50:20 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZE00E01YJE4TL0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Feb 2012 11:50:18 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZE00BI8YJTKQV0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Feb 2012 11:50:18 +0900 (KST)
In-reply-to: <CAKLKtzcoOXJoZX7E87u-yfbYMCz26y3KWmqn-dA-UkJ=HiYW7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On 02/14/2012 08:41 PM, Saugata Das wrote:

> On 20 January 2012 12:18, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
>> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
>> the BKOPS-STATUS vaule.
>>
>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>> And if you want to set the BKOPS_EN bit in ext_csd register,
>> use the MMC_CAP2_INIT_BKOPS.
>>
>> Future considerations
>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>  * Interrupt ongoing BKOPS before powering off the card.
>>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
> 
> Do you have some statistics on the total size of the write operations
> which triggers the "urgent BKOPS" situation on a given eMMC and how
> much time does it take to complete the BKOPS ?

Actually i didn't have the statistics about size..
And i didn't know when trigger the "urgetn BKOPS". 
I think that differs according to card status.

> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> Changelog V7:
>>        - Use HPI command when issued URGENT_BKOPS
>>        - Recheck until clearing the bkops-status bit.
>> Changelog V6:
>>        - Add the flag of check-bkops-status.
>>          (For fixing async_req problem)
>>        - Add the capability for MMC_CAP2_INIT_BKOPS.
>>          (When unset the bkops_en bit in ext_csd register)
>>        - modify the wrong condition.
>> Changelog V5:
>>        - Rebase based on the latest mmc-next.
>>        - modify codes based-on Chris's comment
>> Changelog V4:
>>        - Add mmc_read_bkops_status
>>        - When URGENT_BKOPS(level2-3), didn't use HPI command.
>>        - In mmc_switch(), use R1B/R1 according to level.
>> Changelog V3:
>>        - move the bkops setting's location in mmc_blk_issue_rw_rq
>>        - modify condition checking
>>        - bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
>>        - remove the unused code
>>        - change pr_debug instead of pr_warn in mmc_send_hpi_cmd
>>        - Add the Future consideration suggested by Per
>> Changelog V2:
>>        - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>        - Add function to check Exception_status(for eMMC4.5)
>>
>>  drivers/mmc/card/block.c   |    7 +++
>>  drivers/mmc/card/queue.c   |    5 ++
>>  drivers/mmc/core/core.c    |  120 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/mmc.c     |   18 +++++++
>>  drivers/mmc/core/mmc_ops.c |   11 ++++-
>>  include/linux/mmc/card.h   |   20 +++++++
>>  include/linux/mmc/core.h   |    4 ++
>>  include/linux/mmc/host.h   |    2 +
>>  include/linux/mmc/mmc.h    |   19 +++++++
>>  9 files changed, 205 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 176b78e..7e8a154 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1284,6 +1284,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>                type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>>                mmc_queue_bounce_post(mq_rq);
>>
>> +               /*
>> +                * Check BKOPS urgency from each R1 response
>> +                */
>> +               if (mmc_card_mmc(card) &&
>> +                       (brq->cmd.resp[0] & R1_EXCEPTION_EVENT))
>> +                       mmc_card_set_check_bkops(card);
>> +
>>                switch (status) {
>>                case MMC_BLK_SUCCESS:
>>                case MMC_BLK_PARTIAL:
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index 2517547..839735c 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -66,6 +66,9 @@ static int mmc_queue_thread(void *d)
>>                spin_unlock_irq(q->queue_lock);
>>
>>                if (req || mq->mqrq_prev->req) {
>> +                       if (mmc_card_doing_bkops(mq->card))
>> +                               mmc_interrupt_bkops(mq->card);
>> +
> 
> If the "req" is a Write request, then probably it is not a good idea
> to interrupt the background operation since due to the "urgent"
> garbage level the Write will be anyway slower.

Well.. i didn't think that..If trigger "Urgent"(level-3), it's rare case.
And that should be run immediately, if trigger "Urgent"(level-3).
Adrian also mentioned this point..He want to run the BKOPS when critical level.
But this patch should be use the HPI when required the next-request.

In spec, URGENT is "performance being impacted" and "critical".
If didn't run the bkops when trigger the URGENT, 
i think that's more affectable than running the bkops.

And I think the bkops times should not be too long.
Did you test this patch?

Best Regards,
Jaehoon Chung

> 
> 
>>                        set_current_state(TASK_RUNNING);
>>                        mq->issue_fn(mq, req);
>>                } else {
>> @@ -73,6 +76,8 @@ static int mmc_queue_thread(void *d)
>>                                set_current_state(TASK_RUNNING);
>>                                break;
>>                        }
>> +
>> +                       mmc_start_bkops(mq->card);
>>                        up(&mq->thread_sem);
>>                        schedule();
>>                        down(&mq->thread_sem);
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index bec0bf2..8530b38 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -238,6 +238,62 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>        host->ops->request(host, mrq);
>>  }
>>
>> +/**
>> + *     mmc_start_bkops - start BKOPS for supported cards
>> + *     @card: MMC card to start BKOPS
>> + *
>> + *     Start background operations whenever requested.
>> + *     when the urgent BKOPS bit is set in a R1 command response
>> + *     then background operations should be started immediately.
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> +       int err;
>> +       unsigned long flags;
>> +
>> +       BUG_ON(!card);
>> +       if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
>> +               return;
>> +
>> +       if (mmc_card_check_bkops(card)) {
>> +               spin_lock_irqsave(&card->host->lock, flags);
>> +               mmc_card_clr_check_bkops(card);
>> +               spin_unlock_irqrestore(&card->host->lock, flags);
>> +               if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
>> +                       if (card->ext_csd.raw_bkops_status)
>> +                               mmc_card_set_need_bkops(card);
>> +       }
>> +
>> +       /*
>> +        * If card is already doing bkops or need for
>> +        * bkops flag is not set, then do nothing just
>> +        * return
>> +        */
>> +       if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
>> +               return;
>> +
>> +       mmc_claim_host(card->host);
>> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                       EXT_CSD_BKOPS_START, 1, 0);
>> +       if (err) {
>> +               pr_warning("%s: error %d starting bkops\n",
>> +                          mmc_hostname(card->host), err);
>> +               mmc_card_clr_need_bkops(card);
>> +               goto out;
>> +       }
>> +
>> +       spin_lock_irqsave(&card->host->lock, flags);
>> +       mmc_card_clr_need_bkops(card);
>> +       mmc_card_set_doing_bkops(card);
>> +       if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2)
>> +               mmc_card_set_check_bkops(card);
>> +
>> +       spin_unlock_irqrestore(&card->host->lock, flags);
>> +out:
>> +       mmc_release_host(card->host);
>> +}
>> +EXPORT_SYMBOL(mmc_start_bkops);
>> +
>>  static void mmc_wait_done(struct mmc_request *mrq)
>>  {
>>        complete(&mrq->completion);
>> @@ -472,6 +528,69 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
>>  EXPORT_SYMBOL(mmc_wait_for_cmd);
>>
>>  /**
>> + *     mmc_interrupt_bkops - interrupt ongoing BKOPS
>> + *     @card: MMC card to check BKOPS
>> + *
>> + *     Send HPI command to interrupt ongoing background operations,
>> + *     to allow rapid servicing of foreground operations,e.g. read/
>> + *     writes. Wait until the card comes out of the programming state
>> + *     to avoid errors in servicing read/write requests.
>> + */
>> +int mmc_interrupt_bkops(struct mmc_card *card)
>> +{
>> +       int err = 0;
>> +       unsigned long flags;
>> +
>> +       BUG_ON(!card);
>> +
>> +       err = mmc_interrupt_hpi(card);
>> +
>> +       spin_lock_irqsave(&card->host->lock, flags);
>> +       mmc_card_clr_doing_bkops(card);
>> +       spin_unlock_irqrestore(&card->host->lock, flags);
>> +
>> +       return err;
>> +}
>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>> +
>> +int mmc_read_bkops_status(struct mmc_card *card)
>> +{
>> +       int err;
>> +       u8 ext_csd[512];
>> +
>> +       mmc_claim_host(card->host);
>> +       err = mmc_send_ext_csd(card, ext_csd);
>> +       mmc_release_host(card->host);
>> +       if (err)
>> +               return err;
>> +
>> +       card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
>> +       card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXCEPTION_STATUS];
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_read_bkops_status);
>> +
>> +int mmc_is_exception_event(struct mmc_card *card, unsigned int value)
>> +{
>> +       int err;
>> +
>> +       err = mmc_read_bkops_status(card);
>> +       if (err) {
>> +               pr_err("%s: Didn't read bkops status : %d\n",
>> +                      mmc_hostname(card->host), err);
>> +               return 0;
>> +       }
>> +
>> +       /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
>> +       if (card->ext_csd.rev == 5)
>> +               return 1;
>> +
>> +       return (card->ext_csd.raw_exception_status & value) ? 1 : 0;
>> +}
>> +EXPORT_SYMBOL(mmc_is_exception_event);
>> +
>> +/**
>>  *     mmc_set_data_timeout - set the timeout for a data command
>>  *     @data: data phase for command
>>  *     @card: the MMC card associated with the data transfer
>> @@ -1121,6 +1240,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>>                 * might not allow this operation
>>                 */
>>                voltage = regulator_get_voltage(supply);
>> +
>>                if (voltage < 0)
>>                        result = voltage;
>>                else if (voltage < min_uV || voltage > max_uV)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index dc03291..7ca2315 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -480,6 +480,24 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>        }
>>
>>        if (card->ext_csd.rev >= 5) {
>> +               /* check whether the eMMC card support BKOPS */
>> +               if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>> +                       card->ext_csd.bkops = 1;
>> +                       card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
>> +                       card->ext_csd.raw_bkops_status =
>> +                               ext_csd[EXT_CSD_BKOPS_STATUS];
>> +                       if (!card->ext_csd.bkops_en &&
>> +                               card->host->caps2 & MMC_CAP2_INIT_BKOPS) {
>> +                               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                                       EXT_CSD_BKOPS_EN, 1, 0);
>> +                               if (err)
>> +                                       pr_warning("%s: Enabling BKOPS failed\n",
>> +                                               mmc_hostname(card->host));
>> +                               else
>> +                                       card->ext_csd.bkops_en = 1;
>> +                       }
>> +               }
>> +
>>                /* check whether the eMMC card supports HPI */
>>                if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
>>                        card->ext_csd.hpi = 1;
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 4d41fa9..109d0f0 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -392,13 +392,22 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>>                  (index << 16) |
>>                  (value << 8) |
>>                  set;
>> -       cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +       cmd.flags = MMC_CMD_AC;
>> +       if (index == EXT_CSD_BKOPS_START &&
>> +           card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
>> +               cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>> +       else
>> +               cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>>        cmd.cmd_timeout_ms = timeout_ms;
>>
>>        err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>>        if (err)
>>                return err;
>>
>> +       /* No need to check card status in case of BKOPS switch*/
>> +       if (index == EXT_CSD_BKOPS_START)
>> +               return 0;
>> +
>>        /* Must check status to be sure of no errors */
>>        do {
>>                err = mmc_send_status(card, &status);
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index f9a0663..d87f58c 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -71,10 +71,13 @@ struct mmc_ext_csd {
>>        bool                    hpi_en;                 /* HPI enablebit */
>>        bool                    hpi;                    /* HPI support bit */
>>        unsigned int            hpi_cmd;                /* cmd used as HPI */
>> +       bool                    bkops;          /* background support bit */
>> +       bool                    bkops_en;       /* background enable bit */
>>        unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>>        unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>>        unsigned int            boot_ro_lock;           /* ro lock support */
>>        bool                    boot_ro_lockable;
>> +       u8                      raw_exception_status;   /* 53 */
>>        u8                      raw_partition_support;  /* 160 */
>>        u8                      raw_erased_mem_count;   /* 181 */
>>        u8                      raw_ext_csd_structure;  /* 194 */
>> @@ -88,6 +91,7 @@ struct mmc_ext_csd {
>>        u8                      raw_sec_erase_mult;     /* 230 */
>>        u8                      raw_sec_feature_support;/* 231 */
>>        u8                      raw_trim_mult;          /* 232 */
>> +       u8                      raw_bkops_status;       /* 246 */
>>        u8                      raw_sectors[4];         /* 212 - 4 bytes */
>>
>>        unsigned int            feature_support;
>> @@ -219,6 +223,10 @@ struct mmc_card {
>>  #define MMC_CARD_SDXC          (1<<6)          /* card is SDXC */
>>  #define MMC_CARD_REMOVED       (1<<7)          /* card has been removed */
>>  #define MMC_STATE_HIGHSPEED_200        (1<<8)          /* card is in HS200 mode */
>> +#define MMC_STATE_NEED_BKOPS   (1<<9)          /* card need to do BKOPS */
>> +#define MMC_STATE_DOING_BKOPS  (1<<10)         /* card is doing BKOPS */
>> +#define MMC_STATE_CHECK_BKOPS  (1<<11)         /* card need to check BKOPS */
>> +
>>        unsigned int            quirks;         /* card quirks */
>>  #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 writes outside of the VS CCCR range */
>>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func->cur_blksize */
>> @@ -384,6 +392,10 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>  #define mmc_sd_card_uhs(c)     ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
>>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>>  #define mmc_card_removed(c)    ((c) && ((c)->state & MMC_CARD_REMOVED))
>> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_doing_bkops(c)        ((c)->state & MMC_STATE_DOING_BKOPS)
>> +#define mmc_card_check_bkops(c) ((c)->state & MMC_STATE_CHECK_BKOPS)
>> +
>>
>>  #define mmc_card_set_present(c)        ((c)->state |= MMC_STATE_PRESENT)
>>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>> @@ -395,6 +407,14 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>  #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>> +#define mmc_card_set_need_bkops(c)     ((c)->state |= MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_set_doing_bkops(c)    ((c)->state |= MMC_STATE_DOING_BKOPS)
>> +#define mmc_card_set_check_bkops(c) ((c)->state |= MMC_STATE_CHECK_BKOPS)
>> +
>> +#define mmc_card_clr_need_bkops(c)     ((c)->state &= ~MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_clr_doing_bkops(c)    ((c)->state &= ~MMC_STATE_DOING_BKOPS)
>> +#define mmc_card_clr_check_bkops(c) ((c)->state &= ~MMC_STATE_CHECK_BKOPS)
>> +
>>
>>  /*
>>  * Quirk add/remove for MMC products.
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 87a976c..45357c7 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -134,6 +134,9 @@ struct mmc_host;
>>  struct mmc_card;
>>  struct mmc_async_req;
>>
>> +extern int mmc_interrupt_bkops(struct mmc_card *);
>> +extern int mmc_read_bkops_status(struct mmc_card *);
>> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int);
>>  extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>>                                           struct mmc_async_req *, int *);
>>  extern int mmc_interrupt_hpi(struct mmc_card *);
>> @@ -163,6 +166,7 @@ extern int mmc_can_sanitize(struct mmc_card *card);
>>  extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>>  extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
>>                                   unsigned int nr);
>> +extern void mmc_start_bkops(struct mmc_card *card);
>>  extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>>
>>  extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index dd13e05..d9eeb42 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -257,6 +257,8 @@ struct mmc_host {
>>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
>>  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
>>                                 MMC_CAP2_HS200_1_2V_SDR)
>> +#define MMC_CAP2_BKOPS         (1 << 7)        /* BKOPS supported */
>> +#define MMC_CAP2_INIT_BKOPS    (1 << 8)        /* Need to set BKOPS_EN */
>>
>>        mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>        unsigned int        power_notify_type;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index b822a2c..9760c70 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
>>  #define R1_CURRENT_STATE(x)    ((x & 0x00001E00) >> 9) /* sx, b (4 bits) */
>>  #define R1_READY_FOR_DATA      (1 << 8)        /* sx, a */
>>  #define R1_SWITCH_ERROR                (1 << 7)        /* sx, c */
>> +#define R1_EXCEPTION_EVENT     (1 << 6)        /* sx, a */
>>  #define R1_APP_CMD             (1 << 5)        /* sr, c */
>>
>>  #define R1_STATE_IDLE  0
>> @@ -274,12 +275,15 @@ struct _mmc_csd {
>>  #define EXT_CSD_FLUSH_CACHE            32      /* W */
>>  #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>>  #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
>> +#define EXT_CSD_EXCEPTION_STATUS       54      /* RO */
>>  #define EXT_CSD_DATA_SECTOR_SIZE       61      /* R */
>>  #define EXT_CSD_GP_SIZE_MULT           143     /* R/W */
>>  #define EXT_CSD_PARTITION_ATTRIBUTE    156     /* R/W */
>>  #define EXT_CSD_PARTITION_SUPPORT      160     /* RO */
>>  #define EXT_CSD_HPI_MGMT               161     /* R/W */
>>  #define EXT_CSD_RST_N_FUNCTION         162     /* R/W */
>> +#define EXT_CSD_BKOPS_EN               163     /* R/W */
>> +#define EXT_CSD_BKOPS_START            164     /* W */
>>  #define EXT_CSD_SANITIZE_START         165     /* W */
>>  #define EXT_CSD_WR_REL_PARAM           166     /* RO */
>>  #define EXT_CSD_BOOT_WP                        173     /* R/W */
>> @@ -313,11 +317,13 @@ struct _mmc_csd {
>>  #define EXT_CSD_PWR_CL_200_360         237     /* RO */
>>  #define EXT_CSD_PWR_CL_DDR_52_195      238     /* RO */
>>  #define EXT_CSD_PWR_CL_DDR_52_360      239     /* RO */
>> +#define EXT_CSD_BKOPS_STATUS           246     /* RO */
>>  #define EXT_CSD_POWER_OFF_LONG_TIME    247     /* RO */
>>  #define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
>>  #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
>>  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
>>  #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
>> +#define EXT_CSD_BKOPS_SUPPORT          502     /* RO */
>>  #define EXT_CSD_HPI_FEATURES           503     /* RO */
>>
>>  /*
>> @@ -446,4 +452,17 @@ struct _mmc_csd {
>>  #define MMC_SWITCH_MODE_CLEAR_BITS     0x02    /* Clear bits which are 1 in value */
>>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value */
>>
>> +/*
>> + * BKOPS status level
>> + */
>> +#define EXT_CSD_BKOPS_LEVEL_2          0x2
>> +
>> +/*
>> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
>> + */
>> +#define EXT_CSD_URGENT_BKOPS           BIT(0)
>> +#define EXT_CSD_DYNCAP_NEEDED          BIT(1)
>> +#define EXT_CSD_SYSPOOL_EXHAUSTED      BIT(2)
>> +#define EXT_CSD_PACKED_FAILURE         BIT(3)
>> +
>>  #endif /* LINUX_MMC_MMC_H */
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


