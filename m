From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] arm64: dts: r8a7796: salvator: enable on board eMMC
Date: Wed, 14 Sep 2016 19:09:43 +0200
Message-ID: <20160914170943.1663-3-wsa+renesas@sang-engineering.com>
References: <20160914170943.1663-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160914170943.1663-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 91440eb2237e72..db27615fc6ff9f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -31,6 +31,24 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 
+	reg_1p8v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -78,7 +96,6 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
-
 };
 
 &pfc {
@@ -106,6 +123,18 @@
 		power-source = <1800>;
 	};
 
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data8", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <3300>;
+	};
+
+	sdhi2_pins_uhs: sd2 {
+		groups = "sdhi2_data8", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <1800>;
+	};
+
 	sdhi3_pins: sd3 {
 		groups = "sdhi3_data4", "sdhi3_ctrl";
 		function = "sdhi3";
@@ -138,6 +167,19 @@
 	status = "okay";
 };
 
+&sdhi2 {
+	/* used for on-board 8bit eMMC */
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-1 = <&sdhi2_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	status = "okay";
+	/* 'non-removable;' does not work currently. Needs PM fixes. */
+};
+
 &sdhi3 {
 	pinctrl-0 = <&sdhi3_pins>;
 	pinctrl-1 = <&sdhi3_pins_uhs>;
-- 
2.9.3
