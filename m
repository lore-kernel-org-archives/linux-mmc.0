From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter to fake CD bit
Date: Wed, 24 Aug 2016 18:23:03 -0500
Message-ID: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:33305 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752725AbcHXXXi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Aug 2016 19:23:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org

The sdhci controller on xilinx zynq devices will not function unless
the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the cd bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function with out the cd bit.

The device property "fake-cd" will let the arasan driver know it needs
to fake the cd bit for the controller inorder for the controller to
function with a SD card that does not provide the CD bit.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..3b9f406 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -21,6 +21,10 @@ Required Properties:
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
+Optional Properties:
+- fake-cd: On Zynq Devices the SDHCI Controller will not work without the cd
+  bit. When this option is set the driver will put the controller in test mode
+  and fake the cd bit so it will function.
 
 Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
-- 
2.7.4

