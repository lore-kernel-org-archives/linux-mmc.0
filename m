Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D7C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 02:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKICxF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKICxE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 21:53:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F751F62F
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 18:53:03 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6TzT25tFzRp5l;
        Wed,  9 Nov 2022 10:52:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:53:02 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 10:53:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v3 3/3] mmc: sdio: fix possible memory leak in mmc_attach_sdio()
Date:   Wed, 9 Nov 2022 10:51:42 +0800
Message-ID: <20221109025142.1565445-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109025142.1565445-1-yangyingliang@huawei.com>
References: <20221109025142.1565445-1-yangyingliang@huawei.com>
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

If sdio_add_func() returns error in mmc_attach_sdio(),
sdio_remove_func() can not free the memory that allocated
in sdio_init_func(), because the sdio function is not
presented and won't call put_device().

To fix these leaks, make sdio_func_present() only control
whether device_del() needs to be called or not. Then,
put_device() is called to give up the reference which was
set in device_initialize(), the memory can be freed in
sdio_release_func().

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio_bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 266639504a94..da561658bdae 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -377,11 +377,11 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	of_node_put(func->dev.of_node);
-	if (!sdio_func_present(func))
-		return;
+	if (!sdio_func_present(func)) {
+		device_del(&func->dev);
+	}
 
-	device_del(&func->dev);
+	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
 
-- 
2.25.1

