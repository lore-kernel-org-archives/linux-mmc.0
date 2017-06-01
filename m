From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/7] ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
Date: Thu, 1 Jun 2017 20:03:55 +0530
Message-ID: <20170601143401.16852-2-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61315 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAOew (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2017 10:34:52 -0400
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com, Ravikumar Kattekola <rk@ti.com>

On dra72/dra71 evms, mmc2 vdd/ios are connected to a common 1.8V supply
not 3.3V. Also the regulator that supplies 1.8V is different on dra71-evm
so move the supply property from common dtsi to evm specific dts files.

Fixes: a4240d3af677 ("ARM: dts: Add support for dra72-evm rev C (SR2.0)")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts         | 14 ++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi |  2 --
 arch/arm/boot/dts/dra72-evm-revc.dts    | 14 ++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts         | 14 ++++++++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 4d57a55473af..c7a56b6263a6 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -32,6 +32,16 @@
 			  3000000 0x1>;
 	};
 
+	evm_1v8_sw: fixedregulator-evm_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&lp8732_buck0_reg>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	poweroff: gpio-poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio7 30 GPIO_ACTIVE_HIGH>;
@@ -165,6 +175,10 @@
 	vmmc_aux-supply = <&vpo_sd_1v8_3v3>;
 };
 
+&mmc2 {
+	vmmc-supply = <&evm_1v8_sw>;
+};
+
 &mac {
 	mode-gpios = <&pcf_gpio_21 4 GPIO_ACTIVE_LOW>,
 		     <&pcf_hdmi 9 GPIO_ACTIVE_LOW>,	/* P11 */
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index ad24544adf0f..d97370217eff 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -418,8 +418,6 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
-
-	vmmc-supply = <&evm_3v3_sw>;
 	bus-width = <8>;
 	ti,non-removable;
 	max-frequency = <192000000>;
diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 3ecac56bf504..47dcd527ec58 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -15,6 +15,16 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>; /* 2GB */
 	};
+
+	evm_1v8_sw: fixedregulator-evm_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&smps4_reg>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
@@ -82,3 +92,7 @@
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
+
+&mmc2 {
+	vmmc-supply = <&evm_1v8_sw>;
+};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index cd9c4ff12654..adbcc570eba9 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -13,6 +13,16 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x40000000>; /* 1024 MB */
 	};
+
+	evm_1v8_sw: fixedregulator-evm_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&smps4_reg>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
@@ -43,3 +53,7 @@
 	phy_id = <&davinci_mdio>, <3>;
 	phy-mode = "rgmii";
 };
+
+&mmc2 {
+	vmmc-supply = <&evm_1v8_sw>;
+};
-- 
2.11.0

