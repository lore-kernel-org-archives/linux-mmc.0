From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 02/11] dts: imx53: fix sd card gpio polarity specified in
 device tree
Date: Wed, 22 Jul 2015 20:53:01 +0800
Message-ID: <1437569590-5228-3-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, hs@denx.de, p.zabel@pengutronix.de, tharvey@gateworks.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, ipaton0@gmail.com, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, smoch@web.de, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, lisovy@gmail.com, s.trumtrar@pengutronix.de, robertcnelson@gmail.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx53-ard.dts         | 4 ++--
 arch/arm/boot/dts/imx53-m53evk.dts      | 4 ++--
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 4 ++--
 arch/arm/boot/dts/imx53-smd.dts         | 4 ++--
 arch/arm/boot/dts/imx53-tqma53.dtsi     | 4 ++--
 arch/arm/boot/dts/imx53-tx53.dtsi       | 4 ++--
 arch/arm/boot/dts/imx53-voipac-bsb.dts  | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index e9337ad..3bc1883 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -103,8 +103,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio1 1 0>;
-	wp-gpios = <&gpio1 9 0>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index d0e0f57..53f4088 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -124,8 +124,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio1 1 0>;
-	wp-gpios = <&gpio1 9 0>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index ab4ba39..b0d5542 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -147,8 +147,8 @@
 &esdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc3>;
-	cd-gpios = <&gpio3 11 0>;
-	wp-gpios = <&gpio3 12 0>;
+	cd-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
 	bus-width = <8>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 1d32557..fc89ce1 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -41,8 +41,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio3 13 0>;
-	wp-gpios = <&gpio4 11 0>;
+	cd-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 4f1f0e2..e03373a 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -41,8 +41,8 @@
 	pinctrl-0 = <&pinctrl_esdhc2>,
 		    <&pinctrl_esdhc2_cdwp>;
 	vmmc-supply = <&reg_3p3v>;
-	wp-gpios = <&gpio1 2 0>;
-	cd-gpios = <&gpio1 4 0>;
+	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 704bd72..d3e50b2 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -183,7 +183,7 @@
 };
 
 &esdhc1 {
-	cd-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
 	fsl,wp-controller;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
@@ -191,7 +191,7 @@
 };
 
 &esdhc2 {
-	cd-gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
 	fsl,wp-controller;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>;
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/imx53-voipac-bsb.dts
index c17d3ad..fc51b87 100644
--- a/arch/arm/boot/dts/imx53-voipac-bsb.dts
+++ b/arch/arm/boot/dts/imx53-voipac-bsb.dts
@@ -119,8 +119,8 @@
 &esdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>;
-	cd-gpios = <&gpio3 25 0>;
-	wp-gpios = <&gpio2 19 0>;
+	cd-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
-- 
1.9.1
