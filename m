From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 1/2] Documentation: bindings: add description of phy for sdhci-of-arasan
Date: Mon, 15 Feb 2016 17:41:55 +0800
Message-ID: <1455529315-7495-1-git-send-email-shawn.lin@rock-chips.com>
References: <1455529288-7454-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455529288-7454-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

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
