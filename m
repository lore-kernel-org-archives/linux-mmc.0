From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
Date: Thu, 1 Mar 2018 11:44:18 +0100
Message-ID: <CAPDyKFqFWcZnWoUdnfRtj9WA1+ooNCXKfZ94Ddq4j849CH2QOQ@mail.gmail.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpfPAaLRZLqpyi6RwC1-=7Ao=u+OmEfHaYBABzd_-BKAw@mail.gmail.com> <8f328063-610f-a2e8-5f29-d3f0019384f2@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8f328063-610f-a2e8-5f29-d3f0019384f2@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 March 2018 at 10:57, Ludovic BARRE <ludovic.barre@st.com> wrote:
> Hi Ulf
>
> On 03/01/2018 10:06 AM, Ulf Hansson wrote:
>>
>> Hi Ludovic,
>>
>> On 28 February 2018 at 16:47, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch serie adds support of stm32 SDMMC controller.
>>> stm32h7 is the first SoC to use stm32 SDMMC controller
>>> (previous SoC had pl180 controller).
>>
>>
>> I am a not convinced this isn't a new improved variant of the pl180.
>> According to register layout and the code you submitted in patch2,
>> there are great similarities to pl180 and the mmci driver.
>
>
> In fact, ST designers which created stm32-sdmmc hardware block from scratch
> are the same which have done the modifications on pl180 variant (stm32
> legacy f4, f7).
> So some registers or bits name seem identical (or strongly inspirited) but
> the engine and features are different.

Well, in that case, I assume the driver would also need work
differently, but when looking at the code in patch2 this doesn't seem
to be the case.

>
> You could find the datasheet of STM32H7x3 on:
> http://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/c9/a3/76/fa/55/46/45/fa/DM00314099/files/DM00314099.pdf/jcr:content/translations/en.DM00314099.pdf
>
> Chapters: 55 Secure digital input/output MultiMediaCard interface
> (SDMMC)

Thanks for sharing this. However this confirms my view, it looks
exactly as a new improved mmci variant. :-)

>
> This hardware block has own roadmap and some features are already in the
> pipe for next SoC.

That's fine. I don't have a problem extending the mmci driver, even
several times, as to cope with new revisions.

>
> For code design: like I also worked on pl180 in the past :-)
> my code is inspirited of this driver.

Right, that may explain things a bit.

However, besides a re-name of the registers, I really think that the
code execution, dealing with IRQs etc, is very similar to the mmci
driver. Isn't it?

So, I think it's at least worth to give it a go with the mmci driver
first, to see if we can get it to work.

I guess you understand why I am pushing!? This is about maintenance -
and I really want to avoid having a yet another driver to maintain,
unless we can extend an existing one.

[...]

Kind regards
Uffe
