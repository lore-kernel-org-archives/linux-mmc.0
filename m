From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
Date: Thu, 10 Nov 2016 19:44:19 +0800
Message-ID: <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <ee296deafdcbeb431a592b591ae38a758ba4cce7.1477911954.git-series.gregory.clement@free-electrons.com>
 <20161109182426.vfrpb4i2mfatdzz3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161109182426.vfrpb4i2mfatdzz3@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Hilbert Zhang <zzhang@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Romain Perier <romain.perier@free-electrons.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Xueping Liu <xpliu@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Yu Cao <yucao@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infr
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On 2016/11/10 2:24, Rob Herring wrote:
> On Mon, Oct 31, 2016 at 12:09:54PM +0100, Gregory CLEMENT wrote:
>> From: Ziji Hu <huziji@marvell.com>
>>
>> Marvell Xenon SDHC can support eMMC/SD/SDIO.
>> Add Xenon-specific properties.
>> Also add properties for Xenon PHY setting.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 161 +++++++-
>>  MAINTAINERS                                                   |   1 +-
>>  2 files changed, 162 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>> new file mode 100644
>> index 000000000000..0d2d139494d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>> @@ -0,0 +1,161 @@
>> +Marvell's Xenon SDHCI Controller device tree bindings
>> +This file documents differences between the core mmc properties
>> +described by mmc.txt and the properties used by the Xenon implementation.
>> +
>> +A single Xenon IP can support multiple slots.
>> +Each slot acts as an independent SDHC. It owns independent resources, such
>> +as register sets clock and PHY.
>> +Each slot should have an independent device tree node.
>> +
>> +Required Properties:
>> +- compatible: should be one of the following
>> +  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SOC.
>> +  Must provide a second register area and marvell,pad-type.
>> +  - "marvell,xenon-sdhci": For controllers on all the SOCs, other than
>> +  Armada-3700.
> 
> Need SoC specific compatible strings.
> 

	Xenon SDHC is a common IP for all Marvell SOCs.
	It is difficult to use a single SOC specific compatible to represent Xenon SDHC.
	There will be so many SOC compatible strings in list if each specific SOC owns a compatible.
	Actually only few SOCs require special properties.
	Any suggestion please?

>> +
>> +- clocks:
>> +  Array of clocks required for SDHCI.
>> +  Requires at least one for Xenon IP core.
>> +  Some SOCs require additional clock for AXI bus.
>> +
>> +- clock-names:
>> +  Array of names corresponding to clocks property.
>> +  The input clock for Xenon IP core should be named as "core".
>> +  The optional AXI clock should be named as "axi".
> 
> When is AXI clock optional? This should be required for ?? compatible 
> strings.
> 
	It is required on some SOCs.
	I will double check if a suitable compatible string can be determined for those SOCs.

>> +
>> +- reg:
>> +  * For "marvell,xenon-sdhci", one register area for Xenon IP.
>> +
>> +  * For "marvell,armada-3700-sdhci", two register areas.
>> +    The first one for Xenon IP register. The second one for the Armada 3700 SOC
>> +    PHY PAD Voltage Control register.
>> +    Please follow the examples with compatible "marvell,armada-3700-sdhci"
>> +    in below.
>> +    Please also check property marvell,pad-type in below.
>> +
>> +Optional Properties:
>> +- marvell,xenon-slotno:
> 
> Multiple slots should be represented as child nodes IMO. I think some 
> other bindings already do this.
> 

	All the slots are entirely independent.
	I prefer to consider it as multiple independent SDHCs placed in a single IP, instead of that a IP contains multiple child slots.

	It is unlike the implementation which put multiple slots behind PCIe EP interface. sdhci-pci.c will handle each slot init one by one.
	If Xenon SDHC slots are represented as child nodes, there should also be a main entry in Xenon driver to init each child node one by one.
	In my very own opinion, it is inconvenient and unnecessary.

>> +  Indicate the corresponding bit index of current Xenon SDHC slot in
>> +  SDHC System Operation Control Register Bit[7:0].
>> +  Set/clear the corresponding bit to enable/disable current Xenon SDHC
>> +  slot.
>> +  If this property is not provided, Xenon IP should contain only one
>> +  slot.
>> +
>> +- marvell,xenon-phy-type:
>> +  Xenon support mutilple types of PHYs.
>> +  To select eMMC 5.1 PHY, set:
>> +  marvell,xenon-phy-type = "emmc 5.1 phy"
>> +  eMMC 5.1 PHY is the default choice if this property is not provided.
>> +  To select eMMC 5.0 PHY, set:
>> +  marvell,xenon-phy-type = "emmc 5.0 phy"
>> +  To select SDH PHY, set:
>> +  marvell,xenon-phy-type = "sdh phy"
>> +  Please note that eMMC PHY is a general PHY for eMMC/SD/SDIO, other than for
>> +  eMMC only.
> 
> Does this vary per instance on a single SoC? If not, then an SoC 
> specific compatible should determine this.
> 
> Also, the " phy" part is redundant.
> 

	Yes. Some SOCs might have multiple Xenon PHY types.

	This property is only the name/type of PHY. It doesn't stand for the entire SDHC property.
	"emmc 5.1 PHY" doesn't mean that this Xenon SDHC only support eMMC 5.1.
	Xenon SDHC with "sdh PHY" can also support eMMC. 

