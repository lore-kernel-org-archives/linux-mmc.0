From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] ARM: at91: dts: add MCI DMA support
Date: Tue, 16 Apr 2013 15:03:10 +0200
Message-ID: <1366117390-24686-7-git-send-email-ludovic.desroches@atmel.com>
References: <1366117390-24686-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366117390-24686-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Add DMA resources to MCI nodes.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 ++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++++
 arch/arm/boot/dts/sama5d3.dtsi     | 6 ++++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 275e768..de2abc0 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -513,6 +513,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
 				interrupts = <11 4 0>;
+				dmas = <&dma0 1 0>;
+				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -522,6 +524,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xfffd0000 0x600>;
 				interrupts = <29 4 0>;
+				dmas = <&dma0 1 13>;
+				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index f912124..0b61c41 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -89,6 +89,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
 				interrupts = <12 4 0>;
+				dmas = <&dma0 1 0>
+				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 16c9b81..5f42e7a 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -449,6 +449,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
 				interrupts = <12 4 0>;
+				dmas = <&dma0 1 0>;
+				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -458,6 +460,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf000c000 0x600>;
 				interrupts = <26 4 0>;
+				dmas = <&dma1 1 0>;
+				dma-names = "rxtx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 8e87277..2e643ea 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -60,6 +60,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf0000000 0x600>;
 				interrupts = <21 4 0>;
+				dmas = <&dma0 2 0>;
+				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7>;
 				status = "disabled";
@@ -173,6 +175,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf8000000 0x600>;
 				interrupts = <22 4 0>;
+				dmas = <&dma1 2 0>;
+				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
 				status = "disabled";
@@ -184,6 +188,8 @@
 				compatible = "atmel,hsmci";
 				reg = <0xf8004000 0x600>;
 				interrupts = <23 4 0>;
+				dmas = <&dma1 2 1>;
+				dma-names = "rxtx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc2_clk_cmd_dat0 &pinctrl_mmc2_dat1_3>;
 				status = "disabled";
-- 
1.7.11.3
