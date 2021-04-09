Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47BC433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 02:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AAB61055
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 02:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDICYO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Apr 2021 22:24:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16851 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICYO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2021 22:24:14 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGhhq2brPz9xgR;
        Fri,  9 Apr 2021 10:21:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 10:23:53 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <ulf.hansson@linaro.org>, <afaerber@suse.de>, <mani@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-actions@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mmc: owl-mmc: Remove unnecessary error log
Date:   Fri, 9 Apr 2021 10:33:49 +0800
Message-ID: <20210409023349.3325907-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

devm_ioremap_resource() has recorded error log, so it's
unnecessary to record log again.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 drivers/mmc/host/owl-mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 5490962dc8e5..3dc143b03939 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -581,7 +581,6 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	owl_host->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(owl_host->base)) {
-		dev_err(&pdev->dev, "Failed to remap registers\n");
 		ret = PTR_ERR(owl_host->base);
 		goto err_free_host;
 	}
-- 
2.25.1

