From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/14] ARM: dts: dra76x: Create a common file with MMC/SD
 IOdelay data
Date: Thu, 14 Dec 2017 07:15:31 -0800
Message-ID: <20171214151531.GI14441@atomide.com>
References: <20171214134054.7749-1-kishon@ti.com>
 <20171214134054.7749-5-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171214134054.7749-5-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [171214 13:44]:
> +&dra7_pmx_core {
> +	mmc1_pins_default: mmc1_pins_default {
> +		pinctrl-single,pins = <
> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
> +		>;
> +	};
> +
> +	mmc1_pins_sdr12: mmc1_pins_sdr12 {
> +		pinctrl-single,pins = <
> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.dat0 */
> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.dat1 */
> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.dat2 */
> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.dat3 */
> +		>;
> +	};

Can't you just do:

pinctrl-0 = <&mmc1_pins_default>;
pinctrl-1 = <&mmc1_pins_default>;
pinctrl-2 = <&mmc1_pins_hs>;
pinctrl-names = "default", "sdr12", "sdr25";

And avoid defining duplicate pinctrl groups that way?

Regards,

Tony
