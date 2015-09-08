From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
Date: Tue, 8 Sep 2015 17:47:40 +0530
Message-ID: <55EED1E4.9030904@linaro.org>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150908145254.6807dffc@xhacker> <55EEABB1.8010806@linaro.org>
 <20150908175220.6b81efda@xhacker> <55EEB23A.50805@linaro.org>
 <20150908180451.4c8bd26c@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150908180451.4c8bd26c@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Kevin Liu <kliu5@marvell.com>
List-Id: linux-mmc@vger.kernel.org



On Tuesday 08 September 2015 03:34 PM, Jisheng Zhang wrote:
> On Tue, 8 Sep 2015 15:32:34 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>>
>>
>> On Tuesday 08 September 2015 03:22 PM, Jisheng Zhang wrote:
>>> On Tue, 8 Sep 2015 15:04:41 +0530
>>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>>>

<snip>

>>>>>>     static const struct sdhci_ops pxav3_sdhci_ops = {
>>>>>> @@ -586,6 +619,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>>>>>     		}
>>>>>>     	}
>>>>>>
>>>>>> +	pxa->pinctrl = devm_pinctrl_get(dev);
>>>>>
>>>>> could we ignore this for those SDHCI hosts that don't need it?
>>>>>
>>>>
>>>> Again, no need to introduce flags here. This is standard call and
>>>> handled properly. So for the platforms not using this, it really should
>>>> not matter.
>>>> Also, lookup is getting executed only when pinctrl is populated.
>>>>
>>>> So I do not see any need here.
>>>>
>>>>>> +	if (!IS_ERR(pxa->pinctrl)) {
>>>>>> +		pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
>>>>>> +		if (IS_ERR(pxa->pins_default))
>>>>>> +			dev_err(dev, "could not get default pinstate\n");
>>>>>
>>>>> Why those SDHCI hosts that don't need pinctl setting should got this error?
>>>>>
>>>>
>>>> It won't.
>>>
>>> It does. On Marvell Berlin SoCs, I got
>>>
>>> [    1.070000] sdhci-pxav3 f7ab0800.sdhci: could not get default pinstate
>>> [    1.080000] sdhci-pxav3 f7ab0800.sdhci: could not get fast pinstate
>>>
>>>
>>>
>>>>
>>>> If Host does not need pinctrl, the execution would never reach this
>>>> point.
>>>> The if condition check would handle it, isn't it?
>>>>
>>>> 	pxa->pinctrl = devm_pinctrl_get(dev);
>>>
>>> It seems this function always succeed...
>>>
>>
>> Not always.
>> I would succeed only if you have pinctrl defined in DT for this device.
>
> Yes, that's what I thought, but I got
>
> [    1.070000] sdhci-pxav3 f7ab0800.sdhci: could not get default pinstate
> [    1.080000] sdhci-pxav3 f7ab0800.sdhci: could not get fast pinstate
>
> there's no pinctrl for f7ab0800.sdhci. Am I missing somthing?
>
> Thanks,
> Jisheng
>
>>
>> And if you have pinctrl defined, isn't it is expected to have "default"
>> pin state to be always present?
>> And if answer is yes here, then it is fair to be prompting error for it.
>>
>>>   From another side, we may have default pin in dts, for example: pin muxed between
>>> emmc and nandflash. But we don't have fast pinstate, so we at least need the
>>> flag to fast pinstate. Otherwise, in such platforms, we could get something like
>>>
>>
>> That is exactly the reason behind keeping it as dev_info.
>>
>>> [    1.000000] sdhci-pxav3 f7ab0000.sdhci: get default pinstate
>>> [    1.000000] sdhci-pxav3 f7ab0000.sdhci: could not get fast pinstate
>>>
>>>

I did some invastigation here on the execution flow,
and you know what, you are right here.

It seems, devm_pinctrl_get() always returns valid pinctrl pointer, even
though the DT property is not populated.

The return value from I did some invastigation () should have been 
treated differently, but it is not. Instead it creates the
"struct pinctrl" and return back to the driver.

I am looping Linus Walleji here, probably he can comment/confirm on
this.


Thanks,
Vaibhav


>> Thanks,
>> Vaibhav
>
