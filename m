From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 15/16] ARM: dts: dra7: Use new dra7-specific compatible string
Date: Fri, 16 Jun 2017 18:15:43 +0530
Message-ID: <20170616124544.15046-16-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use the new compatible string "ti,dra7-hsmmc" that was specifically
added for dra7 and dra72. This is required since for dra7 and dra72
processors iodelay values has to be set unlike other processors.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b9b8b4b5143a..52ce3fab483f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1035,7 +1035,7 @@
 		};
 
 		mmc1: mmc@4809c000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
@@ -1049,7 +1049,7 @@
 		};
 
 		mmc2: mmc@480b4000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
@@ -1061,7 +1061,7 @@
 		};
 
 		mmc3: mmc@480ad000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
@@ -1074,7 +1074,7 @@
 		};
 
 		mmc4: mmc@480d1000 {
-			compatible = "ti,omap4-hsmmc";
+			compatible = "ti,dra7-hsmmc", "ti,omap4-hsmmc";
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
-- 
2.11.0
