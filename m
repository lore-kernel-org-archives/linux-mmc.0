From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 34/41] ARM: dts: dra7: Use new dra7-specific compatible string
Date: Fri, 19 May 2017 13:45:34 +0530
Message-ID: <20170519081541.26753-35-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
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
index 38fb1828e26a..40b9eb96cdeb 100644
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

