From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 1/2] sdhci-of-arasan: Add device tree parameter fails-without-test-cd bit
Date: Mon, 29 Aug 2016 18:20:56 -0500
Message-ID: <1472512857-13063-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

The sdhci controller on xilinx zynq devices will not function unless
the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the CD bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function without the CD bit.

The device property "fails-without-test-cd" will let the arasan driver know
the controller does not have the CD line wired and that the controller
does not function without it.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
v2:
 * improved commit messages
 * removed fake-cd device property
 * removed fake-cd quirk
 * use broken-cd device property
 * documented new usage of broken-cd
v3:
 * removed new usage of broken-cd
 * created fails-without-test-cd device property
 * created arasan controller specific quirk


 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..ec0dc82 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -21,6 +21,10 @@ Required Properties:
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
+Optional Properties:
+- fails-without-test-cd: when present, the controller doesn't work when the CD
+  line is not connected properly, and the line is not connected properly. Test
+  mode can be used to force the controller to function.

 Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
--
2.7.4
