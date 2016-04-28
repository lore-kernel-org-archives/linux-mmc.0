From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: exynos: Define vqmmc for eMMC card on
 Odroid X/X2/U3
Date: Thu, 28 Apr 2016 02:21:40 -0400
Message-ID: <CABxcv=mGMyjr=Gj8srdL+h5JruvRxYuybBRohBSNnRfykDdaDg@mail.gmail.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
	<1461765620-6833-2-git-send-email-k.kozlowski@samsung.com>
	<bca8c1c9-41ac-c7e8-9313-ff96058376be@osg.samsung.com>
	<5721A49A.1020401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37139 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbcD1GVm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 02:21:42 -0400
Received: by mail-ig0-f180.google.com with SMTP id s8so13016476ign.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2016 23:21:41 -0700 (PDT)
In-Reply-To: <5721A49A.1020401@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello Krzysztof,

On Thu, Apr 28, 2016 at 1:50 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 04/27/2016 11:29 PM, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 04/27/2016 10:00 AM, Krzysztof Kozlowski wrote:
>>> The eMMC card vmmc-supply contained incorrectly two regulators: LDO20
>>> and buck8. The second one is ignored. Additionally the buck8 is a vqmmc
>>> supply only on X and X2. On U3 the buck8 is providing power to the LAN
>>> (SMSC95xx) so instead the LDO22 should be used.
>>>
>>> Fix this by defining proper vmmc and vqmmc supplies for respective
>>> boards.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>> ---
>>>
>>> Changes since v1:
>>> 1. buck8 is used on X/X2 so differentiate the configuration (hint by
>>>    Tobias Jakobi).
>>> ---
>>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 13 ++++++++++---
>>>  arch/arm/boot/dts/exynos4412-odroidu3.dts       | 18 ++++++++++++++++++
>>>  arch/arm/boot/dts/exynos4412-odroidx.dts        | 11 +++++++++++
>>>  arch/arm/boot/dts/exynos4412-odroidx2.dts       | 11 +++++++++++
>>>  4 files changed, 50 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> index 3d0d44581fbd..34a5b3daced0 100644
>>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> @@ -347,6 +347,13 @@
>>>                              regulator-boot-on;
>>>                      };
>>>
>>> +                    ldo22_reg: LDO22 {
>>> +                            regulator-name = "LDO22";
>>> +                            regulator-min-microvolt = <800000>;
>>> +                            regulator-max-microvolt = <3950000>;
>>> +                            regulator-boot-on;
>>> +                    };
>>> +
>>
>> I don't have a datasheet for the max77686 but I guess these min and max
>> values are the actual voltage range that the ldo22 regulator can support?
>
> Yes.
>
>> If that's the case, then I don't think setting these are correct since the
>> DT binding says that the regulator-{min,max}-microvolt properties describe
>> the voltage range that consumers may set. I've seen Mark mention this many
>> times, the last one I remember is at [0].
>
> For LDO22 there is no consumer so these are the constraints. Leaving

That was my point, there's no consumers for X/X2 and there is only a
consumer in U3 (vqmmc-supply for mshc_0) added by $SUBJECT. That's why
I thought that it should be defined in odroidu3.dts and removed from
the .dtsi.

> them undefined (here and in DTS for X/X2) would result in the same
> effect. The point is that these values are valid constraints. Please
> have in mind that the binding describe this as "smallest/largest voltage
> consumer may set" which is true for the code above.
>
>>
>> Probably would be better to leave the ldo22_reg definition to odroidu3.dts
>> to avoid setting these constraint in a .dtsi file.
>
> What about X/X2?
>

Mmm, I see what you mean. If the regulators are not defined then these
for example won't be turned off by the regulator subsystem if were
enabled by the bootloader. Then I guess your change makes sense.

>>>                      ldo25_reg: LDO25 {
>>>                              regulator-name = "VDDQ_LCD_1.8V";
>>>                              regulator-min-microvolt = <1800000>;
>>> @@ -411,8 +418,8 @@
>>>
>>>                      buck8_reg: BUCK8 {
>>>                              regulator-name = "BUCK8_2.8V";
>>> -                            regulator-min-microvolt = <2800000>;
>>> -                            regulator-max-microvolt = <2800000>;
>>> +                            regulator-min-microvolt = <750000>;
>>> +                            regulator-max-microvolt = <3900000>;
>>
>> Same here, since not all boards have the same constraint for this regulator,
>> it would be better to remove it from the .dtsi and let each dts to define it.
>
> Since all of the boards define them, it does not bring any difference
> having it here... so I can remove them.
>
>

Ok. I don't have a strong opinion on this though now that I realized
that not defining some regulators could lead to unused ones not being
disabled on boot.

>>>                      };
>>>              };
>>>      };
>>> @@ -456,7 +463,7 @@
>>>  &mshc_0 {
>>>      pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
>>>      pinctrl-names = "default";
>>> -    vmmc-supply = <&ldo20_reg &buck8_reg>;
>>> +    vmmc-supply = <&ldo20_reg>;
>>>      mmc-pwrseq = <&emmc_pwrseq>;
>>>      status = "okay";
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>>> index dd89f7b37c9f..d73aa6c58fe3 100644
>>> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
>>> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>>> @@ -69,6 +69,24 @@
>>>      };
>>>  };
>>>
>>> +/* Supply for LAN9730/SMSC95xx */
>>> +&buck8_reg {
>>> +    regulator-name = "BUCK8_P3V3";
>>
>> I think it would be better to name it "BUCK8_3.3V" for consistency.
>
> Consistency of naming is nice but in the same time we want the regulator
> names to match the hardware because it is easier to read the code and
> check the schematics. On the schematics this is unfortunately called
> P3V3. :)
>

oh, I missed that. It's pity but I agree with you that matching the
schematics is more important that naming consistency.

Thanks a lot for your explanations, the patch looks good to me as it is now:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
