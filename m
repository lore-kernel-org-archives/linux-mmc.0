From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mobile_sdhi: remove unneeded clock connection ID
Date: Wed, 28 Nov 2012 10:24:21 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1211281016550.1710@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59662 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2K1JYY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 04:24:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

SDHI only uses one clock, all ARM and SuperH platform register SDHI clock
lookup entries with no connection ID, hence it can be dropped in the
driver too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0bdc146..22ac8e7 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -123,7 +123,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_data *mmc_data;
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
-	char clk_name[8];
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
 
@@ -144,11 +143,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		}
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
+	priv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(priv->clk);
+		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto eclkget;
 	}
 
-- 
1.7.2.5

