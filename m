From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 13/14] ARM: dts: dra7: Use sdhci-omap programming model
Date: Thu, 14 Dec 2017 19:10:53 +0530
Message-ID: <20171214134054.7749-14-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the first 2 instances of eMMC/SD/SDIO
controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  3 +--
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  2 +-
 arch/arm/boot/dts/dra7-evm.dts                  |  1 +
 arch/arm/boot/dts/dra7.dtsi                     | 25 ++++++++++++++++---------
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  2 +-
 arch/arm/boot/dts/dra76-evm.dts                 |  3 ++-
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 50e7c3c0d111..44e6720bc939 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -444,8 +444,7 @@
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
-	ti,non-removable;
-	cap-mmc-dual-data-rate;
+	non-removable;
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43cdf523a8a0..855c130afc69 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -423,7 +423,7 @@
 	vmmc-supply = <&v3_3d>;
 	vqmmc-supply = <&v3_3d>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <96000000>;
 };
 
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index ef9c90daa74b..b5ec42f16efc 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -351,6 +351,7 @@
 	status = "okay";
 	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..1acd77f29d0b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1057,17 +1057,21 @@
 		};
 
 		mmc1: mmc@4809c000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
-			ti,dual-volt;
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 61>, <&sdma_xbar 62>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
 			max-frequency = <192000000>;
+			sd-uhs-sdr104;
+			sd-uhs-sdr50;
+			sd-uhs-ddr50;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
+			cap-sd-highspeed;
+			mmc-ddr-1_8v;
+			cap-mmc-highspeed;
 		};
 
 		hdqw1w: 1w@480b2000 {
@@ -1078,15 +1082,18 @@
 		};
 
 		mmc2: mmc@480b4000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			max-frequency = <192000000>;
+			cap-sd-highspeed;
+			sd-uhs-sdr25;
+			sd-uhs-sdr12;
+			mmc-hs200-1_8v;
+			mmc-ddr-1_8v;
+			cap-mmc-highspeed;
 		};
 
 		mmc3: mmc@480ad000 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2e485a13dfd7..4f48f97c9c47 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -421,7 +421,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <192000000>;
 };
 
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 4dd8a5ac8fae..02c01cecc417 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -306,7 +306,7 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vio_3v3_sd>;
-	vmmc_aux-supply = <&ldo4_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
@@ -323,6 +323,7 @@
 	vmmc-supply = <&vio_1v8>;
 	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
-- 
2.11.0
