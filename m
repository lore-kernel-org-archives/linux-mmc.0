From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: g12a: add SDIO controller
Date: Mon, 27 May 2019 14:43:07 +0200
Message-ID: <20190527124307.32075-4-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@baylibre.com
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
add the port A (SDIO) pinctrl and controller nodes and mark this specific
controller with the amlogic,dram-access-quirk property.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 9f72396ba710..d1a3da9d0b2e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -202,6 +202,30 @@
 						};
 					};
 
+					sdio_pins: sdio {
+						mux {
+							groups = "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_cmd",
+								 "sdio_clk";
+							function = "sdio";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdio_clk_gate_pins: sdio_clk_gate {
+						mux {
+							groups = "GPIOX_4";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -566,6 +590,19 @@
 			};
 		};
 
+		sd_emmc_a: sd@ffe03000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe03000 0x0 0x800>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,dram-access-quirk;
+		};
+
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.21.0
