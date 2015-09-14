From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for
 all other voltages
Date: Mon, 14 Sep 2015 18:17:03 +0530
Message-ID: <55F6C1C7.8030107@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150902150442.118d3305@xhacker> <55E6B129.1030002@linaro.org>
 <20150902162627.682cdedf@xhacker> <55E6E0FD.7000806@linaro.org>
 <CAPDyKFqOGsKXTCOG89Kq=F6VsDpyfnpwo+jNb+6otgPUFE_bzw@mail.gmail.com>
 <55F6969D.7090004@linaro.org>
 <CAPDyKFrpDPaCLNEdwP7vYM4CJfxyz-zwC8+9AJMcUG+O=GCBOA@mail.gmail.com>
 <55F6C080.8000604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55F6C080.8000604@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On Monday 14 September 2015 06:11 PM, Vaibhav Hiremath wrote:
>
>
> On Monday 14 September 2015 04:04 PM, Ulf Hansson wrote:
>> On 14 September 2015 at 11:42, Vaibhav Hiremath
>> <vaibhav.hiremath@linaro.org> wrote:
>>>
>>>
>>> On Monday 14 September 2015 03:00 PM, Ulf Hansson wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>>
>>>>>>>> Could this be implemented by regulator API? From patch set 3/3, the
>>>>>>>> pxa1928
>>>>>>>> voltage_switch hook is to operate the IO pad registers, this
>>>>>>>> seems not
>>>>>>>> belong
>>>>>>>> to the SDHC IP core.
>>>>>>>>
>>>>>>>
>>>>>>> Not quite sure whether regulator would be right fit for this.
>>>>>>
>>>>>>
>>>>>>
>>>>>>    From the patche[3/3], this can be achieved by abstracting the
>>>>>> IO PAD
>>>>>> as
>>>>>> regulators
>>>>>> then, we may not need to touch the core sdhci.c. But I'm not sure
>>>>>> whether
>>>>>> this
>>>>>> is the good solution or not.
>>>>>
>>>>>
>>>>>
>>>>> Exactly...
>>>>>
>>>>>> sdhci Maintainers and experts may have better
>>>>>> suggestions.
>>>>>>
>>>>>
>>>>> Thats is the reason I stamped it as a RFC :)
>>>>>
>>>>
>>>> [...]
>>>>
>>>>   From an mmc core perspective it would be preferred if you implement
>>>> this as a regulator (vqmmc).
>>>>
>>>> Especially since we will soon have an API for how to set the I/O
>>>> voltages - and the intelligence within that API is not something we
>>>> would like to implement for each and every host driver.
>>>> https://lkml.org/lkml/2015/8/31/367
>>>>
>>>
>>>
>>> I would still consider this as a regulator specific and may not address
>>> the IO configuration within the SoC which are module specific.
>>> The API regulator_set_voltage_triplet() will not have intelligence to
>>> differentiate whether the call is coming from MMC or somewhere else.
>>>
>>> Note that, the IO pad voltage configuration which I am referring to is
>>> MMC specific and applicable only when pad is configured in MMC mode. So
>>> technically it is not simply common pad voltage configuration.
>>>
>>>
>>> And I am still not sure regulator framework would be right fit for
>>> this. Pinctrl would have been right fit, but...since I saw f_sdh30
>>> driver is already doing this, which is easy fit; so adopted the same.
>>
>> Pinctrl would work as well, or perhaps a combination of both pinctrl
>> and a regulator.
>
>
> Not sure, how I can propagate "call coming from MMC/SD" to both
> regulator and pinctrl.
> Probably pinctrl would already know, but then it doesn't know the
> voltage settings.
>
> Let me spend some time, but atleast at this point I am not sure.
>
>>

On the side note,
Lets park this patch aside, till I get back with better option.

It would be nice if you could review other patches, let them notget
blocked due to this.


Thanks,
Vaibhav
