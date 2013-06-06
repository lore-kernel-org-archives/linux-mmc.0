From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 08/10] ARM: dts: omap3: split omap3_pmx_core
Date: Fri, 7 Jun 2013 00:44:17 +0530
Message-ID: <1370546059-24181-9-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

omap3_pmx_core: padconf register are in two banks 0x48003000 to 0x48002268
and 0x480025c0 to 0x480025f8.

split omap3_pmx_core into 2 banks as register between 0x48002270 and 0x48002564
belongs to type pinctrl-single,bit-per-mux with access to certain bit
fields with bit field mask.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle.dts |   28 ++++++++++++++++++++--------
 arch/arm/boot/dts/omap3.dtsi       |   11 ++++++++++-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 6eec699..7da9979 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -76,17 +76,11 @@
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&hsusbb2_pins
+			&hsusbb2_pins1
 	>;
 
-	hsusbb2_pins: pinmux_hsusbb2_pins {
+	hsusbb2_pins1: pinmux_hsusbb2_pins1 {
 		pinctrl-single,pins = <
-			0x5c0 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
-			0x5c2 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
-			0x5c4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
-			0x5c6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
-			0x5c8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
-			0x5cA 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
 			0x1a4 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat2 INPUT | PULLDOWN */
 			0x1a6 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat3 INPUT | PULLDOWN */
 			0x1a8 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat4 INPUT | PULLDOWN */
@@ -97,6 +91,24 @@
 	};
 };
 
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusbb2_pins2
+	>;
+
+	hsusbb2_pins2: pinmux_hsusbb2_pins2 {
+		pinctrl-single,pins = <
+			0x50 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_clk OUTPUT */
+			0x52 0x3  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_stp OUTPUT */
+			0x54 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dir INPUT | PULLDOWN */
+			0x56 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_nxt INPUT | PULLDOWN */
+			0x58 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat0 INPUT | PULLDOWN */
+			0x5A 0x10b  /* USBB2_ULPITLL_CLK_MUXMODE.usbb1_ulpiphy_dat1 INPUT | PULLDOWN */
+		>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 82a404d..caaa708 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -95,7 +95,16 @@
 
 		omap3_pmx_core: pinmux@48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x05cc>;
+			reg = <0x48002030 0x238>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7f1f>;
+		};
+
+		omap3_pmx_core2: pinmux@480025a0 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x480025a0 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-- 
1.7.5.4
