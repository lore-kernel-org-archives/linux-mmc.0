From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 27/27] mmc: mmci: add stm32 sdmmc variant
Date: Mon, 1 Oct 2018 14:56:53 +0200
Message-ID: <50222b8d-3b53-acea-7935-092fa149d54c@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-28-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqGY2o7TcUVW9bCZM9-4xtyJJ4PaCtWWQvV3VMd+cK99A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqGY2o7TcUVW9bCZM9-4xtyJJ4PaCtWWQvV3VMd+cK99A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Loic Pallardy <loic.pallardy@st.com>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 10/01/2018 11:31 AM, Ulf Hansson wrote:
> On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds a stm32 sdmmc variant, rev 1.1.
>> Introduces a new Manufacturer id "0x53, ascii 'S' to define
>> new stm32 sdmmc family with clean range of amba
>> revision/configurations bits (corresponding to sdmmc_ver
>> register with major/minor fields).
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/Kconfig            |  10 ++
>>   drivers/mmc/host/Makefile           |   1 +
>>   drivers/mmc/host/mmci.c             |  25 ++++
>>   drivers/mmc/host/mmci.h             |   5 +
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 282 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 323 insertions(+)
>>   create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 5ab2eb0..e59671a 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -34,6 +34,16 @@ config MMC_QCOM_DML
>>
>>            if unsure, say N.
>>
>> +config MMC_STM32_SDMMC
>> +       bool "STMicroelectronics STM32 SDMMC Controller"
>> +       depends on MMC_ARMMMCI
>> +       default y
>> +       help
>> +         This selects the STMicroelectronics STM32 SDMMC host controller.
>> +         If you have a STM32 sdmmc host with internal dma say Y or M here.
>> +
>> +         If unsure, say N.
>> +
>>   config MMC_PXA
>>          tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
>>          depends on ARCH_PXA
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index ce8398e..f14410f 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -6,6 +6,7 @@
>>   obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
>>   armmmci-y := mmci.o
>>   armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
>> +armmmci-$(CONFIG_MMC_STM32_SDMMC) += mmci_stm32_sdmmc.o
>>   obj-$(CONFIG_MMC_PXA)          += pxamci.o
>>   obj-$(CONFIG_MMC_MXC)          += mxcmmc.o
>>   obj-$(CONFIG_MMC_MXS)          += mxs-mmc.o
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 4057456..ca2e483 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -254,6 +254,26 @@ static struct variant_data variant_stm32 = {
>>          .init                   = mmci_variant_init,
>>   };
>>
>> +static struct variant_data variant_stm32_sdmmc = {
>> +       .fifosize               = 16 * 4,
>> +       .fifohalfsize           = 8 * 4,
>> +       .f_max                  = 208000000,
>> +       .stm32_clkdiv           = true,
>> +       .reset                  = true,
>> +       .cmdreg_cpsm_enable     = MCI_CPSM_STM32_ENABLE,
>> +       .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>> +       .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>> +       .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
>> +       .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>> +       .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>> +       .datactrl_first         = true,
>> +       .datacnt_useless        = true,
>> +       .datalength_bits        = 25,
>> +       .datactrl_blocksz       = 14,
>> +       .stm32_idmabsize_mask   = GENMASK(12, 5),
>> +       .init                   = sdmmc_variant_init,
>> +};
>> +
>>   static struct variant_data variant_qcom = {
>>          .fifosize               = 16 * 4,
>>          .fifohalfsize           = 8 * 4,
>> @@ -2180,6 +2200,11 @@ static const struct amba_id mmci_ids[] = {
>>                  .mask   = 0x00ffffff,
>>                  .data   = &variant_stm32,
>>          },
>> +       {
>> +               .id     = 0x10153180,
>> +               .mask   = 0xf0ffffff,
>> +               .data   = &variant_stm32_sdmmc,
>> +       },
>>          /* Qualcomm variants */
>>          {
>>                  .id     = 0x00051180,
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 017d9b8..581b9b1 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -305,6 +305,8 @@ struct mmci_host;
>>    *            register.
>>    * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>>    * @reset: true if variant has need reset signal.
>> + * @dma_lli: true if variant has dma link list feature.
>> + * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -348,6 +350,8 @@ struct variant_data {
>>          unsigned int            irq_pio_mask;
>>          u32                     start_err;
>>          u32                     opendrain;
>> +       bool                    dma_lli;
>> +       u32                     stm32_idmabsize_mask;
> 
> What are these?

This property is specific for sdmmc variants:
sdmmc has a Internal DMA and the number bytes per buffer
could be different between sdmmc variants
(depend of SDMMC_IDMABSIZER register).

> 
>>          void (*init)(struct mmci_host *host);
>>   };
>>
>> @@ -421,6 +425,7 @@ void mmci_write_clkreg(struct mmci_host *host, u32 clk);
>>   void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
>>
>>   void mmci_variant_init(struct mmci_host *host);
>> +void sdmmc_variant_init(struct mmci_host *host);
>>
>>   int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>>                          bool next);
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> new file mode 100644
>> index 0000000..cfbfc6f
>> --- /dev/null
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -0,0 +1,282 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>> + * Author: Ludovic.barre@st.com for STMicroelectronics.
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/reset.h>
>> +#include <linux/scatterlist.h>
>> +#include "mmci.h"
>> +
>> +#define SDMMC_LLI_BUF_LEN      PAGE_SIZE
>> +#define SDMMC_IDMA_BURST       BIT(MMCI_STM32_IDMABNDT_SHIFT)
>> +
>> +struct sdmmc_lli_desc {
>> +       u32 idmalar;
>> +       u32 idmabase;
>> +       u32 idmasize;
>> +};
>> +
>> +struct sdmmc_priv {
>> +       dma_addr_t sg_dma;
>> +       void *sg_cpu;
>> +};
>> +
>> +int sdmmc_idma_validate_data(struct mmci_host *host,
>> +                            struct mmc_data *data)
>> +{
>> +       struct scatterlist *sg;
>> +       int i;
>> +
>> +       /*
>> +        * idma has constraints on idmabase & idmasize for each element
>> +        * excepted the last element which has no constraint on idmasize
>> +        */
>> +       for_each_sg(data->sg, sg, data->sg_len - 1, i) {
>> +               if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32)) ||
>> +                   !IS_ALIGNED(sg_dma_len(data->sg), SDMMC_IDMA_BURST)) {
>> +                       dev_err(mmc_dev(host->mmc),
>> +                               "unaligned scatterlist: ofst:%x length:%d\n",
>> +                               data->sg->offset, data->sg->length);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32))) {
>> +               dev_err(mmc_dev(host->mmc),
>> +                       "unaligned last scatterlist: ofst:%x length:%d\n",
>> +                       data->sg->offset, data->sg->length);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int _sdmmc_idma_prep_data(struct mmci_host *host,
>> +                                struct mmc_data *data)
>> +{
>> +       int n_elem;
>> +
>> +       n_elem = dma_map_sg(mmc_dev(host->mmc),
>> +                           data->sg,
>> +                           data->sg_len,
>> +                           mmc_get_dma_dir(data));
>> +
>> +       if (!n_elem) {
>> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdmmc_idma_prep_data(struct mmci_host *host,
>> +                               struct mmc_data *data, bool next)
>> +{
>> +       /* Check if job is already prepared. */
>> +       if (!next && data->host_cookie == host->next_cookie)
>> +               return 0;
>> +
>> +       return _sdmmc_idma_prep_data(host, data);
>> +}
>> +
>> +static void sdmmc_idma_unprep_data(struct mmci_host *host,
>> +                                  struct mmc_data *data, int err)
>> +{
>> +       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>> +                    mmc_get_dma_dir(data));
>> +}
> 
> The sdmmc_idma_prep_data() and sdmmc_idma_unprep_data(), seems very
> similar to what the mmci core driver needs to do in this regards.
> 
> Can we perhaps avoid adding these callbacks altogether, but rather
> rely on common code in the mmci core driver?

Actually, these callbacks allow to manage prepare/unprepare of
dmaengine interface for mmci variant, (not needed for sdmmc which uses 
an internal dma).

For Sdmmc, today there are no special case, just dma_map/unmap.
But in the future, I hope manage the lli list in these callback.

Only dma_map/unmap could be common, but the error management may
be complicated (in mmci variant).

Personally, I prefer keep prep_data/unprep_data mmci_host_ops
interfaces.
What do you suggest ?

> 
> [...]
> 
> Kind regards
> Uffe
> 
