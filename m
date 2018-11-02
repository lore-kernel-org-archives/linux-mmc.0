From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH] mmc: mmci: add variant property to send stop cmd if a
 command fail
Date: Fri, 2 Nov 2018 14:57:25 +0100
Message-ID: <805f43ce-81f3-15f6-ab46-4b25ee3911f3@st.com>
References: <1540894589-4004-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFoyvKeFFwvJppg=NFDQNnDmL83+BR0fhkX=5DwpsGZ11g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoyvKeFFwvJppg=NFDQNnDmL83+BR0fhkX=5DwpsGZ11g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

On 10/31/18 4:16 PM, Ulf Hansson wrote:
> On 30 October 2018 at 11:16, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> The mmc framework follows the requirement of SD_Specification:
>> the STOP_TRANSMISSION is sent on multiple write/read commands
>> and the stop command (alone), not needed on other ADTC commands.
> 
> Well, there is a bit more to it than that.
> 
> Host drivers may set MMC_CAP_CMD23 support, which means pre-defined
> multi-block transfers, becomes preferable to open-ended ones.
> 
> However, even for pre-defined transfers, a CM12 (stop transmission)
> should be sent, in case of data transfer errors. At least if I
> understand the specs correctly.

About CMD23 (sbc)
yes are right, if you refer to "4.15 Set Block Count Command" of sd 
specification:
-CMD23 is useful for the host to stop multiple read/write operation 
instead of CMD12.
-"Host needs to issue CMD12 if any error is detected in the CMD18 and
CMD25 operations" (multiple block read/write).

> 
> By looking at the code in mmci_data_irq(), I realize that it's not
> considering this case - so I think that need to be fixed as to start
> with.

for "it's not considering this case" you're referring to line:
	if (!data->stop || host->mrq->sbc) {
		mmci_request_end(host, data->mrq);
  	} else {
  		mmci_start_command(host, data->stop, 0);
  	}

MMC framework, sets a data->stop command for requests
read/write multi block:
mmc_blk_data_prep:
	brq->stop.opcode = MMC_STOP_TRANSMISSION;
mmc_blk_rw_rq_prep:
	brq->mrq.stop = &brq->stop

mmc_start_request
	mmc_mrq_prep
		if (mrq->stop) {
			mrq->data->stop = mrq->stop;

Normally, the framework set a data->stop command for sbc request.
so we could replace the previous line by:

	if (!data->stop || (host->mrq->sbc && !data->error))
		mmci_request_end(host, data->mrq);
	else
		mmci_start_command(host, data->stop, 0);

> 
>>
>> But, if an error happens on command or data step, some variants
>> require a stop command "STOP_TRANSMISION" to clear the DPSM
>> "Data Path State Machine". If it's not done the next data
>> command freezes hardware block.
>> Needed to support the STM32 sdmmc variant.
> 
> I don't really follow this, sorry. Could you start by clarifying what
> you mean by "data step", according to the above?

perhaps more explicit with:
"if an error happens while command/data transmission

> 
> As far as I understand, you need to send a CMD12 to clear the DPSM, in
> case of any errors happening during a data transfer (which includes
> ADTC commands as well), right?

yes, that's right.

Regards
Ludo

> 
> Or is there anything else to it?
> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
>>   drivers/mmc/host/mmci.h |  4 ++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 19650ed..ecedca3 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/err.h>
>>   #include <linux/highmem.h>
>>   #include <linux/log2.h>
>> +#include <linux/mmc/mmc.h>
>>   #include <linux/mmc/pm.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/card.h>
>> @@ -57,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
>>   #else
>>   static inline void sdmmc_variant_init(struct mmci_host *host) {}
>>   #endif
>> +static void
>> +mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
>>
>>   static unsigned int fmax = 515633;
>>
>> @@ -274,6 +277,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>          .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>>          .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>>          .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
>> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>>          .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>>          .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>>          .datactrl_first         = true,
>> @@ -574,6 +578,24 @@ void mmci_dma_error(struct mmci_host *host)
>>   static void
>>   mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>>   {
>> +       /*
>> +        * If an error happens on command or data step, some variants
>> +        * require a stop command to reinit the DPSM.
>> +        * If it's not done the next data command freeze hardware block.
>> +        */
>> +       if (host->variant->cmdreg_stop) {
>> +               u32 dpsm;
>> +
>> +               dpsm = readl_relaxed(host->base + MMCISTATUS);
>> +               dpsm &= MCI_STM32_DPSMACTIVE;
>> +
>> +               if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
>> +                            (mrq->data && mrq->data->error))) {
>> +                       mmci_start_command(host, &host->stop_abort, 0);
>> +                       return;
>> +               }
>> +       }
>> +
>>          writel(0, host->base + MMCICOMMAND);
>>
>>          BUG_ON(host->data);
>> @@ -1106,6 +1128,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>                  mmci_reg_delay(host);
>>          }
>>
>> +       if (host->variant->cmdreg_stop &&
>> +           cmd->opcode == MMC_STOP_TRANSMISSION)
>> +               c |= host->variant->cmdreg_stop;
>> +
>>          c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>>          if (cmd->flags & MMC_RSP_PRESENT) {
>>                  if (cmd->flags & MMC_RSP_136)
>> @@ -1957,6 +1983,13 @@ static int mmci_probe(struct amba_device *dev,
>>                  mmc->max_busy_timeout = 0;
>>          }
>>
>> +       /* prepare the stop command, used to abort and reinitialized the DPSM */
>> +       if (variant->cmdreg_stop) {
>> +               host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
>> +               host->stop_abort.arg = 0;
>> +               host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +       }
>> +
>>          mmc->ops = &mmci_ops;
>>
>>          /* We support these PM capabilities. */
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index ec13d90..afb6ec4 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -166,6 +166,7 @@
>>   #define MCI_ST_CEATAEND                (1 << 23)
>>   #define MCI_ST_CARDBUSY                (1 << 24)
>>   /* Extended status bits for the STM32 variants */
>> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>>   #define MCI_STM32_BUSYD0       BIT(20)
>>
>>   #define MMCICLEAR              0x038
>> @@ -269,6 +270,7 @@ struct mmci_host;
>>    * @cmdreg_lrsp_crc: enable value for long response with crc
>>    * @cmdreg_srsp_crc: enable value for short response with crc
>>    * @cmdreg_srsp: enable value for short response without crc
>> + * @cmdreg_stop: enable value for stop and abort transmission
>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
>>    * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>>    *           is asserted (likewise for RX)
>> @@ -322,6 +324,7 @@ struct variant_data {
>>          unsigned int            cmdreg_lrsp_crc;
>>          unsigned int            cmdreg_srsp_crc;
>>          unsigned int            cmdreg_srsp;
>> +       unsigned int            cmdreg_stop;
>>          unsigned int            datalength_bits;
>>          unsigned int            fifosize;
>>          unsigned int            fifohalfsize;
>> @@ -384,6 +387,7 @@ struct mmci_host {
>>          void __iomem            *base;
>>          struct mmc_request      *mrq;
>>          struct mmc_command      *cmd;
>> +       struct mmc_command      stop_abort;
>>          struct mmc_data         *data;
>>          struct mmc_host         *mmc;
>>          struct clk              *clk;
>> --
>> 2.7.4
>>
