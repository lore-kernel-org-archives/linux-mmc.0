From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 7/7] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
Date: Fri, 19 Feb 2016 21:16:43 +0100
Message-ID: <1455913003-6140-8-git-send-email-wsa@the-dreams.de>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index cdc0414f5f0716..08eef61ffad1af 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -327,11 +327,25 @@
 	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	sdhi0_pins_1v8: sd0_1v8 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0";
+		power-source = <1800>;
 	};
 
 	sdhi2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
+		power-source = <3300>;
+	};
+
+	sdhi2_pins_1v8: sd2_1v8 {
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+		power-source = <1800>;
 	};
 
 	mmc1_pins: mmc1 {
@@ -515,21 +529,25 @@
 
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi0_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi2_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.7.0
