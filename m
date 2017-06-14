From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 04/21] arm64: dts: hi3660: add resources for clock and reset
Date: Wed, 14 Jun 2017 16:23:21 +0800
Message-ID: <20170614082338.15673-5-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Add some resource nodes for clock and reset

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 53 +++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3983086..f55710a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/hi3660-clock.h>
 
 / {
 	compatible = "hisilicon,hi3660";
@@ -141,18 +142,56 @@
 		#size-cells = <2>;
 		ranges;
 
-		fixed_uart5: fixed_19_2M {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <19200000>;
-			clock-output-names = "fixed:uart5";
+		crg_ctrl: crg_ctrl@fff35000 {
+			compatible = "hisilicon,hi3660-crgctrl", "syscon";
+			reg = <0x0 0xfff35000 0x0 0x1000>;
+			#clock-cells = <1>;
 		};
 
-		uart5: uart@fdf05000 {
+		crg_rst: crg_rst_controller {
+			compatible = "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&crg_ctrl>;
+		};
+
+
+		pctrl: pctrl@e8a09000 {
+			compatible = "hisilicon,hi3660-pctrl", "syscon";
+			reg = <0x0 0xe8a09000 0x0 0x2000>;
+			#clock-cells = <1>;
+		};
+
+		pmuctrl: crg_ctrl@fff34000 {
+			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
+			reg = <0x0 0xfff34000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sctrl: sctrl@fff0a000 {
+			compatible = "hisilicon,hi3660-sctrl", "syscon";
+			reg = <0x0 0xfff0a000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		iomcu: iomcu@ffd7e000 {
+			compatible = "hisilicon,hi3660-iomcu", "syscon";
+			reg = <0x0 0xffd7e000 0x0 0x1000>;
+			#clock-cells = <1>;
+
+		};
+
+		iomcu_rst: reset {
+			compatible = "hisilicon,hi3660-reset";
+			hisi,rst-syscon = <&iomcu>;
+			#reset-cells = <2>;
+		};
+
+		uart5: serial@fdf05000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&fixed_uart5 &fixed_uart5>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
+				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
-- 
2.10.2
