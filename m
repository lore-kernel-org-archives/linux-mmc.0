From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/2] Documentation: mmc: sdhci-of-arasan: add description of power domain
Date: Thu,  8 Sep 2016 14:49:04 +0800
Message-ID: <20160908064905.18080-2-xzy.xu@rock-chips.com>
References: <20160908064905.18080-1-xzy.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160908064905.18080-1-xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add power domain as a optional property for sdhci-of-arasan, which can
be truned off in the so-called unused condition, such as suspend and
remove. Aim to lower power requirements.

Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v2:
- fix a typo
- add an example code for power-domain

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..eb84d29 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -1,12 +1,14 @@
 Device Tree Bindings for the Arasan SDHCI Controller
 
-  The bindings follow the mmc[1], clock[2], interrupt[3] and phy[4] bindings.
+  The bindings follow the mmc[1], clock[2], interrupt[3], phy[4] and power
+  domain[5] bindings.
   Only deviations are documented here.
 
   [1] Documentation/devicetree/bindings/mmc/mmc.txt
   [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
   [4] Documentation/devicetree/bindings/phy/phy-bindings.txt
+  [5] Documentation/devicetree/bindings/power/power_domain.txt
 
 Required Properties:
   - compatible: Compatibility string.  One of:
@@ -36,6 +38,8 @@ Optional Properties:
   - #clock-cells: If specified this should be the value <0>.  With this property
     in place we will export a clock representing the Card Clock.  This clock
     is expected to be consumed by our PHY.  You must also specify
+  - power-domains: A phandle and PM domain as specifier defined by bindings
+    of the power controller specified by phandle.
 
 Example:
 	sdhci@e0100000 {
@@ -71,5 +75,6 @@ Example:
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
+		power-domains = <&power RK3399_PD_EMMC>;
 		status = "disabled";
 	};
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
