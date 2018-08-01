From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V4 5/7] mmc: sdhci: add Auto CMD Auto Select support
Date: Wed, 1 Aug 2018 17:26:25 +0800
Message-ID: <CAAfSe-udgj-Cbwzf0dE+891KMcsR6BoqD+VSYgPuav5Jt35n1A@mail.gmail.com>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
 <33ceb61c-3e09-c336-e9b9-87c01336f56c@intel.com> <CAAfSe-vVEve63y-Pc0QF6w7vc37cbbbOknGkp9SmocXyNX3J4g@mail.gmail.com>
 <f810df5a-2cc4-a534-9fdc-2575ae81cf4b@intel.com> <CAAfSe-uyjnBGk7w2KMgrgEYVgYY6p6EqCWTUW+r2BWDoYmPpLg@mail.gmail.com>
 <23282747-4ae1-d627-a537-590b9315b941@intel.com> <CAAfSe-vp_6zFPo+UYKiR+St1ajv8WXP_OL-OZh_POiUybzDHeQ@mail.gmail.com>
 <c036244d-e944-f0c7-3efd-886def5fb22c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c036244d-e944-f0c7-3efd-886def5fb22c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Jason Wu <jason.wu@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

On 31 July 2018 at 17:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 31/07/18 12:20, Chunyan Zhang wrote:
>> On 31 July 2018 at 16:56, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 31/07/18 11:36, Chunyan Zhang wrote:
>>>> On 31 July 2018 at 16:05, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 31/07/18 10:04, Chunyan Zhang wrote:
>>>>>> Hi Adrian,
>>>>>>
>>>>>> On 30 July 2018 at 21:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>> On 23/07/18 13:08, Chunyan Zhang wrote:
>>>>>>>> As SD Host Controller Specification v4.10 documents:
>>>>>>>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>>>>>>>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>>>>>>>> Control 2 register which indicates whether card supports CMD23. If CMD23
>>>>>>>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>>>>>>>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>>>>>>>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>>>>>>>> Enable.
>>>>>>>>
>>>>>>>> This patch add this new mode support.
>>>>>>>>
>>>>>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/host/sdhci.c | 61 +++++++++++++++++++++++++++++++++++++++---------
>>>>>>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>>>>>>  2 files changed, 52 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>>>> index 5acea3d..5c60590 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>> @@ -311,6 +311,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>>>>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>>>>>>>> +{
>>>>>>>> +     u16 ctrl2;
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * This is used along with "Auto CMD Auto Select" feature,
>>>>>>>> +      * which is introduced from v4.10, if card supports CMD23,
>>>>>>>> +      * Auto CMD23 should be used instead of Auto CMD12.
>>>>>>>> +      */
>>>>>>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>>>>>>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>>>>>>>
>>>>>>> That is the host capability.  It needs to be the card capability.
>>>>>>
>>>>>> Could you please elaborate the issue?
>>>>>>
>>>>>> I thought we're setting for host here.  Do you mean we need to see the
>>>>>> card capability?
>>>>>
>>>>> Yes. SDHCI_TRNS_AUTO_SEL selects auto-CMD23 or auto-CMD12 based on this
>>>>> setting, so this must reflect the card's capability.
>>>>
>>>> Got it, but how to know if the card supports CMD23?
>>>
>>> At the moment the only way of knowing is if a request is received with mrq->sbc
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>>>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>>>>>>>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>>>  {
>>>>>>>>       struct mmc_host *mmc = host->mmc;
>>>>>>>> @@ -329,6 +346,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>>>               host->clock = 0;
>>>>>>>>               mmc->ops->set_ios(mmc, &mmc->ios);
>>>>>>>>       }
>>>>>>>> +
>>>>>>>> +     sdhci_enable_cmd23(host);
>>>>>>>>  }
>>>>>>>>
>>>>>>>>  static void sdhci_reinit(struct sdhci_host *host)
>>>>>>>> @@ -1093,6 +1112,36 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>>>>>>              !mrq->cap_cmd_during_tfr;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>>>>>>>> +                                      struct mmc_command *cmd,
>>>>>>>> +                                      u16 *mode)
>>>>>>>> +{
>>>>>>>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>>>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>>>>>>>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>>>>>>>> +      * Select' is recommended rather than use of 'Auto CMD12
>>>>>>>> +      * Enable' or 'Auto CMD23 Enable'.
>>>>>>>> +      */
>>>>>>>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>>>>>>>
>>>>>>> As noted in patch 4, the CMD23 argument is not just the block count for eMMC.
>>>>>>
>>>>>> Probably I haven't got your point...
>>>>>>
>>>>>> >From what I understand, auto_sel mode doesn't need argument2. Doesn't
>>>>>> this work for eMMC?
>>>>>
>>>>> CMD23 always needs an argument
>>>>
>>>> But setting argument for CMD23 will cover the block count value we set
>>>> before, that will lead mounting emmc to fail.
>>>
>>> Does it fail because it contains cmd->mrq->sbc->arg or does it fail because
>>> it gets written twice?
>>
>> Seems that the argument is too big compared with block count, hardware
>> think it is a super block count.
>>
>> More details of the error information:
>> https://www.irccloud.com/pastebin/uYlVEUsP/
>
> Does it work with auto-CMD23 instead of auto-CMD-auto-select?

No, so long as SDHCI_32BIT_BLK_CNT was set with cmd->mrq->sbc->arg
which is a big value, it would report error "I/O error while writing
superblock" when mounting emmc.

> Does it work if the 16-bit block count register is used?

16-bit block count register is Read Only on my board :-(

>
> Obviously, if we can't pass the CMD23 argument correctly then we can't use
> auto-CMD23.

On my board, if argument2 was limited to the maximum of 65535, then
everything works, otherwise I would see an error "EXT4-fs
(mmcblk0p28): I/O error while writing superblock".  Haven't found the
root cause. I will continue to look at the problem, any comments would
be appreciated.

Thanks,
Chunyan

>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> The test platform I used was just eMMC only, haven't found problem.
>>>>>
>>>>> Because the bits that are missing from the CMD23 argument (reliable write,
>>>>> context id, etc) will not make the command fail.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Chunyan
>>>>>>
>>>>>>>
>>>>>>>> +             return;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * If we are sending CMD23, CMD12 never gets sent
>>>>>>>> +      * on successful completion (so no Auto-CMD12).
>>>>>>>> +      */
>>>>>>>> +     if (use_cmd12) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>>>> +     } else if (use_cmd23) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>>>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>>>       struct mmc_command *cmd)
>>>>>>>>  {
>>>>>>>> @@ -1119,17 +1168,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>>>
>>>>>>>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>>>>>>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>>>>>>> -             /*
>>>>>>>> -              * If we are sending CMD23, CMD12 never gets sent
>>>>>>>> -              * on successful completion (so no Auto-CMD12).
>>>>>>>> -              */
>>>>>>>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>>>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>>>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>>>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>>>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>>>> -             }
>>>>>>>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>>>>>>>       }
>>>>>>>>
>>>>>>>>       if (data->flags & MMC_DATA_READ)
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>>>> index 81aae07..a8f4ec2 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>>>> @@ -42,6 +42,7 @@
>>>>>>>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>>>>>>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>>>>>>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>>>>>>>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>>>>>>>  #define  SDHCI_TRNS_READ     0x10
>>>>>>>>  #define  SDHCI_TRNS_MULTI    0x20
>>>>>>>>
>>>>>>>> @@ -185,6 +186,7 @@
>>>>>>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>>>>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>>>>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>>>>>>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>>>>>>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>>>>>>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>>>>>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>
