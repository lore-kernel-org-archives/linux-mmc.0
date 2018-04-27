From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 08/14] ARM: dts: dra72-evm-common: Add wilink8 wlan support
Date: Fri, 27 Apr 2018 17:38:59 +0530
Message-ID: <20180427120905.3665-9-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com, Hari Nagalla <hnagalla@ti.com>, Eyal Reizer <eyalr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Hari Nagalla <hnagalla@ti.com>

Wilink8 module is a combo wireless connectivity card based
on Texas Instrument's wl18xx solution.

Add support for the wlan capabilities of this module by muxing
the relevant mmc lines, and setting the required device-tree
data.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[nsekhar@ti.com: drop WLAN_EN pinmux. It should be done by bootloader.
                 Also, some commit message adjustments]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi   | 42 +++++++++++++++++++++++
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi | 11 ++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 8e3b185d864b..b81214051a89 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -44,6 +44,16 @@
 		regulator-boot-on;
 	};
 
+	evm_3v6: fixedregulator-evm_3v6 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_3v6";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+		vin-supply = <&evm_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_3v3: fixedregulator-vsys3v3 {
 		/* Output 2 of TPS43351QDAPRQ1 on dra72-evm */
 		/* Output 2 of LM5140QRWGTQ1 on dra71-evm */
@@ -171,6 +181,15 @@
 			clocks = <&atl_clkin2_ck>;
 		};
 	};
+
+	vmmcwl_fixed: fixedregulator-mmcwl {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcwl_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &dra7_pmx_core {
@@ -398,6 +417,29 @@
 	max-frequency = <192000000>;
 };
 
+&mmc4 {
+	status = "okay";
+	vmmc-supply = <&evm_3v6>;
+	vqmmc-supply = <&vmmcwl_fixed>;
+	bus-width = <4>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default", "hs", "sdr12", "sdr25";
+	pinctrl-0 = <&mmc4_pins_default>;
+	pinctrl-1 = <&mmc4_pins_default>;
+	pinctrl-2 = <&mmc4_pins_default>;
+	pinctrl-3 = <&mmc4_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wifi@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
 &mac {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi b/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
index 088013c6dc6e..edad87c4292c 100644
--- a/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
+++ b/arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
@@ -202,6 +202,17 @@
 			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MODE_SELECT | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
+
+	mmc4_pins_default: mmc4_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x37e8, PIN_INPUT_PULLUP | MUX_MODE3) /* uart1_ctsn.mmc4_clk */
+			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT_PULLUP | MUX_MODE3) /* uart1_rtsn.mmc4_cmd */
+			DRA7XX_CORE_IOPAD(0x37f0, PIN_INPUT_PULLUP | MUX_MODE3) /* uart2_rxd.mmc4_dat0 */
+			DRA7XX_CORE_IOPAD(0x37f4, PIN_INPUT_PULLUP | MUX_MODE3) /* uart2_txd.mmc4_dat1 */
+			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT_PULLUP | MUX_MODE3) /* uart2_ctsn.mmc4_dat2 */
+			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_PULLUP | MUX_MODE3) /* uart2_rtsn.mmc4_dat3 */
+		>;
+	};
 };
 
 &dra7_iodelay_core {
-- 
2.17.0
