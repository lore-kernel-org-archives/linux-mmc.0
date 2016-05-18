From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 3/3] ARM: dts: dra7/omap4/omap5: Enable ADMA2
Date: Wed, 18 May 2016 14:15:15 +0530
Message-ID: <1463561115-31798-4-git-send-email-kishon@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463561115-31798-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, peter.ujfalusi@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Now that ADMA2 support is added in omap hsmmc controller driver,
enable ADMA2 for all the mmc instances that has ADMA2 support in
DRA7, OMAP4 and OMAP5 SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi  |    4 ++++
 arch/arm/boot/dts/omap4.dtsi |    2 ++
 arch/arm/boot/dts/omap5.dtsi |    4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac882..a63df6b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -883,6 +883,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma_xbar 61>, <&sdma_xbar 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -895,6 +896,7 @@
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -906,6 +908,7 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
@@ -917,6 +920,7 @@
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 421fe9f..23c78b4 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -513,6 +513,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			pbias-supply = <&pbias_mmc_reg>;
@@ -524,6 +525,7 @@
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
 		};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 120b6b8..3bf113b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -566,6 +566,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			pbias-supply = <&pbias_mmc_reg>;
@@ -577,6 +578,7 @@
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
 		};
@@ -587,6 +589,7 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
 		};
@@ -597,6 +600,7 @@
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
+			ti,use_adma;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
 		};
-- 
1.7.9.5
