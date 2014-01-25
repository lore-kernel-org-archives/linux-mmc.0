From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mxs-mmc: Check the return value from clk_prepare_enable()
Date: Sat, 25 Jan 2014 19:53:25 -0200
Message-ID: <1390686805-14771-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:43563 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaAYWUv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jan 2014 17:20:51 -0500
Received: by mail-yk0-f169.google.com with SMTP id q9so7995144ykb.0
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jan 2014 14:20:51 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 19633fe..69bc942 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -612,7 +612,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(ssp->clk);
 		goto out_mmc_free;
 	}
-	clk_prepare_enable(ssp->clk);
+	ret = clk_prepare_enable(ssp->clk);
+	if (ret)
+		goto out_mmc_free;
 
 	ret = mxs_mmc_reset(host);
 	if (ret) {
@@ -710,8 +712,7 @@ static int mxs_mmc_resume(struct device *dev)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	clk_prepare_enable(ssp->clk);
-	return 0;
+	return clk_prepare_enable(ssp->clk);
 }
 
 static const struct dev_pm_ops mxs_mmc_pm_ops = {
-- 
1.8.1.2

