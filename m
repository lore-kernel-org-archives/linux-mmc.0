From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V3 2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
Date: Wed, 27 Mar 2019 09:28:39 +0100
Message-ID: <b98b0692-c052-c4e1-f525-bf7ef4dffd1d@st.com>
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
 <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org



On 3/26/19 6:46 PM, Ulf Hansson wrote:
> On Tue, 26 Mar 2019 at 10:11, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch defines get_dctrl_cfg callback for legacy variants
>> whatever DMA_ENGINE configuration.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 31 +++++++++++++++++++++++--------
>>   drivers/mmc/host/mmci.h |  3 +++
>>   2 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 9e6a2c1..4041e36 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -46,12 +46,6 @@
>>
>>   #define DRIVER_NAME "mmci-pl18x"
>>
>> -#ifdef CONFIG_DMA_ENGINE
>> -static void mmci_variant_init(struct mmci_host *host);
>> -#else
>> -static inline void mmci_variant_init(struct mmci_host *host) {}
>> -#endif
> 
> Looks like you are moving the declaration to the header file. I would
> rather keep it here as there is no point in sharing to another c-file
> (at least not yet). The same applies for the new ux500v2 init
> function.

no problem, I will resend a V4 to keep mmci and ux500v2 variant init in 
the c file.

> 
> Other than that, this looks good to me!

thanks

> 
> Kind regards
> Uffe
> 
