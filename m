From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 07/10] mmc: sdhci: Add Auto CMD Auto Select support
Date: Fri, 24 Aug 2018 09:55:41 +0300
Message-ID: <c1e0a508-c47b-c02f-7df9-d3e928526e86@intel.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-8-git-send-email-zhang.chunyan@linaro.org>
 <0dc112ca-1c01-d8ae-c6f0-80492264f5a4@intel.com>
 <CAAfSe-uZ3ghR+8dZ7CD03UnGX2Uf1fv=-5s656ZkybcU8LWzJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfSe-uZ3ghR+8dZ7CD03UnGX2Uf1fv=-5s656ZkybcU8LWzJQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

On 24/08/18 09:52, Chunyan Zhang wrote:
> On 23 August 2018 at 20:55, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 16/08/18 10:54, Chunyan Zhang wrote:
>>> As SD Host Controller Specification v4.10 documents:
>>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>>> Control 2 register which indicates whether card supports CMD23. If CMD23
>>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>>> Enable.
>>>
>>> This patch add this new mode support.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 67 ++++++++++++++++++++++++++++++++++++++++--------
>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a72ad0d..06c2ae9 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -312,6 +312,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>  }
>>>
>>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>>> +{
>>> +     u16 ctrl2;
>>> +
>>> +     /*
>>> +      * This is used along with "Auto CMD Auto Select" feature,
>>> +      * which is introduced from v4.10, if card supports CMD23,
>>> +      * Auto CMD23 should be used instead of Auto CMD12.
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>>
>> The caller has already checked those conditions
>>
>>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>>> +     }
>>> +}
>>> +
>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>  {
>>>       struct mmc_host *mmc = host->mmc;
>>> @@ -1095,6 +1112,44 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>              !mrq->cap_cmd_during_tfr;
>>>  }
>>>
>>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>>> +                                      struct mmc_command *cmd,
>>> +                                      u16 *mode)
>>> +{
>>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>>> +
>>> +     /*
>>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>>> +      * Select' is recommended rather than use of 'Auto CMD12
>>> +      * Enable' or 'Auto CMD23 Enable'.
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>>> +             /*
>>> +              * Note no need to set SDHCI_ARGUMENT2 here, since for version
>>> +              * 4.10 and aboves, it doesn't support stuff bits of CMD23
>>> +              * argument but only number of blocks which have been set
>>> +              * already during prepare data.
>>
>> The argument will only have already been written in v4_mode.
> 
> It seems that we still need to set SDHCI_ARGUMENT2 here, if adding a
> quirk for broken using 32-bit block count and also moved below to
> sdhci-sprd.c

Yes

> 
> "
> +     /*
> +      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
> +      * block count register which don't support stuff bits of CMD23 argument
> +      */
> +     if (host->version >= SDHCI_SPEC_410 &&
> +         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
> +         (host->flags & SDHCI_AUTO_CMD23))
> +             host->flags &= ~SDHCI_AUTO_CMD23
> "
> 
>>
>>> +              */
>>> +             if (use_cmd23)
>>> +                     sdhci_enable_cmd23(host);
>>
>> Need to ensure that SDHCI_CMD23_ENABLE is cleared for !use_cmd23
>>
>>> +             return;
>>> +     }
>>> +
>>> +     /*
>>> +      * If we are sending CMD23, CMD12 never gets sent
>>> +      * on successful completion (so no Auto-CMD12).
>>> +      */
>>> +     if (use_cmd12) {
>>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>>> +     } else if (use_cmd23) {
>>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>> +     }
>>> +}
>>> +
>>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>       struct mmc_command *cmd)
>>>  {
>>> @@ -1121,17 +1176,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>
>>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>> -             /*
>>> -              * If we are sending CMD23, CMD12 never gets sent
>>> -              * on successful completion (so no Auto-CMD12).
>>> -              */
>>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>> -             }
>>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>>       }
>>>
>>>       if (data->flags & MMC_DATA_READ)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index daf8c1e..a8d5be5 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -43,6 +43,7 @@
>>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>>  #define  SDHCI_TRNS_READ     0x10
>>>  #define  SDHCI_TRNS_MULTI    0x20
>>>
>>> @@ -186,6 +187,7 @@
>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>
>>
> 
