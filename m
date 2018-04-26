From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Date: Thu, 26 Apr 2018 17:46:26 +0100
Message-ID: <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBA4FRDLQKGQEC33U4NQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180426140728.43155-4-icenowy-h8G6r0blFSE@public.gmane.org>
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
> The Pine H64 board have a MicroSD slot connected to MMC0 controller of
> the H6 SoC and a eMMC slot connected to MMC2.
> 
> Enable them in the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index d36de5eb81f3..78b1cd54687c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -20,6 +20,38 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_vcc1v8: vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;

So this is actually CLDO1 on the AXP, correct?


> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc1v8>;

And this is BLDO2?

I am just asking because I want to avoid running into the same problem
as with the A64 before: that future DTs become incompatible with older
kernels, because we change the power supply to point to the AXP
regulators, which this kernel does not support yet.

It looks like there are more users of those power rails, so we could
keep those supplies connected to these fixed regulators here, even with
AXP-805 support in the kernel.

Or we keep this back until we get proper AXP support in the kernel? I
guess it's quite close to the existing PMICs, so it might be more a
copy&paste exercise to support the AXP-805?

But apart from this this looks correct to me.

Cheers,
Andre.

> +	non-removable;
> +	cap-mmc-hw-reset;
> +	status = "okay";
>  };
>  
>  &uart0 {
> 
