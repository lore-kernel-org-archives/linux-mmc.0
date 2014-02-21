From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/5] mmc: sdhci-spear: simplify resource handling
Date: Fri, 21 Feb 2014 10:41:17 +0000
Message-ID: <E1WGnXh-0007Jo-Pr@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45450 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754608AbaBUKl0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 05:41:26 -0500
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

Use devm_ioremap_resource() to simplify iomem resource handling in the
probe path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index ca1cb9776ea2..f879b27e59b1 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -113,20 +113,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	struct device *dev;
 	int ret;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem) {
-		ret = -ENOMEM;
-		dev_dbg(&pdev->dev, "memory resource not defined\n");
-		goto err;
-	}
-
-	if (!devm_request_mem_region(&pdev->dev, iomem->start,
-				resource_size(iomem), "spear-sdhci")) {
-		ret = -EBUSY;
-		dev_dbg(&pdev->dev, "cannot request region\n");
-		goto err;
-	}
-
 	dev = pdev->dev.parent ? pdev->dev.parent : &pdev->dev;
 	host = sdhci_alloc_host(dev, sizeof(*sdhci));
 	if (IS_ERR(host)) {
@@ -135,6 +121,19 @@ static int sdhci_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(host->ioaddr)) {
+		ret = PTR_ERR(host->ioaddr);
+		dev_dbg(&pdev->dev, "unable to map iomem: %d\n", ret);
+		goto err_host;
+	}
+
+	host->hw_name = "sdhci";
+	host->ops = &sdhci_pltfm_ops;
+	host->irq = platform_get_irq(pdev, 0);
+	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
+
 	sdhci = sdhci_priv(host);
 
 	/* clk enable */
@@ -166,19 +165,6 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = dev_get_platdata(&pdev->dev);
 	}
 
-	host->hw_name = "sdhci";
-	host->ops = &sdhci_pltfm_ops;
-	host->irq = platform_get_irq(pdev, 0);
-	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
-
-	host->ioaddr = devm_ioremap(&pdev->dev, iomem->start,
-			resource_size(iomem));
-	if (!host->ioaddr) {
-		ret = -ENOMEM;
-		dev_dbg(&pdev->dev, "failed to remap registers\n");
-		goto disable_clk;
-	}
-
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
-- 
1.8.3.1

