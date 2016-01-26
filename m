From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-iproc: use sdhci_pltfm_unregister directly
Date: Tue, 26 Jan 2016 18:26:03 +0800
Message-ID: <1453803963-6385-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17064 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933952AbcAZKaM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 05:30:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, rjui@broadcom.com, sbranden@broadcom.com, jonmason@broadcom.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

The sdhci_iproc_remove() is jsut a wrapper to sdhci_pltfm_unregister.
So use the sdhci_pltfm_unregister() for the .remove hook directly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-iproc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 3b423b0..24c5546 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -220,11 +220,6 @@ err:
 	return ret;
 }
 
-static int sdhci_iproc_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static struct platform_driver sdhci_iproc_driver = {
 	.driver = {
 		.name = "sdhci-iproc",
@@ -232,7 +227,7 @@ static struct platform_driver sdhci_iproc_driver = {
 		.pm = SDHCI_PLTFM_PMOPS,
 	},
 	.probe = sdhci_iproc_probe,
-	.remove = sdhci_iproc_remove,
+	.remove = sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_iproc_driver);
 
-- 
2.7.0

