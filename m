From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 10/10] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
Date: Sat, 12 Mar 2016 10:15:12 +0100
Message-ID: <1457774112-16958-11-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since RFC:

* rename DT binding name and pinctrl variables to "*uhs" instead of "*1v8"

 arch/arm/boot/dts/r8a7790-lager.dts | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 4972d24a609d2a..db87041617b1d8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -346,11 +346,25 @@
 	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
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
+	sdhi2_pins_uhs: sd2_uhs {
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+		power-source = <1800>;
 	};
 
 	mmc1_pins: mmc1 {
@@ -539,21 +553,25 @@
 
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi2_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.7.0
