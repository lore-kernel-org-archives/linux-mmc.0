From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 02/11] mmc: core: Add members to mmc_request and
 mmc_data for CQE's
Date: Tue, 8 Aug 2017 14:33:20 +0300
Message-ID: <cb25c079-f7ad-47f1-9fdd-b90cb8d7ef7f@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFo+0h5j8iRrrsr3yQe3FQ-zG+tr68n_XU3ZHJDS_eT+9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdHHLju (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Aug 2017 07:39:50 -0400
In-Reply-To: <CAPDyKFo+0h5j8iRrrsr3yQe3FQ-zG+tr68n_XU3ZHJDS_eT+9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 07/08/17 16:51, Ulf Hansson wrote:
> On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Most of the information needed to issue requests to a CQE is already in
>> struct mmc_request and struct mmc_data. Add data block address, some flags,
>> and the task id (tag), and allow for cmd being NULL which it is for CQE
>> tasks.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  include/linux/mmc/core.h   | 13 +++++++++++--
>>  include/trace/events/mmc.h | 36 +++++++++++++++++++++++-------------
>>  2 files changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index a0c63ea28796..bf1788a224e6 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -122,11 +122,18 @@ struct mmc_data {
>>         unsigned int            timeout_clks;   /* data timeout (in clocks) */
>>         unsigned int            blksz;          /* data block size */
>>         unsigned int            blocks;         /* number of blocks */
>> +       unsigned int            blk_addr;       /* block address */
>>         int                     error;          /* data error */
>>         unsigned int            flags;
>>
>> -#define MMC_DATA_WRITE (1 << 8)
>> -#define MMC_DATA_READ  (1 << 9)
>> +#define MMC_DATA_WRITE         BIT(8)
>> +#define MMC_DATA_READ          BIT(9)
>> +/* Extra flags used by CQE */
>> +#define MMC_DATA_QBR           BIT(10)         /* CQE queue barrier*/
>> +#define MMC_DATA_PRIO          BIT(11)         /* CQE high priority */
> 
> Regarding high priority data requests. I think this can be debated a
> bit on how it should be implemented.
> 
> If possible, may I suggest we move adding the support for this to the
> end of the series? In that way we can discuss it separately and it
> won't block us moving forward.

Yes, there is no reason we need to make use of the priority to start with.
> 
>> +#define MMC_DATA_REL_WR                BIT(12)         /* Reliable write */
> 
> What has this bit to do with CQE?

CQE processes read / write requests based on the information in struct
mmc_data, so we have to tell it whether the request is a reliable write.

> 
>> +#define MMC_DATA_DAT_TAG       BIT(13)         /* Tag request */
>> +#define MMC_DATA_FORCED_PRG    BIT(14)         /* Forced programming */
>>
>>         unsigned int            bytes_xfered;
>>
>> @@ -153,6 +160,8 @@ struct mmc_request {
>>
>>         /* Allow other commands during this ongoing data transfer or busy wait */
>>         bool                    cap_cmd_during_tfr;
>> +
>> +       int                     tag;
>>  };
>>
>>  struct mmc_card;
>> diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
>> index a72f9b94c80b..f30a99ac65b6 100644
>> --- a/include/trace/events/mmc.h
>> +++ b/include/trace/events/mmc.h
>> @@ -29,8 +29,10 @@
>>                 __field(unsigned int,           sbc_flags)
>>                 __field(unsigned int,           sbc_retries)
>>                 __field(unsigned int,           blocks)
>> +               __field(unsigned int,           blk_addr)
>>                 __field(unsigned int,           blksz)
>>                 __field(unsigned int,           data_flags)
>> +               __field(int,                    tag)
>>                 __field(unsigned int,           can_retune)
>>                 __field(unsigned int,           doing_retune)
>>                 __field(unsigned int,           retune_now)
>> @@ -42,10 +44,10 @@
>>         ),
>>
>>         TP_fast_assign(
>> -               __entry->cmd_opcode = mrq->cmd->opcode;
>> -               __entry->cmd_arg = mrq->cmd->arg;
>> -               __entry->cmd_flags = mrq->cmd->flags;
>> -               __entry->cmd_retries = mrq->cmd->retries;
>> +               __entry->cmd_opcode = mrq->cmd ? mrq->cmd->opcode : 0;
>> +               __entry->cmd_arg = mrq->cmd ? mrq->cmd->arg : 0;
>> +               __entry->cmd_flags = mrq->cmd ? mrq->cmd->flags : 0;
>> +               __entry->cmd_retries = mrq->cmd ? mrq->cmd->retries : 0;
>>                 __entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
>>                 __entry->stop_arg = mrq->stop ? mrq->stop->arg : 0;
>>                 __entry->stop_flags = mrq->stop ? mrq->stop->flags : 0;
>> @@ -56,7 +58,9 @@
>>                 __entry->sbc_retries = mrq->sbc ? mrq->sbc->retries : 0;
>>                 __entry->blksz = mrq->data ? mrq->data->blksz : 0;
>>                 __entry->blocks = mrq->data ? mrq->data->blocks : 0;
>> +               __entry->blk_addr = mrq->data ? mrq->data->blk_addr : 0;
>>                 __entry->data_flags = mrq->data ? mrq->data->flags : 0;
>> +               __entry->tag = mrq->tag;
>>                 __entry->can_retune = host->can_retune;
>>                 __entry->doing_retune = host->doing_retune;
>>                 __entry->retune_now = host->retune_now;
>> @@ -71,8 +75,8 @@
>>                   "cmd_opcode=%u cmd_arg=0x%x cmd_flags=0x%x cmd_retries=%u "
>>                   "stop_opcode=%u stop_arg=0x%x stop_flags=0x%x stop_retries=%u "
>>                   "sbc_opcode=%u sbc_arg=0x%x sbc_flags=0x%x sbc_retires=%u "
>> -                 "blocks=%u block_size=%u data_flags=0x%x "
>> -                 "can_retune=%u doing_retune=%u retune_now=%u "
>> +                 "blocks=%u block_size=%u blk_addr=%u data_flags=0x%x "
>> +                 "tag=%d can_retune=%u doing_retune=%u retune_now=%u "
>>                   "need_retune=%d hold_retune=%d retune_period=%u",
>>                   __get_str(name), __entry->mrq,
>>                   __entry->cmd_opcode, __entry->cmd_arg,
>> @@ -81,7 +85,8 @@
>>                   __entry->stop_flags, __entry->stop_retries,
>>                   __entry->sbc_opcode, __entry->sbc_arg,
>>                   __entry->sbc_flags, __entry->sbc_retries,
>> -                 __entry->blocks, __entry->blksz, __entry->data_flags,
>> +                 __entry->blocks, __entry->blk_addr,
>> +                 __entry->blksz, __entry->data_flags, __entry->tag,
>>                   __entry->can_retune, __entry->doing_retune,
>>                   __entry->retune_now, __entry->need_retune,
>>                   __entry->hold_retune, __entry->retune_period)
>> @@ -108,6 +113,7 @@
>>                 __field(unsigned int,           sbc_retries)
>>                 __field(unsigned int,           bytes_xfered)
>>                 __field(int,                    data_err)
>> +               __field(int,                    tag)
>>                 __field(unsigned int,           can_retune)
>>                 __field(unsigned int,           doing_retune)
>>                 __field(unsigned int,           retune_now)
>> @@ -119,10 +125,13 @@
>>         ),
>>
>>         TP_fast_assign(
>> -               __entry->cmd_opcode = mrq->cmd->opcode;
>> -               __entry->cmd_err = mrq->cmd->error;
>> -               memcpy(__entry->cmd_resp, mrq->cmd->resp, 4);
>> -               __entry->cmd_retries = mrq->cmd->retries;
>> +               __entry->cmd_opcode = mrq->cmd ? mrq->cmd->opcode : 0;
>> +               __entry->cmd_err = mrq->cmd ? mrq->cmd->error : 0;
>> +               __entry->cmd_resp[0] = mrq->cmd ? mrq->cmd->resp[0] : 0;
>> +               __entry->cmd_resp[1] = mrq->cmd ? mrq->cmd->resp[1] : 0;
>> +               __entry->cmd_resp[2] = mrq->cmd ? mrq->cmd->resp[2] : 0;
>> +               __entry->cmd_resp[3] = mrq->cmd ? mrq->cmd->resp[3] : 0;
>> +               __entry->cmd_retries = mrq->cmd ? mrq->cmd->retries : 0;
>>                 __entry->stop_opcode = mrq->stop ? mrq->stop->opcode : 0;
>>                 __entry->stop_err = mrq->stop ? mrq->stop->error : 0;
>>                 __entry->stop_resp[0] = mrq->stop ? mrq->stop->resp[0] : 0;
>> @@ -139,6 +148,7 @@
>>                 __entry->sbc_retries = mrq->sbc ? mrq->sbc->retries : 0;
>>                 __entry->bytes_xfered = mrq->data ? mrq->data->bytes_xfered : 0;
>>                 __entry->data_err = mrq->data ? mrq->data->error : 0;
>> +               __entry->tag = mrq->tag;
>>                 __entry->can_retune = host->can_retune;
>>                 __entry->doing_retune = host->doing_retune;
>>                 __entry->retune_now = host->retune_now;
>> @@ -154,7 +164,7 @@
>>                   "cmd_retries=%u stop_opcode=%u stop_err=%d "
>>                   "stop_resp=0x%x 0x%x 0x%x 0x%x stop_retries=%u "
>>                   "sbc_opcode=%u sbc_err=%d sbc_resp=0x%x 0x%x 0x%x 0x%x "
>> -                 "sbc_retries=%u bytes_xfered=%u data_err=%d "
>> +                 "sbc_retries=%u bytes_xfered=%u data_err=%d tag=%d "
>>                   "can_retune=%u doing_retune=%u retune_now=%u need_retune=%d "
>>                   "hold_retune=%d retune_period=%u",
>>                   __get_str(name), __entry->mrq,
>> @@ -170,7 +180,7 @@
>>                   __entry->sbc_resp[0], __entry->sbc_resp[1],
>>                   __entry->sbc_resp[2], __entry->sbc_resp[3],
>>                   __entry->sbc_retries,
>> -                 __entry->bytes_xfered, __entry->data_err,
>> +                 __entry->bytes_xfered, __entry->data_err, __entry->tag,
>>                   __entry->can_retune, __entry->doing_retune,
>>                   __entry->retune_now, __entry->need_retune,
>>                   __entry->hold_retune, __entry->retune_period)
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

