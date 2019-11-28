From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: sdhci-of-at91: new compatible string and update properties
Date: Thu, 28 Nov 2019 08:45:20 +0100
Message-ID: <20191128074522.69706-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@microchip.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com, Ludovic Desroches <ludovic.desroches@microchip.com>, Rob Herring <robh@kernel.org>
List-Id: linux-mmc@vger.kernel.org

There is a new compatible string for the SAM9X60 sdhci device. It involves
an update of the properties about the clocks stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:
- v3: rebase due to conflict with Nicolas' patch
- v2: remove the extra example and fix node label

 .../devicetree/bindings/mmc/sdhci-atmel.txt         | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 503c6dbac1b2..69edfd4d3922 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -5,11 +5,16 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
 sdhci-of-at91 driver.
 
 Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci".
+- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
 - clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk";
+- clock-names:		Must be "hclock", "multclk", "baseclk" for
+			"atmel,sama5d2-sdhci".
+			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
 
 Optional properties:
+- assigned-clocks:	The same with "multclk".
+- assigned-clock-rates	The rate of "multclk" in order to not rely on the
+			gck configuration set by previous components.
 - microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
   inverted. The default polarity for this signal is described in the datasheet.
   For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
@@ -17,10 +22,12 @@ Optional properties:
 
 Example:
 
-sdmmc0: sdio-host@a0000000 {
+mmc0: sdio-host@a0000000 {
 	compatible = "atmel,sama5d2-sdhci";
 	reg = <0xa0000000 0x300>;
 	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
 	clock-names = "hclock", "multclk", "baseclk";
+	assigned-clocks = <&sdmmc0_gclk>;
+	assigned-clock-rates = <480000000>;
 };
-- 
2.24.0
