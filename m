From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v4 2/9] mmc: dw_mmc: Use devm_* functions in dw_mmc platform
 driver
Date: Sun, 26 Aug 2012 17:22:00 +0530
Message-ID: <1345981927-26359-3-git-send-email-thomas.abraham@linaro.org>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:22665 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab2HZLeR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Aug 2012 07:34:17 -0400
In-reply-to: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

Use devm_* managed functions for simpler error handling.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 9a63299..1488b17 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -27,38 +27,27 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 	struct resource	*regs;
 	int ret;
 
-	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
 	if (!host)
 		return -ENOMEM;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		ret = -ENXIO;
-		goto err_free;
-	}
+	if (!regs)
+		return -ENXIO;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		ret = host->irq;
-		goto err_free;
-	}
+	if (host->irq < 0)
+		return host->irq;
 
 	host->dev = &pdev->dev;
 	host->irq_flags = 0;
 	host->pdata = pdev->dev.platform_data;
-	ret = -ENOMEM;
-	host->regs = ioremap(regs->start, resource_size(regs));
+	host->regs = devm_request_and_ioremap(&pdev->dev, regs);
 	if (!host->regs)
-		goto err_free;
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, host);
 	ret = dw_mci_probe(host);
-	if (ret)
-		goto err_out;
-	return ret;
-err_out:
-	iounmap(host->regs);
-err_free:
-	kfree(host);
 	return ret;
 }
 
@@ -68,8 +57,6 @@ static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	dw_mci_remove(host);
-	iounmap(host->regs);
-	kfree(host);
 	return 0;
 }
 
-- 
1.6.6.rc2

