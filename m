From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 1/9] Revert "Documentation: dw-mshc: deprecate num-slots"
Date: Fri,  6 Oct 2017 15:21:24 -0400
Message-ID: <7deccd8a59339ef0ca5c1d54eb453d040b7df594.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39996 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752343AbdJFTWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Oct 2017 15:22:03 -0400
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

This reverts commit 3f5b4b79d4c0fa71fd7d74c2a44bbc0869c04c9b.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt         | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index ef3e5f1..9cb55ca 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -12,12 +12,12 @@ Required Properties:
 * #address-cells: should be 1.
 * #size-cells: should be 0.
 
-# Slots (DEPRECATED): The slot specific information are contained within
-  child-nodes with each child-node representing a supported slot. There should
-  be atleast one child node representing a card slot. The name of the child node
-  representing the slot is recommended to be slot@n where n is the unique number
-  of the slot connected to the controller. The following are optional properties
-  which can be included in the slot child node.
+# Slots: The slot specific information are contained within child-nodes with
+  each child-node representing a supported slot. There should be atleast one
+  child node representing a card slot. The name of the child node representing
+  the slot is recommended to be slot@n where n is the unique number of the slot
+  connected to the controller. The following are optional properties which
+  can be included in the slot child node.
 
 	* reg: specifies the physical slot number. The valid values of this
 	  property is 0 to (num-slots -1), where num-slots is the value
@@ -63,7 +63,7 @@ Optional properties:
   clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
 	  (Use the "max-frequency" instead of "clock-freq-min-max".)
 
-* num-slots (DEPRECATED): specifies the number of slots supported by the controller.
+* num-slots: specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
   value specified by num-slots. If this property is not specified, the value
   of num-slot property is assumed to be 1.
@@ -124,6 +124,7 @@ board specific portions as listed below.
 	dwmmc0@12200000 {
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
+		num-slots = <1>;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
@@ -138,6 +139,7 @@ board specific portions as listed below.
 	dwmmc0@12200000 {
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
+		num-slots = <1>;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
-- 
1.8.3.1

