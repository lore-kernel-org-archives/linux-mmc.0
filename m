From: Balaji T K <balajitk@ti.com>
Subject: [RFC PATCH v3 6/8] ARM: dts: add pbias-supply
Date: Thu, 21 Nov 2013 19:50:25 +0530
Message-ID: <1385043627-30439-7-git-send-email-balajitk@ti.com>
References: <20130613174554.GB1403@sirena.org.uk>
 <1385043627-30439-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1385043627-30439-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add pbias-supply to mmc1/sd card.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts            |    1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    1 +
 arch/arm/boot/dts/omap3-beagle.dts        |    1 +
 arch/arm/boot/dts/omap3-devkit8000.dts    |    1 +
 arch/arm/boot/dts/omap3-evm-common.dtsi   |    1 +
 arch/arm/boot/dts/omap3-gta04.dts         |    1 +
 arch/arm/boot/dts/omap3-igep.dtsi         |    1 +
 arch/arm/boot/dts/omap3-n900.dts          |    1 +
 arch/arm/boot/dts/omap3-overo.dtsi        |    1 +
 arch/arm/boot/dts/omap3-zoom3.dts         |    1 +
 arch/arm/boot/dts/omap3430-sdp.dts        |    1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi |    1 +
 arch/arm/boot/dts/omap4-sdp.dts           |    1 +
 arch/arm/boot/dts/omap4-var-som.dts       |    1 +
 arch/arm/boot/dts/omap5-uevm.dts          |    1 +
 15 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..b2a5099 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -261,6 +261,7 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&ldo1_reg>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 31a632f..1e9290d 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -166,6 +166,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index fa532aa..bb335c9 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -129,6 +129,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 4665421..ff8a9f9 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -86,6 +86,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 3007e79..be47a37 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -64,6 +64,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index b9b55c9..95854ea 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -142,6 +142,7 @@
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index ba1e58b..6f74003 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -114,6 +114,7 @@
       pinctrl-0 = <&mmc1_pins>;
       vmmc-supply = <&vmmc1>;
       vmmc_aux-supply = <&vsim>;
+      pbias-supply = <&pbias_regulator>;
       bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c4f20bf..73f26ad 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -354,6 +354,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
 };
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a461d2f..e697f0e 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -61,6 +61,7 @@
 /* on board microSD slot */
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 };
 
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 15eb9fe..a6e1557 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -168,6 +168,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 281914e..cee3ee4 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -34,6 +34,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05..7a1758b 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -346,6 +346,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index dbc81fb..1d2be1d 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -416,6 +416,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <8>;
 };
 
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index b41269e..9ccb07c 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -75,6 +75,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vmmc>;
+	pbias-supply = <&pbias_regulator>;
 	ti,bus-width = <8>;
 	ti,non-removable;
 };
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 002fa70..76eae5a 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -204,6 +204,7 @@
 
 &mmc1 {
 	vmmc-supply = <&ldo9_reg>;
+	pbias-supply = <&pbias_regulator>;
 	bus-width = <4>;
 };
 
-- 
1.7.5.4

