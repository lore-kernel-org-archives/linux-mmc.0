From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when needed in ->probe()
Date: Thu, 11 Feb 2016 13:59:53 +0100
Message-ID: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33616 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbcBKNAM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 08:00:12 -0500
Received: by mail-lf0-f51.google.com with SMTP id m1so31180861lfg.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 05:00:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

While accessing the device, make sure it stays active by increasing the
runtime PM usage count for it.

Let's also defer to enable runtime PM until we really need access to the
device. This also enables the error path in ->probe() to become simpler.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8d870ce..c6c2a08 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1519,23 +1519,23 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	pm_runtime_enable(dev);
-	host->power = false;
-
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		dev_err(dev, "cannot get clock: %d\n", ret);
-		goto err_pm;
+		goto err_host;
 	}
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret < 0)
-		goto err_pm;
+		goto err_host;
 
 	sh_mmcif_clk_setup(host);
 
-	ret = pm_runtime_resume(dev);
+	pm_runtime_enable(dev);
+	host->power = false;
+
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
 		goto err_clk;
 
@@ -1579,12 +1579,13 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		 sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0xffff,
 		 clk_get_rate(host->clk) / 1000000UL);
 
+	pm_runtime_put(dev);
 	clk_disable_unprepare(host->clk);
 	return ret;
 
 err_clk:
 	clk_disable_unprepare(host->clk);
-err_pm:
+	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 err_host:
 	mmc_free_host(mmc);
-- 
1.9.1

