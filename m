From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v6 07/14] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
Date: Tue, 14 Feb 2017 18:01:47 +0100
Message-ID: <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@baylibre.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Wilson
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji@marvell.com>

Marvell Xenon SDHC can support eMMC/SD/SDIO.
Add Xenon-specific properties.
Also add properties for Xenon PHY setting.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 172 +++++++-
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
new file mode 100644
index 000000000000..eabee8b64db6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
@@ -0,0 +1,172 @@
+Marvell Xenon SDHCI Controller device tree bindings
+This file documents differences between the core mmc properties
+described by mmc.txt and the properties used by the Xenon implementation.
+
+Multiple SDHCs might be put into a single Xenon IP, to save size and cost.
+Each SDHC is independent and owns independent resources, such as register sets,
+clock and PHY.
+Each SDHC should have an independent device tree node.
+
+Required Properties:
+- compatible: should be one of the following
+  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SoC.
+  Must provide a second register area and marvell,pad-type.
+  - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
+  - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
+
+- clocks:
+  Array of clocks required for SDHC.
+  Require at least input clock for Xenon IP core.
+
+- clock-names:
+  Array of names corresponding to clocks property.
+  The input clock for Xenon IP core should be named as "core".
+
+- reg:
+  * For "marvell,armada-3700-sdhci", two register areas.
+    The first one for Xenon IP register. The second one for the Armada 3700 SoC
+    PHY PAD Voltage Control register.
+    Please follow the examples with compatible "marvell,armada-3700-sdhci"
+    in below.
+    Please also check property marvell,pad-type in below.
+
+  * For other compatible strings, one register area for Xenon IP.
+
+Optional Properties:
+- marvell,xenon-sdhc-id:
+  Indicate the corresponding bit index of current SDHC in
+  SDHC System Operation Control Register Bit[7:0].
+  Set/clear the corresponding bit to enable/disable current SDHC.
+  If Xenon IP contains only one SDHC, this property is optional.
+
+- marvell,xenon-phy-type:
+  Xenon support multiple types of PHYs.
+  To select eMMC 5.1 PHY, set:
+  marvell,xenon-phy-type = "emmc 5.1 phy"
+  eMMC 5.1 PHY is the default choice if this property is not provided.
+  To select eMMC 5.0 PHY, set:
+  marvell,xenon-phy-type = "emmc 5.0 phy"
+
+  All those types of PHYs can support eMMC, SD and SDIO.
+  Please note that this property only presents the type of PHY.
+  It doesn't stand for the entire SDHC type or property.
+  For example, "emmc 5.1 phy" doesn't mean that this Xenon SDHC only
+  supports eMMC 5.1.
+
+- marvell,xenon-phy-znr:
+  Set PHY ZNR value.
+  Only available for eMMC PHY.
+  Valid range = [0:0x1F].
+  ZNR is set as 0xF by default if this property is not provided.
+
+- marvell,xenon-phy-zpr:
+  Set PHY ZPR value.
+  Only available for eMMC PHY.
+  Valid range = [0:0x1F].
+  ZPR is set as 0xF by default if this property is not provided.
+
+- marvell,xenon-phy-nr-success-tun:
+  Set the number of required consecutive successful sampling points
+  used to identify a valid sampling window, in tuning process.
+  Valid range = [1:7].
+  Set as 0x4 by default if this property is not provided.
+
+- marvell,xenon-phy-tun-step-divider:
+  Set the divider for calculating TUN_STEP.
+  Set as 64 by default if this property is not provided.
+
+- marvell,xenon-phy-slow-mode:
+  If this property is selected, transfers will bypass PHY.
+  Only available when bus frequency lower than 55MHz in SDR mode.
+  Disabled by default. Please only try this property if timing issues
+  always occur with PHY enabled in eMMC HS SDR, SD SDR12, SD SDR25,
+  SD Default Speed and HS mode and eMMC legacy speed mode.
+
+- marvell,xenon-tun-count:
+  Xenon SDHC SoC usually doesn't provide re-tuning counter in
+  Capabilities Register 3 Bit[11:8].
+  This property provides the re-tuning counter.
+  If this property is not set, default re-tuning counter will
+  be set as 0x9 in driver.
+
+- marvell,pad-type:
+  Type of Armada 3700 SoC PHY PAD Voltage Controller register.
+  Only valid when "marvell,armada-3700-sdhci" is selected.
+  Two types: "sd" and "fixed-1-8v".
+  If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning and is
+  switched to 1.8V when later in higher speed mode.
+  If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for eMMC.
+  Please follow the examples with compatible "marvell,armada-3700-sdhci"
+  in below.
+
+Example:
+- For eMMC:
+
+	sdhci@aa0000 {
+		compatible = "marvell,armada-ap806-sdhci";
+		reg = <0xaa0000 0x1000>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
+		clocks = <&emmc_clk>;
+		clock-names = "core";
+		bus-width = <4>;
+		marvell,xenon-phy-slow-mode;
+		marvell,xenon-tun-count = <11>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		apm_mmccard: mmccard@0 {
+			compatible = "mmc-card";
+			reg = <0>;
+		};
+	};
+
+- For SD/SDIO:
+
+	sdhci@ab0000 {
+		compatible = "marvell,armada-cp110-sdhci";
+		reg = <0xab0000 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
+		vqmmc-supply = <&sd_regulator>;
+		clocks = <&sdclk>;
+		clock-names = "core";
+		bus-width = <4>;
+		marvell,xenon-tun-count = <9>;
+	};
+
+- For eMMC with compatible "marvell,armada-3700-sdhci":
+
+	sdhci@aa0000 {
+		compatible = "marvell,armada-3700-sdhci";
+		reg = <0xaa0000 0x1000>,
+		      <phy_addr 0x4>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
+		clocks = <&emmcclk>;
+		clock-names = "core";
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs400-1_8v;
+
+		marvell,pad-type = "fixed-1-8v";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mmccard: mmccard@0 {
+			compatible = "mmc-card";
+			reg = <0>;
+		};
+	};
+
+- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
+
+	sdhci@ab0000 {
+		compatible = "marvell,armada-3700-sdhci";
+		reg = <0xab0000 0x1000>,
+		      <phy_addr 0x4>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
+		vqmmc-supply = <&sd_regulator>;
+		clocks = <&sdclk>;
+		clock-names = "core";
+		bus-width = <4>;
+
+		marvell,pad-type = "sd";
+	};
-- 
git-series 0.9.1
