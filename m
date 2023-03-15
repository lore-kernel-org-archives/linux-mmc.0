Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EBC61DA4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 05:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCOFl3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 01:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjCOFlZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 01:41:25 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555252905;
        Tue, 14 Mar 2023 22:41:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VduqG3R_1678858874;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VduqG3R_1678858874)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 13:41:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ulf.hansson@linaro.org
Cc:     afaerber@suse.de, mani@kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mmc: owl-mmc: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 15 Mar 2023 13:41:13 +0800
Message-Id: <20230315054113.48898-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mmc/host/owl-mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 3dc143b03939..6f9d31a886ba 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -578,8 +578,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	owl_host->mmc = mmc;
 	spin_lock_init(&owl_host->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	owl_host->base = devm_ioremap_resource(&pdev->dev, res);
+	owl_host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(owl_host->base)) {
 		ret = PTR_ERR(owl_host->base);
 		goto err_free_host;
-- 
2.20.1.7.g153144c

