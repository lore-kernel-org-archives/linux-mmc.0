From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2: set the sdmmc gclk frequency
Date: Thu, 12 Sep 2019 22:09:08 +0200
Message-ID: <20190912200908.31318-3-ludovic.desroches@microchip.com>
References: <20190912200908.31318-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912200908.31318-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, claudiu.beznea@microchip.com
List-Id: linux-mmc@vger.kernel.org

Set the frequency of the generated clock used by sdmmc devices in order
to not rely on the configuration done by previous components.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2e2c1a7b1d1d..8d79ff75e3cd 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -300,6 +300,8 @@
 			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 31>, <&pmc PMC_TYPE_GCK 31>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 31>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
@@ -309,6 +311,8 @@
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 32>, <&pmc PMC_TYPE_GCK 32>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 32>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
-- 
2.23.0
