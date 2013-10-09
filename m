From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 01/10] ARM: dts: imx6sl: add pinctrl uhs states for usdhc
Date: Wed, 9 Oct 2013 19:20:07 +0800
Message-ID: <1381317616-1229-2-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:36464
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab3JILeo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:34:44 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

This is needed for SD3.0 cards working on UHS mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts |   12 ++++-
 arch/arm/boot/dts/imx6sl.dtsi    |   77 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 2886a59..d2f46c6 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -50,8 +50,10 @@
 };
 
 &usdhc1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1_1>;
+	pinctrl-1 = <&pinctrl_usdhc1_1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_1_200mhz>;
 	bus-width = <8>;
 	cd-gpios = <&gpio4 7 0>;
 	wp-gpios = <&gpio4 6 0>;
@@ -59,16 +61,20 @@
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2_1>;
+	pinctrl-1 = <&pinctrl_usdhc2_1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_1_200mhz>;
 	cd-gpios = <&gpio5 0 0>;
 	wp-gpios = <&gpio4 29 0>;
 	status = "okay";
 };
 
 &usdhc3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	pinctrl-1 = <&pinctrl_usdhc3_1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_1_200mhz>;
 	cd-gpios = <&gpio3 22 0>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..d0ae4c6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -572,6 +572,38 @@
 							MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x17059
 						>;
 					};
+
+					pinctrl_usdhc1_1_100mhz: usdhc1grp-1-100mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD1_CMD__SD1_CMD 0x170b9
+							MX6SL_PAD_SD1_CLK__SD1_CLK 0x100b9
+							MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x170b9
+							MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x170b9
+							MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x170b9
+							MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x170b9
+							MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x170b9
+							MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x170b9
+							MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x170b9
+							MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x170b9
+						>;
+					};
+
+					pinctrl_usdhc1_1_200mhz: usdhc1grp-1-200mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD1_CMD__SD1_CMD 0x170f9
+							MX6SL_PAD_SD1_CLK__SD1_CLK 0x100f9
+							MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x170f9
+							MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x170f9
+							MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x170f9
+							MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x170f9
+							MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x170f9
+							MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x170f9
+							MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x170f9
+							MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x170f9
+						>;
+					};
+
+
 				};
 
 				usdhc2 {
@@ -585,6 +617,29 @@
 							MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc2_1_100mhz: usdhc2grp-1-100mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD2_CMD__SD2_CMD    0x170b9
+							MX6SL_PAD_SD2_CLK__SD2_CLK    0x100b9
+							MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x170b9
+							MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x170b9
+							MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x170b9
+							MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x170b9
+						>;
+					};
+
+					pinctrl_usdhc2_1_200mhz: usdhc2grp-1-200mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD2_CMD__SD2_CMD    0x170f9
+							MX6SL_PAD_SD2_CLK__SD2_CLK    0x100f9
+							MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x170f9
+							MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x170f9
+							MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x170f9
+							MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x170f9
+						>;
+					};
+
 				};
 
 				usdhc3 {
@@ -598,6 +653,28 @@
 							MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x17059
 						>;
 					};
+
+					pinctrl_usdhc3_1_100mhz: usdhc3grp-1-100mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD3_CMD__SD3_CMD    0x170b9
+							MX6SL_PAD_SD3_CLK__SD3_CLK    0x100b9
+							MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x170b9
+							MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x170b9
+							MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x170b9
+							MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x170b9
+						>;
+					};
+
+					pinctrl_usdhc3_1_200mhz: usdhc3grp-1-200mhz {
+						fsl,pins = <
+							MX6SL_PAD_SD3_CMD__SD3_CMD    0x170f9
+							MX6SL_PAD_SD3_CLK__SD3_CLK    0x100f9
+							MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x170f9
+							MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x170f9
+							MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x170f9
+							MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x170f9
+						>;
+					};
 				};
 			};
 
-- 
1.7.2.rc3


