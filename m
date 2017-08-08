From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] ARM: dts: am572x-idk: Fix GPIO polarity for MMC1 card detect
Date: Tue, 8 Aug 2017 10:50:57 +0530
Message-ID: <20170808052057.24433-2-kishon@ti.com>
References: <20170808052057.24433-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808052057.24433-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The GPIO polarity for MMC1 card detect is set to '0' which means
active-high. However the polarity should be active-low. Fix it
here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 9da6d83ca185..940fcbe5380b 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -81,7 +81,7 @@
 	vmmc-supply = <&v3_3d>;
 	vmmc_aux-supply = <&ldo1_reg>;
 	bus-width = <4>;
-	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
 };
 
 &sn65hvs882 {
-- 
2.11.0
