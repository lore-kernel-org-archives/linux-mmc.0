From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v7 1/4] Documentation: bindings: add description of phy for sdhci-of-arasan
Date: Mon,  7 Mar 2016 23:38:42 +0800
Message-ID: <1457365122-23291-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457365099-23248-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds phys and phy-names for sdhci-of-arasan as required
properties for arasan,sdhci-5.1, and details the example as well.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

Changes in v6:
- add Rob's Acked-by tag

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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
