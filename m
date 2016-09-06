From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH v4 1/2] sdhci-of-arasan: Add device tree parameter xlnx-fails-without-test-cd bit
Date: Tue, 6 Sep 2016 15:34:43 -0500
Message-ID: <1473194084-14485-1-git-send-email-zach.brown@ni.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The sdhci controller on xilinx zynq devices will not function unless
the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the CD bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function without the CD bit.

The device property "xlnx-fails-without-test-cd" will let the arasan
driver know the controller does not have the CD line wired and that the
controller does not function without it.

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
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

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 31b35c3..7407450 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -17,6 +17,10 @@ Required Properties:
   - interrupts: Interrupt specifier
   - interrupt-parent: Phandle for the interrupt controller that services
 		      interrupts for this device.
+Optional Properties:
+- xlnx-fails-without-test-cd: when present, the controller doesn't work when
+  the CD line is not connected properly, and the line is not connected
+  properly. Test mode can be used to force the controller to function.
 
 Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
