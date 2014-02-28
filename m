From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/6] mmc: sdhci-spear: fix error handling paths for DT
Date: Fri, 28 Feb 2014 21:32:29 +0000
Message-ID: <E1WJV2j-00042G-4E@rmk-PC.arm.linux.org.uk>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60170 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752299AbaB1Vcc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:32:32 -0500
In-Reply-To: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

Fix the error handling paths for DT and simplify using the devm_* API
for clk_get().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8d1760..3cb0087ad98b 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -131,7 +131,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	}
 
 	/* clk enable */
-	sdhci->clk = clk_get(&pdev->dev, NULL);
+	sdhci->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
@@ -141,7 +141,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto put_clk;
+		goto err;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -153,7 +153,7 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = sdhci_probe_config_dt(pdev);
 		if (IS_ERR(sdhci->data)) {
 			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-			return -ENODEV;
+			goto disable_clk;
 		}
 	} else {
 		sdhci->data = dev_get_platdata(&pdev->dev);
@@ -263,8 +263,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	sdhci_free_host(host);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
-put_clk:
-	clk_put(sdhci->clk);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -284,7 +282,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	sdhci_free_host(host);
 	clk_disable_unprepare(sdhci->clk);
-	clk_put(sdhci->clk);
 
 	return 0;
 }
-- 
1.8.3.1

