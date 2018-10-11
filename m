From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
Date: Thu, 11 Oct 2018 14:35:22 +0800
Message-ID: <20181011063522.7767-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yinbo.zhu@nxp.com, yangbo.lu@nxp.com, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, leoyang.li@nxp.com
Cc: xiaobo.xie@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There are two eSDHC controllers in lx2160a. This patch is to
enable eSDHC for RDB and QDS board.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		squash all lx2160a esdhc dts patch into the original patch

 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |    8 ++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   15 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   25 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index bc30173..b58b96c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -294,6 +294,14 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
 &dspi0 {
 	dflash0: n25q128a {
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 53b0e80..cbe8919 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -170,6 +170,21 @@
 	status = "okay";
 };
 
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &fspi {
 	status = "okay";
 	nxp,fspi-has-second-chip;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index fa4a1f8..174544a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -356,6 +356,31 @@
 			little-endian;
 		};
 
+		esdhc0: esdhc@2140000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <0 28 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2150000 0x0 0x10000>;
+			interrupts = <0 63 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
1.7.1
