From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] s3cmci: Move to clk_prepare_enable/clk_disable_unprepare
Date: Mon, 30 Jun 2014 22:11:06 +0300
Message-ID: <1404155466-2971-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:39603 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644AbaF3TNU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jun 2014 15:13:20 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so6554513wiv.8
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2014 12:13:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mmc/host/s3cmci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 0d115a8..e5516a2 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1707,7 +1707,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 		goto probe_free_dma;
 	}
 
-	ret = clk_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock source.\n");
 		goto clk_free;
@@ -1765,7 +1765,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	s3cmci_cpufreq_deregister(host);
 
  free_dmabuf:
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 
  clk_free:
 	clk_put(host->clk);
@@ -1817,7 +1817,7 @@ static void s3cmci_shutdown(struct platform_device *pdev)
 	s3cmci_debugfs_remove(host);
 	s3cmci_cpufreq_deregister(host);
 	mmc_remove_host(mmc);
-	clk_disable(host->clk);
+	clk_disable_unprepare(host->clk);
 }
 
 static int s3cmci_remove(struct platform_device *pdev)
-- 
2.0.0

