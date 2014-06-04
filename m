From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/6] mmc: sh-mmcif: update to print version and bus clock rate on probe
Date: Wed,  4 Jun 2014 12:42:08 +0100
Message-ID: <1401882133-11050-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45903 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752049AbaFDLm1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:27 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

Change the initial print to show chip version and the bus rate it is
working at instead of the driver version. This is more useful information
as we already know which driver version from the kernel it is in.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 54730f4..7f819f1 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1468,16 +1468,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	mutex_init(&host->thread_lock);
 
-	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
-	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
-		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
+	dev_info(&pdev->dev, "Chip version 0x%04x, clock rate %luMHz\n",
+		 sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0xffff,
+		 clk_get_rate(host->hclk) / 1000000UL);
+
+	clk_disable_unprepare(host->hclk);
 	return ret;
 
 emmcaddh:
-- 
2.0.0.rc2

