From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 27/27] mmc: mmci: add stm32 sdmmc variant
Date: Mon, 1 Oct 2018 15:53:21 +0200
Message-ID: <9e64085d-c137-6117-644d-78f796210277@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-28-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqGY2o7TcUVW9bCZM9-4xtyJJ4PaCtWWQvV3VMd+cK99A@mail.gmail.com>
 <50222b8d-3b53-acea-7935-092fa149d54c@st.com>
 <CAPDyKFr45FF-wbhT7C=+G5ptbCMRiKie304UM9P2vRypKd=PvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr45FF-wbhT7C=+G5ptbCMRiKie304UM9P2vRypKd=PvQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org



On 10/01/2018 03:39 PM, Ulf Hansson wrote:
> [...]
> 
>>>>    struct variant_data {
>>>>           unsigned int            clkreg;
>>>> @@ -348,6 +350,8 @@ struct variant_data {
>>>>           unsigned int            irq_pio_mask;
>>>>           u32                     start_err;
>>>>           u32                     opendrain;
>>>> +       bool                    dma_lli;
>>>> +       u32                     stm32_idmabsize_mask;
>>>
>>>
>>> What are these?
>>
>>
>> This property is specific for sdmmc variants:
>> sdmmc has a Internal DMA and the number bytes per buffer
>> could be different between sdmmc variants
>> (depend of SDMMC_IDMABSIZER register).
> 
> Okay. Thanks for clarifying.
> 
> Could you please add some information about this in the changelog as well?

OK

> 
> [...]
> 
>>>> +
>>>> +static int _sdmmc_idma_prep_data(struct mmci_host *host,
>>>> +                                struct mmc_data *data)
>>>> +{
>>>> +       int n_elem;
>>>> +
>>>> +       n_elem = dma_map_sg(mmc_dev(host->mmc),
>>>> +                           data->sg,
>>>> +                           data->sg_len,
>>>> +                           mmc_get_dma_dir(data));
>>>> +
>>>> +       if (!n_elem) {
>>>> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int sdmmc_idma_prep_data(struct mmci_host *host,
>>>> +                               struct mmc_data *data, bool next)
>>>> +{
>>>> +       /* Check if job is already prepared. */
>>>> +       if (!next && data->host_cookie == host->next_cookie)
>>>> +               return 0;
>>>> +
>>>> +       return _sdmmc_idma_prep_data(host, data);
>>>> +}
>>>> +
>>>> +static void sdmmc_idma_unprep_data(struct mmci_host *host,
>>>> +                                  struct mmc_data *data, int err)
>>>> +{
>>>> +       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>>>> +                    mmc_get_dma_dir(data));
>>>> +}
>>>
>>>
>>> The sdmmc_idma_prep_data() and sdmmc_idma_unprep_data(), seems very
>>> similar to what the mmci core driver needs to do in this regards.
>>>
>>> Can we perhaps avoid adding these callbacks altogether, but rather
>>> rely on common code in the mmci core driver?
>>
>>
>> Actually, these callbacks allow to manage prepare/unprepare of
>> dmaengine interface for mmci variant, (not needed for sdmmc which uses an
>> internal dma).
>>
>> For Sdmmc, today there are no special case, just dma_map/unmap.
>> But in the future, I hope manage the lli list in these callback.
>>
>> Only dma_map/unmap could be common, but the error management may
>> be complicated (in mmci variant).
>>
>> Personally, I prefer keep prep_data/unprep_data mmci_host_ops
>> interfaces.
>> What do you suggest ?
> 
> Okay, let's keep them for now. We can always change things on top, in
> case we see later that those callbacks can be removed.

Okay, that make sense.

> 
> [...]
> 
> Kind regards
> Uffe
> 
