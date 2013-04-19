From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/6] ARM: at91: dts: add i2c dma support
Date: Fri, 19 Apr 2013 11:11:21 +0200
Message-ID: <1366362683-14496-5-git-send-email-ludovic.desroches@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366362683-14496-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Add DMA resources to i2c nodes.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 9 +++++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 9 +++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index acc4526..f912124 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -361,6 +361,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
 				interrupts = <9 4 6>;
+				dmas = <&dma0 1 13>,
+				       <&dma0 1 14>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -370,6 +373,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
 				interrupts = <10 4 6>;
+				dmas = <&dma0 1 15>,
+				       <&dma0 1 16>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8e83d87..16c9b81 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -519,6 +519,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
 				interrupts = <9 4 6>;
+				dmas = <&dma0 1 7>,
+				       <&dma0 1 8>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pinctrl-names = "default";
@@ -530,6 +533,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
 				interrupts = <10 4 6>;
+				dmas = <&dma1 1 5>,
+				       <&dma1 1 6>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pinctrl-names = "default";
@@ -541,6 +547,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8018000 0x100>;
 				interrupts = <11 4 6>;
+				dmas = <&dma0 1 9>,
+				       <&dma0 1 10>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 95c00a3..8e87277 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -111,6 +111,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0014000 0x4000>;
 				interrupts = <18 4 6>;
+				dmas = <&dma0 2 7>,
+				       <&dma0 2 8>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0>;
 				#address-cells = <1>;
@@ -122,6 +125,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0018000 0x4000>;
 				interrupts = <19 4 6>;
+				dmas = <&dma0 2 9>,
+				       <&dma0 2 10>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c1>;
 				#address-cells = <1>;
@@ -294,6 +300,9 @@
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf801c000 0x4000>;
 				interrupts = <20 4 6>;
+				dmas = <&dma1 2 11>,
+				       <&dma1 2 12>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
1.7.11.3
