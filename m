From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 11/13] ARM: dts: rockchip: replace to "max-frequency" instead
 of "clock-freq-min-max"
Date: Thu, 03 Nov 2016 15:21:33 +0900
Message-ID: <20161103062135.10697-12-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

In drivers/mmc/core/host.c, there is "max-frequency" property.
It should be same behavior. So use the "max-frequency" instead of
"clock-freq-min-max".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 6 +++---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index a935523..d3fb323 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -244,7 +244,7 @@
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
 		clock-frequency = <37500000>;
-		clock-freq-min-max = <400000 37500000>;
+		max-frequency = <37500000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x100>;
@@ -255,7 +255,7 @@
 	sdio: dwmmc@10218000 {
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10218000 0x4000>;
-		clock-freq-min-max = <400000 37500000>;
+		max-frequency = <37500000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
@@ -271,7 +271,7 @@
 		bus-width = <8>;
 		cap-mmc-highspeed;
 		clock-frequency = <37500000>;
-		clock-freq-min-max = <400000 37500000>;
+		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9e6bf0e..8c2e360 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -402,7 +402,7 @@
 		reg = <0x30020000 0x4000>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <37500000>;
-		clock-freq-min-max = <400000 37500000>;
+		max-frequency = <37500000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 17ec2e2..65b60b7 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -227,7 +227,7 @@
 
 	sdmmc: dwmmc@ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -239,7 +239,7 @@
 
 	sdio0: dwmmc@ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
 			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -251,7 +251,7 @@
 
 	sdio1: dwmmc@ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>,
 			 <&cru SCLK_SDIO1_DRV>, <&cru SCLK_SDIO1_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -263,7 +263,7 @@
 
 	emmc: dwmmc@ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-- 
2.10.1
