From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v10 5/7] ARM: dts: add pbias dt node
Date: Wed, 15 Jan 2014 20:39:28 +0530
Message-ID: <52D6A4A8.5060307@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com> <1389627375-9107-1-git-send-email-balajitk@ti.com> <1389627375-9107-6-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60586 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbaAOPJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 10:09:45 -0500
In-Reply-To: <1389627375-9107-6-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com

On Monday 13 January 2014 09:06 PM, Balaji T K wrote:
> Add pbias regulator node as a child of system control
> module - syscon.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
Hi Benoit,

Gentle Ping, Let me know if you have any comments.

> ---
>   arch/arm/boot/dts/dra7.dtsi     |   17 +++++++++++++++++
>   arch/arm/boot/dts/omap2430.dtsi |   17 +++++++++++++++++
>   arch/arm/boot/dts/omap3.dtsi    |   17 +++++++++++++++++
>   arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
>   arch/arm/boot/dts/omap5.dtsi    |   17 +++++++++++++++++
>   5 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index d0df4c4..876c9b8 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -110,6 +110,22 @@
>   			ti,hwmods = "counter_32k";
>   		};
>
> +		dra7_ctrl_general: tisyscon@4a002e00 {
> +			compatible = "syscon", "simple-bus";
> +			reg = <0x4a002e00 0x7c>;
> +		};
> +
> +		pbias_regulator: pbias_regulator {
> +			compatible = "ti,pbias-omap";
> +			reg = <0 0x4>;
> +			syscon = <&dra7_ctrl_general>;
> +			pbias_mmc_reg: pbias_mmc_omap5 {
> +				regulator-name = "pbias_mmc_omap5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +		};
> +
>   		dra7_pmx_core: pinmux@4a003400 {
>   			compatible = "pinctrl-single";
>   			reg = <0x4a003400 0x0464>;
> @@ -485,6 +501,7 @@
>   			dmas = <&sdma 61>, <&sdma 62>;
>   			dma-names = "tx", "rx";
>   			status = "disabled";
> +			pbias-supply = <&pbias_mmc_reg>;
>   		};
>
>   		mmc2: mmc@480b4000 {
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index d624345..af71eb0 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -29,6 +29,22 @@
>   			pinctrl-single,function-mask = <0x3f>;
>   		};
>
> +		omap2_scm_general: tisyscon@49002270 {
> +			compatible = "syscon", "simple-bus";
> +			reg = <0x49002270 0x240>;
> +		};
> +
> +		pbias_regulator: pbias_regulator {
> +			compatible = "ti,pbias-omap";
> +			reg = <0x230 0x4>;
> +			syscon = <&omap2_scm_general>;
> +			pbias_mmc_reg: pbias_mmc_omap2430 {
> +				regulator-name = "pbias_mmc_omap2430";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +		};
> +
>   		gpio1: gpio@4900c000 {
>   			compatible = "ti,omap2-gpio";
>   			reg = <0x4900c000 0x200>;
> @@ -183,6 +199,7 @@
>   			ti,dual-volt;
>   			dmas = <&sdma 61>, <&sdma 62>;
>   			dma-names = "tx", "rx";
> +			pbias-supply = <&pbias_mmc_reg>;
>   		};
>
>   		mmc2: mmc@480b4000 {
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index daabf99..b7828da 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -137,6 +137,22 @@
>   			pinctrl-single,function-mask = <0xff1f>;
>   		};
>
> +		omap3_scm_general: tisyscon@48002270 {
> +			compatible = "syscon", "simple-bus";
> +			reg = <0x48002270 0x2f0>;
> +		};
> +
> +		pbias_regulator: pbias_regulator {
> +			compatible = "ti,pbias-omap";
> +			reg = <0x2b0 0x4>;
> +			syscon = <&omap3_scm_general>;
> +			pbias_mmc_reg: pbias_mmc_omap2430 {
> +				regulator-name = "pbias_mmc_omap2430";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +		};
> +
>   		gpio1: gpio@48310000 {
>   			compatible = "ti,omap3-gpio";
>   			reg = <0x48310000 0x200>;
> @@ -351,6 +367,7 @@
>   			ti,dual-volt;
>   			dmas = <&sdma 61>, <&sdma 62>;
>   			dma-names = "tx", "rx";
> +			pbias-supply = <&pbias_mmc_reg>;
>   		};
>
>   		mmc2: mmc@480b4000 {
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index a1e0585..9e19363 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -134,6 +134,22 @@
>   			pinctrl-single,function-mask = <0x7fff>;
>   		};
>
> +		omap4_padconf_global: tisyscon@4a1005a0 {
> +			compatible = "syscon", "simple-bus";
> +			reg = <0x4a1005a0 0x170>;
> +		};
> +
> +		pbias_regulator: pbias_regulator {
> +			compatible = "ti,pbias-omap";
> +			reg = <0x60 0x4>;
> +			syscon = <&omap4_padconf_global>;
> +			pbias_mmc_reg: pbias_mmc_omap4 {
> +				regulator-name = "pbias_mmc_omap4";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +		};
> +
>   		sdma: dma-controller@4a056000 {
>   			compatible = "ti,omap4430-sdma";
>   			reg = <0x4a056000 0x1000>;
> @@ -367,6 +383,7 @@
>   			ti,needs-special-reset;
>   			dmas = <&sdma 61>, <&sdma 62>;
>   			dma-names = "tx", "rx";
> +			pbias-supply = <&pbias_mmc_reg>;
>   		};
>
>   		mmc2: mmc@480b4000 {
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index fc3fad5..f178899 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -130,6 +130,22 @@
>   			pinctrl-single,function-mask = <0x7fff>;
>   		};
>
> +		omap5_padconf_global: tisyscon@4a002da0 {
> +			compatible = "syscon";
> +			reg = <0x4A002da0 0xec>;
> +		};
> +
> +		pbias_regulator: pbias_regulator {
> +			compatible = "ti,pbias-omap";
> +			reg = <0x60 0x4>;
> +			syscon = <&omap5_padconf_global>;
> +			pbias_mmc_reg: pbias_mmc_omap5 {
> +				regulator-name = "pbias_mmc_omap5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +		};
> +
>   		sdma: dma-controller@4a056000 {
>   			compatible = "ti,omap4430-sdma";
>   			reg = <0x4a056000 0x1000>;
> @@ -409,6 +425,7 @@
>   			ti,needs-special-reset;
>   			dmas = <&sdma 61>, <&sdma 62>;
>   			dma-names = "tx", "rx";
> +			pbias-supply = <&pbias_mmc_reg>;
>   		};
>
>   		mmc2: mmc@480b4000 {
>

