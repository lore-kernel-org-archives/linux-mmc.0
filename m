From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/17] ARM: dts: am57xx-beagle-x15: Fix regulator populated in MMC1 dt node
Date: Wed, 29 Jul 2015 16:39:42 +0530
Message-ID: <1438168187-1614-13-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

For beagle x15, both the vdd and io lines are connected to the
same regulator (ldo1_reg). However vmmc_aux is populated to vdd_3v3.
Remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a63bf78..d0db5c5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -579,7 +579,6 @@
 	pinctrl-0 = <&mmc1_pins_default>;
 
 	vmmc-supply = <&ldo1_reg>;
-	vmmc_aux-supply = <&vdd_3v3>;
 	pbias-supply = <&pbias_mmc_reg>;
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
-- 
1.7.9.5
