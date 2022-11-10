Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C64FC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 02:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiKJC5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiKJC5E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 21:57:04 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04E24099
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 18:57:03 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N75yJ0zsmzJnZl;
        Thu, 10 Nov 2022 10:54:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:57:00 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:57:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v4 2/2] mmc: sdio: fix possible memory leak in some error path
Date:   Thu, 10 Nov 2022 10:55:30 +0800
Message-ID: <20221110025530.4106568-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110025530.4106568-1-yangyingliang@huawei.com>
References: <20221110025530.4106568-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If sdio_add_func() or sdio_init_func() fails, sdio_remove_func() can
not free the memory, because the sdio function is not presented in
these two cases, it won't call put_device().

To fix these leaks, make sdio_func_present() only control whether
device_del() needs to be called or not. Then, put_device() is called
to give up the reference which was set in device_initialize(), the
memory can be freed in sdio_release_func().

In error case in sdio_init_func(), the reference of 'card->dev' is
not get, so set 'func->card' to NULL to avoid redundant put in
sdio_free_func_cis().

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio.c     | 1 +
 drivers/mmc/core/sdio_bus.c | 8 ++++----
 drivers/mmc/core/sdio_cis.c | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..ff95fb6aa741 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -137,6 +137,7 @@ static int sdio_init_func(struct mmc_card *card, unsigned int fn)
 	 * It is okay to remove the function here even though we hold
 	 * the host lock as we haven't registered the device yet.
 	 */
+	func->card = NULL;
 	sdio_remove_func(func);
 	return ret;
 }
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
 
diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index a705ba6eff5b..d374460fba9b 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -439,6 +439,7 @@ void sdio_free_func_cis(struct sdio_func *func)
 	 * We have now removed the link to the tuples in the
 	 * card structure, so remove the reference.
 	 */
-	put_device(&func->card->dev);
+	if (func->card)
+		put_device(&func->card->dev);
 }
 
-- 
2.25.1

