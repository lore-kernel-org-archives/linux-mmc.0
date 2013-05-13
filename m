From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Use devm_clk_get API
Date: Mon, 13 May 2013 15:56:33 +0200
Message-ID: <1368453393-1272-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:34052 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750830Ab3EMN5w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 09:57:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Converting to devm_clk_get simplifies error handling in probe
and we can remove other corresponding calls to clk_put.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f4f3038..d57ce43 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1362,16 +1362,15 @@ static int mmci_probe(struct amba_device *dev,
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
 	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
-	host->clk = clk_get(&dev->dev, NULL);
+	host->clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
-		host->clk = NULL;
 		goto host_free;
 	}
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret)
-		goto clk_free;
+		goto host_free;
 
 	host->plat = plat;
 	host->variant = variant;
@@ -1576,8 +1575,6 @@ static int mmci_probe(struct amba_device *dev,
 	iounmap(host->base);
  clk_disable:
 	clk_disable_unprepare(host->clk);
- clk_free:
-	clk_put(host->clk);
  host_free:
 	mmc_free_host(mmc);
  rel_regions:
@@ -1623,7 +1620,6 @@ static int mmci_remove(struct amba_device *dev)
 
 		iounmap(host->base);
 		clk_disable_unprepare(host->clk);
-		clk_put(host->clk);
 
 		mmc_free_host(mmc);
 
-- 
1.7.10

