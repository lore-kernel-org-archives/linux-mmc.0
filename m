From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 15 Oct 2012 10:43:48 +0100
Message-ID: <20121015094348.GP21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52428 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2JOJpF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 05:45:05 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

1. Unregister the device _BEFORE_ taking away any resources it may
   be using.
2. Don't check clks against NULL.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I noticed this while merging v3.6 into Rabeeh's cubox kernel.

 drivers/mmc/host/sdhci-dove.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 90140eb..c11db64 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -117,14 +117,13 @@ static int __devexit sdhci_dove_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_dove_priv *priv = pltfm_host->priv;
 
-	if (priv->clk) {
-		if (!IS_ERR(priv->clk)) {
-			clk_disable_unprepare(priv->clk);
-			clk_put(priv->clk);
-		}
-		devm_kfree(&pdev->dev, priv->clk);
+	sdhci_pltfm_unregister(pdev);
+
+	if (!IS_ERR(priv->clk)) {
+		clk_disable_unprepare(priv->clk);
+		clk_put(priv->clk);
 	}
-	return sdhci_pltfm_unregister(pdev);
+	return 0;
 }
 
 static const struct of_device_id sdhci_dove_of_match_table[] __devinitdata = {
