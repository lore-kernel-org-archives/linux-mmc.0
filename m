From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH v7 1/2] sdhci-of-arasan: Add device tree parameter xlnx,fails-without-test-cd bit
Date: Fri, 9 Sep 2016 11:28:02 -0500
Message-ID: <1473438483-3857-1-git-send-email-zach.brown@ni.com>
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

The device property "xlnx,fails-without-test-cd" will let the arasan
driver know the controller does not have the CD line wired and that the
controller does not function without it.

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
v4:
 * changed fails-without-test-cd to xlnx-fails-without-test-cd
 * removed extra blank line
v5:
 * Fixed style mistake
 * Changed (1 << 0 ) to BIT(0)
v6:
 * Fixed style mistakes
 * Condensed unnecessarily long variable names
 * Removed line wraps that were no longer necessary.
 * Rebased changes off Ulf's mmc tree's next branch.
v7:
 * Removed erroneous re-creation of Optional Properties section
 * Changed xlnx-fails-without-test-cd to xlnx,fails-without-test-cd
 * Changed of_get_property to of_property_read_bool


 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..49df630 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -36,6 +36,9 @@ Optional Properties:
   - #clock-cells: If specified this should be the value <0>.  With this property
     in place we will export a clock representing the Card Clock.  This clock
     is expected to be consumed by our PHY.  You must also specify
+  - xlnx,fails-without-test-cd: when present, the controller doesn't work when
+    the CD line is not connected properly, and the line is not connected
+    properly. Test mode can be used to force the controller to function.
 
 Example:
 	sdhci@e0100000 {
-- 
2.7.4
