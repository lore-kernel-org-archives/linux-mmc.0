From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3] ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc"
Date: Fri, 9 Jun 2017 17:38:18 +0530
Message-ID: <20170609120818.13667-1-kishon@ti.com>
References: <20170607093749.15656-9-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:50369 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdFIMI7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 08:08:59 -0400
In-Reply-To: <20170607093749.15656-9-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com

Replace deprecated "vmmc_aux" with the generic "vqmmc" binding for
MMC IO supply.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v2:
Rebased on [1].
[1] -> https://www.spinics.net/lists/arm-kernel/msg586977.html
 arch/arm/boot/dts/am572x-idk.dts               | 2 +-
 arch/arm/boot/dts/dra7-evm.dts                 | 2 +-
 arch/arm/boot/dts/dra71-evm.dts                | 2 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi      | 2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts          | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts             | 2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts           | 2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts           | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-n900.dts               | 2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts              | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts             | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 8350b4b34b08..8d538f5d9a5f 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -79,7 +79,7 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&v3_3d>;
-	vmmc_aux-supply = <&ldo1_reg>;
+	vqmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index e5d7e7f5f645..e4c4037e6314 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -446,7 +446,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_default>;
 	vmmc-supply = <&evm_3v3_sd>;
-	vmmc_aux-supply = <&ldo1_reg>;
+	vqmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index c7a56b6263a6..02c11e658810 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -172,7 +172,7 @@
 };
 
 &mmc1 {
-	vmmc_aux-supply = <&vpo_sd_1v8_3v3>;
+	vqmmc-supply = <&vpo_sd_1v8_3v3>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
index e6df676886c0..57bfe5caf5e4 100644
--- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
@@ -146,5 +146,5 @@
 };
 
 &mmc1 {
-	vmmc_aux-supply = <&ldo1_reg>;
+	vqmmc-supply = <&ldo1_reg>;
 };
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 673cee2234b2..683b96a8f73e 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -299,7 +299,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 4be85ce59dd1..4d2eaf843fa9 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -283,7 +283,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index 53ae04f9104d..3d293b345e99 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -129,7 +129,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&wl12xx_vmmc2>;
-	vmmc_aux-supply = <&wl12xx_vaux2>;
+	vqmmc-supply = <&wl12xx_vaux2>;
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 2294f5b0aa10..bdf4b7fdda39 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -69,7 +69,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&wl12xx_vmmc2>;
-	vmmc_aux-supply = <&wl12xx_vaux2>;
+	vqmmc-supply = <&wl12xx_vaux2>;
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index f330c69cc683..4036cef4f9fc 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -149,7 +149,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 090475083c2f..b831f2ed1abc 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -98,7 +98,7 @@
 &mmc1 {
 	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 49f37084e435..92c1f4ac4040 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -741,7 +741,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&vaux3>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index cd220342a805..f25e158e7163 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -181,7 +181,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&w3cbw003c_npoweron>;
-	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
+	vqmmc-supply = <&w3cbw003c_wifi_nreset>;
 	bus-width = <4>;
 	cap-sdio-irq;
 	non-removable;
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index dc80886b5329..ac6ff9b4db94 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -224,7 +224,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_HIGH>;
 	bus-width = <8>;
 };
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 45e2ce0803de..96d0301a336a 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -174,7 +174,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index abd6921143be..908951eb5943 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -33,7 +33,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
+	vqmmc-supply = <&vsim>;
 	/*
 	 * S6-3 must be in ON position for 8 bit mode to function
 	 * Else, use 4 bit mode
-- 
2.11.0

