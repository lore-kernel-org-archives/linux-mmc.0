From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/6] mmc: sdhci-spear: fix platform_data usage
Date: Fri, 28 Feb 2014 21:32:34 +0000
Message-ID: <E1WJV2o-00042K-7K@rmk-PC.arm.linux.org.uk>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60174 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752206AbaB1Vch (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:32:37 -0500
In-Reply-To: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

sdhci-spear is unsafe should a probe fail or defer, since it overwrites
the platform_data with its own driver-private data.  It's trivial to
fix as SDHCI allows for driver-private data to be appended to its own
structure - we just need to arrange the code to allow this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 43 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 3cb0087ad98b..663222f6c1c3 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -107,6 +107,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct spear_sdhci *sdhci;
+	struct device *dev;
 	int ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -123,25 +124,28 @@ static int sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	sdhci = devm_kzalloc(&pdev->dev, sizeof(*sdhci), GFP_KERNEL);
-	if (!sdhci) {
-		ret = -ENOMEM;
+	dev = pdev->dev.parent ? pdev->dev.parent : &pdev->dev;
+	host = sdhci_alloc_host(dev, sizeof(*sdhci));
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
 		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
 		goto err;
 	}
 
+	sdhci = sdhci_priv(host);
+
 	/* clk enable */
 	sdhci->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
-		goto err;
+		goto err_host;
 	}
 
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto err;
+		goto err_host;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -159,19 +163,6 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = dev_get_platdata(&pdev->dev);
 	}
 
-	pdev->dev.platform_data = sdhci;
-
-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
-	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
-
-	if (IS_ERR(host)) {
-		ret = PTR_ERR(host);
-		dev_dbg(&pdev->dev, "error allocating host\n");
-		goto disable_clk;
-	}
-
 	host->hw_name = "sdhci";
 	host->ops = &sdhci_pltfm_ops;
 	host->irq = platform_get_irq(pdev, 0);
@@ -182,13 +173,13 @@ static int sdhci_probe(struct platform_device *pdev)
 	if (!host->ioaddr) {
 		ret = -ENOMEM;
 		dev_dbg(&pdev->dev, "failed to remap registers\n");
-		goto free_host;
+		goto disable_clk;
 	}
 
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
-		goto free_host;
+		goto disable_clk;
 	}
 
 	platform_set_drvdata(pdev, host);
@@ -259,10 +250,10 @@ static int sdhci_probe(struct platform_device *pdev)
 
 set_drvdata:
 	sdhci_remove_host(host, 1);
-free_host:
-	sdhci_free_host(host);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
+err_host:
+	sdhci_free_host(host);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -271,7 +262,7 @@ static int sdhci_probe(struct platform_device *pdev)
 static int sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int dead = 0;
 	u32 scratch;
 
@@ -280,8 +271,8 @@ static int sdhci_remove(struct platform_device *pdev)
 		dead = 1;
 
 	sdhci_remove_host(host, dead);
-	sdhci_free_host(host);
 	clk_disable_unprepare(sdhci->clk);
+	sdhci_free_host(host);
 
 	return 0;
 }
@@ -290,7 +281,7 @@ static int sdhci_remove(struct platform_device *pdev)
 static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
@@ -303,7 +294,7 @@ static int sdhci_suspend(struct device *dev)
 static int sdhci_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int ret;
 
 	ret = clk_enable(sdhci->clk);
-- 
1.8.3.1

