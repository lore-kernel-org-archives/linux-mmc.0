Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DEC4321E
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 01:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKBB1K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiKBB1I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 21:27:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261881FCC3
        for <linux-mmc@vger.kernel.org>; Tue,  1 Nov 2022 18:27:04 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N28Hx6KKZzRnvG;
        Wed,  2 Nov 2022 09:22:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:26:50 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:26:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v2 1/3] mmc: sdio: fix of node refcount leak in sdio_add_func()
Date:   Wed, 2 Nov 2022 09:25:31 +0800
Message-ID: <20221102012533.1270876-2-yangyingliang@huawei.com>
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

If device_add() returns error in sdio_add_func(), sdio function is not
presented, so the node refcount that hold in sdio_set_of_node() can not
be put in sdio_remove_func() which is called from error path. Fix this
by calling of_node_put() if device_add() fails.

Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/sdio_bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index babf21a0adeb..b9308813a226 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -365,6 +365,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		of_node_put(func->dev.of_node);
 
 	return ret;
 }
-- 
2.25.1

