From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/7] ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply property
Date: Thu, 30 Jul 2015 13:43:38 +0530
Message-ID: <1438244020-4244-6-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

pbias-supply is initialized in dra7.dtsi. Remove redundant initialization
of pbias-supply from MMC1 dt node in am57xx-beagle-x15.dts

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d0db5c5..daf4f17 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -579,7 +579,6 @@
 	pinctrl-0 = <&mmc1_pins_default>;
 
 	vmmc-supply = <&ldo1_reg>;
-	pbias-supply = <&pbias_mmc_reg>;
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
 };
-- 
1.7.9.5
