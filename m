Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62872C04A6A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 20:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjHHUys (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjHHUyc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 16:54:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A61B324
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:10:48 -0700 (PDT)
Received: from dggpemm100013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKsZt32w4z1hwH2;
        Tue,  8 Aug 2023 20:15:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100013.china.huawei.com (7.185.36.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:18:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 20:18:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2] mmc: remove unnecessary set_drvdata() function
Date:   Tue, 8 Aug 2023 20:15:13 +0800
Message-ID: <20230808121513.553143-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver data will be cleared in device_unbind_cleanup() in driver
core code. So the set_drvdata(..., NULL) called in remove and error
path in probe can be removed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Squash into one patch.
---
 drivers/mmc/core/block.c       | 1 -
 drivers/mmc/host/moxart-mmc.c  | 2 --
 drivers/mmc/host/sunplus-mmc.c | 1 -
 drivers/mmc/host/via-sdmmc.c   | 2 --
 drivers/mmc/host/wbsd.c        | 2 --
 5 files changed, 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f701efb1fa78..2d734b325287 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3025,7 +3025,6 @@ static void mmc_blk_remove(struct mmc_card *card)
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
-	dev_set_drvdata(&card->dev, NULL);
 	destroy_workqueue(card->complete_wq);
 }
 
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d0d6ffcf78d4..43c2a95bc29a 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -692,8 +692,6 @@ static int moxart_remove(struct platform_device *pdev)
 	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
 	struct moxart_host *host = mmc_priv(mmc);
 
-	dev_set_drvdata(&pdev->dev, NULL);
-
 	if (!IS_ERR_OR_NULL(host->dma_chan_tx))
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index a55a87f64d2a..e9f33976c94e 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -955,7 +955,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 	clk_disable_unprepare(host->clk);
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_disable(&dev->dev);
-	platform_set_drvdata(dev, NULL);
 	mmc_free_host(host->mmc);
 
 	return 0;
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index a2b0d9461665..ba6044b16e07 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1160,7 +1160,6 @@ static int via_sd_probe(struct pci_dev *pcidev,
 unmap:
 	iounmap(sdhost->mmiobase);
 free_mmc_host:
-	dev_set_drvdata(&pcidev->dev, NULL);
 	mmc_free_host(mmc);
 release:
 	pci_release_regions(pcidev);
@@ -1212,7 +1211,6 @@ static void via_sd_remove(struct pci_dev *pcidev)
 	writeb(gatt, sdhost->pcictrl_mmiobase + VIA_CRDR_PCICLKGATT);
 
 	iounmap(sdhost->mmiobase);
-	dev_set_drvdata(&pcidev->dev, NULL);
 	mmc_free_host(sdhost->mmc);
 	pci_release_regions(pcidev);
 	pci_disable_device(pcidev);
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index bf2a92fba0ed..0589d169e8fb 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1264,8 +1264,6 @@ static void wbsd_free_mmc(struct device *dev)
 	del_timer_sync(&host->ignore_timer);
 
 	mmc_free_host(mmc);
-
-	dev_set_drvdata(dev, NULL);
 }
 
 /*
-- 
2.25.1

