From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/5] mmc: sdhci-spear: fix platform_data usage
Date: Fri, 21 Feb 2014 10:41:12 +0000
Message-ID: <E1WGnXc-0007Jk-MM@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45445 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754608AbaBUKlX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 05:41:23 -0500
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

sdhci-spear is unsafe should a probe fail or defer, since it overwrites
the platform_data with its own driver-private data.  It's trivial to
fix as SDHCI allows for driver-private data to be appended to its own
structure - we just need to arrange the code to allow this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 43 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index d4621eb59527..ca1cb9776ea2 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -110,6 +110,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct spear_sdhci *sdhci;
+	struct device *dev;
 	int ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -126,25 +127,28 @@ static int sdhci_probe(struct platform_device *pdev)
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
@@ -162,19 +166,6 @@ static int sdhci_probe(struct platform_device *pdev)
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
@@ -185,13 +176,13 @@ static int sdhci_probe(struct platform_device *pdev)
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
@@ -262,10 +253,10 @@ static int sdhci_probe(struct platform_device *pdev)
 
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
@@ -274,7 +265,7 @@ static int sdhci_probe(struct platform_device *pdev)
 static int sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int dead = 0;
 	u32 scratch;
 
@@ -283,8 +274,8 @@ static int sdhci_remove(struct platform_device *pdev)
 		dead = 1;
 
 	sdhci_remove_host(host, dead);
-	sdhci_free_host(host);
 	clk_disable_unprepare(sdhci->clk);
+	sdhci_free_host(host);
 
 	return 0;
 }
@@ -293,7 +284,7 @@ static int sdhci_remove(struct platform_device *pdev)
 static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
@@ -306,7 +297,7 @@ static int sdhci_suspend(struct device *dev)
 static int sdhci_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct spear_sdhci *sdhci = dev_get_platdata(dev);
+	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int ret;
 
 	ret = clk_enable(sdhci->clk);
-- 
1.8.3.1

