From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/2] dt-bindings: sdhci-of-at91: add the microchip,sdcal-inverted property
Date: Tue, 8 Oct 2019 14:34:31 +0200
Message-ID: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-mmc@vger.kernel.org

Add the specific microchip,sdcal-inverted property to at91 sdhci
device binding.
This optional property describes how the SoC SDCAL pin is connected.
It could be handled at SiP, SoM or board level.

This property read by at91 sdhci driver will allow to put in place a
software workaround that would reduce power consumption.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 1b662d7171a0..503c6dbac1b2 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -9,6 +9,11 @@ Required properties:
 - clocks:		Phandlers to the clocks.
 - clock-names:		Must be "hclock", "multclk", "baseclk";
 
+Optional properties:
+- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
+  inverted. The default polarity for this signal is described in the datasheet.
+  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
+  and a capacitor (see "SDMMC I/O Calibration" chapter).
 
 Example:
 
-- 
2.17.1
