From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V6 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
Date: Mon, 27 Aug 2018 15:52:16 +0800
Message-ID: <CAAfSe-sC_NCkwU=-L-Rn1Bu9ZnHhA3TByM1Q7Wyzb6CH6yWSKA@mail.gmail.com>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
 <1535102428-20332-6-git-send-email-zhang.chunyan@linaro.org> <f209e114-152c-65e0-4c24-53252818ab5d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f209e114-152c-65e0-4c24-53252818ab5d@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

On 27 August 2018 at 15:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/08/18 12:20, Chunyan Zhang wrote:
>> Host Controller Version 4.10 re-defines SDMA System Address register
>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead if v4 mode is enabled. Also
>> when using 32-bit block count, 16-bit block count register need
>> to be set to zero.
>>
>> Since using 32-bit Block Count would cause problems for auto-cmd23,
>> it can be chosen via host->quirk2.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
>>  drivers/mmc/host/sdhci.h |  3 +++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 38d083c..05f9fff 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1073,7 +1073,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>       /* Set the DMA boundary value and block size */
>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
>>                    SDHCI_BLOCK_SIZE);
>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +
>> +     /*
>> +      * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
>> +      * register need to be set to zero, 32-bit Block Count register would
>> +      * be selected.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
>> +         !(host->quirks2 & SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT)) {
>
> Because 32-bit block count is problematic but also not essential, I would
> prefer to do the quirk the other way around. i.e. SDHCI_QUIRK2_USE_32BIT_BLK_CNT
>
> I would also add a comment to the definition of
> SDHCI_QUIRK2_USE_32BIT_BLK_CNT, like:
>
> 32-bit block count may not support eMMC where upper bits of CMD23 are used
> for other purposes.  Consequently we support 16-bit block count by default.
> Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
> block count.

Ok, thanks Adrian!

I will address the comments and also rebase the whole patchset to v4.19-rc1.

>
>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
>> +     } else {
>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     }
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index f3b9ebc..0a1e25f 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -28,6 +28,7 @@
>>
>>  #define SDHCI_DMA_ADDRESS    0x00
>>  #define SDHCI_ARGUMENT2              SDHCI_DMA_ADDRESS
>> +#define SDHCI_32BIT_BLK_CNT  SDHCI_DMA_ADDRESS
>>
>>  #define SDHCI_BLOCK_SIZE     0x04
>>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
>> @@ -462,6 +463,8 @@ struct sdhci_host {
>>   * obtainable timeout.
>>   */
>>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT                      (1<<17)
>> +/* Controller broken with using 32-bit block count in v4_mode */
>> +#define SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT            (1<<18)
>>
>>       int irq;                /* Device IRQ */
>>       void __iomem *ioaddr;   /* Mapped address */
>>
>
