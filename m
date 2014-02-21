From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/5] mmc: sdhci-spear: fix error handling paths for DT
Date: Fri, 21 Feb 2014 10:41:07 +0000
Message-ID: <E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45436 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754620AbaBUKlQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 05:41:16 -0500
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

Fix the error handling paths for DT and simplify using the devm_* API
for clk_get().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 94ae64d23ef3..d4621eb59527 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -134,7 +134,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	}
 
 	/* clk enable */
-	sdhci->clk = clk_get(&pdev->dev, NULL);
+	sdhci->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdhci->clk)) {
 		ret = PTR_ERR(sdhci->clk);
 		dev_dbg(&pdev->dev, "Error getting clock\n");
@@ -144,7 +144,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(sdhci->clk);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Error enabling clock\n");
-		goto put_clk;
+		goto err;
 	}
 
 	ret = clk_set_rate(sdhci->clk, 50000000);
@@ -156,7 +156,7 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = sdhci_probe_config_dt(pdev);
 		if (IS_ERR(sdhci->data)) {
 			dev_err(&pdev->dev, "DT: Failed to get pdata\n");
-			return -ENODEV;
+			goto disable_clk;
 		}
 	} else {
 		sdhci->data = dev_get_platdata(&pdev->dev);
@@ -266,8 +266,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	sdhci_free_host(host);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
-put_clk:
-	clk_put(sdhci->clk);
 err:
 	dev_err(&pdev->dev, "spear-sdhci probe failed: %d\n", ret);
 	return ret;
@@ -287,7 +285,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	sdhci_free_host(host);
 	clk_disable_unprepare(sdhci->clk);
-	clk_put(sdhci->clk);
 
 	return 0;
 }
-- 
1.8.3.1

