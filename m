Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B151C001B0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHGOUL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjHGOUJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 10:20:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D21BC8
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 07:19:57 -0700 (PDT)
Received: from dggpemm100013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJK83hnGztRs6;
        Mon,  7 Aug 2023 22:16:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100013.china.huawei.com (7.185.36.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:19:55 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:19:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 1/4] mmc: via-sdmmc: remove unnecessary dev_set_drvdata()
Date:   Mon, 7 Aug 2023 22:17:01 +0800
Message-ID: <20230807141704.3486854-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807141704.3486854-1-yangyingliang@huawei.com>
References: <20230807141704.3486854-1-yangyingliang@huawei.com>
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

Remove unnecessary dev_set_drvdata() in ->remove(), and
in error path in ->probe(), the driver_data will be set
to NULL in device_unbind_cleanup() in driver core code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/via-sdmmc.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.25.1

