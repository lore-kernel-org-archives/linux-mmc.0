From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 1/3] Documentation: Update Arasan SDHC documentation for the APM X-Gene SoC SDHC DTS binding
Date: Tue,  3 Jun 2014 15:13:03 -0600
Message-ID: <1401829985-5212-2-git-send-email-lho@apm.com>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:45100 "HELO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754670AbaFCVNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 17:13:34 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so6022931pbc.28
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 14:13:34 -0700 (PDT)
In-Reply-To: <1401829985-5212-1-git-send-email-lho@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

This patch updates Arasan SDHC documentation for the APM X-Gene SoC SDHC controller
DTS binding.

Signed-off-by: Loc Ho <lho@apm.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 98ee2ab..4dfcb9e 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -8,14 +8,22 @@ Device Tree Bindings for the Arasan SDHCI Controller
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Required Properties:
-  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
-  - reg: From mmc bindings: Register location and length.
-  - clocks: From clock bindings: Handles to clock inputs.
-  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
+  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
+                'apm,arasan,sdhci-8.9a'
+  - reg: First resource is the SDHC register location and length.
+         Second optional resource is the bridge translation register location
+         and length if required.
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
 
+Optional Properties:
+  - clocks: For format, refer to clock bindings. It requires two clocks if
+            specified - AHB clock and SDHC clock.
+  - clock-names: For format, refer to clock bindings. The clock corresponding
+                 to the AHBC clock must be named "clk_ahb". The clock
+                 corresponding to the SDHC clock must be named "clk_xin".
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
1.5.5

