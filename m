Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F8C54EAA
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 13:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjA3NBX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjA3NBU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 08:01:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAB8692
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 05:01:18 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P57bP397nzfYtm;
        Mon, 30 Jan 2023 21:01:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 21:01:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <drzeus@drzeus.cx>,
        <david-b@pacbell.net>, <yangyingliang@huawei.com>
Subject: [PATCH] mmc: mmc_spi: fix error handling in mmc_spi_probe()
Date:   Mon, 30 Jan 2023 21:01:06 +0800
Message-ID: <20230130130106.3484864-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If mmc_add_host() fails, it doesn't need to call mmc_remove_host(),
or it will cause null-ptr-deref, because of deleting a not added
device in mmc_remove_host().

To fix this, goto label 'fail_glue_init', if mmc_add_host() fails,
and change the label 'fail_add_host' to 'fail_gpiod_reuqest'.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mmc/host/mmc_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 75778ffd6cd4..3959c454ce48 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1437,7 +1437,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 
 	status = mmc_add_host(mmc);
 	if (status != 0)
-		goto fail_add_host;
+		goto fail_glue_init;
 
 	/*
 	 * Index 0 is card detect
@@ -1445,7 +1445,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 */
 	status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000);
 	if (status == -EPROBE_DEFER)
-		goto fail_add_host;
+		goto fail_gpiod_reuqest;
 	if (!status) {
 		/*
 		 * The platform has a CD GPIO signal that may support
@@ -1460,7 +1460,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	/* Index 1 is write protect/read only */
 	status = mmc_gpiod_request_ro(mmc, NULL, 1, 0);
 	if (status == -EPROBE_DEFER)
-		goto fail_add_host;
+		goto fail_gpiod_reuqest;
 	if (!status)
 		has_ro = true;
 
@@ -1474,7 +1474,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 				? ", cd polling" : "");
 	return 0;
 
-fail_add_host:
+fail_gpiod_reuqest:
 	mmc_remove_host(mmc);
 fail_glue_init:
 	mmc_spi_dma_free(host);
-- 
2.25.1

