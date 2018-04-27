From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 12/14] ARM: dts: dra7: Use sdhci-omap programming model
Date: Fri, 27 Apr 2018 17:39:03 +0530
Message-ID: <20180427120905.3665-13-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the eMMC/SD/SDIO controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../boot/dts/am57xx-beagle-x15-common.dtsi    |  4 +--
 arch/arm/boot/dts/am57xx-beagle-x15.dts       |  1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi      |  3 ++-
 arch/arm/boot/dts/dra7-evm.dts                |  1 +
 arch/arm/boot/dts/dra7.dtsi                   | 27 +++++++------------
 arch/arm/boot/dts/dra72-evm-common.dtsi       |  2 +-
 arch/arm/boot/dts/dra76-evm.dts               |  3 ++-
 7 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 6204a266212a..ad953113cefb 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -444,8 +444,8 @@
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
-	ti,non-removable;
-	cap-mmc-dual-data-rate;
+	non-removable;
+	no-1-8-v;
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index c76ea6579a81..70a71c641066 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -25,6 +25,7 @@
 	pinctrl-1 = <&mmc1_pins_hs>;
 
 	vmmc-supply = <&ldo1_reg>;
+	no-1-8-v;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43a6d0590f7c..ad87f1ae904d 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -412,8 +412,9 @@
 	vmmc-supply = <&v3_3d>;
 	vqmmc-supply = <&v3_3d>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <96000000>;
+	no-1-8-v;
 };
 
 &dcan1 {
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 704947cbef48..0894593860d6 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -377,6 +377,7 @@
 	vmmc-supply = <&evm_1v8_sw>;
 	vqmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f4ddd86f2c77..ae2f8dd46328 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1079,14 +1079,10 @@
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
@@ -1100,40 +1096,37 @@
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
+			/* SDR104/DDR50/SDR50 bits in CAPA2 is not supported */
+			sdhci-caps-mask = <0x7 0x0>;
 		};
 
 		mmc3: mmc@480ad000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			/* Errata i887 limits max-frequency of MMC3 to 64 MHz */
 			max-frequency = <64000000>;
+			/* SDMA is not supported */
+			sdhci-caps-mask = <0x0 0x400000>;
 		};
 
 		mmc4: mmc@480d1000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-sdhci";
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
-			ti,needs-special-reset;
-			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
-			dma-names = "tx", "rx";
 			status = "disabled";
 			max-frequency = <192000000>;
+			/* SDMA is not supported */
+			sdhci-caps-mask = <0x0 0x400000>;
 		};
 
 		mmu0_dsp1: mmu@40d01000 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index b81214051a89..df174f5c15d1 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -413,7 +413,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 	max-frequency = <192000000>;
 };
 
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index ad154c7b0632..c07f0051844d 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -327,7 +327,7 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vio_3v3_sd>;
-	vmmc_aux-supply = <&ldo4_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
@@ -344,6 +344,7 @@
 	vmmc-supply = <&vio_1v8>;
 	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
+	non-removable;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_default>;
-- 
2.17.0
