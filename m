From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Fri, 3 May 2019 17:15:03 +0200
Message-ID: <bccca4e0-849d-2589-c144-296cc273245d@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
 <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
 <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

On 5/3/19 3:29 PM, Ulf Hansson wrote:
> On Tue, 30 Apr 2019 at 14:06, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>>
>> On 4/30/19 1:13 PM, Ulf Hansson wrote:
>>> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch series adds busy detect for stm32 sdmmc variant.
>>>> Some adaptations are required:
>>>> -Avoid to check and poll busy status when is not expected.
>>>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>>>    different.
>>>> -Add hardware busy timeout with MMCIDATATIMER register.
>>>>
>>>> V2:
>>>> -mmci_cmd_irq cleanup in separate patch.
>>>> -simplify the busy_detect_flag exclude
>>>> -replace sdmmc specific comment in
>>>> "mmc: mmci: avoid fake busy polling in mmci_irq"
>>>> to focus on common behavior
>>>>
>>>> Ludovic Barre (5):
>>>>     mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>>>>     mmc: mmci: avoid fake busy polling in mmci_irq
>>>>     mmc: mmci: fix clear of busy detect status
>>>>     mmc: mmci: add hardware busy timeout feature
>>>>     mmc: mmci: add busy detect for stm32 sdmmc variant
>>>>
>>>>    drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>>>>    drivers/mmc/host/mmci.h |  3 +++
>>>>    2 files changed, 51 insertions(+), 13 deletions(-)
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> Ludovic, just wanted to let you know that I am reviewing and testing
>>> this series.
>>>
>>> However, while running some tests on Ux500 for validating the busy
>>> detection code, even without your series applied, I encounter some odd
>>> behaviors. I am looking into the problem to understand better and will
>>> let you know as soon as I have some more data to share.
>>
>> Oops, don't hesitate to share your status, if I could help.
> 
> Thanks! Good and bad news here, then.
> 
> I now understand what is going on - and there is certainly room for
> improvements here, but more importantly the actual mmci busy detection
> works as expected.
> 
> When it comes to improvements, the main issue I have found is how we
> treat DATA WRITES. In many cases we simply don't use the HW busy
> detection at all, but instead rely on the mmc core to send CMD13 in a
> loop to poll. Well, then if the polling would have consisted of a
> couple of CMD13s that wouldn't be an issue, but my observations is
> rather that the numbers of CMD13 sent to poll is in the range or
> hundreds/thousands - per each WRITE request!
> 
> I am going to send a patch (or two) that improves the behavior. It
> might even involve changing parts in core layer, not sure how the end
> result will look like yet.

yes, these will improve the drivers without hardware busy completion.
great

> 
> In any case, I have applied patch 1 and patch2 for next, as the tests
> turned out well at my side. I also took the liberty of updating some
> of the comments/changelogs, please have look and tell if there is
> something you want to change.
> 
> I will continue with the rest of series next week.

thanks, and good week-end.

> 
> Kind regards
> Uffe
> 
