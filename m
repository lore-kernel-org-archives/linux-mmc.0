From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
Date: Tue, 3 Jan 2017 10:52:12 +0800
Message-ID: <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com> <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB5FDVTBQKGQEQ57RTCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1483398226-29321-4-git-send-email-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wrote:

A commit message explaining the mmc controllers would be nice.

> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 +++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index e0dcab8..c680566 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -150,6 +150,32 @@
>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
>                         };
> +
> +                       mmc0_pins: mmc0@0 {
> +                               pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
> +                               function = "mmc0";
> +                               drive-strength = <30>;
> +                       };
> +
> +                       mmc0_default_cd_pin: mmc0_cd_pin@0 {
> +                               pins = "PF6";
> +                               function = "gpio_in";
> +                               bias-pull-up;
> +                       };

We are starting to drop pinmux nodes for gpio usage.

> +
> +                       mmc1_pins: mmc1@0 {
> +                               pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
> +                               function = "mmc1";
> +                               drive-strength = <30>;
> +                       };
> +
> +                       mmc2_pins: mmc2@0 {
> +                               pins = "PC1", "PC5", "PC6", "PC8", "PC9",
> +                                      "PC10", "PC11", "PC12", "PC13", "PC14",
> +                                      "PC15", "PC16";
> +                               function = "mmc2";
> +                               drive-strength = <30>;
> +                       };

Moreover I think you should split out the pinmux nodes to a separate patch.

>                 };
>
>                 uart0: serial@1c28000 {
> @@ -240,6 +266,47 @@
>                         #size-cells = <0>;
>                 };
>
> +               mmc0: mmc@1c0f000 {
> +                       compatible = "allwinner,sun50i-a64-mmc",
> +                                    "allwinner,sun5i-a13-mmc";

Given that sun5i doesn't support mmc delay timings, and the A64 has
calibration and delay timings, I wouldn't call them compatible.

Or are you claiming that for the A64 has a delay of 0 for the
currently supported speeds, so the calibration doesn't really
matter? If so this should be mentioned in the commit message.

> +                       reg = <0x01c0f000 0x1000>;
> +                       clocks = <&ccu 31>, <&ccu 75>;

The clock / reset index macros are in the tree now.
Please switch to them.

ChenYu

> +                       clock-names = "ahb", "mmc";
> +                       resets = <&ccu 8>;
> +                       reset-names = "ahb";
> +                       interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               mmc1: mmc@1c10000 {
> +                       compatible = "allwinner,sun50i-a64-mmc",
> +                                    "allwinner,sun5i-a13-mmc";
> +                       reg = <0x01c10000 0x1000>;
> +                       clocks = <&ccu 32>, <&ccu 76>;
> +                       clock-names = "ahb", "mmc";
> +                       resets = <&ccu 9>;
> +                       reset-names = "ahb";
> +                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               mmc2: mmc@1c11000 {
> +                       compatible = "allwinner,sun50i-a64-emmc";
> +                       reg = <0x01c11000 0x1000>;
> +                       clocks = <&ccu 33>, <&ccu 77>;
> +                       clock-names = "ahb", "mmc";
> +                       resets = <&ccu 10>;
> +                       reset-names = "ahb";
> +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>                 gic: interrupt-controller@1c81000 {
>                         compatible = "arm,gic-400";
>                         reg = <0x01c81000 0x1000>,
> --
> 2.8.2
>
