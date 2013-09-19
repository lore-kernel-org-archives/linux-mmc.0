From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] ARM: at91: at91sam9x5: set default mmc[01] pinctrl-names
Date: Thu, 19 Sep 2013 15:24:35 +0200
Message-ID: <1379597075-3748-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c68486e..e74dc15 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -556,6 +556,7 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -567,6 +568,7 @@
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
1.8.2.2
