From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 33/41] ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
Date: Fri, 19 May 2017 13:45:33 +0530
Message-ID: <20170519081541.26753-34-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add "max-frequency" property to MMC dt nodes and set the
maximum frequency to 192MHz for MMC1/MMC2, 64MHz for MMC3
and 192MHz for MMC4. pdata quirks must be utilized to
detect presence of rev 1.1/1.0 of silicon and adjust
maximum frequencies as per restrictions documented in i843.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5a262e1a0313..38fb1828e26a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1045,6 +1045,7 @@
 			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
+			max-frequency = <192000000>;
 		};
 
 		mmc2: mmc@480b4000 {
@@ -1056,6 +1057,7 @@
 			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmc3: mmc@480ad000 {
@@ -1067,6 +1069,8 @@
 			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			/* Errata i887 limits max-frequency of MMC3 to 64 MHz */
+			max-frequency = <64000000>;
 		};
 
 		mmc4: mmc@480d1000 {
@@ -1078,6 +1082,7 @@
 			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmu0_dsp1: mmu@40d01000 {
-- 
2.11.0
