Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2BEC636CC
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 02:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBQCoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 21:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBQCoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 21:44:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3EE38669
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 18:44:16 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHx0b1XmWznWGs;
        Fri, 17 Feb 2023 10:41:51 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 17 Feb
 2023 10:44:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <hkallweit1@gmail.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] mmc: core: fix return value check in devm_mmc_alloc_host()
Date:   Fri, 17 Feb 2023 10:43:33 +0800
Message-ID: <20230217024333.4018279-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_alloc_host() returns NULL pointer not PTR_ERR(), if it
fails, so replace the IS_ERR() check with NULL pointer check.

In commit 418f7c2de133 ("mmc: meson-gx: use devm_mmc_alloc_host"),
it checks NULL pointer not PTR_ERR, if devm_mmc_alloc_host() fails,
so make it to return NULL pointer to keep same with mmc_alloc_host(),
the drivers don't need to change the error handle when switch to
use devm_mmc_alloc_host().

Fixes: 80df83c2c57e ("mmc: core: add devm_mmc_alloc_host")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/core/host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6a7475ad7685..096093f7be00 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -599,12 +599,12 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
 
 	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	host = mmc_alloc_host(extra, dev);
-	if (IS_ERR(host)) {
+	if (!host) {
 		devres_free(dr);
-		return host;
+		return NULL;
 	}
 
 	*dr = host;
-- 
2.25.1

