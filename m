Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E07C43219
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 01:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKBB1F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiKBB1D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 21:27:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E981FCDC
        for <linux-mmc@vger.kernel.org>; Tue,  1 Nov 2022 18:26:53 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N28PN4GrDz15MHL;
        Wed,  2 Nov 2022 09:26:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:26:51 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:26:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v2 2/3] mmc: sdio: fix possible memory leak in sdio_init_func()
Date:   Wed, 2 Nov 2022 09:25:32 +0800
Message-ID: <20221102012533.1270876-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102012533.1270876-1-yangyingliang@huawei.com>
References: <20221102012533.1270876-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If it fails in sdio_init_func(), sdio_remove_func() can not
free the memory that allocated in sdio_alloc_func(), because
sdio_add_func() is not called yet, the sdio function is not
presented and sdio_remove_func() will return directly.

In this error path, we can not call put_device() to free the
memory in sdio_release_func(), because sdio_read_func_cis()
may fail, then sdio_free_func_cis() is called in release()
funtion which could cause put the reference that has not
been got.

So fix these leaks with calling kfree() instead of sdio_remove_func()
in error path.

Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..f314224b362b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -133,11 +133,8 @@ static int sdio_init_func(struct mmc_card *card, unsigned int fn)
 	return 0;
 
 fail:
-	/*
-	 * It is okay to remove the function here even though we hold
-	 * the host lock as we haven't registered the device yet.
-	 */
-	sdio_remove_func(func);
+	kfree(func->tmpbuf);
+	kfree(func);
 	return ret;
 }
 
-- 
2.25.1

