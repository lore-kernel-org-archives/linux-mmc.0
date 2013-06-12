From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: omap3: add pbias and mmc_init
 pinctrl states
Date: Wed, 12 Jun 2013 07:35:49 -0700
Message-ID: <20130612143548.GZ8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-10-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370546059-24181-10-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [130606 12:20]:
> add pbias states for pbias 0, 1.8V, 3V
> add omap3 sd/mmc2 loop back clock config for devconf1 in mmc2_init pinctrl state
> add OMAP3430 sd/mmc1 loop back clock config for devconf0 in mmc1_init pinctrl state
> add OMAP3630 sd/mmc1 speed mode config for prog_io1 in mmc1_init pinctrl state

Looks OK to me, except these should be under mmc1 for omap[345].dtsi files.

Regards,

Tony
 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts |   42 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-beagle.dts    |   42 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi          |   10 ++++++++
>  3 files changed, 94 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 3046d1f..45d1642 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -59,6 +59,40 @@
>  	};
>  };
>  
> +&omap3_pmx_general {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <>;
> +	pbias_off: pinmux_pbias_off {
> +		pinctrl-single,bits = <
> +			0x2b0 0x1 0x3	/* pbias */
> +		>;
> +	};
> +
> +	pbias_1v8: pinmux_pbias_1v8 {
> +		pinctrl-single,bits = <
> +			0x2b0 0x2 0x3	/* pbias */
> +		>;
> +	};
> +
> +	pbias_3v: pinmux_pbias_3v {
> +		pinctrl-single,bits = <
> +			0x2b0 0x3 0x3	/* pbias */
> +		>;
> +	};
> +
> +	mmc1_init: pinmux_mmc1_init {
> +		pinctrl-single,bits = <
> +			0x1d8 0x100000 0x100000	/* prog_io1 */
> +		>;
> +	};
> +
> +	mmc2_init: pinmux_mmc2_init {
> +		pinctrl-single,bits = <
> +			0x68 0x40 0x40	/* devconf1 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <2600000>;
>  
> @@ -95,12 +129,20 @@
>  };
>  
>  &mmc1 {
> +	pinctrl-names = "default", "mmc_init", "pbias_off", "pbias_1v8", "pbias_3v";
> +	pinctrl-0 = <>;
> +	pinctrl-1 = <&mmc1_init>;
> +	pinctrl-2 = <&pbias_off>;
> +	pinctrl-3 = <&pbias_1v8>;
> +	pinctrl-4 = <&pbias_3v>;
>  	vmmc-supply = <&vmmc1>;
>  	vmmc_aux-supply = <&vsim>;
>  	bus-width = <8>;
>  };
>  
>  &mmc2 {
> +	pinctrl-names = "mmc_init";
> +	pinctrl-1 = <&mmc2_init>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 7da9979..14e251f 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -109,6 +109,40 @@
>  	};
>  };
>  
> +&omap3_pmx_general {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <>;
> +	pbias_off: pinmux_pbias_off {
> +		pinctrl-single,bits = <
> +			0x2b0 0x5 0x7	/* pbias */
> +		>;
> +	};
> +
> +	pbias_1v8: pinmux_pbias_1v8 {
> +		pinctrl-single,bits = <
> +			0x2b0 0x6 0x7	/* pbias */
> +		>;
> +	};
> +
> +	pbias_3v: pinmux_pbias_3v {
> +		pinctrl-single,bits = <
> +			0x2b0 0x7 0x7	/* pbias */
> +		>;
> +	};
> +
> +	mmc1_init: pinmux_mmc1_init {
> +		pinctrl-single,bits = <
> +			0x4 0x01000000 0x01000000	/* devconf0 */
> +		>;
> +	};
> +
> +	mmc2_init: pinmux_mmc2_init {
> +		pinctrl-single,bits = <
> +			0x68 0x40 0x40	/* devconf1 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <2600000>;
>  
> @@ -122,12 +156,20 @@
>  /include/ "twl4030.dtsi"
>  
>  &mmc1 {
> +	pinctrl-names = "default", "mmc_init", "pbias_off", "pbias_1v8", "pbias_3v";
> +	pinctrl-0 = <>;
> +	pinctrl-1 = <&mmc1_init>;
> +	pinctrl-2 = <&pbias_off>;
> +	pinctrl-3 = <&pbias_1v8>;
> +	pinctrl-4 = <&pbias_3v>;
>  	vmmc-supply = <&vmmc1>;
>  	vmmc_aux-supply = <&vsim>;
>  	bus-width = <8>;
>  };
>  
>  &mmc2 {
> +	pinctrl-names = "mmc_init";
> +	pinctrl-1 = <&mmc2_init>;
>  	status = "disabled";
>  };
>  
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index caaa708..de2940d 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -111,6 +111,16 @@
>  			pinctrl-single,function-mask = <0x7f1f>;
>  		};
>  
> +		omap3_pmx_general: pinmux@48002270 {
> +			compatible = "ti,omap3-padconf", "pinctrl-single";
> +			reg = <0x48002270 0x2f4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-single,bit-per-mux;
> +			pinctrl-single,register-width = <32>;
> +			pinctrl-single,function-mask = <0xffffffff>;
> +		};
> +
>  		omap3_pmx_wkup: pinmux@0x48002a00 {
>  			compatible = "ti,omap3-padconf", "pinctrl-single";
>  			reg = <0x48002a00 0x5c>;
> -- 
> 1.7.5.4
> 
