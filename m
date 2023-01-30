Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B69C54EAA
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 12:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjA3M7a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 07:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjA3M7a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 07:59:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F593867F
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 04:58:54 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P57Tj51h1zRqsF;
        Mon, 30 Jan 2023 20:56:09 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 20:58:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v6] mmc: sdio: fix possible resource leaks in some error paths
Date:   Mon, 30 Jan 2023 20:58:08 +0800
Message-ID: <20230130125808.3471254-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If sdio_add_func() or sdio_init_func() fails, sdio_remove_func() can
not release the resources, because the sdio function is not presented
in these two cases, it won't call of_node_put() or put_device().

To fix these leaks, make sdio_func_present() only control whether
device_del() needs to be called or not, then always call of_node_put()
and put_device().

In error case in sdio_init_func(), the reference of 'card->dev' is
not get, to avoid redundant put in sdio_free_func_cis(), move the
get_device() to sdio_alloc_func() and put_device() to sdio_release_func(),
it can keep the get/put function be balanced.

Without this patch, while doing fault inject test, it can get the
following leak reports, after this fix, the leak is gone.

unreferenced object 0xffff888112514000 (size 2048):
  comm "kworker/3:2", pid 65, jiffies 4294741614 (age 124.774s)
  hex dump (first 32 bytes):
    00 e0 6f 12 81 88 ff ff 60 58 8d 06 81 88 ff ff  ..o.....`X......
    10 40 51 12 81 88 ff ff 10 40 51 12 81 88 ff ff  .@Q......@Q.....
  backtrace:
    [<000000009e5931da>] kmalloc_trace+0x21/0x110
    [<000000002f839ccb>] mmc_alloc_card+0x38/0xb0 [mmc_core]
    [<0000000004adcbf6>] mmc_sdio_init_card+0xde/0x170 [mmc_core]
    [<000000007538fea0>] mmc_attach_sdio+0xcb/0x1b0 [mmc_core]
    [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]

unreferenced object 0xffff888112511000 (size 2048):
  comm "kworker/3:2", pid 65, jiffies 4294741623 (age 124.766s)
  hex dump (first 32 bytes):
    00 40 51 12 81 88 ff ff e0 58 8d 06 81 88 ff ff  .@Q......X......
    10 10 51 12 81 88 ff ff 10 10 51 12 81 88 ff ff  ..Q.......Q.....
  backtrace:
    [<000000009e5931da>] kmalloc_trace+0x21/0x110
    [<00000000fcbe706c>] sdio_alloc_func+0x35/0x100 [mmc_core]
    [<00000000c68f4b50>] mmc_attach_sdio.cold.18+0xb1/0x395 [mmc_core]
    [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v5 -> v6:
  Remove a fix tag.
  Call get/put_device() without checking MMC_QUIRK_NONSTD_SDIO.

v4 -> v5:
  Merge to two pathes in one and add leak reports.
  Fix wrong check in sdio_remove_func().
  Move get/put_device() in sdio_alloc/release_func.

v3 -> v4:
  Drop patch1, keep calling put_device() to free memory,
  set 'func->card' to NULL to avoid redundant put.

v2 -> v3:
  Change to call of_node_put() in remove() function to
  fix node refcount leak.

v1 -> v2:
  Fix compile error in patch #2.
---
 drivers/mmc/core/sdio_bus.c | 17 ++++++++++++++---
 drivers/mmc/core/sdio_cis.c | 12 ------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index babf21a0adeb..f191a2a76f3b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -294,6 +294,12 @@ static void sdio_release_func(struct device *dev)
 	if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
 		sdio_free_func_cis(func);
 
+	/*
+	 * We have now removed the link to the tuples in the
+	 * card structure, so remove the reference.
+	 */
+	put_device(&func->card->dev);
+
 	kfree(func->info);
 	kfree(func->tmpbuf);
 	kfree(func);
@@ -324,6 +330,12 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
 
 	device_initialize(&func->dev);
 
+	/*
+	 * We may link to tuples in the card structure,
+	 * we need make sure we have a reference to it.
+	 */
+	get_device(&func->card->dev);
+
 	func->dev.parent = &card->dev;
 	func->dev.bus = &sdio_bus_type;
 	func->dev.release = sdio_release_func;
@@ -377,10 +389,9 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	if (!sdio_func_present(func))
-		return;
+	if (sdio_func_present(func))
+		device_del(&func->dev);
 
-	device_del(&func->dev);
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index a705ba6eff5b..afaa6cab1adc 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -403,12 +403,6 @@ int sdio_read_func_cis(struct sdio_func *func)
 	if (ret)
 		return ret;
 
-	/*
-	 * Since we've linked to tuples in the card structure,
-	 * we must make sure we have a reference to it.
-	 */
-	get_device(&func->card->dev);
-
 	/*
 	 * Vendor/device id is optional for function CIS, so
 	 * copy it from the card structure as needed.
@@ -434,11 +428,5 @@ void sdio_free_func_cis(struct sdio_func *func)
 	}
 
 	func->tuples = NULL;
-
-	/*
-	 * We have now removed the link to the tuples in the
-	 * card structure, so remove the reference.
-	 */
-	put_device(&func->card->dev);
 }
 
-- 
2.25.1

