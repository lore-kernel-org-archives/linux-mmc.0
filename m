Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F329ECAAA1
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Nov 2022 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKANQ0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKANQW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 09:16:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A3563A9
        for <linux-mmc@vger.kernel.org>; Tue,  1 Nov 2022 06:16:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1r6S20l9zpW0l;
        Tue,  1 Nov 2022 21:12:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 21:15:55 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 21:15:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>,
        Daniel Drake <drake@endlessos.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH 3/3] mmc: sdio: fix possible memory leak in mmc_attach_sdio()
Date:   Tue, 1 Nov 2022 21:13:17 +0800
Message-ID: <20221101131317.866961-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101131317.866961-1-yangyingliang@huawei.com>
References: <20221101131317.866961-1-yangyingliang@huawei.com>
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

If sdio_add_func() returns error in mmc_attach_sdio(),
sdio_remove_func() can not free the memory that allocated
in sdio_init_func(), because the sdio function is not
presented and sdio_remove_func() will return directly.

To fix these leaks, we can call put_device() to give up
the reference which was set in device_initialize(), then
the memory can be freed in sdio_release_func().

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Cc: Daniel Drake <drake@endlessos.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio_bus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b9308813a226..c4d3f721567e 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -379,11 +379,10 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	if (!sdio_func_present(func))
-		return;
-
-	device_del(&func->dev);
-	of_node_put(func->dev.of_node);
+	if (sdio_func_present(func)) {
+		device_del(&func->dev);
+		of_node_put(func->dev.of_node);
+	}
 	put_device(&func->dev);
 }
 
-- 
2.25.1

