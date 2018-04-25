From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 07/15] ARM: dts: dra71-evm: Use pinctrl group from dra72x-mmc-iodelay.dtsi to select pulldown
Date: Wed, 25 Apr 2018 18:24:41 +0530
Message-ID: <20180425125449.19755-8-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

commit 0e43884cca77218d2eccc331396e8 ("ARM: dts: dra71-evm: Select pull
down for mmc1_clk line in default mode") modified mmc1_pins_default
pinctrl group in dra71-evm.dts to change the CLK line to
PIN_INPUT_PULLDOWN. However instead of changing the pinctrl group,
use the new pinctrl group "mmc1_pins_default_no_clk_pu" in
dra72x-mmc-iodelay added specifically to be used for CLK line
without external pull up.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 64c57d87ca2f..8065678b8016 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -50,19 +50,6 @@
 	};
 };
 
-&dra7_pmx_core {
-	mmc1_pins_default: mmc1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
-			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
-		>;
-	};
-};
-
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -187,7 +174,7 @@
 
 &mmc1 {
 	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
-	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
 	pinctrl-2 = <&mmc1_pins_sdr12>;
 	pinctrl-3 = <&mmc1_pins_sdr25>;
-- 
2.17.0
