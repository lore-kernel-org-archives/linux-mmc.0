From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH 1/2] Documentation: mmc: sdhci-of-arasan: add description of power domain
Date: Sat, 27 Aug 2016 21:41:02 +0800
Message-ID: <20160827134103.28160-2-xzy.xu@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:40195 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbcH0Nln (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Aug 2016 09:41:43 -0400
In-Reply-To: <20160827134103.28160-1-xzy.xu@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Add power domain as a optional property for sdhci-of-arasan, which can
be truned off in the so-called unused condition, such as suspend and
remove. Aim to lower power requirements.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>

---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..3f5189c 100644
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
+  - power-domains: A phandle of and PM domain as specifier defined by bindings
+    of the power controller specified by phandle.
 
 Example:
 	sdhci@e0100000 {
-- 
2.9.2


