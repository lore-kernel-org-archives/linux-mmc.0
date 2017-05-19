From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 21/41] ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
Date: Fri, 19 May 2017 13:45:21 +0530
Message-ID: <20170519081541.26753-22-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

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
index 58a2e6599ea7..40a399735533 100644
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
@@ -86,3 +96,7 @@
 &mmc1 {
 	vmmc_aux-supply = <&ldo1_reg>;
 };
+
+&mmc2 {
+	vmmc-supply = <&evm_1v8_sw>;
+};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 1c570236a1a0..b25e7c67badf 100644
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
@@ -47,3 +57,7 @@
 &mmc1 {
 	vmmc_aux-supply = <&ldo1_reg>;
 };
+
+&mmc2 {
+	vmmc-supply = <&evm_1v8_sw>;
+};
-- 
2.11.0
