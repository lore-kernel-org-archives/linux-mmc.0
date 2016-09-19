From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 5/6] arm64: dts: r8a7795: salvator: enable on-board eMMC
Date: Mon, 19 Sep 2016 22:57:49 +0200
Message-ID: <20160919205750.4766-6-wsa+renesas@sang-engineering.com>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37819 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbcISU6L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 16:58:11 -0400
In-Reply-To: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 8964b1ea3cea69..8e98aeae54c066 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -62,6 +62,24 @@
 		clock-frequency = <24576000>;
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
 
@@ -246,6 +264,18 @@
 		power-source = <1800>;
 	};
 
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data8", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <3300>;
+	};
+
+	sdhi2_pins_uhs: sd2_uhs {
+		groups = "sdhi2_data8", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <1800>;
+	};
+
 	sdhi3_pins: sd3 {
 		groups = "sdhi3_data4", "sdhi3_ctrl";
 		function = "sdhi3";
@@ -398,6 +428,19 @@
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
+	non-removable;
+	status = "okay";
+};
+
 &sdhi3 {
 	pinctrl-0 = <&sdhi3_pins>;
 	pinctrl-1 = <&sdhi3_pins_uhs>;
-- 
2.9.3

