From: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 5/7] ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC
Date: Thu, 22 Jun 2017 15:23:52 +0800
Message-ID: <1498116232-22848-1-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, charles.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kevan.lan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wmc-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

This patch adds sdmmc/sdio controller nodes for rk3228 SoC.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 arch/arm/boot/dts/rk322x.dtsi | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index c4d43ce..66578fa 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -522,6 +522,32 @@
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
@@ -732,6 +758,40 @@
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
