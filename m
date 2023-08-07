Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D04C001B0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 12:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjHGMsM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjHGMsI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 08:48:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A51172D
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 05:47:49 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGKS4YSNzfbnl;
        Mon,  7 Aug 2023 20:46:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:47:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:47:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <pierre@ossman.eu>, <ulf.hansson@linaro.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 2/2] mmc: wbsd: remove unnecessary dev_set_drvdata()
Date:   Mon, 7 Aug 2023 20:44:43 +0800
Message-ID: <20230807124443.3431366-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124443.3431366-1-yangyingliang@huawei.com>
References: <20230807124443.3431366-1-yangyingliang@huawei.com>
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

Remove unnecessary dev_set_drvdata() in ->remove(), and
in error path in ->probe(), the driver_data will be set
to NULL in device_unbind_cleanup() in driver core code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/wbsd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index bf2a92fba0ed..0589d169e8fb 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1264,8 +1264,6 @@ static void wbsd_free_mmc(struct device *dev)
 	del_timer_sync(&host->ignore_timer);
 
 	mmc_free_host(mmc);
-
-	dev_set_drvdata(dev, NULL);
 }
 
 /*
-- 
2.25.1

