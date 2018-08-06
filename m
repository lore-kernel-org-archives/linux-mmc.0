From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date: Mon, 6 Aug 2018 19:29:06 +0800
Message-ID: <CAAfSe-vT0+9seTJwioY8Um0ch85Q_pDfbWC=uCyF2Ch+LEby-g@mail.gmail.com>
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
 <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org> <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Jason Wu <jason.wu@unisoc.com>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 30 July 2018 at 21:05, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/07/18 05:51, Chunyan Zhang wrote:
>> Host Controller Version 4.10 re-defines SDMA System Address register
>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead if v4 mode is enabled. Also
>> when using 32-bit block count, 16-bit block count register need
>> to be set to zero.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>>  drivers/mmc/host/sdhci.h |  1 +
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 920d8ec..c272a2b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
>
> So this is also SDHCI_ARGUMENT2 which is why there is a conflict with
> auto-CMD23.  We need to write SDHCI_32BIT_BLK_CNT only once, but also cater
> for eMMC which uses the CMD23 argument for more than just block count.
>

What you would suggest on how should we change here?

I've double checked with the hardware fellow within the company, the
sd host controller v4 (on our platform at least) would  use this
register as block count only, that's saying that it would not deal
with the flags (i.e. reliable write and data tag) of CMD23.

Thanks,
Chunyan

>> +     } else {
>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     }
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 23318ff..81aae07 100644
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
