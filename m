From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/7] ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO lines
Date: Thu, 1 Jun 2017 20:03:58 +0530
Message-ID: <20170601143401.16852-5-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

The dt binding documentation of omap-hsmmc recommends using
"vmmc_aux" for IO supply lines. However
commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add support
for rev B1") added it as "vmmc-aux". Fix it here.

Fixes: commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add
support for rev B1")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 39a92aff0a0d..6ae94ab52b7b 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -20,7 +20,7 @@
 
 &mmc1 {
 	vmmc-supply = <&vdd_3v3>;
-	vmmc-aux-supply = <&ldo1_reg>;
+	vmmc_aux-supply = <&ldo1_reg>;
 };
 
 /* errata i880 "Ethernet RGMII2 Limited to 10/100 Mbps" */
-- 
2.11.0
