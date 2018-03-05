From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
Date: Mon, 5 Mar 2018 13:53:25 +0100
Message-ID: <CAPDyKFopp6aSXO0vguWah44vBqfvuRvFHUSNbynjFE8NFPnNRA@mail.gmail.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpfPAaLRZLqpyi6RwC1-=7Ao=u+OmEfHaYBABzd_-BKAw@mail.gmail.com>
 <8f328063-610f-a2e8-5f29-d3f0019384f2@st.com> <CAPDyKFqFWcZnWoUdnfRtj9WA1+ooNCXKfZ94Ddq4j849CH2QOQ@mail.gmail.com>
 <cbdd31d8-dbea-4ea3-01ba-443daeb51775@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cbdd31d8-dbea-4ea3-01ba-443daeb51775@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 2 March 2018 at 09:51, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 03/01/2018 11:44 AM, Ulf Hansson wrote:
>>
>> On 1 March 2018 at 10:57, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>>
>>> Hi Ulf
>>>
>>> On 03/01/2018 10:06 AM, Ulf Hansson wrote:
>>>>
>>>>
>>>> Hi Ludovic,
>>>>
>>>> On 28 February 2018 at 16:47, Ludovic Barre <ludovic.Barre@st.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>
>>>>> This patch serie adds support of stm32 SDMMC controller.
>>>>> stm32h7 is the first SoC to use stm32 SDMMC controller
>>>>> (previous SoC had pl180 controller).
>>>>
>>>>
>>>>
>>>> I am a not convinced this isn't a new improved variant of the pl180.
>>>> According to register layout and the code you submitted in patch2,
>>>> there are great similarities to pl180 and the mmci driver.
>>>
>>>
>>>
>>> In fact, ST designers which created stm32-sdmmc hardware block from
>>> scratch
>>> are the same which have done the modifications on pl180 variant (stm32
>>> legacy f4, f7).
>>> So some registers or bits name seem identical (or strongly inspirited)
>>> but
>>> the engine and features are different.
>>
>>
>> Well, in that case, I assume the driver would also need work
>> differently, but when looking at the code in patch2 this doesn't seem
>> to be the case.
>>
>
> I understand why you push to avoid drivers multiplication. But I'm
> scared to squash 2 different hardware block which are their own roadmap
> in the same drivers. I fear that it complicates the features management and
> maintenance of this driver.

It may require more work for you to upstream the code you need. You
may even have to re-factor existing code in mmci before you can add
your specific parts on top.

However, whether it gets complicated or not, I think much depends on
the quality of the code changes we make. Both sdhci and dw_mmc gives
an idea of how we can deal with variant differences, in particular
when variant changes are a bit bigger.

In the mmci case, so far the controller that differs the most, is the
qcom variant, which also has the built-in DMA support, similar to your
new ST variant. Perhaps there is some code we can re-use around that.

>
> there are some difference:
> -the stm32-sdmmc use an internal dma (stm32-sdmmc is master on the bus),
> -idma alignment constraint.
> -idma transfer mode single buffer, double buffer... (future evolution)
> -need a command to stop transmission for data state machine
> -same bit naming could have offset, mask width or set in different register.
> => I will try to synthesis register difference in a document
> -voltage switch sequence
> -delay block: calibration, tunning (sdr104)
> -reset line required
> -the same feature have not the same impact, example ddr mode
> stm32:no bypass clk, activated in clk register
> pl180: clkreg_neg_edge_enable, activated in datactrl register,

Doesn't sound like this couldn't be done, yes there are differences
but not that much.

Sure we may need re-work the core driver mmci code, maybe convert it
to set of library function instead and invent a couple mmci specific
callbacks. As I said, sdhci and dw_mmc already does it, so I am sure
it can be done.

> ...
>
> stm32-sdmmc is just at begining of its life cycle. Each revision of this
> block increases the difference with pl180. Today, I've just push the minimal

That's fine, this happens all the time to sdhci and dw_mmc variants.
Again, if it works for them, it should work for mmci.

> driver to start a request, but I've not yet send all features of this
> revision like sdio, sdr104 support. After this revision there already are 2
> other revisions in the pipe (at short term).
>
> I am Out of Office with limited access to my e-mail till 2018 march 12th
> I'll try to think about it on ski slope. euh, in fact no just ski and enjoy
> ;-)

Enjoy you skiing and let's talk more when you get back!

[...]

Kind regards
Uffe
