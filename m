From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv3 4/4] ARM: dts: replace the slot property into slot
 sub-node for dwmmc.
Date: Fri, 30 May 2014 21:54:13 +0900
Message-ID: <001d01cf7c06$420dea90$c629bfb0$%jun@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
 <1401255351-17653-5-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:25568 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaE3MyQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 08:54:16 -0400
In-reply-to: <1401255351-17653-5-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, dinguyen@altera.com, heiko@sntech.de, cpgs@samsung.com

+ Dinh Nguyen <dinguyen@altera.com>
+ Heiko Stuebner <heiko@sntech.de>

On Wed, May 28, 2014, Jaehoon Chung wrote:
> dw-mmc controller can support the multiple slot.
> So each slot's property can be difference.
> And "support-highspeed" property in dw-mmc is deprecated.
> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Looks good to me.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
> Changelog V3:
> 	- Merge "[PATCH 2/5] mmc: dw_mmc: rmove the "supports-highspeed" property"
> Changelog V2:
> 	- None
> 
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    5 +++--
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    3 ++-
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    6 ++++--
>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    4 ++--
>  arch/arm/boot/dts/exynos4412-origen.dts            |    4 ++--
>  arch/arm/boot/dts/exynos4412-trats2.dts            |    6 +++---
>  arch/arm/boot/dts/exynos5250-arndale.dts           |    6 +++---
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   10 +++++-----
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    6 +++---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    6 +++---
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 ++--
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts             |    2 +-
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    5 +++--
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    5 +++--
>  arch/arm/boot/dts/socfpga_vt.dts                   |    5 +++--
>  15 files changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index 532b1d4..41cc703 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -69,8 +69,6 @@ Example:
> 
>  	dwmmc0@12200000 {
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
> @@ -85,5 +83,8 @@ Example:
>  				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
>  				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
>  				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
> +			broken-cd;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  	};
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> index b8653ea..b1844c5 100644
> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -34,7 +34,6 @@ Example:
>  		num-slots = <1>;
>  		vmmc-supply = <&ldo12>;
>  		fifo-depth = <0x100>;
> -		supports-highspeed;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
>  		slot@0 {
> @@ -42,5 +41,7 @@ Example:
>  			bus-width = <4>;
>  			disable-wp;
>  			cd-gpios = <&gpio10 3 0>;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  	};
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 2d4a725..ff393ab 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -67,7 +67,8 @@ Optional properties:
>  * card-detect-delay: Delay in milli-seconds before detecting card after card
>    insert event. The default value is 0.
> 
> -* supports-highspeed: Enables support for high speed cards (up to 50MHz)
> +* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
> +			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
> 
>  * broken-cd: as documented in mmc core bindings.
> 
> @@ -98,7 +99,6 @@ board specific portions as listed below.
>  		clock-frequency = <400000000>;
>  		clock-freq-min-max = <400000 200000000>;
>  		num-slots = <1>;
> -		supports-highspeed;
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> @@ -107,5 +107,7 @@ board specific portions as listed below.
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index 31db28a..fb2cd8d 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -45,8 +45,6 @@
>  		status = "okay";
> 
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -55,6 +53,8 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index e2c0dca..698a5f4 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -128,8 +128,6 @@
>  		status = "okay";
> 
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -138,6 +136,8 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 73be464..eb53d3a 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -459,9 +459,6 @@
> 
>  	mmc@12550000 {
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
> -		non-removable;
>  		card-detect-delay = <200>;
>  		vmmc-supply = <&vemmc_reg>;
>  		clock-frequency = <400000000>;
> @@ -475,6 +472,9 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			non-removable;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 090f983..c48293f 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -399,8 +399,6 @@
>  	mmc_0: mmc@12200000 {
>  		status = "okay";
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -412,13 +410,14 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
>  	mmc_2: mmc@12220000 {
>  		status = "okay";
>  		num-slots = <1>;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -431,6 +430,7 @@
>  			reg = <0>;
>  			bus-width = <4>;
>  			disable-wp;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-
> common.dtsi
> index 2c1560d..c00eef6 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -248,8 +248,6 @@
> 
>  	mmc@12200000 {
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -260,12 +258,13 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
>  	mmc@12220000 {
>  		num-slots = <1>;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -277,13 +276,12 @@
>  			reg = <0>;
>  			bus-width = <4>;
>  			wp-gpios = <&gpc2 1 0>;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
>  	mmc@12230000 {
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -293,6 +291,8 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <4>;
> +			broken-cd;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index a794a70..28095cb 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -282,8 +282,6 @@
>  	mmc@12200000 {
>  		status = "okay";
>  		num-slots = <1>;
> -		supports-highspeed;
> -		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -294,13 +292,14 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
>  	mmc@12220000 {
>  		status = "okay";
>  		num-slots = <1>;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -312,6 +311,7 @@
>  			reg = <0>;
>  			bus-width = <4>;
>  			disable-wp;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-
> octa.dts
> index 80a3bf4..506ce0d 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -39,8 +39,6 @@
> 
>  	mmc@12200000 {
>  		status = "okay";
> -		broken-cd;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <0 4>;
> @@ -52,12 +50,13 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			broken-cd;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
>  	mmc@12220000 {
>  		status = "okay";
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -69,6 +68,7 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <4>;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 6910485..4d7b2c8 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -71,7 +71,6 @@
>  	mmc@12200000 {
>  		status = "okay";
>  		broken-cd;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <0 4>;
> @@ -82,12 +81,12 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <8>;
> +			cap-mmc-highspeed;
>  		};
>  	};
> 
>  	mmc@12220000 {
>  		status = "okay";
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -98,6 +97,7 @@
>  		slot@0 {
>  			reg = <0>;
>  			bus-width = <4>;
> +			cap-sd-highspeed;
>  		};
>  	};
> 
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> index 035df40..62c7484 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -69,7 +69,6 @@
>  		dwmmc@10218000 { /* wifi */
>  			num-slots = <1>;
>  			status = "okay";
> -			non-removable;
> 
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
> @@ -78,6 +77,7 @@
>  				reg = <0>;
>  				bus-width = <4>;
>  				disable-wp;
> +				non-removable;
>  			};
>  		};
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 6c87b70..1da0e81 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,12 +29,13 @@
> 
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
> -			broken-cd;
> 
>  			slot@0 {
>  				reg = <0>;
>  				bus-width = <4>;
> +				broken-cd;
> +				cap-mmc-highspeed;
> +				cap-sd-highspeed;
>  			};
>  		};
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index ca41b0e..5c61067 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -30,12 +30,13 @@
> 
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
> -			broken-cd;
> 
>  			slot@0 {
>  				reg = <0>;
>  				bus-width = <4>;
> +				broken-cd;
> +				cap-mmc-highspeed;
> +				cap-sd-highspeed;
>  			};
>  		};
> 
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 87d6f75..79c0e86 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -43,12 +43,13 @@
> 
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
> -			broken-cd;
> 
>  			slot@0 {
>  				reg = <0>;
>  				bus-width = <4>;
> +				broken-cd;
> +				cap-mmc-highspeed;
> +				cap-sd-highspeed;
>  			};
>  		};
> 
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

