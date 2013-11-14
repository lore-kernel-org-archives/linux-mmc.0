From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] mmc: omap: Fix I2C dependency and make driver
 usable with device tree
Date: Thu, 14 Nov 2013 09:25:27 -0800
Message-ID: <20131114172527.GD10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-4-git-send-email-tony@atomide.com>
 <20131114110533.GD16396@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131114110533.GD16396@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

* Mark Rutland <mark.rutland@arm.com> [131114 03:06]:
>
> Missing binding document.

Here's this one updated with a minimal binding document. The
ti,hwmods is still needed until we have removed the dependencies
to hwmod code for omaps.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 13 Nov 2013 16:36:37 -0800
Subject: [PATCH] mmc: omap: Fix I2C dependency and make driver usable with device tree

Some features can be configured by the companion I2C chips,
which may not be available at the probe time. Fix the issue
by returning -EPROBE_DEFER when the MMC controller slots
are not configured.

While at it, let's also add minimal device tree support so
omap24xx platforms can use this driver without legacy mode
since we claim to support device tree for mach-omap2 based
systems.

Although adding the minimal device tree support is not strictly
a fix, it does remove one of the last blockers for dropping a
bunch of legacy platform data for mach-omap2.

Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

+++ b/Documentation/devicetree/bindings/mmc/ti-omap.txt
@@ -0,0 +1,27 @@
+* TI MMC host controller for OMAP1 and 2420
+
+The MMC Host Controller on TI OMAP1 and 2420 family provides
+an interface for MMC, SD, and SDIO types of memory cards.
+
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the omap mmc driver.
+
+Note that this driver will not work with omap2430 or later omaps,
+please see the omap hsmmc driver for the current omaps.
+
+Required properties:
+- compatible: Must be "ti,omap2420-mmc", for OMAP2420 controllers
+- ti,hwmods: For 2420, must be "msdi<n>", where n is controller
+  instance starting 1
+
+Examples:
+
+	msdi1: mmc@4809c000 {
+		compatible = "ti,omap2420-mmc";
+		ti,hwmods = "msdi1";
+		reg = <0x4809c000 0x80>;
+		interrupts = <83>;
+		dmas = <&sdma 61 &sdma 62>;
+		dma-names = "tx", "rx";
+	};
+
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/of.h>
 #include <linux/omap-dma.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -1330,7 +1331,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	}
 	if (pdata->nr_slots == 0) {
 		dev_err(&pdev->dev, "no slots\n");
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1553,6 +1554,12 @@ static int mmc_omap_resume(struct platform_device *pdev)
 #define mmc_omap_resume		NULL
 #endif
 
+#if IS_BUILTIN(CONFIG_OF)
+static const struct of_device_id mmc_omap_match[] = {
+	{ .compatible = "ti,omap2420-mmc", },
+	{ },
+};
+#endif
 static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
 	.remove		= mmc_omap_remove,
@@ -1561,6 +1568,7 @@ static struct platform_driver mmc_omap_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mmc_omap_match),
 	},
 };
 
