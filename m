From: Hongtao Wu <wuht06@gmail.com>
Subject: [RFC PATCH v3 3/3] DT: Add MMC nodes in Spreadtrum DT files.
Date: Sat, 15 Aug 2015 00:55:53 +0800
Message-ID: <1439571353-30165-4-git-send-email-wuht06@gmail.com>
References: <y>
 <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f195.google.com ([209.85.192.195]:36740 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbbHNQzv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Aug 2015 12:55:51 -0400
In-Reply-To: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com
Cc: Orson.Zhai@spreadtrum.com, Chunyan.Zhang@spreadtrum.com, Jason.Wu@spreadtrum.com

The MMC nodes is used to supply device nodes for Spreadtrum MMC driver.

Signed-off-by: Billows Wu(WuHongtao) <wuht06@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts |   24 ++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        |   44 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9836-openphone.dts b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
index e5657c3..1c6d284 100644
--- a/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
+++ b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
@@ -47,3 +47,27 @@
 &uart3 {
 	status = "okay";
 };
+
+&sdio0 {
+	vmmc-supply = <&vddsdcore>;
+	vqmmc-supply = <&vddsdio>;
+	cd-gpios = <&ap_gpio 141 0>;
+	sprd,delay = <0x03 0x03 0x03>;
+	sprd,name = "sd";
+};
+
+&sdio1 {
+	sprd,delay = <0x03 0x03 0x03>;
+	sprd,name = "wifi";
+	keep-power-in-suspend;
+};
+
+&sdio3 {
+	vmmc-supply = <&vddemmccore>;
+	vqmmc-supply = <&vddgen0>;
+	bus-width = <8>;
+	non-removable;
+	sprd,delay = <0x3e 0xa 0xa>;
+	sprd,name = "emmc";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/sprd/sharkl64.dtsi b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
index 69f64e7..ba4fd21 100644
--- a/arch/arm64/boot/dts/sprd/sharkl64.dtsi
+++ b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
@@ -55,6 +55,44 @@
 				status = "disabled";
 			};
 		};
+
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sdio0: sdio@20300000 {
+				compatible  = "sprd,sdhost-3.0";
+				reg = <0 0x20300000 0 0x1000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_192m>;
+				status = "disabled";
+			};
+
+			sdio1: sdio@20400000 {
+				compatible  = "sprd,sdhost-3.0";
+				reg = <0 0x20400000 0 0x1000>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_192m>;
+				status = "disabled";
+			};
+
+			sdio2: sdio@20500000 {
+				reg = <0 0x20500000 0 0x1000>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			sdio3: sdio@20600000 {
+				compatible  = "sprd,sdhost-3.0";
+				reg = <0 0x20600000 0 0x1000>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_192m>;
+				status = "disabled";
+			};
+		};
+
 	};

 	clk26mhz: clk26mhz {
@@ -62,4 +100,10 @@
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
+
+	ext_192m: ext-192m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000000>;
+	};
 };
--
1.7.9.5

