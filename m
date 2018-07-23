From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V3 5/7] mmc: sdhci: add Auto CMD Auto Select support
Date: Mon, 23 Jul 2018 15:11:42 +0800
Message-ID: <CAAfSe-t8T0JRR7w++FeWppEaC0S7x838EGmySoBsS0+WMOpDng@mail.gmail.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-6-git-send-email-zhang.chunyan@linaro.org> <3cc11907-5248-ea5a-5e2a-f93e12ef4e68@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cc11907-5248-ea5a-5e2a-f93e12ef4e68@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>
List-Id: linux-mmc@vger.kernel.org

On 17 July 2018 at 19:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/07/18 06:19, Chunyan Zhang wrote:
>> As SD Host Controller Specification v4.10 documents:
>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>> Control 2 register which indicates whether card supports CMD23. If CMD23
>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>> Enable.
>>
>> This patch add this new mode support.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++++-----------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index f64e766..1ca3871 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1033,6 +1033,33 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>              !mrq->cap_cmd_during_tfr;
>>  }
>>
>> +static inline void sdhci_auto_cmd_enable(struct sdhci_host *host,
>> +                                      struct mmc_command *cmd,
>> +                                      u16 *mode)
>> +{
>> +     /*
>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>> +      * Select' is recommended rather than use of 'Auto CMD12
>> +      * Enable' or 'Auto CMD23 Enable'.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410) {
>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>
> The rules for selecting auto commands still need to be applied.  In effect:
>
>         if (sdhci_auto_cmd12(host, cmd->mrq) &&
>             (cmd->opcode != SD_IO_RW_EXTENDED)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>         } else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>                 *mode |= SDHCI_TRNS_AUTO_SEL;
>                 sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);

The fact seems that SDHCI_TRNS_AUTO_SEL mode don't need
SDHCI_ARGUMENT2 register being written. The test result on my board
showed that mounting a blk partition would fail due to lack of a
hardware interrupt if SDHCI_ARGUMENT2 was set like above.

>         }
>
> Also the selection of Host Control 2 register CMD23 Enable should be done by
> SDHCI (if supported by the card) not the Spreadtrum driver.

Ok.

>
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * If we are sending CMD23, CMD12 never gets sent
>> +      * on successful completion (so no Auto-CMD12).
>> +      */
>> +     if (sdhci_auto_cmd12(host, cmd->mrq) &&
>> +         (cmd->opcode != SD_IO_RW_EXTENDED)) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>> +     } else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +     }
>> +}
>> +
>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>       struct mmc_command *cmd)
>>  {
>> @@ -1059,17 +1086,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>
>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>> -             /*
>> -              * If we are sending CMD23, CMD12 never gets sent
>> -              * on successful completion (so no Auto-CMD12).
>> -              */
>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> -             }
>> +             sdhci_auto_cmd_enable(host, cmd, &mode);
>>       }
>>
>>       if (data->flags & MMC_DATA_READ)
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 889e48b..8263ac6 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -42,6 +42,7 @@
>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>  #define  SDHCI_TRNS_READ     0x10
>>  #define  SDHCI_TRNS_MULTI    0x20
>>
>> @@ -185,6 +186,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>
