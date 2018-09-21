From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 02/27] mmc: mmci: internalize dma_inprogress into mmci
 dma functions
Date: Fri, 21 Sep 2018 09:42:24 +0200
Message-ID: <4a1ab21e-0c0c-8d93-fd9d-1662a2fa642c@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
 <1537268144-21152-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFrwiQv-EFfSrY7TwxXN-AnOsbbPop88GPo8_32hcjBzsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrwiQv-EFfSrY7TwxXN-AnOsbbPop88GPo8_32hcjBzsg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org



On 09/20/2018 07:56 PM, Ulf Hansson wrote:
> On 18 September 2018 at 12:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch internalizes the dma_inprogress into mmci dma interfaces.
>> This allows to simplify and prepare the next dma callbacks
>> for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
>> and mmci_dma_finalize.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 16 ++++++++++------
>>   drivers/mmc/host/mmci.h |  4 +---
>>   2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index bf0bb07..7d22cb9 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>>
>>   static void mmci_dma_data_error(struct mmci_host *host)
>>   {
>> +       if (!__dma_inprogress(host))
>> +               return;
>> +
>>          dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>>          dmaengine_terminate_all(host->dma_current);
>>          host->dma_in_progress = false;
>> @@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>>          u32 status;
>>          int i;
>>
>> +       if (!__dma_inprogress(dmae))
>> +               return;
>> +
>>          /* Wait up to 1ms for the DMA to complete */
>>          for (i = 0; ; i++) {
>>                  status = readl(host->base + MMCISTATUS);
>> @@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                  u32 remain, success;
>>
>>                  /* Terminate the DMA transfer */
>> -               if (dma_inprogress(host))
>> -                       mmci_dma_data_error(host);
>> +               mmci_dma_data_error(host);
>>
>>                  /*
>>                   * Calculate how far we are into the transfer.  Note that
>> @@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                  dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>>
>>          if (status & MCI_DATAEND || data->error) {
>> -               if (dma_inprogress(host))
>> -                       mmci_dma_finalize(host, data);
>> +               mmci_dma_finalize(host, data);
>> +
>>                  mmci_stop_data(host);
>>
>>                  if (!data->error)
>> @@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          if ((!sbc && !cmd->data) || cmd->error) {
>>                  if (host->data) {
>>                          /* Terminate the DMA transfer */
>> -                       if (dma_inprogress(host))
>> -                               mmci_dma_data_error(host);
>> +                       mmci_dma_data_error(host);
>>
>>                          mmci_stop_data(host);
>>                  }
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 696a066..f1ec066 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -332,9 +332,7 @@ struct mmci_host {
>>          struct mmci_host_next   next_data;
>>          bool                    dma_in_progress;
>>
>> -#define dma_inprogress(host)   ((host)->dma_in_progress)
>> -#else
>> -#define dma_inprogress(host)   (0)
>> +#define __dma_inprogress(host) ((host)->dma_in_progress)
> 
> Overall the change makes good sense to me, however I don't get why you
> want to rename the macro-function. Please don't.

Oops it's a mistake, I forgot this patch (I remove this)  .
I wait the end of review and will resend.

like you proposed in previous review this macros is renamed with
mmci_dmae_inprogress (in patch 04/14) to has common prefix with 
structure mmci_dmae_priv, mmci_dmae_next...

> 
>>   #endif
>>   };
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
