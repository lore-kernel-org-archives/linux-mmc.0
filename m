From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/14] ARM: dts: dra76x: Create a common file with MMC/SD
 IOdelay data
Date: Fri, 15 Dec 2017 08:32:07 -0800
Message-ID: <20171215163207.GB3875@atomide.com>
References: <20171214134054.7749-1-kishon@ti.com>
 <20171214134054.7749-5-kishon@ti.com>
 <20171214151531.GI14441@atomide.com>
 <be4d8cfd-bdd3-aedf-9d9c-156de39d2621@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:60424 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756697AbdLOQcM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Dec 2017 11:32:12 -0500
Content-Disposition: inline
In-Reply-To: <be4d8cfd-bdd3-aedf-9d9c-156de39d2621@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [171215 06:12]:
> Hi Tony,
> 
> On Thursday 14 December 2017 08:45 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [171214 13:44]:
> >> +&dra7_pmx_core {
> >> +	mmc1_pins_default: mmc1_pins_default {
> >> +		pinctrl-single,pins = <
> >> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
> >> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
> >> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
> >> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
> >> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
> >> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
> >> +		>;
> >> +	};
> >> +
> >> +	mmc1_pins_sdr12: mmc1_pins_sdr12 {
> >> +		pinctrl-single,pins = <
> >> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
> >> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
> >> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.dat0 */
> >> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.dat1 */
> >> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.dat2 */
> >> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.dat3 */
> >> +		>;
> >> +	};
> > 
> > Can't you just do:
> > 
> > pinctrl-0 = <&mmc1_pins_default>;
> > pinctrl-1 = <&mmc1_pins_default>;
> > pinctrl-2 = <&mmc1_pins_hs>;
> > pinctrl-names = "default", "sdr12", "sdr25";
> 
> just wanted to make sure every mode has it's own pinctrl group so that it's
> easy to review. Initially we were thinking something like
> mmc1_pins_default_sdr12_sdr25.

OK that naming works fine for me.

> But if you'd prefer we just use mmc1_pins_default for all modes that uses
> default pinmux configuration, I can change it that way too.

No up to you with the naming thanks.

Regards,

Tony
