From: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 07/21] arm64: dts: hi3660: Add uarts nodes
Date: Wed, 14 Jun 2017 16:23:24 +0800
Message-ID: <20170614082338.15673-8-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wang Xiaoyin <hw.wangxiaoyin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>

Add nodes uart0 to uart4 and uart6 for hi3660 SoC.
Enable uart3 and uart6, disable uart5, in hikey960 board dts.

On HiKey960:
 - UART6 is used as default console, and is wired out through low speed
         expansion connector.
 - UART3 has RTS/CTS hardware handshake, and is wired out through low
         speed expansion connector.
 - UART5 is not used in commercial launched boards. So disable it.
 - UART4 is connected to Bluetooth, WL1837.

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 20 +++++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 74 +++++++++++++++++++++++
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 1a4d6c5..0a3f2e0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -15,11 +15,17 @@
 	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
-		serial5 = &uart5;       /* console UART */
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
 	};
 
 	chosen {
-		stdout-path = "serial5:115200n8";
+		stdout-path = "serial6:115200n8";
 	};
 
 	memory@0 {
@@ -51,6 +57,14 @@
 	status = "okay";
 };
 
-&uart5 {
+&uart3 {
+	/* On Low speed expansion */
+	label = "LS-UART0";
+	status = "okay";
+};
+
+&uart6 {
+	/* On Low speed expansion */
+	label = "LS-UART1";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index b03be4d..7a90c92 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -242,6 +242,66 @@
 			status = "disabled";
 		};
 
+		uart0: serial@fdf02000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf02000 0x0 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_MUX_UART0>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+			status = "disabled";
+		};
+
+		uart1: serial@fdf00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
+				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
+			status = "disabled";
+		};
+
+		uart2: serial@fdf03000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf03000 0x0 0x1000>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
+			status = "disabled";
+		};
+
+		uart3: serial@ffd74000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xffd74000 0x0 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_FACTOR_UART3>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			status = "disabled";
+		};
+
+		uart4: serial@fdf01000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfdf01000 0x0 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
+				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
+			status = "disabled";
+		};
+
 		uart5: serial@fdf05000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
@@ -249,6 +309,20 @@
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart5_pmx_func &uart5_cfg_func>;
+			status = "disabled";
+		};
+
+		uart6: serial@fff32000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0xfff32000 0x0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_UART6>,
+				 <&crg_ctrl HI3660_PCLK>;
+			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart6_pmx_func &uart6_cfg_func>;
 			status = "disabled";
 		};
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
