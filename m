From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
Date: Thu, 26 Apr 2018 17:45:38 +0100
Message-ID: <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-3-icenowy@aosc.io>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBQ4ERDLQKGQE5VHRE4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180426140728.43155-3-icenowy-h8G6r0blFSE@public.gmane.org>
Content-Language: en-GB
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-h8G6r0blFSE@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 26/04/18 15:07, Icenowy Zheng wrote:
> The Allwinner H6 SoC have 3 MMC controllers.
> 
> Add device tree nodes for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56 ++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 4debc3962830..3cbfc035c979 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -124,12 +124,68 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			mmc0_pins: mmc0-pins {
> +				pins = "PF0", "PF1", "PF2", "PF3",
> +				       "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc2_pins: mmc2-pins {
> +				pins = "PC1", "PC4", "PC5", "PC6",
> +				       "PC7", "PC8", "PC9", "PC10",
> +				       "PC11", "PC12", "PC13", "PC14";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
>  			uart0_ph_pins: uart0-ph {
>  				pins = "PH0", "PH1";
>  				function = "uart0";
>  			};
>  		};
>  
> +		mmc0: mmc@4020000 {
> +			compatible = "allwinner,sun50i-h6-mmc";

This should be:
			compatible = "allwinner,sun50i-h6-mmc",
				     "allwinner,sun50i-a64-mmc";

> +			reg = <0x04020000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc1: mmc@4021000 {
> +			compatible = "allwinner,sun50i-h6-mmc";

same here

> +			reg = <0x04021000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC1>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc2: mmc@4022000 {
> +			compatible = "allwinner,sun50i-h6-emmc";

and here:
			compatible = "allwinner,sun50i-h6-emmc",
				     "allwinner,sun50i-a64-emmc";

The rest looks correct to me.

Cheers,
Andre.

> +			reg = <0x04022000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC2>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		uart0: serial@5000000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x05000000 0x400>;
> 
