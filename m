From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC documentation to support 4.9a version of Arasan SDHC controller.
Date: Fri,  1 May 2015 10:24:12 +0530
Message-ID: <1430456052-8888-4-git-send-email-stripathi@apm.com>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:42712 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753284AbbEAEz5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 00:55:57 -0400
In-Reply-To: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch updates Arasan SDHC documentation to support
4.9a version of Arasan SDHC controller.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 98ee2ab..f01d41a 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Required Properties:
-  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
+  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
+                'arasan,sdhci-4.9a'           
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
@@ -18,7 +19,7 @@ Required Properties:
 
 Example:
 	sdhci@e0100000 {
-		compatible = "arasan,sdhci-8.9a";
+		compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
 		reg = <0xe0100000 0x1000>;
 		clock-names = "clk_xin", "clk_ahb";
 		clocks = <&clkc 21>, <&clkc 32>;
-- 
1.8.2.1

