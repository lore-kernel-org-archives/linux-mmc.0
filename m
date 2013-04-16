From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/6] ARM: at91: dts: set #dma-cells to the correct value
Date: Tue, 16 Apr 2013 15:03:06 +0200
Message-ID: <1366117390-24686-3-git-send-email-ludovic.desroches@atmel.com>
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

Moving to generic DMA DT binding involves to set #dma-cells to 2.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 1 +
 arch/arm/boot/dts/at91sam9n12.dtsi | 1 +
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 ++
 arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 6b1d4ca..275e768 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -108,6 +108,7 @@
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
 				interrupts = <21 4 0>;
+				#dma-cells = <2>;
 			};
 
 			pinctrl@fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 7750f98..acc4526 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -110,6 +110,7 @@
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
 				interrupts = <20 4 0>;
+				#dma-cells = <2>;
 			};
 
 			pinctrl@fffff400 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 3870322..8e83d87 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -104,12 +104,14 @@
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
 				interrupts = <20 4 0>;
+				#dma-cells = <2>;
 			};
 
 			dma1: dma-controller@ffffee00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffee00 0x200>;
 				interrupts = <21 4 0>;
+				#dma-cells = <2>;
 			};
 
 			pinctrl@fffff400 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 39b0458..95c00a3 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -348,14 +348,14 @@
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
 				interrupts = <30 4 0>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 			};
 
 			dma1: dma-controller@ffffe800 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe800 0x200>;
 				interrupts = <31 4 0>;
-				#dma-cells = <1>;
+				#dma-cells = <2>;
 			};
 
 			ramc0: ramc@ffffea00 {
-- 
1.7.11.3
