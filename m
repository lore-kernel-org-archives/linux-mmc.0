From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible on
 sun7i and newer
Date: Sat, 30 Jul 2016 16:25:48 +0200
Message-ID: <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-mmc@vger.kernel.org

Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
and newer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set
---
 arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
 arch/arm/boot/dts/sun7i-a20.dtsi     | 8 ++++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
 arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 1867af2..0d24f10 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -469,7 +469,7 @@
 		};
 
 		mmc0: mmc@01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb1_gates 8>,
 				 <&mmc0_clk 0>,
@@ -488,7 +488,7 @@
 		};
 
 		mmc1: mmc@01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb1_gates 9>,
 				 <&mmc1_clk 0>,
@@ -507,7 +507,7 @@
 		};
 
 		mmc2: mmc@01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb1_gates 10>,
 				 <&mmc2_clk 0>,
@@ -526,7 +526,7 @@
 		};
 
 		mmc3: mmc@01c12000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ahb1_gates 11>,
 				 <&mmc3_clk 0>,
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bd0c476..94cf5a1 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -905,7 +905,7 @@
 		};
 
 		mmc0: mmc@01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb_gates 8>,
 				 <&mmc0_clk 0>,
@@ -922,7 +922,7 @@
 		};
 
 		mmc1: mmc@01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb_gates 9>,
 				 <&mmc1_clk 0>,
@@ -939,7 +939,7 @@
 		};
 
 		mmc2: mmc@01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb_gates 10>,
 				 <&mmc2_clk 0>,
@@ -956,7 +956,7 @@
 		};
 
 		mmc3: mmc@01c12000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ahb_gates 11>,
 				 <&mmc3_clk 0>,
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7e05e09..e3b196e 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -266,7 +266,7 @@
 		};
 
 		mmc0: mmc@01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb1_gates 8>,
 				 <&mmc0_clk 0>,
@@ -285,7 +285,7 @@
 		};
 
 		mmc1: mmc@01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb1_gates 9>,
 				 <&mmc1_clk 0>,
@@ -304,7 +304,7 @@
 		};
 
 		mmc2: mmc@01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb1_gates 10>,
 				 <&mmc2_clk 0>,
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 93c88f3..b5cc2dc 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -154,7 +154,7 @@
 		};
 
 		mmc0: mmc@01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC0>,
 				 <&ccu CLK_MMC0>,
@@ -173,7 +173,7 @@
 		};
 
 		mmc1: mmc@01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC1>,
 				 <&ccu CLK_MMC1>,
@@ -192,7 +192,7 @@
 		};
 
 		mmc2: mmc@01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC2>,
 				 <&ccu CLK_MMC2>,
-- 
2.7.4
