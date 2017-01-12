From: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v2 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Thu, 12 Jan 2017 09:53:38 +0100
Message-ID: <CAN8YU5M9hXTJ-gbBy9_-u4ruN4xVFNQZD1xrTxtVEe_ivtGiBw@mail.gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
 <1484037736-25029-9-git-send-email-andrea.merello@gmail.com>
 <a6b5bd41-894e-befb-d3c9-ae0c9119c822@st.com> <CAN8YU5Modccie5g3PTehwg0YxnBvV+C7mZa4ym2R7uW922U46g@mail.gmail.com>
 <ffcfb1f9-4057-f045-778b-99c53ed26961@st.com>
Reply-To: andrea.merello@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33266 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdALIyH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 03:54:07 -0500
Received: by mail-yb0-f193.google.com with SMTP id 123so454398ybe.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 00:53:59 -0800 (PST)
In-Reply-To: <ffcfb1f9-4057-f045-778b-99c53ed26961@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-mmc@vger.kernel.org, Bruno Herrera <bruherrera@gmail.com>

On Thu, Jan 12, 2017 at 9:34 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Andrea
>
>
> On 01/12/2017 08:25 AM, Andrea Merello wrote:
>>
>> On Tue, Jan 10, 2017 at 10:18 AM, Alexandre Torgue
>> <alexandre.torgue@st.com> wrote:
>>>
>>> Hi Andrea
>>>
>>> On 01/10/2017 09:42 AM, Andrea Merello wrote:
>>>>
>>>>
>>>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>>>
>>>
>>>
>>> Can you please add a commit message.
>>> Can you also change commit header like: "ARM: dts: stm32: enable SDIO
>>> controller on stm32f469 disco board
>>
>>
>> Sure.
>>
>>>
>>>
>>>> ---
>>>>  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
>>>>  arch/arm/boot/dts/stm32f469-disco.dts | 29
>>>> +++++++++++++++++++++++++++++
>>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>>> index c12a64e..5aba383 100644
>>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>>> @@ -206,7 +206,7 @@
>>>>                         reg = <0x40007000 0x400>;
>>>>                 };
>>>>
>>>> -               pin-controller {
>>>> +               pinctrl:pin-controller {
>>>>                         #address-cells = <1>;
>>>>                         #size-cells = <1>;
>>>>                         compatible = "st,stm32f429-pinctrl";
>>>
>>>
>>>
>>>
>>>
>>>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>>>> b/arch/arm/boot/dts/stm32f469-disco.dts
>>>> index 8877c00..7b3458e 100644
>>>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>>>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>>>> @@ -65,6 +65,13 @@
>>>>                 serial0 = &usart3;
>>>>         };
>>>>
>>>> +       mmc_vcard: mmc_vcard {
>>>> +               compatible = "regulator-fixed";
>>>> +               regulator-name = "mmc_vcard";
>>>> +               regulator-min-microvolt = <3300000>;
>>>> +               regulator-max-microvolt = <3300000>;
>>>> +       };
>>>> +
>>>>         soc {
>>>>                 dma-ranges = <0xc0000000 0x0 0x10000000>;
>>>>         };
>>>> @@ -78,6 +85,28 @@
>>>>         clock-frequency = <8000000>;
>>>>  };
>>>>
>>>> +&pinctrl {
>>>> +       sdio-cd {
>>>> +               sdio_cd: sdio-cd {
>>>> +                       pins {
>>>> +                               pinmux = <STM32F429_PG2_FUNC_GPIO>;
>>>> +                               bias-pull-up;
>>>> +                       };
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>
>>>
>>>
>>> As you only have config for 469-disco, please add this configuration of
>>> pinmux directly in stm32f429.dtsi.
>>
>>
>> I'm not sure I got your point here..
>>
>> I would say that stm32f429.dtsi should contain the HW description of
>> the MCU, and should be board-agnostic, while stm32f469-disco should
>> contain the HW description of this specific board.
>>
>> Even if we haven't this config for other boards yet, I would say this
>> is still a very board-specific stuff, unrelated to the stm MCU itself.
>> Please correct me if I'm wrong: AFAIK the CD could be routed to any
>> GPIO pin, and it is not dependant by any STM32 specific AFIO.
>
>
> For pinctrl:
> To my point of view pinmuxing defintion is SOC, because those muxing
> possibilities are offered by the SOC.
> The pinmuxing choice is board-specific.
>
> For GPIO:
> yes it stays in board file (it is not a definition but a gpio choice)
>
> I hope to be enough clear :$

Yes, now it makes more sense to me. Thanks.
Going to perform all changes you requested and post a V3. Hopefully today.

>
>>
>>>
>>>> +&sdio {
>>>> +       status = "okay";
>>>> +       vmmc-supply = <&mmc_vcard>;
>>>> +       cd-gpios = <&gpiog 2 0>;
>>>> +       cd-inverted;
>>>> +       pinctrl-names = "default", "opendrain";
>>>> +       pinctrl-0 = <&sdio_pins>;
>>>> +       pinctrl-1 = <&sdio_pins_od>;
>>>> +       bus-width = <4>;
>>>> +};
>>>> +
>>>>  &usart3 {
>>>>         status = "okay";
>>>>  };
>>>>
>>>
>
