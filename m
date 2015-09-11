From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] Documentation: bindings: add description of phy for sdhci-of-arasan
Date: Fri, 11 Sep 2015 16:55:29 +0800
Message-ID: <1441961729-10594-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, S?ren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds phys and phy-names for sdhci-of-arasan as optional
properties, and details the example as well.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index da541c3..0264d5f 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -1,11 +1,12 @@
 Device Tree Bindings for the Arasan SDHCI Controller
 
-  The bindings follow the mmc[1], clock[2] and interrupt[3] bindings. Only
-  deviations are documented here.
+  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
+  Only deviations are documented here.
 
   [1] Documentation/devicetree/bindings/mmc/mmc.txt
   [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+  [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
 
 Required Properties:
   - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
@@ -16,6 +17,9 @@ Required Properties:
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
+Optional Properties:
+  - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
+  - phy-names:  MUST be "phy_arasan".
 
 Example:
 	sdhci@e0100000 {
@@ -25,4 +29,6 @@ Example:
 		clocks = <&clkc 21>, <&clkc 32>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 24 4>;
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
 	} ;
-- 
2.3.7
