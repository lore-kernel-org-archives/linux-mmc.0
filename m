From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv5 2/2] ARM: dts: unuse the slot-node and deprecated
 supports-highspeed for dw-mmc.
Date: Thu, 05 Jun 2014 16:41:15 +0900
Message-ID: <53901F1B.8030908@samsung.com>
References: <1401943439-8146-1-git-send-email-jh80.chung@samsung.com>
 <1401943439-8146-3-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFrzny2UqtU0DHyy4TLEaEoPU=z_QfjNHvoYTcKoX=bv2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48111 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaFEHl2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 03:41:28 -0400
In-reply-to: <CAPDyKFrzny2UqtU0DHyy4TLEaEoPU=z_QfjNHvoYTcKoX=bv2g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>

Hi, Ulf.

If we know whether card is eMMC or SD, then just use only cap-mmc-highspeed or cap-sd-highspeed, isn't?
In exynos series's case, i know the card is eMMC or SD, so use one of them.
But i didn't know whether card is eMMC or SD at other SoC, so added all property.
Do you think it need to add all property?

snip[...]
>>         };
>>
>>         mmc@12220000 {
>>                 num-slots = <1>;
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <2 3>;
>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <4>;
>> -                       wp-gpios = <&gpc2 1 0>;
>> -               };
>> +               bus-width = <4>;
>> +               wp-gpios = <&gpc2 1 0>;
> 
> cap-sd-highspeed?
> cap-mmc-highspeed?

Sorry, missed.

Best Regards,
Jaehoon Chung

