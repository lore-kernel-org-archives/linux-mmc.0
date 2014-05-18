From: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for the APM X-Gene SoC SDHC DTS binding
Date: Sun, 18 May 2014 01:41:56 -0600
Message-ID: <1400398918-1502-2-git-send-email-lho@apm.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400398918-1502-1-git-send-email-lho-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch updates Arasan SDHC documentation for the APM X-Gene SoC SDHC controller
DTS binding.

Signed-off-by: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 98ee2ab..8fc4cc4 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Required Properties:
-  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
+  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
+                'xgene,arasan,sdhci-8.9a'
   - reg: From mmc bindings: Register location and length.
-  - clocks: From clock bindings: Handles to clock inputs.
-  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
 
+Optional Properties:
+  - clocks: From clock bindings: Handles to clock inputs.
+  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
1.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
