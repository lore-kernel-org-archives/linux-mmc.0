From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 12/13] ARM64: dts: rockchip: replace to "max-frequency" instead
 of "clock-freq-min-max"
Date: Thu, 03 Nov 2016 15:21:34 +0900
Message-ID: <20161103062135.10697-13-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

In drivers/mmc/core/host.c, there is "max-freqeuncy" property.
It should be same behavior, So Use the "max-frequency" instead of
"clock-freq-min-max".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi               | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 5797933..0acf8a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -347,7 +347,7 @@
 &sdmmc {
 	bus-width = <4>;
 	clock-frequency = <50000000>;
-	clock-freq-min-max = <400000 50000000>;
+	max-frequency = <50000000>;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	keep-power-in-suspend;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 0fcb214..79e7c88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -231,7 +231,7 @@
 	sdmmc: dwmmc@ff0c0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0c0000 0x0 0x4000>;
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -243,7 +243,7 @@
 	sdio0: dwmmc@ff0d0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0d0000 0x0 0x4000>;
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
 			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
@@ -255,7 +255,7 @@
 	emmc: dwmmc@ff0f0000 {
 		compatible = "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff0f0000 0x0 0x4000>;
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b65c193..b1c011d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -235,7 +235,7 @@
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe310000 0x0 0x4000>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH 0>;
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -248,7 +248,7 @@
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe320000 0x0 0x4000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH 0>;
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-- 
2.10.1
