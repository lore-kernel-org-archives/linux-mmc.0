Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C90C04E69
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjHGOUM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHGOUK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 10:20:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4910DC
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 07:20:00 -0700 (PDT)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJK85qDHzNmm7;
        Mon,  7 Aug 2023 22:16:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:19:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:19:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 4/4] mmc: sunplus: remove unnecessary platform_set_drvdata()
Date:   Mon, 7 Aug 2023 22:17:04 +0800
Message-ID: <20230807141704.3486854-5-yangyingliang@huawei.com>
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

Remove unnecessary platform_set_drvdata(..., NULL) in ->remove(),
the driver_data will be set to NULL in device_unbind_cleanup()
after calling ->remove() in driver call code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/sunplus-mmc.c | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.25.1

