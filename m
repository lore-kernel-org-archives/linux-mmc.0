Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C816CC04A94
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHGOUL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHGOUJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 10:20:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB810F6
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 07:19:59 -0700 (PDT)
Received: from dggpemm100012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKJMq2xrGz1KCNk;
        Mon,  7 Aug 2023 22:18:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:19:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:19:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 2/4] mmc: block: remove unnecessary dev_set_drvdata()
Date:   Mon, 7 Aug 2023 22:17:02 +0800
Message-ID: <20230807141704.3486854-3-yangyingliang@huawei.com>
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

Remove unnecessary dev_set_drvdata(..., NULL) in ->remove(),
the driver_data will be set to NULL in device_unbind_cleanup()
after calling ->remove() in driver call code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/block.c | 1 -
 1 file changed, 1 deletion(-)

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
 
-- 
2.25.1

