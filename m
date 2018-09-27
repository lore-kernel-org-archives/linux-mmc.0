From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
Date: Thu, 27 Sep 2018 09:55:05 +0100
Message-ID: <55622e1c-190f-6903-ab04-16089264f277@linaro.org>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

Thanks for looping me!

On 24/09/18 15:28, Ulf Hansson wrote:
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
> It seems like the existing code is an attempt to fallback to use pio
> mode. However, I doubt it works as is.

If I remember it correctly, Yes, that was the intent. we should still be 
able to use the pio mode if the dma setup fails.

I believe pio mode should work, Last time when I tried (3-4 years back) 
it did work!

> 
>> -               return;
>> +               return -EINVAL;
> My point is, if you return an error code here, it means that the error
> code becomes propagated and ->probe() will fail.
That would be very bad!, We should report it and may be just continue 
with pio mode.

> 
> Ideally, we should be able fall back to pio mode when dma doesn't
> work. I have looped in Srinivas who implemented the qcom dml support,
> let's see if he can explains the intent with the code.
> 
> I also volunteer to help out running some tests on the 410c platform,
I think you meant IFC6410.. DB410c uses sdhci.


--srini
> however allow me a day or two to do that.
> 
