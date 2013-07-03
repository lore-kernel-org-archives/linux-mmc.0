From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] mmc: mxs-mmc: Use devm_clk_get()
Date: Wed,  3 Jul 2013 17:02:37 -0300
Message-ID: <1372881758-23502-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:35815 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3GCUCy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jul 2013 16:02:54 -0400
Received: by mail-yh0-f42.google.com with SMTP id c41so194973yho.15
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jul 2013 13:02:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

Using devm_clk_get() allows us to remove the clk_put() calls, so let's use it
to simplify the code.

Rename the 'out_clk_put' label to 'out_clk_disable' now that clk_put is removed.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/mxs-mmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index f38d75f..b76778f 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -618,7 +618,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ssp->clk = clk_get(&pdev->dev, NULL);
+	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
 		goto out_mmc_free;
@@ -632,7 +632,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		dev_err(mmc_dev(host->mmc),
 			"%s: failed to request dma\n", __func__);
 		ret = -ENODEV;
-		goto out_clk_put;
+		goto out_clk_disable;
 	}
 
 	/* set mmc core parameters */
@@ -685,9 +685,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 out_free_dma:
 	if (ssp->dmach)
 		dma_release_channel(ssp->dmach);
-out_clk_put:
+out_clk_disable:
 	clk_disable_unprepare(ssp->clk);
-	clk_put(ssp->clk);
 out_mmc_free:
 	mmc_free_host(mmc);
 	return ret;
@@ -705,7 +704,6 @@ static int mxs_mmc_remove(struct platform_device *pdev)
 		dma_release_channel(ssp->dmach);
 
 	clk_disable_unprepare(ssp->clk);
-	clk_put(ssp->clk);
 
 	mmc_free_host(mmc);
 
-- 
1.8.1.2

