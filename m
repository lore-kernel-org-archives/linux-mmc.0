From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 04/15] ARM: dts: dra74x-mmc-iodelay: Add a new pinctrl
 group for clk line without pullup
Date: Wed, 25 Apr 2018 06:35:29 -0700
Message-ID: <20180425133529.GU5671@atomide.com>
References: <20180425125449.19755-1-kishon@ti.com>
 <20180425125449.19755-5-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425125449.19755-5-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180425 12:57]:
> --- a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
> +++ b/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
> @@ -49,6 +49,17 @@
>  		>;
>  	};
>  
> +	mmc1_pins_default_no_clk_pu: mmc1_pins_default_no_clk_pu {
> +		pinctrl-single,pins = <
> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
> +		>;
> +	};
> +
>  	mmc1_pins_sdr12: mmc1_pins_sdr12 {
>  		pinctrl-single,pins = <
>  			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
> -- 

If this data is the same for all of them, why don't you add something
like dra7-iodelay.dtsi that can be included as needed?

Regards,

Tony
