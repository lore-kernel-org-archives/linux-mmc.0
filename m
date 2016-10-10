From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Mon, 10 Oct 2016 16:34:17 -0500
Message-ID: <20161010213417.GA11795@rob-hp-laptop>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <fc0ca2b3140287cbccf5c176a12b7dce25d06a47.1475853198.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fc0ca2b3140287cbccf5c176a12b7dce25d06a47.1475853198.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 07, 2016 at 05:22:51PM +0200, Gregory CLEMENT wrote:
> From: Ziji Hu <huziji@marvell.com>
> 
> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> Add Xenon-specific properties.
> Also add properties for Xenon PHY setting.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt | 164 +++++++-
>  MAINTAINERS                                                   |   1 +-
>  2 files changed, 165 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
> new file mode 100644
> index 000000000000..8b25ad28ebbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
> @@ -0,0 +1,164 @@
> +Marvell's Xenon SDHCI Controller device tree bindings
> +This file documents differences between the core mmc properties
> +described by mmc.txt and the properties used by the Xenon implementation.
> +
> +A single Xenon IP can support multiple slots.
> +Each slot acts as an independent SDHC. It owns independent resources, such
> +as register sets clock and PHY.

Is the phy really part of the same block?

> +Each slot should have an independent device tree node.
> +
> +Required Properties:
> +- compatible: should be "marvell,sdhci-xenon" or "marvell,armada-3700-sdhci".

Perhaps some consistent ordering (w/ -sdhci on the end).

> +
> +- Input Clock Name

Your formatting of properties is a bit strange. Please restructure like 
most bindings so the property names are before all the description.

> +  Some SOCs require additional clock for AXI bus.

Those SoCs should have a specific compatible string and you need to 
define which compatible strings have 2 clocks vs. 1 clock.

> +  The input clock for Xenon IP core should be named as "core".
> +  The optional AXI clock should be named as "axi".
> +  - clocks = <&core_clk>, <&axi_clock>;
> +  - clock-names = "core", "axi";
> +
> +- Register Set Size

Is this a property name?

> +  Different Xenon SDHC release has different register set size.
> +  The specific size should also refer to the SOC implementation.
> +
> +Optional Properties:
> +- Slot Index
> +  A single Xenon IP can support multiple slots.
> +  During initialization, each slot should set corresponding setting bit in
> +  some Xenon-specific registers. The corresponding bit is determined by
> +  this property.
> +  - xenon,slotno = <slot_index>;

Slots should probably be represented as child nodes with the reg 
property being the slot number.

Also, xenon is not a vendor prefix.

> +  If this property is not provided, Xenon IP should contain only one slot
> +  and the slot index will be 0x0 by default.
> +
> +- PHY Type

You're going to need to come of with a common binding for this.

> +  Xenon support mutilple types of PHYs.
> +  To select eMMC 5.1 PHY, set:
> +  - xenon,phy-type = "emmc 5.1 phy"
> +  eMMC 5.1 PHY is the default choice if this property is not provided.
> +  To select eMMC 5.0 PHY, set:
> +  - xenon,phy-type = "emmc 5.0 phy"
> +  To select SDH PHY, set:
> +  - xenon,phy-type = "sdh phy"
> +  Please note that eMMC PHY is a general PHY for eMMC/SD/SDIO, other than for
> +  eMMC only.
> +
> +- Customized eMMC PHY Parameters
> +  Some boards require different values of some specific eMMC PHY parameters.
> +  Some SOCs also require specific workaround to set eMMC PHY.
> +  These properties enable diverse boards to customize the eMMC PHY.
> +  The supported eMMC PHY parameters are listed in below. All those properties
> +  are only available for eMMC PHY 5.1 and eMMC PHY 5.0.
> +  ZNR
> +  valid range = [0:0x1F].
> +  ZNR is set as 0xF by default if this property is not provided.
> +  - xenon,phy-znr = <value>;
> +
> +  ZPR
> +  valid range = [0:0x1F].
> +  ZPR is set as 0xF by default if this property is not provided.
> +  - xenon,phy-zpr = <value>;

marvell is the vendor prefix.

