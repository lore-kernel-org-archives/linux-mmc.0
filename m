From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2 2/7] mmc: sdhci: made changes for System Address
 register of SDMA
Date: Wed, 4 Jul 2018 11:02:43 +0800
Message-ID: <CAAfSe-tegyiEhHrJ+9pqbhm+sYDnd3WwuSEc4p7qDMDpYJw-xw@mail.gmail.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-3-git-send-email-zhang.chunyan@linaro.org> <2eb994d3-7f23-6ff8-4740-7a444a581e9d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2eb994d3-7f23-6ff8-4740-7a444a581e9d@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>
List-Id: linux-mmc@vger.kernel.org

On 21 June 2018 at 19:22, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/06/18 05:04, Chunyan Zhang wrote:
>> According to the SD host controller specification version 4.10, when
>> Host Version 4 is enabled, SDMA uses ADMA System Address register
>> (05Fh-058h) instead of using SDMA System Address register to
>> support both 32-bit and 64-bit addressing.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index cf5695f..f57201f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>       u8 ctrl;
>> +     u32 reg;
>
> reg could just be an int.

Why? Shouldn't addresses be unsigned?

>
>>       struct mmc_data *data = cmd->data;
>>
>>       if (sdhci_data_line_cmd(cmd))
>> @@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>                                            SDHCI_ADMA_ADDRESS_HI);
>>               } else {
>>                       WARN_ON(sg_cnt != 1);
>> +                     reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
>> +                             SDHCI_DMA_ADDRESS;
>>                       sdhci_writel(host, sdhci_sdma_address(host),
>> -                                  SDHCI_DMA_ADDRESS);
>> +                                  reg);
>
> Shouldn't we support 64-bit SDMA in version 4 mode?

I will address.

>
>
>>               }
>>       }
>>
>> @@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>                */
>>               if (intmask & SDHCI_INT_DMA_END) {
>>                       u32 dmastart, dmanow;
>> +                     u32 reg;
>>
>>                       dmastart = sdhci_sdma_address(host);
>>                       dmanow = dmastart + host->data->bytes_xfered;
>> @@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>                       host->data->bytes_xfered = dmanow - dmastart;
>>                       DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
>>                           dmastart, host->data->bytes_xfered, dmanow);
>> -                     sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>> +                     reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
>> +                             SDHCI_DMA_ADDRESS;
>> +                     sdhci_writel(host, dmanow, reg);
>
> Shouldn't we support 64-bit SDMA in version 4 mode?
>
>>               }
>>
>>               if (intmask & SDHCI_INT_DATA_END) {
>>
>
