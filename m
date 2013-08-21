From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 4/8] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Wed, 21 Aug 2013 12:10:13 +0200
Message-ID: <1856833.dLvJPAi2rE@amdc1227>
References: <1377066933-28058-1-git-send-email-yuvaraj.cd@samsung.com>
 <1377066933-28058-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:62032 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3HUKKR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 06:10:17 -0400
In-reply-to: <1377066933-28058-2-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hi Yuvaraj,

On Wednesday 21 of August 2013 12:05:33 Yuvaraj Kumar C D wrote:
> This patch adds the device tree node entries for exynos5420 SOC.
> Exynos5420 has a different version of DWMMC controller,so a new
> compatible string is used to distinguish it from the prior SOC's.

Is this patch a v3 of [1]?

[1] - http://thread.gmane.org/gmane.linux.kernel.mmc/21981

Why it is named patch 4/8?

> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    2 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   41
> ++++++++++++++++++++ arch/arm/boot/dts/exynos5420.dtsi                 
> |   33 ++++++++++++++++ 3 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt index
> 6d1c098..84cd56f 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -16,6 +16,8 @@ Required Properties:
>  	  specific extensions.
>  	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
> specific extensions.
> +	- "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
> +	  specific extensions.
> 
>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card
> interface unit (ciu) clock. This property is applicable only for Exynos5
> SoC's and diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> b/arch/arm/boot/dts/exynos5420-smdk5420.dts index 08607df..4530700
> 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -30,4 +30,45 @@
>  			clock-frequency = <24000000>;
>  		};
>  	};
> +
> +	dwmmc0@12200000 {
> +		num-slots = <1>;
> +		broken-cd;
> +		bypass-smu;
> +		supports-highspeed;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <0 4>;
> +		samsung,dw-mshc-ddr-timing = <0 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;

See below.

> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <8>;
> +		};
> +	};
> +
> +	dwmmc1@12210000 {
> +		status = "disabled";

You should rather keep things the other way around. A board dts shouldn't 
care about peripherals it doesn't use, so any peripheral requiring board-
specific data in its node should have status set as "disabled" at top level 
and then overridden to "okay" at level in which it has all the required 
properties to operate (in board dts in this case).

> +	};
> +
> +	dwmmc2@12220000 {
> +		num-slots = <1>;
> +		supports-highspeed;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <2 3>;
> +		samsung,dw-mshc-ddr-timing = <1 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;

Here would go status = "okay".

> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +		};
> +	};
> +
>  };
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index 9e90d1e..8559aa8 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -19,6 +19,9 @@
>  	compatible = "samsung,exynos5420";
> 
>  	aliases {
> +		mshc0 = &dwmmc_0;
> +		mshc1 = &dwmmc_1;
> +		mshc2 = &dwmmc_2;
>  		pinctrl0 = &pinctrl_0;
>  		pinctrl1 = &pinctrl_1;
>  		pinctrl2 = &pinctrl_2;
> @@ -65,6 +68,36 @@
>  		#clock-cells = <1>;
>  	};
> 
> +	dwmmc_0: dwmmc0@12200000 {
> +		compatible = "samsung,exynos5420-dw-mshc";
> +		interrupts = <0 75 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x12200000 0x2000>;
> +		clocks = <&clock 351>, <&clock 132>;
> +		clock-names = "biu", "ciu";

Here would go status = "disabled" in this case.

> +	};
> +
> +	dwmmc_1: dwmmc1@12210000 {
> +		compatible = "samsung,exynos5420-dw-mshc";
> +		interrupts = <0 76 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x12210000 0x2000>;
> +		clocks = <&clock 352>, <&clock 133>;
> +		clock-names = "biu", "ciu";

...

> +	};
> +
> +	dwmmc_2: dwmmc2@12220000 {
> +		compatible = "samsung,exynos5420-dw-mshc";
> +		interrupts = <0 77 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x12220000 0x2000>;
> +		clocks = <&clock 353>, <&clock 134>;
> +		clock-names = "biu", "ciu";

...

Best regards,
Tomasz

