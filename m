From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid
Date: Wed, 10 Feb 2016 15:02:50 -0800
Message-ID: <1455145370-20301-8-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33463 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbcBJXDL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2016 18:03:11 -0500
In-Reply-To: <1455145370-20301-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>

If a driver PM runtime is disabled via sysfs, and the module is
unloaded, PM runtime can't do anything to disable the device. Let's
let the interconnect disable the device on BUS_NOTIFY_UNBOUND_DRIVER.

Otherwise omap_device will produce and error on the following module
reload. This can be easily tested with something like:

# modprobe omap_hsmmc
# echo on > /sys/devices/platform/68000000.ocp/4809c000.mmc/power/control
# rmmod omap_hsmmc
# modprobe omap_hsmmc

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index ebd8369..f7ff3b9 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -191,12 +191,22 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od;
+	int err;
 
 	switch (event) {
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		od = to_omap_device(pdev);
+		if (od && (od->_state == OMAP_DEVICE_STATE_ENABLED)) {
+			dev_info(dev, "enabled after unload, idling\n");
+			err = omap_device_idle(pdev);
+			if (err)
+				dev_err(dev, "failed to idle\n");
+		}
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
-- 
2.7.0

