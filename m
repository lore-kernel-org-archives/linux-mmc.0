From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Fri, 13 Jan 2017 16:52:36 +0100
Message-ID: <c740a266-723a-a07e-b94d-c10df0107697@st.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
 <1484037736-25029-9-git-send-email-andrea.merello@gmail.com>
 <a6b5bd41-894e-befb-d3c9-ae0c9119c822@st.com>
 <CAN8YU5Neg3i_HKgAMmYAi8juDc7YunmVst-u0EE7_aMO4qDxuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34891 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751955AbdAMPwm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 10:52:42 -0500
In-Reply-To: <CAN8YU5Neg3i_HKgAMmYAi8juDc7YunmVst-u0EE7_aMO4qDxuA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: andrea.merello@gmail.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-mmc@vger.kernel.org, Bruno Herrera <bruherrera@gmail.com>

Hi Andrea

On 01/13/2017 04:01 PM, Andrea Merello wrote:
> On Tue, Jan 10, 2017 at 10:18 AM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> Hi Andrea
>>
>> On 01/10/2017 09:42 AM, Andrea Merello wrote:
>>>
>>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>>
>>
>> Can you please add a commit message.
>> Can you also change commit header like: "ARM: dts: stm32: enable SDIO
>> controller on stm32f469 disco board
>>
>>
>>
>>> ---
>>>  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
>>>  arch/arm/boot/dts/stm32f469-disco.dts | 29 +++++++++++++++++++++++++++++
>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>> index c12a64e..5aba383 100644
>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>> @@ -206,7 +206,7 @@
>>>                         reg = <0x40007000 0x400>;
>>>                 };
>>>
>>> -               pin-controller {
>>> +               pinctrl:pin-controller {
>>>                         #address-cells = <1>;
>>>                         #size-cells = <1>;
>>>                         compatible = "st,stm32f429-pinctrl";
>>
>>
>>
>>
>>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>>> b/arch/arm/boot/dts/stm32f469-disco.dts
>>> index 8877c00..7b3458e 100644
>>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>>> @@ -65,6 +65,13 @@
>>>                 serial0 = &usart3;
>>>         };
>>>
>>> +       mmc_vcard: mmc_vcard {
>>> +               compatible = "regulator-fixed";
>>> +               regulator-name = "mmc_vcard";
>>> +               regulator-min-microvolt = <3300000>;
>>> +               regulator-max-microvolt = <3300000>;
>>> +       };
>>> +
>>>         soc {
>>>                 dma-ranges = <0xc0000000 0x0 0x10000000>;
>>>         };
>>> @@ -78,6 +85,28 @@
>>>         clock-frequency = <8000000>;
>>>  };
>>>
>>> +&pinctrl {
>>> +       sdio-cd {
>>> +               sdio_cd: sdio-cd {
>>> +                       pins {
>>> +                               pinmux = <STM32F429_PG2_FUNC_GPIO>;
>>> +                               bias-pull-up;
>>> +                       };
>>> +               };
>>> +       };
>>> +};
>>> +
>>
>>
>> As you only have config for 469-disco, please add this configuration of
>> pinmux directly in stm32f429.dtsi.
>
> While in the process of moving this, I realized that there is
> something wrong here..
>
> Currently this pinmux config ended up to be not referenced by the SDIO
> DT node at all. This happened in V2; it was intended to fix an
> apparently double-claimed GPIO problem, but now I realized that I
> misunderstood this thing, and it was a bad fix..
>
> So, actually the SD works, but as soon as I reference the CD pinmux
> config in the SDIO node, it fails with the following error:
>
> [    0.980000] stm32f429-pinctrl soc:pin-controller: pin PG2 already
> requested by 40012c00.sdio; cannot claim for GPIOG:98
> [    0.990000] stm32f429-pinctrl soc:pin-controller: pin-98 (GPIOG:98)
> status -22
> [    1.000000] mmci-pl18x: probe of 40012c00.sdio failed with error -22
>
> I've bisected this to happen since the 'strict' flag has been added to
> the stm32 pinctrl driver.
> commit c32c22eea0c47e13cffd6b5f7eedd7a6b6f2c18f
>
> Right now It seems that few pinctrl drivers use the 'strict' flag, so
> maybe it could be a bug in pinctrl-realated code.

It is not a bug but added intentionally.

>
> I need to look more in detail about this, however as far as I could understand:
>
> - when the mmc layer asks for the CD pin, due to the "cd-gpios"
> property,  the owner name for this config request is not the one from
> the OF node, but it is "conjured" - as written in comment - from the
> GPIO number and name (GPIOG:98) in pinmux_request_gpio()
>
> - the pinmux config done in behalf of the 'pinctrl-0' property has the
> OF node name (40012c00.sdio) as owner.
>

I will look at deeper in the driver but first why you need to control 
this pin by both way (gpio lib through gpio definition and pinctrl 
framework through pinctrl definition) ?

In strict mode the error you get is "normal". You can't control the same 
pin in the same time by gpiolib and pinctrl.


> This owner mismatch causes a check to fail in pin_request(), that
> believes that two different owners try to use the same pin (while in
> true both are in behalf of the same SDIO device).
>
> I don't know when I'll have more time to look into this. If you want I
> can temporary drop the CD pinmux config and post the V3 - that
> nevertheless works - and we can add the CD pinmux cfg later, once it
> has been fixed.
>
> In someone have clues, or want to look into this, he/she would be
> really welcome :)

No problem, we can wait. Let's merge it when it will be fully functional.

Br
Alex

>
>>
>>
>>> +&sdio {
>>> +       status = "okay";
>>> +       vmmc-supply = <&mmc_vcard>;
>>> +       cd-gpios = <&gpiog 2 0>;
>>> +       cd-inverted;
>>> +       pinctrl-names = "default", "opendrain";
>>> +       pinctrl-0 = <&sdio_pins>;
>>> +       pinctrl-1 = <&sdio_pins_od>;
>>> +       bus-width = <4>;
>>> +};
>>> +
>>>  &usart3 {
>>>         status = "okay";
>>>  };
>>>
>>