> +
> +  Number of successful tuning times
> +  Set the number of required consecutive successful sampling points used to
> +  identify a valid sampling window, in tuning process.
> +  Valid range = [1:7]. Set as 0x4 by default if this property is not provided.
> +  - xenon,phy-nr-tun-times = <nr_times>;
> +
> +  Divider for TUN_STEP
> +  Set the divider for calculating TUN_STEP.
> +  Set as 64 by default if this property is not provided.
> +  - xenon,phy-tun-step-divider = <divider>;
> +
> +  Force PHY into slow mode.
> +  Only available when bus frequency lower than 50MHz in SDR mde.
> +  Disabled by default. Please do not enable it unless it is necessary.
> +  - xenon,phy-slow-mode;
> +
> +- Mask Conflict Error Report
> +  Disable Conflict Error alert on some SOC. Disabled by default.
> +  xenon,mask-conflict-err;
> +
> +- Re-tuning Counter
> +  Xenon SDHC SOC usually doesn't provide re-tuning counter in
> +  Capabilities Register 3 Bit[11:8].
> +  This property provides the re-tuning counter.
> +  xenon,tuning-count = <count>;
> +  If this property is not set, default re-tuning counter will
> +  be set as 0x9 in driver.
> +
> +- SOC PHY PAD Voltage Control register
> +  Some SOCs have SOC PHY PAD Voltage Control register outside Xenon IP.
> +  This register sets SOC PHY PAD Voltage to keep aligh with Vccq.
> +  Two properties provide information of this control register.
> +  These two properties are only valid when "marvell,armada-3700-sdhci"
> +  is selected. Both of them must be provided when "marvell,armada-3700-sdhci"
> +  is selected.
> +  - xenon,pad-type
> +    Two types: "sd" and "fixed-1-8v".
> +    If "sd" is slected, SOC PHY PAD is set as 3.3V at the beginning and is
> +    switched to 1.8V when SD in UHS-I.
> +    If "fixed-1-8v" is slected, SOC PHY PAD is fixed 1.8V, such as for eMMC.

You should be able to existing, common properties for i/o voltage 
capabilities/constraints.

> +  - reg
> +    Physical address and size of SOC PHY PAD register.
> +    Append after Xenon SDHC register space, as a second register field.
> +
> +  Please follow the examples with compatible "marvell,armada-3700-sdhci"
> +  in below.
> +
> +Example:
> +- For eMMC slot:
> +
> +	sdhci@aa0000 {
> +		compatible = "marvell,sdhci-xenon";
> +		reg = <0xaa0000 0x1000>;
> +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +		clocks = <&emmcclk>;
> +		clock-names = "core";
> +		xenon,slotno = <0>;
> +		xenon,phy-type = "emmc 5.1 phy";
> +		bus-width = <8>;
> +		tuning-count = <11>;
> +	};
> +
> +- For SD/SDIO slot:
> +
> +	sdhci@ab0000 {
> +		compatible = "marvell,sdhci-xenon";
> +		reg = <0xab0000 0x1000>;
> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +		vqmmc-supply = <&sd_regulator>;
> +		clocks = <&sdclk>;
> +		clock-names = "core";
> +		bus-width = <4>;
> +		tuning-count = <9>;
> +	};
> +
> +- For eMMC slot with compatible "marvell,armada-3700-sdhci":
> +
> +	sdhci@aa0000 {
> +		compatible = "marvell,armada-3700-sdhci";
> +		reg = <0xaa0000 0x1000>,
> +		      <phy_addr 0x4>;
> +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +		clocks = <&emmcclk>;
> +		clock-names = "core";
> +		bus-width = <8>;
> +
> +		xenon,pad-type = "fixed-1-8v";
> +	};
> +
> +- For SD/SDIO slot with compatible "marvell,armada-3700-sdhci":
> +
> +	sdhci@ab0000 {
> +		compatible = "marvell,armada-3700-sdhci";
> +		reg = <0xab0000 0x1000>,
> +		      <phy_addr 0x4>;
> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +		vqmmc-supply = <&sd_regulator>;
> +		clocks = <&sdclk>;
> +		clock-names = "core";
> +		bus-width = <4>;
> +
> +		xenon,pad-type = "sd";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89adcd57aa25..4aa0eac9bfc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7582,6 +7582,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>  M:	Ziji Hu <huziji@marvell.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
>  
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
> -- 
> git-series 0.8.10
