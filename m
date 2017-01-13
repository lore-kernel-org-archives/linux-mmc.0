From: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v2 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Fri, 13 Jan 2017 19:40:23 +0100
Message-ID: <CAN8YU5PjsNYTP_6qzX3i_OnqQTL0oVa7xs5uEDL25E32sHraVw@mail.gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
 <1484037736-25029-9-git-send-email-andrea.merello@gmail.com>
 <a6b5bd41-894e-befb-d3c9-ae0c9119c822@st.com> <CAN8YU5Neg3i_HKgAMmYAi8juDc7YunmVst-u0EE7_aMO4qDxuA@mail.gmail.com>
 <c740a266-723a-a07e-b94d-c10df0107697@st.com> <CAN8YU5M66Jn7XT9oC-x3mTMbfEq4V0fcsAX06arm6jBHk=KK5Q@mail.gmail.com>
 <406b3d9a-05be-82be-d885-cc35145b226d@st.com>
Reply-To: andrea.merello@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35564 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAMSkp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 13:40:45 -0500
Received: by mail-yw0-f194.google.com with SMTP id 17so4346948ywk.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 10:40:45 -0800 (PST)
In-Reply-To: <406b3d9a-05be-82be-d885-cc35145b226d@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-mmc@vger.kernel.org, Bruno Herrera <bruherrera@gmail.com>

On Fri, Jan 13, 2017 at 5:28 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
>
> On 01/13/2017 05:12 PM, Andrea Merello wrote:
>>
>> On Fri, Jan 13, 2017 at 4:52 PM, Alexandre Torgue
>> <alexandre.torgue@st.com> wrote:
>>>
>>> Hi Andrea
>>>
>>>
>>> On 01/13/2017 04:01 PM, Andrea Merello wrote:
>>>>
>>>>
>>>> On Tue, Jan 10, 2017 at 10:18 AM, Alexandre Torgue
>>>> <alexandre.torgue@st.com> wrote:
>>>>>
>>>>>
>>>>> Hi Andrea
>>>>>
>>>>> On 01/10/2017 09:42 AM, Andrea Merello wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Can you please add a commit message.
>>>>> Can you also change commit header like: "ARM: dts: stm32: enable SDIO
>>>>> controller on stm32f469 disco board
>>>>>
>>>>>
>>>>>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
>>>>>>  arch/arm/boot/dts/stm32f469-disco.dts | 29
>>>>>> +++++++++++++++++++++++++++++
>>>>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>> index c12a64e..5aba383 100644
>>>>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>> @@ -206,7 +206,7 @@
>>>>>>                         reg = <0x40007000 0x400>;
>>>>>>                 };
>>>>>>
>>>>>> -               pin-controller {
>>>>>> +               pinctrl:pin-controller {
>>>>>>                         #address-cells = <1>;
>>>>>>                         #size-cells = <1>;
>>>>>>                         compatible = "st,stm32f429-pinctrl";
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>> b/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>> index 8877c00..7b3458e 100644
>>>>>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>> @@ -65,6 +65,13 @@
>>>>>>                 serial0 = &usart3;
>>>>>>         };
>>>>>>
>>>>>> +       mmc_vcard: mmc_vcard {
>>>>>> +               compatible = "regulator-fixed";
>>>>>> +               regulator-name = "mmc_vcard";
>>>>>> +               regulator-min-microvolt = <3300000>;
>>>>>> +               regulator-max-microvolt = <3300000>;
>>>>>> +       };
>>>>>> +
>>>>>>         soc {
>>>>>>                 dma-ranges = <0xc0000000 0x0 0x10000000>;
>>>>>>         };
>>>>>> @@ -78,6 +85,28 @@
>>>>>>         clock-frequency = <8000000>;
>>>>>>  };
>>>>>>
>>>>>> +&pinctrl {
>>>>>> +       sdio-cd {
>>>>>> +               sdio_cd: sdio-cd {
>>>>>> +                       pins {
>>>>>> +                               pinmux = <STM32F429_PG2_FUNC_GPIO>;
>>>>>> +                               bias-pull-up;
>>>>>> +                       };
>>>>>> +               };
>>>>>> +       };
>>>>>> +};
>>>>>> +
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> As you only have config for 469-disco, please add this configuration of
>>>>> pinmux directly in stm32f429.dtsi.
>>>>
>>>>
>>>>
>>>> While in the process of moving this, I realized that there is
>>>> something wrong here..
>>>>
>>>> Currently this pinmux config ended up to be not referenced by the SDIO
>>>> DT node at all. This happened in V2; it was intended to fix an
>>>> apparently double-claimed GPIO problem, but now I realized that I
>>>> misunderstood this thing, and it was a bad fix..
>>>>
>>>> So, actually the SD works, but as soon as I reference the CD pinmux
>>>> config in the SDIO node, it fails with the following error:
>>>>
>>>> [    0.980000] stm32f429-pinctrl soc:pin-controller: pin PG2 already
>>>> requested by 40012c00.sdio; cannot claim for GPIOG:98
>>>> [    0.990000] stm32f429-pinctrl soc:pin-controller: pin-98 (GPIOG:98)
>>>> status -22
>>>> [    1.000000] mmci-pl18x: probe of 40012c00.sdio failed with error -22
>>>>
>>>> I've bisected this to happen since the 'strict' flag has been added to
>>>> the stm32 pinctrl driver.
>>>> commit c32c22eea0c47e13cffd6b5f7eedd7a6b6f2c18f
>>>>
>>>> Right now It seems that few pinctrl drivers use the 'strict' flag, so
>>>> maybe it could be a bug in pinctrl-realated code.
>>>
>>>
>>>
>>> It is not a bug but added intentionally.
>>>
>>>>
>>>> I need to look more in detail about this, however as far as I could
>>>> understand:
>>>>
>>>> - when the mmc layer asks for the CD pin, due to the "cd-gpios"
>>>> property,  the owner name for this config request is not the one from
>>>> the OF node, but it is "conjured" - as written in comment - from the
>>>> GPIO number and name (GPIOG:98) in pinmux_request_gpio()
>>>>
>>>> - the pinmux config done in behalf of the 'pinctrl-0' property has the
>>>> OF node name (40012c00.sdio) as owner.
>>>>
>>>
>>> I will look at deeper in the driver but first why you need to control
>>> this
>>> pin by both way (gpio lib through gpio definition and pinctrl framework
>>> through pinctrl definition) ?
>>
>>
>> Hmm, sorry, maybe I'm missing something here.. Please correct me if I'm
>> wrong :)
>>
>> Don't I need to reference the pinmux configuration for CD in my
>> pinctrl configs in the SDIO DT node, in order to have it active? e.g.
>> pinctrl-0 = <&sdio_pins>, <&sdio_cd>;
>>
>> Don't I need to provide "cs-gpios" to the MMC layer as well ? e.g.
>> cd-gpios = <&gpiog 2 0>;
>
>
> Maybe I miss also something but it depends on "how" the driver uses this
> pin. If you want to control the GPIO (change direction or set gpio in input
> or read input ...) you have to use gpiolib and so declare "cd-gpios =
> <&gpiog 2 0>;". By doing that gpiolib will request the gpio to pinctrl for
> you. No need to declare a pinctrl entry for that.

