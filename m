From: Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH 1/5] mmc: core: Add support to read command queue parameters
Date: Fri, 16 Jan 2015 09:02:36 +0530
Message-ID: <54B88654.4090101@codeaurora.org>
References: <20141202115629.GA27638@asutoshd-ics.in.qualcomm.com> <CAPDyKFqHzH4ocRXmvqr9z3KZOdegNak+Vqav0n-dwob4m3Dt1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqHzH4ocRXmvqr9z3KZOdegNak+Vqav0n-dwob4m3Dt1w@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1/15/2015 2:40 PM, Ulf Hansson wrote:
> On 2 December 2014 at 12:56, Sujit Reddy Thumma <sthumma@codeaurora.org> wrote:
>> eMMC cards with EXT_CSD version >= 7, optionally support command
>> queuing feature as defined by Jedec eMMC5.1. Add support for probing
>> command queue feature for such type of cards.
>>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   drivers/mmc/core/mmc.c   | 15 +++++++++++++++
>>   include/linux/mmc/card.h |  7 +++++++
>>   include/linux/mmc/mmc.h  |  6 ++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 1ab5f3a..0ef3af5 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -571,6 +571,21 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>                  card->ext_csd.data_sector_size = 512;
>>          }
>>
>> +       if (card->ext_csd.rev >= 7) {
>> +               card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
>> +               if (card->ext_csd.cmdq_support)
>> +                       card->ext_csd.cmdq_depth = ext_csd[EXT_CSD_CMDQ_DEPTH];
>> +       }
>> +
>> +       if (card->ext_csd.rev >= 7) {
>> +               card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
>> +               if (card->ext_csd.cmdq_support)
>> +                       card->ext_csd.cmdq_depth = ext_csd[EXT_CSD_CMDQ_DEPTH];
>> +       } else {
>> +               card->ext_csd.cmdq_support = 0;
>> +               card->ext_csd.cmdq_depth = 0;
>> +       }
>> +
>>   out:
>>          return err;
>>   }
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index b730272..b87a27c 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -112,6 +112,9 @@ struct mmc_ext_csd {
>>          u8                      raw_pwr_cl_ddr_52_360;  /* 239 */
>>          u8                      raw_bkops_status;       /* 246 */
>>          u8                      raw_sectors[4];         /* 212 - 4 bytes */
>> +       u8                      cmdq_mode_en;           /* 15 */
>
> Besides the comments from Konstantin, I also wonder about the above
> variable. I don't see it used anywhere in this patch.

Thanks. I'll re-check and remove it.
>
> Kind regards
> Uffe
>
>> +       u8                      cmdq_depth;             /* 307 */
>> +       u8                      cmdq_support;           /* 308 */
>>
>>          unsigned int            feature_support;
>>   #define MMC_DISCARD_FEATURE    BIT(0)                  /* CMD38 feature */
>> @@ -259,6 +262,7 @@ struct mmc_card {
>>   #define MMC_STATE_HIGHSPEED_200        (1<<8)          /* card is in HS200 mode */
>>   #define MMC_STATE_DOING_BKOPS  (1<<10)         /* card is doing BKOPS */
>>   #define MMC_STATE_SUSPENDED    (1<<11)         /* card is suspended */
>> +#define MMC_STATE_CMDQ       (1<<12)         /* card is in cmd queue mode */
>>          unsigned int            quirks;         /* card quirks */
>>   #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 writes outside of the VS CCCR range */
>>   #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func->cur_blksize */
>> @@ -427,6 +431,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>   #define mmc_card_removed(c)    ((c) && ((c)->state & MMC_CARD_REMOVED))
>>   #define mmc_card_doing_bkops(c)        ((c)->state & MMC_STATE_DOING_BKOPS)
>>   #define mmc_card_suspended(c)  ((c)->state & MMC_STATE_SUSPENDED)
>> +#define mmc_card_cmdq(c)   ((c)->state & MMC_STATE_CMDQ)
>>
>>   #define mmc_card_set_present(c)        ((c)->state |= MMC_STATE_PRESENT)
>>   #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>> @@ -441,6 +446,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>   #define mmc_card_clr_doing_bkops(c)    ((c)->state &= ~MMC_STATE_DOING_BKOPS)
>>   #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
>>   #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
>> +#define mmc_card_set_cmdq(c)       ((c)->state |= MMC_STATE_CMDQ)
>> +#define mmc_card_clr_cmdq(c)       ((c)->state &= ~MMC_STATE_CMDQ)
>>
>>   /*
>>    * Quirk add/remove for MMC products.
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 50bcde3..a893c84 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -84,6 +84,9 @@
>>   #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
>>   #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1  */
>>
>> +/* MMC 5.1 - class 11: Command Queueing */
>> +#define MMC_CMDQ_TASK_MGMT        48  /* ac   [31:0] task ID     R1b */
>> +
>>   static inline bool mmc_op_multi(u32 opcode)
>>   {
>>          return opcode == MMC_WRITE_MULTIPLE_BLOCK ||
>> @@ -272,6 +275,7 @@ struct _mmc_csd {
>>    * EXT_CSD fields
>>    */
>>
>> +#define EXT_CSD_CMDQ_MODE              15      /* R/W */
>>   #define EXT_CSD_FLUSH_CACHE            32      /* W */
>>   #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>>   #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
>> @@ -325,6 +329,8 @@ struct _mmc_csd {
>>   #define EXT_CSD_POWER_OFF_LONG_TIME    247     /* RO */
>>   #define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
>>   #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
>> +#define EXT_CSD_CMDQ_DEPTH             307     /* RO */
>> +#define EXT_CSD_CMDQ_SUPPORT           308     /* RO */
>>   #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
>>   #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
>>   #define EXT_CSD_MAX_PACKED_WRITES      500     /* RO */
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
