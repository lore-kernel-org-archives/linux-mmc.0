From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 2/2] mmc: omap_hsmmc: regulator automatically released by devm
Date: Tue,  7 Jul 2015 20:24:53 +0200
Message-ID: <1436293493-5607-2-git-send-email-afenkart@gmail.com>
References: <1436293493-5607-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36184 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbbGGSZJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 14:25:09 -0400
Received: by widjy10 with SMTP id jy10so196497742wid.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2015 11:25:08 -0700 (PDT)
In-Reply-To: <1436293493-5607-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fe7cee5..9761e12 100644
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
@@ -412,10 +406,6 @@ static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	return -EINVAL;
 }
 
-static inline void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
-{
-}
-
 static inline int omap_hsmmc_have_reg(void)
 {
 	return 0;
@@ -2128,7 +2118,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	omap_hsmmc_reg_put(host);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
 	if (host->tx_chan)
@@ -2152,7 +2141,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
-	omap_hsmmc_reg_put(host);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
-- 
2.1.4

