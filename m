From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 7/8] ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices
Date: Wed, 30 Sep 2015 16:07:43 +0200
Message-ID: <1443622064-14362-8-git-send-email-heiko@sntech.de>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-mmc@vger.kernel.org

From: Alexandru M Stan <amstan@chromium.org>

The drive/sample clocks can be phase shifted.  The drive clock
could be used in a future patch to adjust hold times.  The sample
clock is used for tuning.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 27a397f6..37c5a02 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -225,8 +225,9 @@
 	sdmmc: dwmmc@ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
@@ -236,8 +237,9 @@
 	sdio0: dwmmc@ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
+			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0d0000 0x4000>;
@@ -247,8 +249,9 @@
 	sdio1: dwmmc@ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>,
+			 <&cru SCLK_SDIO1_DRV>, <&cru SCLK_SDIO1_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0e0000 0x4000>;
@@ -258,8 +261,9 @@
 	emmc: dwmmc@ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
+			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
-- 
2.5.1

