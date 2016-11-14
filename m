From: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Mon, 14 Nov 2016 11:36:07 +0100
Message-ID: <CAN8YU5PKU7iP1he6MvPCOZ0pf-4fdKgBi8gWmppjdyMU9c=u5Q@mail.gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
 <1478612625-23256-9-git-send-email-andrea.merello@gmail.com> <ffdc246c-0197-f1a7-f848-a02b4e7df13c@st.com>
Reply-To: andrea.merello@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35453 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbcKNKg2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 05:36:28 -0500
Received: by mail-yw0-f195.google.com with SMTP id b66so5869633ywh.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2016 02:36:27 -0800 (PST)
In-Reply-To: <ffdc246c-0197-f1a7-f848-a02b4e7df13c@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-mmc@vger.kernel.org, Bruno Herrera <bruherrera@gmail.com>

On Thu, Nov 10, 2016 at 11:54 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Andrea
>
>
> On 11/08/2016 02:43 PM, Andrea Merello wrote:
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
>>  arch/arm/boot/dts/stm32f469-disco.dts | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>> b/arch/arm/boot/dts/stm32f429.dtsi
>> index d6d0548..23e6a5e 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -185,7 +185,7 @@
>>                         interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>,
>> <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>>                 };
>>
>> -               pin-controller {
>> +               pinctrl:pin-controller {
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>                         compatible = "st,stm32f429-pinctrl";
>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>> b/arch/arm/boot/dts/stm32f469-disco.dts
>> index e911af8..e16dfc3 100644
>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>> @@ -64,12 +64,42 @@
>>         aliases {
>>                 serial0 = &usart3;
>>         };
>> +
>> +       mmc_vcard: mmc_vcard {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "mmc_vcard";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>
> As I assume you will send a v2 (due to kbuild issue) remove empty line
> please.

Sure. I will do. (But unfortunately it will not happen very soon :( )

In the meantime comments and testing are appreciated. Also, I forgot
to say that, if one wants to try this, he/she will need the bootloader
to set properly the 48MHz clk for SD (for afboot use my tree -
pull-req pending on Maxime Coquelin tree). For clk driver probably my
patch for making it aware of the 48MHz setting is still needed (I've
not looked into other recent clk patches yet)..

>> +
>> +       };
>>  };
>>
>>  &clk_hse {
>>         clock-frequency = <8000000>;
>>  };
>>
>> +&pinctrl {
>> +       sdio-cd {
>> +               sdio_cd: sdio-cd {
>> +                       pins {
>> +                               pinmux = <STM32F429_PG2_FUNC_GPIO>;
>> +                               bias-pull-up;
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&sdio {
>> +       status = "okay";
>> +       vmmc-supply = <&mmc_vcard>;
>> +       cd-gpios = <&gpiog 2 0>;
>> +       cd-inverted;
>> +       pinctrl-names = "default", "opendrain", "cd";
>> +       pinctrl-0 = <&sdio_pins>, <&sdio_cd>;
>> +       pinctrl-1 = <&sdio_pins_od>, <&sdio_cd>;
>> +       bus-width = <4>;
>> +};
>> +
>>  &usart3 {
>>         status = "okay";
>>  };
>>
>
