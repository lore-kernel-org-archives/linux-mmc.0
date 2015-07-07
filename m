From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 2/2] mmc: omap_hsmmc: regulator automatically released by devm
Date: Tue,  7 Jul 2015 20:38:44 +0200
Message-ID: <1436294324-18666-3-git-send-email-afenkart@gmail.com>
References: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34892 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933820AbbGGSi7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 14:38:59 -0400
Received: by wiga1 with SMTP id a1so264773766wig.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2015 11:38:58 -0700 (PDT)
In-Reply-To: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 806867b..ec1bcc7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -394,12 +394,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	return 0;
 }
 
-static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
-{
-	if (mmc_pdata(host)->set_power)
-		return;
-}
-
 static inline int omap_hsmmc_have_reg(void)
 {
 	return 1;
@@ -417,10 +411,6 @@ static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	return -EINVAL;
 }
 
-static inline void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
-{
-}
-
 static inline int omap_hsmmc_have_reg(void)
 {
 	return 0;
@@ -2133,7 +2123,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	omap_hsmmc_reg_put(host);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
 	if (host->tx_chan)
@@ -2157,7 +2146,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
-	omap_hsmmc_reg_put(host);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
-- 
2.1.4

