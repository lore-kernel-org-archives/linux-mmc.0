From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH v4 1/2] Documentation: mmc: sdhci-of-arasan: add description of power domain
Date: Tue, 27 Sep 2016 14:15:57 +0800
Message-ID: <20160927061558.2110-2-xzy.xu@rock-chips.com>
References: <20160927061558.2110-1-xzy.xu@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:41979 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcI0GQe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2016 02:16:34 -0400
In-Reply-To: <20160927061558.2110-1-xzy.xu@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, dianders@chromium.org, zhangqing@rock-chips.com, Ziyuan Xu <xzy.xu@rock-chips.com>

Add power domain as a optional property for sdhci-of-arasan, which can
be turned off in the so-called unused condition, such as suspend and
remove. Aim to lower power requirements.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

---

Changes in v4:
- add heiko's review-tag

Changes in v3:
- fix a typo
- add Rob's ack-tag

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
2.9.3


