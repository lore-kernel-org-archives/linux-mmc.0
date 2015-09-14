From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] Documentation: bindings: add description of phy for sdhci-of-arasan
Date: Mon, 14 Sep 2015 14:29:59 +0800
Message-ID: <1442212199-23277-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49822 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbINGcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 02:32:33 -0400
In-Reply-To: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch adds phys and phy-names for sdhci-of-arasan as required
properties for arasan,sdhci-5.1, and details the example as well.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- Keep phy as a mandatory requirement for arasan,sdhci-5.1

 .../devicetree/bindings/mmc/arasan,sdhci.txt         | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index da541c3..31b35c3 100644
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
@@ -17,6 +18,10 @@ Required Properties:
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
 
+Required Properties for "arasan,sdhci-5.1":
+  - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
+  - phy-names:  MUST be "phy_arasan".
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -26,3 +31,14 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <0 24 4>;
 	} ;
+
+	sdhci@e2800000 {
+		compatible = "arasan,sdhci-5.1";
+		reg = <0xe2800000 0x1000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&cru 8>, <&cru 18>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 24 4>;
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+	} ;
-- 
2.3.7


