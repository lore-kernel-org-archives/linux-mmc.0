From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/3] MMC: sdhci-dove: use devm_clk_get()
Date: Thu, 22 Nov 2012 23:55:10 +0000
Message-ID: <E1Tbgbu-0007Kk-Pc@rmk-PC.arm.linux.org.uk>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49200 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2KVX6i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 18:58:38 -0500
In-Reply-To: <20121122235426.GT3332@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Use devm_clk_get() rather than clk_get() to make cleanup paths more simple.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-dove.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8fd50a2..4233fd9 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -92,7 +92,7 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	priv->clk = clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(priv->clk))
 		clk_prepare_enable(priv->clk);
 
@@ -107,10 +107,8 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
 	return 0;
 
 sdhci_dove_register_fail:
-	if (!IS_ERR(priv->clk)) {
+	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
-		clk_put(priv->clk);
-	}
 	return ret;
 }
 
@@ -122,10 +120,9 @@ static int __devexit sdhci_dove_remove(struct platform_device *pdev)
 
 	sdhci_pltfm_unregister(pdev);
 
-	if (!IS_ERR(priv->clk)) {
+	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
-		clk_put(priv->clk);
-	}
+
 	return 0;
 }
 
-- 
1.7.4.4

