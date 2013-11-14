From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] mmc: omap: Fix I2C dependency and make driver usable with device tree
Date: Wed, 13 Nov 2013 18:35:32 -0800
Message-ID: <1384396537-3486-4-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46358 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752490Ab3KNCfq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 21:35:46 -0500
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

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
---

If this looks OK, I'd like to merge this as a fix via arm-soc tree
along with the other patches in this series as my later patches
depend on patches in this series.

---
 drivers/mmc/host/omap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index ed56868..43c66ad 100644
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
 
-- 
1.8.1.1

