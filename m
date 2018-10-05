From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V5 02/24] mmc: mmci: create common mmci_dma_setup/release
Date: Fri, 5 Oct 2018 17:33:14 +0200
Message-ID: <adccdd2f-0525-67b9-35d0-718accc5a7ed@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
 <1538745782-27446-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFogS_74csmZm5_M3D-JFNn_8fi2sxcHpRwVxZOqZhndVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFogS_74csmZm5_M3D-JFNn_8fi2sxcHpRwVxZOqZhndVg@mail.gmail.com>
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
Cc: DTML <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 10/05/2018 03:47 PM, Ulf Hansson wrote:
> On 5 October 2018 at 15:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch creates a common mmci_dma_setup/release which calls
>> dma_setup/release callbacks of mmci_host_ops and manages
>> common features like use_dma... If there is a fallbacks to
>> pio mode, dma functions must check use_dma.
>>
>> error management:
>> -mmci_dmae_setup fail if Tx and Rx dma channels are not defined
>> -qcom_dma_setup fail if one of both dma channels is not defined,
>>   Qcom has no specific resource to release, just mmci dmae resource.
> 
> Makes perfect sense!
> 
> [...]
> 
>> +void mmci_dma_setup(struct mmci_host *host)
>> +{
>> +       if (!host->ops || !host->ops->dma_setup)
>> +               return;
>> +
>> +       if (host->ops->dma_setup(host)) {
>> +               mmci_dma_release(host);
> 
> Please remove this and let the variants clean up themselves. That
> makes it more straight forward.

This common call was not such a good idea.
Ok, I will back on first idea.

> 
>> +               return;
>> +       }
>> +
>> +       host->use_dma = true;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 01e6c6b..9b0a960 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -273,7 +273,8 @@ struct variant_data {
>>
>>   /* mmci variant callbacks */
>>   struct mmci_host_ops {
>> -       void (*dma_setup)(struct mmci_host *host);
>> +       int (*dma_setup)(struct mmci_host *host);
>> +       void (*dma_release)(struct mmci_host *host);
>>   };
>>
>>   struct mmci_host_next {
>> @@ -323,6 +324,7 @@ struct mmci_host {
>>          unsigned int            size;
>>          int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>>
>> +       u8                      use_dma:1;
>>   #ifdef CONFIG_DMA_ENGINE
>>          /* DMA stuff */
>>          struct dma_chan         *dma_current;
>> @@ -336,3 +338,14 @@ struct mmci_host {
>>   #endif
>>   };
>>
>> +#ifdef CONFIG_DMA_ENGINE
>> +void mmci_variant_init(struct mmci_host *host);
>> +#else
>> +static inline void mmci_variant_init(struct mmci_host *host)
>> +{
>> +}
>> +#endif
> 
> This can be kept in mmci.c instead.

OK

> 
>> +
>> +int mmci_dmae_setup(struct mmci_host *host);
>> +void mmci_dmae_release(struct mmci_host *host);
>> +
>> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
>> index be3fab5..aa070a9 100644
>> --- a/drivers/mmc/host/mmci_qcom_dml.c
>> +++ b/drivers/mmc/host/mmci_qcom_dml.c
>> @@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>>   }
>>
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>>          int consumer_id, producer_id;
>>          struct device_node *np = host->mmc->parent->of_node;
>>
>> +       if (mmci_dmae_setup(host))
>> +               return -EINVAL;
>> +
>>          consumer_id = of_get_dml_pipe_index(np, "tx");
>>          producer_id = of_get_dml_pipe_index(np, "rx");
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
>> -               return;
>> +               return -EINVAL;
> 
> This relies on error handling to be done by mmci_dma_setup(), which as
> stated, feels a bit wrong.
> 
> I would rather just call mmci_dmae_realease() here, before returning -EINVAL.

OK

> 
> [...]
> 
> Otherwise, this looks good to me now.
> 
> Kind regards
> Uffe
> 
