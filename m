Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ACC43219
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 12:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiKHMPC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 07:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiKHMPA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 07:15:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2002B2D1FD;
        Tue,  8 Nov 2022 04:14:52 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N66Qr6YWkzHqPG;
        Tue,  8 Nov 2022 20:11:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 20:14:49 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 20:14:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] mmc: host: omap_hsmmc: fix return value check of mmc_add_host()
Date:   Tue, 8 Nov 2022 20:13:16 +0800
Message-ID: <20221108121316.340354-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_add_host() may return error, if we ignore its return value,
it will lead two issues:
1. The memory that allocated in mmc_alloc_host() is leaked.
2. In the remove() path, mmc_remove_host() will be called to
   delete device, but it's not added yet, it will lead a kernel
   crash because of null-ptr-deref in device_del().

Fix this by checking the return value and goto error path wihch
will call mmc_free_host().

Fixes: a45c6cb81647 ("[ARM] 5369/1: omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fca30add563e..4bd744755205 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1946,7 +1946,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (!ret)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto err_irq;
 
 	if (mmc_pdata(host)->name != NULL) {
 		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
-- 
2.25.1

