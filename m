From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Thu, 24 Mar 2016 16:34:59 +0200
Message-ID: <56F3FB13.9040505@intel.com>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
 <20160324155840.50474b98@xhacker> <56F3A0B7.4050509@samsung.com>
 <20160324162449.29c9cf78@xhacker> <56F3A88F.50603@samsung.com>
 <56F3E77D.7030201@intel.com> <20160324140307.GH12245@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160324140307.GH12245@odux.rfo.atmel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24/03/16 16:03, Ludovic Desroches wrote:
> Hi,
> 
> On Thu, Mar 24, 2016 at 03:11:25PM +0200, Adrian Hunter wrote:
>> On 24/03/16 10:42, Krzysztof Kozlowski wrote:
>>> On 24.03.2016 17:24, Jisheng Zhang wrote:
>>>> Hi,
>>>>
>>>> On Thu, 24 Mar 2016 17:09:27 +0900 Jaehoon Chung wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On 03/24/2016 04:58 PM, Jisheng Zhang wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, 24 Mar 2016 16:28:56 +0900 Krzysztof Kozlowski wrote:
>>>>>>   
>>>>>>> Hi,
>>>>>>>
>>>>>>> After 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD via
>>>>>>> external regulator") On Trats2 board I see warnings for invalid VDD
>>>>>>> value (2.8V):
>>>>>>>
>>>>>>> [    3.119656] ------------[ cut here ]------------
>>>>>>> [    3.119666] WARNING: CPU: 3 PID: 90 at
>>>>>>> ../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
>>>>>>> [    3.119669] mmc0: Invalid vdd 0x10  
>>>>>>
>>>>>> Per my understanding, the wrong vdd indicates a wrong ocr, what's the voltage of
>>>>>> this host's vmmc regulator?  
>>>>>
>>>>> As i know, it's fixed-voltage with gpio on trats2. It's 2.8V.
>>>>> I didn't check this entirely..need to check ocr value.
>>>>>
>>>>
>>>> I may know the reason. the vmmc is 2.8v, then mmc_regulator_get_supply() convert
>>>> the value to a ocr as 0x10. The key here is that the 2.8v is invalid in SDHCI
>>>> case and isn't accepted by current sdhci driver.
>>>
>>> Yeah, I already wrote that. It is the part of the warning and my email.
>>> Our regulator is fixed at 2.8 which is 0x10. :)
>>>
>>>> I dunno the elegant solution to handle this case, let's wait for sdhci maintainers
>>>> idea.
>>>
>>> Hmm...
>>
>> I haven't tested it, but what about this:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Thu, 24 Mar 2016 14:29:24 +0200
>> Subject: [PATCH] mmc: sdhci: Fix regression setting power on Trats2 board
>>
>> Several commits relating to setting power have been introducing
>> problems by putting driver-specific rules into generic SDHCI code.
>>
> 
> I remember that I have acked this patch and I still believe it is not
> driver-specific code.

It depends how you look at it.  I decided that since the previous code had
been there for a while (since 3.19), it should stay the default.

I agree you could look at it differently.

> 
> Without this patch, if a regulator is used, we set this regulator and we
> write SDHCI_POWER_ON to SDHCI_POWER_CONTROL so 0x01. In the
> specification, it is said:
> 'If an unsupported voltage is selected, the Host System shall not supply
> SD Bus voltage'.
> Valid voltage are 111b for 3.3V, 110b for 3.0V and 101b for 1.8V. 0 is
> seen as an invalid voltage.

Again, it depends how you look at it.  From my point of view, the
specification doesn't cover external regulators so you can't expect to know
what to put in the power control register.

> 
> If the controller strictly applies the specification then it won't perform
> the power on request. It's what happens with sdhci-pxav3 and
> sdhci-of-at91.

So if I make the same change to sdhci-of-at91 as sdhci-pxav3, it will work
for you?

> 
> I don't care if the patch is reverted because I no more describe
> the regulators but I think the behavior with Jisheng's patch is the right
> one. Maybe more cases should be managed in the switch statement as
> suggested by Tobias.

But always the possibility it won't work for some driver.

> 
> 
>> Fix by adding a 'set_power' callback and restoring the default
>> behaviour prior to commit 918f4cbd4340.  The desired behaviour
>> of commit 918f4cbd4340 is gotten by having sdhci-pxav3 provide
>> its own set_power callback.
>>
> 
> Adding callbacks is the only way to solve all these quirks or
> interpretations of the specification.
> 

At least it means we can go forward.
