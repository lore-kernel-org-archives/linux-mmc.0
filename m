From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv5 2/2] ARM: dts: unuse the slot-node and deprecated
 supports-highspeed for dw-mmc.
Date: Thu, 5 Jun 2014 09:30:21 +0200
Message-ID: <CAPDyKFrzny2UqtU0DHyy4TLEaEoPU=z_QfjNHvoYTcKoX=bv2g@mail.gmail.com>
References: <1401943439-8146-1-git-send-email-jh80.chung@samsung.com>
	<1401943439-8146-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:47508 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaFEHaW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 03:30:22 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so960007qgd.27
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jun 2014 00:30:21 -0700 (PDT)
In-Reply-To: <1401943439-8146-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>

On 5 June 2014 06:43, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V5:
>         - Fix typo.
> Changelog V4:
>         - Remove the slot-node.
>         - Rename Subject.
>                 "[PATCHv3 4/4]ARM: dts: replace the slot property into slot sub-node for dwmmc"
> Changelog V3:
>         - Merge "[PATCH 2/5] mmc: dw_mmc: rmove the "supports-highspeed" property"
> Changelog V2:
>         - None
>
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++--------
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
>  arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
>  arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++---------
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   27 +++++---------------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++---------
>  arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++---------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++---------
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++---------
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    5 ++--
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
>  arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
>  16 files changed, 61 insertions(+), 144 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index 532b1d4..4cdd283 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -46,13 +46,14 @@ Required Properties:
>        - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
>          phase shift clocks should be 0.
>
> -Required properties for a slot:
> +Required properties for a slot (Deprecated - Recommend to use one slot per a host):
>
>  * gpios: specifies a list of gpios used for command, clock and data bus. The
>    first gpio is the command line and the second gpio is the clock line. The
>    rest of the gpios (depending on the bus-width property) are the data lines in
>    no particular order. The format of the gpio specifier depends on the gpio
>    controller.
> + (Deprecated - Refer to Documentaion/devicetree/binding/pinctrl/samsung-pinctrl.txt)
>
>  Example:
>
> @@ -69,21 +70,13 @@ Example:
>
>         dwmmc0@12200000 {
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
> +               cap-mmc-highspeed;
> +               cap-sd-highspeed;
>                 fifo-depth = <0x80>;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -                       gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
> -                               <&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
> -                               <&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
> -                               <&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
> -                               <&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
> -               };
> +               bus-width = <8>;
>         };
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> index b8653ea..514c0fc 100644
> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -34,13 +34,11 @@ Example:
>                 num-slots = <1>;
>                 vmmc-supply = <&ldo12>;
>                 fifo-depth = <0x100>;
> -               supports-highspeed;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       disable-wp;
> -                       cd-gpios = <&gpio10 3 0>;
> -               };
> +               bus-width = <4>;
> +               disable-wp;
> +               cd-gpios = <&gpio10 3 0>;
> +               cap-mmc-highspeed;
> +               cap-sd-highspeed;
>         };
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 2d4a725..346c609 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -67,7 +67,8 @@ Optional properties:
>  * card-detect-delay: Delay in milli-seconds before detecting card after card
>    insert event. The default value is 0.
>
> -* supports-highspeed: Enables support for high speed cards (up to 50MHz)
> +* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
> +                          (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
>
>  * broken-cd: as documented in mmc core bindings.
>
> @@ -98,14 +99,11 @@ board specific portions as listed below.
>                 clock-frequency = <400000000>;
>                 clock-freq-min-max = <400000 200000000>;
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 fifo-depth = <0x80>;
>                 card-detect-delay = <200>;
>                 vmmc-supply = <&buck8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;
> +               cap-sd-highspeed;
>         };
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index 31db28a..778aec6 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -45,17 +45,13 @@
>                 status = "okay";
>
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         regulator_p3v3 {
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index e2c0dca..8832424 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -128,17 +128,13 @@
>                 status = "okay";
>
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         codec@13400000 {
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 73be464..47b6f3a 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -459,7 +459,6 @@
>
>         mmc@12550000 {
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 non-removable;
>                 card-detect-delay = <200>;
> @@ -468,14 +467,11 @@
>                 samsung,dw-mshc-ciu-div = <0>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>                 pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
>                 pinctrl-names = "default";
>                 status = "okay";
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
>         };
>
>         sd_reg: voltage-regulator@1 {
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 090f983..2f61e4d 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -399,7 +399,6 @@
>         mmc_0: mmc@12200000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
> @@ -408,17 +407,13 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         mmc_2: mmc@12220000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -426,12 +421,9 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       disable-wp;
> -               };
> +               bus-width = <4>;
> +               disable-wp;
> +               cap-sd-highspeed;

cap-mmc-highspeed?

>         };
>
>         i2s0: i2s@03830000 {
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> index 2c1560d..272bc84 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -248,7 +248,6 @@
>
>         mmc@12200000 {
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
> @@ -256,44 +255,32 @@
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         mmc@12220000 {
>                 num-slots = <1>;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       wp-gpios = <&gpc2 1 0>;
> -               };
> +               bus-width = <4>;
> +               wp-gpios = <&gpc2 1 0>;

cap-sd-highspeed?
cap-mmc-highspeed?

>         };
>
>         mmc@12230000 {
>                 num-slots = <1>;
> -               supports-highspeed;
> -               broken-cd;
>                 card-detect-delay = <200>;
> +               broken-cd;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 /* See board-specific dts files for pin setup */
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -               };
> +               bus-width = <4>;
> +               cap-sd-highspeed;

cap-mmc-highspeed?

>         };
>
>         spi_1: spi@12d30000 {
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index a794a70..e00ffc6 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -282,7 +282,6 @@
>         mmc@12200000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
> @@ -290,29 +289,22 @@
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         mmc@12220000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       disable-wp;
> -               };
> +               bus-width = <4>;
> +               disable-wp;
> +               cap-sd-highspeed;

cap-mmc-highspeed?

>         };
>
>         spi_1: spi@12d30000 {
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 1ce1088..2245278 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -190,10 +190,8 @@
>          */
>         mmc@12230000 {
>                 status = "okay";
> -               slot@0 {
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
> -               };
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
>         };
>
>         usb@12110000 {
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> index 80a3bf4..752715a 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -40,7 +40,6 @@
>         mmc@12200000 {
>                 status = "okay";
>                 broken-cd;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <0 4>;
> @@ -48,16 +47,12 @@
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>                 vmmc-supply = <&ldo10_reg>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         mmc@12220000 {
>                 status = "okay";
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -65,11 +60,8 @@
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>                 vmmc-supply = <&ldo10_reg>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -               };
> +               bus-width = <4>;
> +               cap-sd-highspeed;

cap-mmc-highspeed?

>         };
>
>         hsi2c_4: i2c@12CA0000 {
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 6910485..7f5e35b 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -71,34 +71,26 @@
>         mmc@12200000 {
>                 status = "okay";
>                 broken-cd;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <0 4>;
>                 samsung,dw-mshc-ddr-timing = <0 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;

cap-sd-highspeed?

>         };
>
>         mmc@12220000 {
>                 status = "okay";
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -               };
> +               bus-width = <4>;
> +               cap-sd-highspeed;

cap-mmc-highspeed?

>         };
>
>         dp-controller@145B0000 {
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> index 035df40..0e618d5 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -58,12 +58,8 @@
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
>                         vmmc-supply = <&vcc_sd0>;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                               disable-wp;
> -                       };
> +                       bus-width = <4>;
> +                       disable-wp;
>                 };
>
>                 dwmmc@10218000 { /* wifi */
> @@ -73,12 +69,8 @@
>
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                               disable-wp;
> -                       };
> +                       bus-width = <4>;
> +                       disable-wp;
>                 };
>
>                 gpio-keys {
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 6c87b70..1da0e81 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,12 +29,13 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
> -                       broken-cd;
>
>                         slot@0 {
>                                 reg = <0>;
>                                 bus-width = <4>;
> +                               broken-cd;
> +                               cap-mmc-highspeed;
> +                               cap-sd-highspeed;
>                         };
>                 };
>
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index ca41b0e..c4ebf65 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -30,13 +30,10 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet@ff702000 {
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 87d6f75..07e7206 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -43,13 +43,10 @@
>
>                 dwmmc0@ff704000 {
>                         num-slots = <1>;
> -                       supports-highspeed;
>                         broken-cd;
> -
> -                       slot@0 {
> -                               reg = <0>;
> -                               bus-width = <4>;
> -                       };
> +                       bus-width = <4>;
> +                       cap-mmc-highspeed;
> +                       cap-sd-highspeed;
>                 };
>
>                 ethernet@ff700000 {
> --
> 1.7.9.5
>

Kind regards
Ulf Hansson