> 
>>         };
>>
>>         mmc@12230000 {
>>                 num-slots = <1>;
>> -               supports-highspeed;
>> -               broken-cd;
>>                 card-detect-delay = <200>;
>> +               broken-cd;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <2 3>;
>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>                 /* See board-specific dts files for pin setup */
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <4>;
>> -               };
>> +               bus-width = <4>;
>> +               cap-sd-highspeed;
> 
> cap-mmc-highspeed?
> 
>>         };
>>
>>         spi_1: spi@12d30000 {
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> index a794a70..e00ffc6 100644
>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> @@ -282,7 +282,6 @@
>>         mmc@12200000 {
>>                 status = "okay";
>>                 num-slots = <1>;
>> -               supports-highspeed;
>>                 broken-cd;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>> @@ -290,29 +289,22 @@
>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <8>;
>> -               };
>> +               bus-width = <8>;
>> +               cap-mmc-highspeed;
> 
> cap-sd-highspeed?
> 
>>         };
>>
>>         mmc@12220000 {
>>                 status = "okay";
>>                 num-slots = <1>;
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <2 3>;
>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <4>;
>> -                       disable-wp;
>> -               };
>> +               bus-width = <4>;
>> +               disable-wp;
>> +               cap-sd-highspeed;
> 
> cap-mmc-highspeed?
> 
>>         };
>>
>>         spi_1: spi@12d30000 {
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index 1ce1088..2245278 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -190,10 +190,8 @@
>>          */
>>         mmc@12230000 {
>>                 status = "okay";
>> -               slot@0 {
>> -                       pinctrl-names = "default";
>> -                       pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
>> -               };
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
>>         };
>>
>>         usb@12110000 {
>> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> index 80a3bf4..752715a 100644
>> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> @@ -40,7 +40,6 @@
>>         mmc@12200000 {
>>                 status = "okay";
>>                 broken-cd;
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <0 4>;
>> @@ -48,16 +47,12 @@
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>                 vmmc-supply = <&ldo10_reg>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <8>;
>> -               };
>> +               bus-width = <8>;
>> +               cap-mmc-highspeed;
> 
> cap-sd-highspeed?
> 
>>         };
>>
>>         mmc@12220000 {
>>                 status = "okay";
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -65,11 +60,8 @@
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>                 vmmc-supply = <&ldo10_reg>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <4>;
>> -               };
>> +               bus-width = <4>;
>> +               cap-sd-highspeed;
> 
> cap-mmc-highspeed?
> 
>>         };
>>
>>         hsi2c_4: i2c@12CA0000 {
>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> index 6910485..7f5e35b 100644
>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> @@ -71,34 +71,26 @@
>>         mmc@12200000 {
>>                 status = "okay";
>>                 broken-cd;
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <0 4>;
>>                 samsung,dw-mshc-ddr-timing = <0 2>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <8>;
>> -               };
>> +               bus-width = <8>;
>> +               cap-mmc-highspeed;
> 
> cap-sd-highspeed?
> 
>>         };
>>
>>         mmc@12220000 {
>>                 status = "okay";
>> -               supports-highspeed;
>>                 card-detect-delay = <200>;
>>                 samsung,dw-mshc-ciu-div = <3>;
>>                 samsung,dw-mshc-sdr-timing = <2 3>;
>>                 samsung,dw-mshc-ddr-timing = <1 2>;
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>> -
>> -               slot@0 {
>> -                       reg = <0>;
>> -                       bus-width = <4>;
>> -               };
>> +               bus-width = <4>;
>> +               cap-sd-highspeed;
> 
> cap-mmc-highspeed?
> 
>>         };
>>
>>         dp-controller@145B0000 {
>> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> index 035df40..0e618d5 100644
>> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> @@ -58,12 +58,8 @@
>>                         pinctrl-names = "default";
>>                         pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
>>                         vmmc-supply = <&vcc_sd0>;
>> -
>> -                       slot@0 {
>> -                               reg = <0>;
>> -                               bus-width = <4>;
>> -                               disable-wp;
>> -                       };
>> +                       bus-width = <4>;
>> +                       disable-wp;
>>                 };
>>
>>                 dwmmc@10218000 { /* wifi */
>> @@ -73,12 +69,8 @@
>>
>>                         pinctrl-names = "default";
>>                         pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
>> -
>> -                       slot@0 {
>> -                               reg = <0>;
>> -                               bus-width = <4>;
>> -                               disable-wp;
>> -                       };
>> +                       bus-width = <4>;
>> +                       disable-wp;
>>                 };
>>
>>                 gpio-keys {
>> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> index 6c87b70..1da0e81 100644
>> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> @@ -29,12 +29,13 @@
>>
>>                 dwmmc0@ff704000 {
>>                         num-slots = <1>;
>> -                       supports-highspeed;
>> -                       broken-cd;
>>
>>                         slot@0 {
>>                                 reg = <0>;
>>                                 bus-width = <4>;
>> +                               broken-cd;
>> +                               cap-mmc-highspeed;
>> +                               cap-sd-highspeed;
>>                         };
>>                 };
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> index ca41b0e..c4ebf65 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> @@ -30,13 +30,10 @@
>>
>>                 dwmmc0@ff704000 {
>>                         num-slots = <1>;
>> -                       supports-highspeed;
>>                         broken-cd;
>> -
>> -                       slot@0 {
>> -                               reg = <0>;
>> -                               bus-width = <4>;
>> -                       };
>> +                       bus-width = <4>;
>> +                       cap-mmc-highspeed;
>> +                       cap-sd-highspeed;
>>                 };
>>
>>                 ethernet@ff702000 {
>> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
>> index 87d6f75..07e7206 100644
>> --- a/arch/arm/boot/dts/socfpga_vt.dts
>> +++ b/arch/arm/boot/dts/socfpga_vt.dts
>> @@ -43,13 +43,10 @@
>>
>>                 dwmmc0@ff704000 {
>>                         num-slots = <1>;
>> -                       supports-highspeed;
>>                         broken-cd;
>> -
>> -                       slot@0 {
>> -                               reg = <0>;
>> -                               bus-width = <4>;
>> -                       };
>> +                       bus-width = <4>;
>> +                       cap-mmc-highspeed;
>> +                       cap-sd-highspeed;
>>                 };
>>
>>                 ethernet@ff700000 {
>> --
>> 1.7.9.5
>>
> 
> Kind regards
> Ulf Hansson
> 

