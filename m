From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: omap4: add pbias and mmc_init
 pinctrl states
Date: Wed, 12 Jun 2013 07:36:17 -0700
Message-ID: <20130612143616.GA8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-11-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59897 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3FLOgT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 10:36:19 -0400
Content-Disposition: inline
In-Reply-To: <1370546059-24181-11-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org

* Balaji T K <balajitk@ti.com> [130606 12:20]:
> add pbias states for pbias 0, 1.8V, 3V
> add sd/mmc1 pull strength values for control_mmc1 in mmc_init pinctrl state

This too should be under mmc1 in the omap4.dtsi file.

Tony
 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   34 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts           |   34 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi              |   11 +++++++++
>  3 files changed, 79 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 03bd60d..d6ffbb1 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -137,6 +137,34 @@
>  	};
>  };
>  
> +&omap4_padconf_global {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <>;
> +	pbias_off: pinmux_pbias_off {
> +		pinctrl-single,bits = <
> +			0x60 0x00000000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	pbias_1v8: pinmux_pbias_1v8 {
> +		pinctrl-single,bits = <
> +			0x60 0x04400000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	pbias_3v: pinmux_pbias_3v {
> +		pinctrl-single,bits = <
> +			0x60 0x04600000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	mmc1_init: pinmux_mmc1_init {
> +		pinctrl-single,bits = <
> +			0x88 0xce000000 0xfe000000	/* control_mmc1 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
> @@ -197,6 +225,12 @@
>  };
>  
>  &mmc1 {
> +	pinctrl-names = "default", "mmc_init", "pbias_off", "pbias_1v8", "pbias_3v";
> +	pinctrl-0 = <>;
> +	pinctrl-1 = <&mmc1_init>;
> +	pinctrl-2 = <&pbias_off>;
> +	pinctrl-3 = <&pbias_1v8>;
> +	pinctrl-4 = <&pbias_3v>;
>  	vmmc-supply = <&vmmc>;
>  	bus-width = <8>;
>  };
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index a35d9cd..b1c0e86 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -142,6 +142,34 @@
>  	};
>  };
>  
> +&omap4_padconf_global {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <>;
> +	pbias_off: pinmux_pbias_off {
> +		pinctrl-single,bits = <
> +			0x60 0x00000000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	pbias_1v8: pinmux_pbias_1v8 {
> +		pinctrl-single,bits = <
> +			0x60 0x04400000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	pbias_3v: pinmux_pbias_3v {
> +		pinctrl-single,bits = <
> +			0x60 0x04600000 0x07e00000	/* pbias */
> +		>;
> +	};
> +
> +	mmc1_init: pinmux_mmc1_init {
> +		pinctrl-single,bits = <
> +			0x88 0xce000000 0xfe000000	/* control_mmc1 */
> +		>;
> +	};
> +};
> +
>  &omap4_pmx_core {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <
> @@ -381,6 +409,12 @@
>  };
>  
>  &mmc1 {
> +	pinctrl-names = "default", "mmc_init", "pbias_off", "pbias_1v8", "pbias_3v";
> +	pinctrl-0 = <>;
> +	pinctrl-1 = <&mmc1_init>;
> +	pinctrl-2 = <&pbias_off>;
> +	pinctrl-3 = <&pbias_1v8>;
> +	pinctrl-4 = <&pbias_3v>;
>  	vmmc-supply = <&vmmc>;
>  	bus-width = <8>;
>  };
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 2a56428..41f575d 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -114,6 +114,17 @@
>  			pinctrl-single,register-width = <16>;
>  			pinctrl-single,function-mask = <0x7fff>;
>  		};
> +
> +		omap4_padconf_global: pinmux@4a100600 {
> +			compatible = "ti,omap4-padconf", "pinctrl-single";
> +			reg = <0x4a1005a0 0x170>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-single,bit-per-mux;
> +			pinctrl-single,register-width = <32>;
> +			pinctrl-single,function-mask = <0xffffffff>;
> +		};
> +
>  		omap4_pmx_wkup: pinmux@4a31e040 {
>  			compatible = "ti,omap4-padconf", "pinctrl-single";
>  			reg = <0x4a31e040 0x0038>;
> -- 
> 1.7.5.4
> 
