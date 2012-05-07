From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 10/10] ARM: dts: enable mmc for imx28-evk
Date: Mon,  7 May 2012 22:43:12 +0800
Message-ID: <1336401793-13753-11-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab2EGOoX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:44:23 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:44:23 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   19 +++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 5aee8ed..6ca10f2 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -21,6 +21,25 @@
 	};
 
 	apb@80000000 {
+		apbh@80000000 {
+			ssp0: ssp@80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				fsl,bus-width = <8>;
+				wp-gpios = <&gpio2 12 0>;
+				status = "okay";
+			};
+
+			ssp1: ssp@80012000 {
+				compatible = "fsl,imx28-mmc";
+				fsl,bus-width = <8>;
+				wp-gpios = <&gpio0 28 0>;
+				status = "okay";
+			};
+		};
+
 		apbx@80040000 {
 			duart: serial@80074000 {
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 1abd9b3..8596bdf 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -81,24 +81,28 @@
 			ssp0: ssp@80010000 {
 				reg = <0x80010000 2000>;
 				interrupts = <96 82>;
+				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
 
 			ssp1: ssp@80012000 {
 				reg = <0x80012000 2000>;
 				interrupts = <97 83>;
+				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
 			ssp2: ssp@80014000 {
 				reg = <0x80014000 2000>;
 				interrupts = <98 84>;
+				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
 			ssp3: ssp@80016000 {
 				reg = <0x80016000 2000>;
 				interrupts = <99 85>;
+				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
 			};
 
@@ -179,6 +183,27 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
+
+				mmc0_8bit_pins_a: mmc0-8bit@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2000 0x2010 0x2020
+						0x2030 0x2040 0x2050 0x2060
+						0x2070 0x2080 0x2090 0x20a0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc0_cd_cfg: mmc0-cd-cfg {
+					fsl,pinmux-ids = <0x2090>;
+					fsl,pull-up = <0>;
+				};
+
+				mmc0_sck_cfg: mmc0-sck-cfg {
+					fsl,pinmux-ids = <0x20a0>;
+					fsl,drive-strength = <2>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl@8001c000 {
-- 
1.7.5.4

