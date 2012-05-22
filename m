From: <ludovic.desroches@atmel.com>
Subject: [PATCH v3 3/3] ARM: dts: add nodes for atmel hsmci controllers for atmel platforms
Date: Tue, 22 May 2012 12:09:12 +0200
Message-ID: <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:17837 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab2EVKKJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 06:10:09 -0400
In-Reply-To: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add nodes for mci controllers.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi     |   12 ++++++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts    |   16 ++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   17 +++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi      |   24 ++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 773ef48..6a28bfe 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -197,6 +197,18 @@
 				interrupts = <10 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc@fffa800 {
+				compatible = "atmel,hsmci";
+				reg = <0xfffa800 0x600>;
+				interrupts = <9 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot@0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7829a4d..dd94f4b 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,22 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc@f0008000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 15 0>;
+				};
+			};
+
+			mmc1: mmc@f000c000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 14 0>;
+				};
+			};
 		};
 
 		usb0: ohci@00600000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c804214..2922648 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -199,6 +199,30 @@
 				interrupts = <25 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc@fff80000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfff80000 0x600>;
+				interrupts = <11 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot@0 {
+					reg = <0>;
+				};
+			};
+
+			mmc1: mmc@fffd0000 {
+				compatible = "atmel,hsmci";
+				reg = <0xfffd0000 0x600>;
+				interrupts = <29 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot@0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..bc4cb3c 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,23 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc@fff80000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 10 0>;
+				};
+			};
+
+			mmc1: mmc@fffd0000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 11 0>;
+					wp-gpios = <&pioD 29 0>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index dd4ed74..d5999b2 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -190,6 +190,30 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc@f0008000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf0008000 0x600>;
+				interrupts = <12 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot@0 {
+					reg = <0>;
+				};
+			};
+
+			mmc1: mmc@f000c000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf000c000 0x600>;
+				interrupts = <26 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot@0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.5.4

