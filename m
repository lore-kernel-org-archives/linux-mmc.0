From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V3 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date: Tue, 17 Jul 2018 17:14:27 +0800
Message-ID: <CAAfSe-tJGM7GMb6pCAMhKVDu9XSEjmyGYkgVCQZr__C0Q0goiQ@mail.gmail.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-5-git-send-email-zhang.chunyan@linaro.org> <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 17 July 2018 at 16:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/07/18 06:19, Chunyan Zhang wrote:
>> When Host Version 4 is enabled, SDMA System Address register is
>> re-defined as 32-bit Block Count, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 +++-
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7871ae2..f64e766 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -889,6 +889,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>       u8 ctrl;
>> +     u32 reg;
>>       struct mmc_data *data = cmd->data;
>>
>>       host->data_timeout = 0;
>> @@ -1021,7 +1022,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>       /* Set the DMA boundary value and block size */
>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
>>                    SDHCI_BLOCK_SIZE);
>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
>> +     sdhci_writew(host, data->blocks, reg);
>
> The specification says to set 16-bit block count register to zero when using
> 32-bit block count.  It also says it is valid for V4.1 onwards and also for
> V4 with SDMA and auto-CMD23.
>
> So maybe we should continue to use the 16-bit block count register with V4.0

Ok.

Where can I get a V4.0 specification? I only have V4.10 on hands.

>
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 24fa58a..889e48b 100644
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
>>
>
