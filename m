From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Date: Tue, 11 Nov 2014 15:42:22 +0900
Message-ID: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on mmc-next branch of Chris Ball's mmc tree.

 drivers/mmc/host/sh_mmcif.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 656fbba..fe9a8b7 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1,6 +1,7 @@
 /*
  * MMCIF eMMC driver.
  *
+ * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2010 Renesas Solutions Corp.
  * Yusuke Goda <yusuke.goda.sx@renesas.com>
  *
@@ -57,6 +58,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -1371,6 +1373,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *reg;
 	const char *name;
+	struct device_node *np = pdev->dev.of_node;
+	int clk_rate;
 
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
@@ -1433,6 +1437,16 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto eclkget;
 	}
+
+	if (np && !of_property_read_u32(np, "renesas,clk-rate", &clk_rate)) {
+		if (clk_rate) {
+			ret = clk_set_rate(host->hclk, clk_rate);
+			if (ret < 0)
+				dev_err(&pdev->dev,
+					"cannot set clock rate: %d\n", ret);
+		}
+	}
+
 	ret = sh_mmcif_clk_update(host);
 	if (ret < 0)
 		goto eclkupdate;
-- 
1.9.1

