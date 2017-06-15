From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 4/6] ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC
Date: Thu, 15 Jun 2017 15:16:18 +0800
Message-ID: <1497510980-23207-5-git-send-email-frank.wang@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

This patch adds sdmmc/sdio controller nodes for rk3228 SoC.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index a812422..5e7b54c 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -500,6 +500,32 @@
 		status = "disabled";
 	};
 
+	sdmmc: dwmmc@30000000 {
+		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x30000000 0x4000>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+		status = "disabled";
+	};
+
+	sdio: dwmmc@30010000 {
+		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x30010000 0x4000>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
+			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4>;
+		status = "disabled";
+	};
+
 	emmc: dwmmc@30020000 {
 		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
@@ -710,6 +736,40 @@
 			drive-strength = <12>;
 		};
 
+		sdmmc {
+			sdmmc_clk: sdmmc-clk {
+				rockchip,pins = <1 16 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+
+			sdmmc_cmd: sdmmc-cmd {
+				rockchip,pins = <1 15 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+
+			sdmmc_bus4: sdmmc-bus4 {
+				rockchip,pins = <1 18 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<1 19 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<1 20 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<1 21 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+		};
+
+		sdio {
+			sdio_clk: sdio-clk {
+				rockchip,pins = <3 0 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+
+			sdio_cmd: sdio-cmd {
+				rockchip,pins = <3 1 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+
+			sdio_bus4: sdio-bus4 {
+				rockchip,pins = <3 2 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<3 3 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<3 4 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<3 5 RK_FUNC_1 &pcfg_pull_none_drv_12ma>;
+			};
+		};
+
 		emmc {
 			emmc_clk: emmc-clk {
 				rockchip,pins = <2 7 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.0.0
