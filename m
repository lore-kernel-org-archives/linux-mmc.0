From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Wed,  4 Jun 2014 12:42:09 +0100
Message-ID: <1401882133-11050-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45893 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752153AbaFDLmY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:24 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

Start tidying the probe/release code by using devm_ioremap_resource() to
map the IO registers.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Fixes from v1:
	- return the PTR_ERR() from devm_ioremap
	- remove error print as it already shows an error
---
 drivers/mmc/host/sh_mmcif.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7f819f1..3ed54c8 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1377,22 +1377,15 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Get irq error\n");
 		return -ENXIO;
 	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "platform_get_resource error.\n");
-		return -ENXIO;
-	}
-	reg = ioremap(res->start, resource_size(res));
-	if (!reg) {
-		dev_err(&pdev->dev, "ioremap error.\n");
-		return -ENOMEM;
-	}
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto ealloch;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
@@ -1497,8 +1490,6 @@ eclkget:
 	pm_runtime_disable(&pdev->dev);
 eofparse:
 	mmc_free_host(mmc);
-ealloch:
-	iounmap(reg);
 	return ret;
 }
 
@@ -1523,9 +1514,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	 */
 	cancel_delayed_work_sync(&host->timeout_work);
 
-	if (host->addr)
-		iounmap(host->addr);
-
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 
-- 
2.0.0.rc2

