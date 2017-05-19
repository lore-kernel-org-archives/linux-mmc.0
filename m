From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 32/41] ARM: dts: dra71-evm: Add pinmux configuration for MMC
Date: Fri, 19 May 2017 13:45:32 +0530
Message-ID: <20170519081541.26753-33-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Include dra72x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra72 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in dra71-evm.dts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index c7a56b6263a6..c87eab0721b6 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -7,6 +7,7 @@
  */
 
 #include "dra72-evm-common.dtsi"
+#include "dra72x-mmc-iodelay.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
@@ -172,10 +173,23 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50_rev20 &mmc1_iodelay_ddr50_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 	vmmc_aux-supply = <&vpo_sd_1v8_3v3>;
 };
 
 &mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
+	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev20_conf>;
 	vmmc-supply = <&evm_1v8_sw>;
 };
 
-- 
2.11.0

