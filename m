From: Loys Ollivier <lollivier@baylibre.com>
Subject: [PATCH v4] arm64: dts: meson: Fix mmc cd-gpios polarity
Date: Mon, 14 Jan 2019 15:44:21 +0100
Message-ID: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org
Cc: Loys Ollivier <lollivier@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
changed the behavior of "cd-inverted" to follow the device tree bindings
specification:
According to SDHCI standard, CD lines are specified as "active low".
Using the "cd-inverted" property means that the CD line is "active high".

Fix the SD card description for meson by setting the cd-gpios as
"active low", according to the boards specifications, and dropping the
"cd-inverted" property.

Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v4: commit message clarification on the "cd-inverted" property and usage.

v3: fix typos in the commit message.

v2: fix more occurences, also in other meson boards.

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
 14 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index e14e0ce7e89f..016641a41694 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -187,8 +187,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 8cd50b75171d..ade2ee09ae96 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -305,8 +305,7 @@
 	max-frequency = <200000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddio_ao3v3>;
 	vqmmc-supply = <&vddio_tf>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 4cf7f6e80c6a..25105ac96d55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..1cc9dc68ef00 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -258,8 +258,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&tflash_vdd>;
 	vqmmc-supply = <&tf_io>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index ce862266b9aa..0be0f2a5d2fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -196,8 +196,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 93a4acf2c46c..ad4d50bd9d77 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -154,8 +154,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index ec09bb5792b7..2d2db783c44c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -211,8 +211,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vcc_3v3>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index f1c410e2da2b..796baea7a0bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -131,8 +131,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index db293440e4ca..255cede7b447 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vcc_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6739697be1de..9cbdb85fb591 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -183,8 +183,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index a1b31013ab6e..bc811a2faf42 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -137,8 +137,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 3c3a667a8df8..3f086ed7de05 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -356,8 +356,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index f7a1cffab4a8..8acfd40090d2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -147,8 +147,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 7212dc4531e4..7fa20a8ede17 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -170,8 +170,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
-- 
2.7.4