>> +
>> +- marvell,xenon-phy-znr:
>> +  Set PHY ZNR value.
>> +  Only available for eMMC PHY 5.1 and eMMC PHY 5.0.
>> +  valid range = [0:0x1F].
>> +  ZNR is set as 0xF by default if this property is not provided.
>> +
>> +- marvell,xenon-phy-zpr:
>> +  Set PHY ZPR value.
>> +  Only available for eMMC PHY 5.1 and eMMC PHY 5.0.
>> +  valid range = [0:0x1F].
>> +  ZPR is set as 0xF by default if this property is not provided.
>> +
>> +- marvell,xenon-phy-nr-success-tun:
>> +  Set the number of required consecutive successful sampling points used to
>> +  identify a valid sampling window, in tuning process.
>> +  Valid range = [1:7]. Set as 0x4 by default if this property is not provided.
>> +
>> +- marvell,xenon-phy-tun-step-divider:
>> +  Set the divider for calculating TUN_STEP.
>> +  Set as 64 by default if this property is not provided.
>> +
>> +- marvell,xenon-phy-slow-mode:
>> +  Force PHY into slow mode.
>> +  Only available when bus frequency lower than 50MHz in SDR mde.
>> +  Disabled by default. Please do not enable it unless it is necessary.
>> +
>> +- marvell,xenon-mask-conflict-err:
>> +  Mask Conflict Error alert on some SOC. Disabled by default.
>> +
>> +- marvell,xenon-tun-count:
>> +  Xenon SDHC SOC usually doesn't provide re-tuning counter in
>> +  Capabilities Register 3 Bit[11:8].
>> +  This property provides the re-tuning counter.
>> +  If this property is not set, default re-tuning counter will
>> +  be set as 0x9 in driver.
>> +
>> +- marvell,pad-type:
>> +  Type of Armada 3700 SOC PHY PAD Voltiage Controller register.
>> +  Only valid when "marvell,armada-3700-sdhci" is selected.
>> +  Two types: "sd" and "fixed-1-8v".
>> +  If "sd" is slected, SOC PHY PAD is set as 3.3V at the beginning and is
>> +  switched to 1.8V when SD in UHS-I.
>> +  If "fixed-1-8v" is slected, SOC PHY PAD is fixed 1.8V, such as for eMMC.
>> +  Please follow the examples with compatible "marvell,armada-3700-sdhci"
>> +  in below.
>> +
>> +Example:
>> +- For eMMC slot:
>> +
>> +	sdhci@aa0000 {
>> +		compatible = "marvell,xenon-sdhci";
>> +		reg = <0xaa0000 0x1000>;
>> +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
>> +		clocks = <&emmc_clk>, <&axi_clock>;
>> +		clock-names = "core", "axi";
>> +		bus-width = <8>;
>> +		marvell,xenon-emmc;
> 
> Not documented. If we need to specify the type of slot/card, then we 
> need to come up with a standard property. This was either already done 
> or attempted IIRC.

	Sorry to lost this property in above.
	I will add it in above.

	Thank you.

Best regards,
Hu Ziji

> 
>> +		marvell,xenon-slotno = <0>;
>> +		marvell,xenon-phy-type = "emmc 5.1 phy";
>> +		marvell,xenon-tun-count = <11>;
>> +	};
>> +
>> +- For SD/SDIO slot:
>> +
>> +	sdhci@ab0000 {
>> +		compatible = "marvell,xenon-sdhci";
>> +		reg = <0xab0000 0x1000>;
>> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>> +		vqmmc-supply = <&sd_regulator>;
>> +		clocks = <&sdclk>;
>> +		clock-names = "core";
>> +		bus-width = <4>;
>> +		marvell,xenon-tun-count = <9>;
>> +	};
>> +
>> +- For eMMC slot with compatible "marvell,armada-3700-sdhci":
>> +
>> +	sdhci@aa0000 {
>> +		compatible = "marvell,armada-3700-sdhci";
>> +		reg = <0xaa0000 0x1000>,
>> +		      <phy_addr 0x4>;
>> +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
>> +		clocks = <&emmcclk>;
>> +		clock-names = "core";
>> +		bus-width = <8>;
>> +		marvell,xenon-emmc;
>> +
>> +		marvell,pad-type = "fixed-1-8v";
>> +	};
>> +
>> +- For SD/SDIO slot with compatible "marvell,armada-3700-sdhci":
>> +
>> +	sdhci@ab0000 {
>> +		compatible = "marvell,armada-3700-sdhci";
>> +		reg = <0xab0000 0x1000>,
>> +		      <phy_addr 0x4>;
>> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>> +		vqmmc-supply = <&sd_regulator>;
>> +		clocks = <&sdclk>;
>> +		clock-names = "core";
>> +		bus-width = <4>;
>> +
>> +		marvell,pad-type = "sd";
>> +	};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1a5c4c30ea24..850a0afb0c8d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7608,6 +7608,7 @@ MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
>>  M:	Ziji Hu <huziji@marvell.com>
>>  L:	linux-mmc@vger.kernel.org
>>  S:	Supported
>> +F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>  
>>  MATROX FRAMEBUFFER DRIVER
>>  L:	linux-fbdev@vger.kernel.org
>> -- 
>> git-series 0.8.10
