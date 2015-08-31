From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 7/8] ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices
Date: Mon, 31 Aug 2015 20:24:05 +0200
Message-ID: <1441045446-30858-8-git-send-email-heiko@sntech.de>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>, Heiko Stuebner <heiko@sntech.de>
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
index 118fe74..b084bc6 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -222,8 +222,9 @@
 	sdmmc: dwmmc@ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
@@ -233,8 +234,9 @@
 	sdio0: dwmmc@ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
+			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0d0000 0x4000>;
@@ -244,8 +246,9 @@
 	sdio1: dwmmc@ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>,
+			 <&cru SCLK_SDIO1_DRV>, <&cru SCLK_SDIO1_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0e0000 0x4000>;
@@ -255,8 +258,9 @@
 	emmc: dwmmc@ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
+			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
-- 
2.1.4
