Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCBC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 12:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A23611AD
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 12:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhETMX3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 08:23:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4701 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhETMXM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 08:23:12 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm8104Kgkz16PHp;
        Thu, 20 May 2021 20:19:00 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 20:21:47 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 20:21:47 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] mmc: core: Use pm_runtime_resume_and_get() to replace open coding
Date:   Thu, 20 May 2021 20:21:44 +0800
Message-ID: <1621513304-27824-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. this change is just to simplify the code, no
actual functional changes

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mmc/core/sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 3eb94ac..68edf7a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -937,11 +937,9 @@ static void mmc_sdio_detect(struct mmc_host *host)
 
 	/* Make sure card is powered before detecting it */
 	if (host->caps & MMC_CAP_POWER_OFF_CARD) {
-		err = pm_runtime_get_sync(&host->card->dev);
-		if (err < 0) {
-			pm_runtime_put_noidle(&host->card->dev);
+		err = pm_runtime_resume_and_get(&host->card->dev);
+		if (err < 0)
 			goto out;
-		}
 	}
 
 	mmc_claim_host(host);
-- 
2.7.4

