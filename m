From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH RESEND 2/3] ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
Date: Fri, 22 Jun 2018 15:46:16 +0530
Message-ID: <20180622101617.11157-3-kishon@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>, kishon@ti.com
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index da78c0034427..af6bf1301cf5 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -391,13 +391,10 @@
 		};
 
 		mmc0: mmc@23000000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23000000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 24 0>, <&edma1 25 0>;
-			dma-names = "tx", "rx";
 			bus-width = <4>;
-			ti,needs-special-reset;
 			no-1-8-v;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xb>;
@@ -407,13 +404,12 @@
 		};
 
 		mmc1: mmc@23100000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23100000 0x400>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 26 0>, <&edma1 27 0>;
-			dma-names = "tx", "rx";
 			bus-width = <8>;
-			ti,needs-special-reset;
+			no-1-8-v;
+			non-removable;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xc>;
 			clocks = <&k2g_clks 0xc 1>, <&k2g_clks 0xc 2>;
-- 
2.17.1
