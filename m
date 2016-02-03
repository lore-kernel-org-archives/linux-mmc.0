From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: remove dw_mci_rockchip_pmops
Date: Wed,  3 Feb 2016 11:26:44 +0800
Message-ID: <1454470004-21408-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:48018 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbcBCDbg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 22:31:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mci_rockchip_pmops just copy-paste what dw_mci_pltfm_pmops
have done. Let's remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d9c92f3..3438ab3 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -276,33 +276,13 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_mci_rockchip_suspend(struct device *dev)
-{
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	return dw_mci_suspend(host);
-}
-
-static int dw_mci_rockchip_resume(struct device *dev)
-{
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	return dw_mci_resume(host);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(dw_mci_rockchip_pmops,
-			 dw_mci_rockchip_suspend,
-			 dw_mci_rockchip_resume);
-
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
 	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_rockchip",
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= &dw_mci_rockchip_pmops,
+		.pm		= &dw_mci_pltfm_pmops,
 	},
 };
 
-- 
2.3.7


