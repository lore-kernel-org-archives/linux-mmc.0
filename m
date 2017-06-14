From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 06/21] arm64: dts: hi3660: add gpio dtsi file for Hisilicon Hi3660 SOC
Date: Wed, 14 Jun 2017 16:23:23 +0800
Message-ID: <20170614082338.15673-7-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

This patch adds pl061 device nodes for Hi3660 SoC.

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 380 ++++++++++++++++++++++++++++++
 1 file changed, 380 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 9abe84e..b03be4d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -251,5 +251,385 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		gpio0: gpio@e8a0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a0b000 0 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 0 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio@e8a0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a0c000 0 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 7 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio@e8a0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a0d000 0 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 14 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio@e8a0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a0e000 0 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 22 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio@e8a0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a0f000 0 0x1000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 30 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio@e8a10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a10000 0 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 38 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio@e8a11000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a11000 0 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 46 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO6>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio@e8a12000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a12000 0 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 54 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO7>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio@e8a13000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a13000 0 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 62 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO8>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio@e8a14000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a14000 0 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 70 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO9>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio@e8a15000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a15000 0 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 78 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO10>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio@e8a16000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a16000 0 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 86 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO11>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio@e8a17000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a17000 0 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 94 3 &pmx0 7 101 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO12>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio@e8a18000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a18000 0 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 102 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO13>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio@e8a19000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a19000 0 0x1000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 110 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO14>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio@e8a1a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a1a000 0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 118 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO15>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio@e8a1b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a1b000 0 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO16>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio@e8a1c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a1c000 0 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO17>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio@ff3b4000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xff3b4000 0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx2 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO18>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio@ff3b5000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xff3b5000 0 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx2 0 8 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO19>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio20: gpio@e8a1f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a1f000 0 0x1000>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 0 0 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO20>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio21: gpio@e8a20000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xe8a20000 0 0x1000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx3 0 0 6>;
+			clocks = <&crg_ctrl HI3660_PCLK_GPIO21>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio22: gpio@fff0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff0b000 0 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO176 */
+			gpio-ranges = <&pmx4 2 0 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio23: gpio@fff0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff0c000 0 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO184 */
+			gpio-ranges = <&pmx4 0 6 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio24: gpio@fff0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff0d000 0 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO192 */
+			gpio-ranges = <&pmx4 0 13 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio25: gpio@fff0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff0e000 0 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO200 */
+			gpio-ranges = <&pmx4 0 21 4 &pmx4 5 25 3>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio26: gpio@fff0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff0f000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO208 */
+			gpio-ranges = <&pmx4 0 28 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio27: gpio@fff10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff10000 0 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO216 */
+			gpio-ranges = <&pmx4 0 36 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio28: gpio@fff1d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0 0xfff1d000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3660_PCLK_AO_GPIO6>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
2.10.2