Ah, ok. Thanks for clarifying :) It's my fault then: I've assumed that
for some reason both were needed, just because the DTS files I've
looked at seem to have both. (BTW apparently there are a lot of them
in arch/arm/dts.. are they all broken and working only because they
have not a "strict" pinctrl driver?)..

Anyway, it should be enough to drop completely the pinmux config for
CD. I'll post a new series next week.

>>
>> If I do both, it fails (due to mmc_of_parse() failing). No matter what
>> I do in the driver, I believe.
>
>
> It is normal that both failed; In strict mode you can't request several
> times the same pin (you request pinG2 one time by gpiolib and oneother time
> by pinctrl).
>
>
>>
>>> In strict mode the error you get is "normal". You can't control the same
>>> pin
>>> in the same time by gpiolib and pinctrl.
>>>
>>>
>>>> This owner mismatch causes a check to fail in pin_request(), that
>>>> believes that two different owners try to use the same pin (while in
>>>> true both are in behalf of the same SDIO device).
>>>>
>>>> I don't know when I'll have more time to look into this. If you want I
>>>> can temporary drop the CD pinmux config and post the V3 - that
>>>> nevertheless works - and we can add the CD pinmux cfg later, once it
>>>> has been fixed.
>>>>
>>>> In someone have clues, or want to look into this, he/she would be
>>>> really welcome :)
>>>
>>>
>>>
>>> No problem, we can wait. Let's merge it when it will be fully functional.
>>>
>>> Br
>>> Alex
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>> +&sdio {
>>>>>> +       status = "okay";
>>>>>> +       vmmc-supply = <&mmc_vcard>;
>>>>>> +       cd-gpios = <&gpiog 2 0>;
>>>>>> +       cd-inverted;
>>>>>> +       pinctrl-names = "default", "opendrain";
>>>>>> +       pinctrl-0 = <&sdio_pins>;
>>>>>> +       pinctrl-1 = <&sdio_pins_od>;
>>>>>> +       bus-width = <4>;
>>>>>> +};
>>>>>> +
>>>>>>  &usart3 {
>>>>>>         status = "okay";
>>>>>>  };
>>>>>>
>>>>>
>>>
>
