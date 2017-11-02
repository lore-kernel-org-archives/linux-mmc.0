From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 03/12] arm64: dts: mt8173: remove "mediatek,mt8135-mmc"
 from mmc nodes
Date: Thu, 2 Nov 2017 12:50:43 +0100
Message-ID: <b24d12e4-251f-6f79-1ed9-5b52f8f39625@gmail.com>
References: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
 <1508118399-21828-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrRVT8YFXvy3Wuf_jga5oourScOdas34U=YkeLRzHoWMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49665 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdKBLus (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Nov 2017 07:50:48 -0400
In-Reply-To: <CAPDyKFrRVT8YFXvy3Wuf_jga5oourScOdas34U=YkeLRzHoWMg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>



On 10/25/2017 11:11 PM, Ulf Hansson wrote:
> On 16 October 2017 at 03:46, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> devicetree bindings has been updated to support multi-platforms,
>> so that each platform has its owns compatible name.
>> And, this compatible name may used in driver to distinguish with
>> other platform.
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> 
> Matthias, do you intend to pick this? Else I can do it with your ack...
> 

If it's not too late, feel free to take it. Otherwise I will queue it for the
next merge window:

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> Kind regards
> Uffe
> 
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index b99a273..26396ef 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -682,8 +682,7 @@
>>                 };
>>
>>                 mmc0: mmc@11230000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                         reg = <0 0x11230000 0 0x1000>;
>>                         interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
>>                         clocks = <&pericfg CLK_PERI_MSDC30_0>,
>> @@ -693,8 +692,7 @@
>>                 };
>>
>>                 mmc1: mmc@11240000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                         reg = <0 0x11240000 0 0x1000>;
>>                         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>>                         clocks = <&pericfg CLK_PERI_MSDC30_1>,
>> @@ -704,8 +702,7 @@
>>                 };
>>
>>                 mmc2: mmc@11250000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                         reg = <0 0x11250000 0 0x1000>;
>>                         interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
>>                         clocks = <&pericfg CLK_PERI_MSDC30_2>,
>> @@ -715,8 +712,7 @@
>>                 };
>>
>>                 mmc3: mmc@11260000 {
>> -                       compatible = "mediatek,mt8173-mmc",
>> -                                    "mediatek,mt8135-mmc";
>> +                       compatible = "mediatek,mt8173-mmc";
>>                         reg = <0 0x11260000 0 0x1000>;
>>                         interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
>>                         clocks = <&pericfg CLK_PERI_MSDC30_3>,
>> --
>> 1.8.1.1.dirty
>>
