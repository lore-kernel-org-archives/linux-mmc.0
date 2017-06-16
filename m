From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/12] ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
Date: Fri, 16 Jun 2017 17:24:33 +0530
Message-ID: <20170616115439.8508-7-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170616115439.8508-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Include dra74x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra74 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in am57xx-beagle-x15/am57xx-beagle-x15-revb1.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 29 +------------------------
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   | 15 +++++++++++++
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 11 ++++++++++
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 585d792a8fdd..064755e6fac5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -9,6 +9,7 @@
 
 #include "dra74x.dtsi"
 #include "am57xx-commercial-grade.dtsi"
+#include "dra74x-mmc-iodelay.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
@@ -166,34 +167,6 @@
 	};
 };
 
-&dra7_pmx_core {
-	mmc1_pins_default: mmc1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
-			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
-			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
-		>;
-	};
-
-	mmc2_pins_default: mmc2_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
-			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
-			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
-			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
-			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
-			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
-			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
-			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
-			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
-			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
-		>;
-	};
-};
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 578398c781b1..5a77b334923d 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -19,10 +19,25 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev11_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev11_conf>;
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&ldo1_reg>;
 };
 
+&mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
+};
+
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
 &phy1 {
 	max-speed = <100>;
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 19a60a11c198..d6689106d2a8 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -20,9 +20,20 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default", "hs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+
 	vmmc-supply = <&ldo1_reg>;
 };
 
+&mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
+};
+
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
 &phy1 {
 	max-speed = <100>;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
