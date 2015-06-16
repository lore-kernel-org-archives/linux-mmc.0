From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
Date: Tue, 16 Jun 2015 20:20:14 +0800
Message-ID: <CAGS+omDMprTvjwpXfdh7mg9i=WXdzO_Fv-oEop3z6AEVCG=DFQ@mail.gmail.com>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
 <1434367253-26577-5-git-send-email-chaotian.jing@mediatek.com> <CAGS+omCwxH5vTTKNOEcN9C9s=1yBpYEqbMz1NygYoLY9OFKchg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCwxH5vTTKNOEcN9C9s=1yBpYEqbMz1NygYoLY9OFKchg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux->
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 16, 2015 at 7:39 PM, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Chaotian,
>
> On Mon, Jun 15, 2015 at 7:20 PM, Chaotian Jing
> <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>> From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>
>> Add node mmc0 ~ mmc3 for mt8173.dtsi
>> Add node mmc0, mmc1 for mt8173-evb.dts
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 126 ++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  45 +++++++++-
>>  2 files changed, 170 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> index b1560c9..762ec61 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> @@ -33,6 +33,132 @@
>>         chosen { };
>>  };
>>
>> +&mmc0 {
>> +       pinctrl-names = "default", "state_uhs";
>> +       pinctrl-0 = <&mmc0_pins_default>;
>> +       pinctrl-1 = <&mmc0_pins_uhs>;
>> +       status = "okay";
>> +       bus-width = <8>;
>> +       max-frequency = <50000000>;
>> +       cap-mmc-highspeed;
>> +       vmmc-supply = <&mt6397_vemc_3v3_reg>;
>> +       vqmmc-supply = <&mt6397_vio18_reg>;

I also can't find phandles for these regulators.

>> +       non-removable;
>> +};
>> +
>> +&mmc1 {
>> +       pinctrl-names = "default", "state_uhs";
>> +       pinctrl-0 = <&mmc1_pins_default>;
>> +       pinctrl-1 = <&mmc1_pins_uhs>;
>> +       status = "okay";
>> +       bus-width = <4>;
>> +       max-frequency = <50000000>;
>> +       cap-sd-highspeed;
>> +       sd-uhs-sdr25;
>> +       cd-gpios = <&pio 132 0>;
>> +       vmmc-supply = <&mt6397_vmch_reg>;
>> +       vqmmc-supply = <&mt6397_vmc_reg>;

nor these regulators.

Which kernel branch are you basing your patch set on?

Thanks,
-Dan


>> +};
>> +
>> +&pio {
>> +       mmc0_pins_default: mmc0default {
>> +               pins_cmd_dat {
>> +                       pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
>> +                               <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
>> +                               <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
>> +                               <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
>> +                               <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
>> +                               <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
>> +                               <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>> +                               <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>> +                               <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
>> +                       input-enable;
>> +                       bias-pull-up;
>> +               };
>> +
>> +               pins_clk {
>> +                       pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
>> +                       bias-pull-down;
>> +               };
>> +
>> +               pins_rst {
>> +                       pinmux = <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
>> +                       bias-pull-up;
>> +               };
>> +       };
>> +
>> +       mmc1_pins_default: mmc1default {
>> +               pins_cmd_dat {
>> +                       pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
>> +                            <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
>> +                            <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>> +                            <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>> +                            <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
>> +                       input-enable;
>> +                       drive-strength = <MTK_DRIVE_4mA>;
>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
>> +               };
>> +
>> +               pins_clk {
>> +                       pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
>> +                       bias-pull-down;
>> +                       drive-strength = <MTK_DRIVE_4mA>;
>> +               };
>> +
>> +               pins_insert {
>> +                       pinmux = <MT8173_PIN_132_I2S0_DATA1__FUNC_GPIO132>;
>> +                       bias-pull-up;
>> +               };
>> +       };
>> +
>> +       mmc0_pins_uhs: mmc0@0{
>> +               pins_cmd_dat {
>> +                       pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
>> +                               <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
>> +                               <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
>> +                               <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
>> +                               <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
>> +                               <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
>> +                               <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>> +                               <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>> +                               <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
>> +                       input-enable;
>> +                       drive-strength = <MTK_DRIVE_2mA>;
>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +               };
>> +
>> +               pins_clk {
>> +                       pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
>> +                       drive-strength = <MTK_DRIVE_2mA>;
>> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
>> +               };
>> +
>> +               pins_rst {
>> +                       pinmux = <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
>> +                       bias-pull-up;
>> +               };
>> +       };
>> +
>> +       mmc1_pins_uhs: mmc1@0 {
>> +               pins_cmd_dat {
>> +                       pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
>> +                            <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
>> +                            <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>> +                            <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>> +                            <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
>> +                       input-enable;
>> +                       drive-strength = <MTK_DRIVE_4mA>;
>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
>> +               };
>> +
>> +               pins_clk {
>> +                       pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
>> +                       drive-strength = <MTK_DRIVE_4mA>;
>> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +               };
>> +       };
>> +};
>> +
>>  &pwrap {
>>         pmic: mt6397 {
>>                 compatible = "mediatek,mt6397";
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index 512e4eb..56ea429 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -288,7 +288,50 @@
>>                         reg = <0 0x19000000 0 0x1000>;
>>                         #clock-cells = <1>;
>>                 };
>> -       };
>>
>> +               mmc0: mmc@11230000 {
>> +                       compatible = "mediatek,mt8173-mmc",
>> +                                    "mediatek,mt8135-mmc";
>> +                       reg = <0 0x11230000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&pericfg CLK_PERI_MSDC30_0>,
>> +                                <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
>> +                       clock-names = "source", "hclk";
>> +                       status = "disabled";
>> +               };
>> +
>> +               mmc1: mmc@11240000 {
>> +                       compatible = "mediatek,mt8173-mmc",
>> +                                    "mediatek,mt8135-mmc";
>> +                       reg = <0 0x11240000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&pericfg CLK_PERI_MSDC30_1>,
>> +                                <&clk_null>;
>
> This requires a "clk_null" phandle, but I have not seen a patch adding
> that on the public list.
> Did I miss a patch?
>
> -Dan
>
>> +                       clock-names = "source", "hclk";
>> +                       status = "disabled";
>> +               };
>> +
>> +               mmc2: mmc@11250000 {
>> +                       compatible = "mediatek,mt8173-mmc",
>> +                                    "mediatek,mt8135-mmc";
>> +                       reg = <0 0x11250000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&pericfg CLK_PERI_MSDC30_2>,
>> +                                <&clk_null>;
>> +                       clock-names = "source", "hclk";
>> +                       status = "disabled";
>> +               };
>> +
>> +               mmc3: mmc@11260000 {
>> +                       compatible = "mediatek,mt8173-mmc",
>> +                                    "mediatek,mt8135-mmc";
>> +                       reg = <0 0x11260000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&pericfg CLK_PERI_MSDC30_3>,
>> +                                <&topckgen CLK_TOP_MSDC50_2_H_SEL>;
>> +                       clock-names = "source", "hclk";
>> +                       status = "disabled";
>> +               };
>> +       };
>>  };
>>
>> --
>> 1.8.1.1.dirty
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
