From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 1/3] dt-bindings: sdhci-of-at91: new compatible string and update properties
Date: Thu, 12 Sep 2019 22:09:06 +0200
Message-ID: <20190912200908.31318-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, claudiu.beznea@microchip.com
List-Id: linux-mmc@vger.kernel.org

There is a new compatible string for the SAM9X60 sdhci device. It involves
an update of the properties about the clocks stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../devicetree/bindings/mmc/sdhci-atmel.txt   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 1b662d7171a0..364ceea330b6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -5,12 +5,19 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
 sdhci-of-at91 driver.
 
 Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci".
+- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
 - clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk";
+- clock-names:		Must be "hclock", "multclk", "baseclk" for
+			"atmel,sama5d2-sdhci".
+			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
 
+Optional properties:
+- assigned-clocks:	The same with "multclk".
+- assigned-clock-rates	The rate of "multclk" in order to not rely on the
+			gck configuration set by previous components.
 
-Example:
+
+Examples:
 
 sdmmc0: sdio-host@a0000000 {
 	compatible = "atmel,sama5d2-sdhci";
@@ -18,4 +25,16 @@ sdmmc0: sdio-host@a0000000 {
 	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
 	clock-names = "hclock", "multclk", "baseclk";
+	assigned-clocks = <&sdmmc0_gclk>;
+	assigned-clock-rates = <480000000>;
+};
+
+sdmmc0: sdio-host@80000000 {
+	compatible = "microchip,sam9x60-sdhci";
+	reg = <0x80000000 0x300>;
+	interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+	clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
+	clock-names = "hclock", "multclk";
+	assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
+	assigned-clock-rates = <100000000>;
 };
-- 
2.23.0
