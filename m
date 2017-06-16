From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/12] ARM: dts: dra7-evm: Add pinmux configuration for MMC
Date: Fri, 16 Jun 2017 17:24:32 +0530
Message-ID: <20170616115439.8508-6-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Include dra74x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra74 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in dra7-evm.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index e4c4037e6314..e74feb7ed53c 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
+#include "dra74x-mmc-iodelay.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clk/ti-dra7-atl.h>
 #include <dt-bindings/input/input.h>
@@ -443,8 +444,6 @@
 
 &mmc1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_default>;
 	vmmc-supply = <&evm_3v3_sd>;
 	vqmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
@@ -453,14 +452,29 @@
 	 * is always hardwired.
 	 */
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50-rev11", "sdr104-rev11", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev11_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev11_conf>;
+	pinctrl-7 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
+	pinctrl-8 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_default>;
 	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
+	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_1_8v_rev11 &mmc2_iodelay_ddr_1_8v_rev11_conf>;
+	pinctrl-3 = <&mmc2_pins_ddr_rev20>;
+	pinctrl-4 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev11_conf>;
+	pinctrl-5 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev20_conf>;
 };
 
 &cpu0 {
-- 
2.11.0
