Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0EC433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 02:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1792610A7
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 02:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhDIC23 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Apr 2021 22:28:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15989 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDIC23 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2021 22:28:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGhnm0h9qzyNkx;
        Fri,  9 Apr 2021 10:26:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 10:28:06 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <adrian.hunter@intel.com>, <patrice.chotard@foss.st.com>,
        <ulf.hansson@linaro.org>, <yuehaibing@huawei.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mmc: sdhci-st: Remove unnecessary error log
Date:   Fri, 9 Apr 2021 10:38:01 +0800
Message-ID: <20210409023801.3326572-1-qiulaibin@huawei.com>
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
 drivers/mmc/host/sdhci-st.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 78941ac3a1d6..d41582c21aa3 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -400,10 +400,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "top-mmc-delay");
 	pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pdata->top_ioaddr)) {
-		dev_warn(&pdev->dev, "FlashSS Top Dly registers not available");
+	if (IS_ERR(pdata->top_ioaddr))
 		pdata->top_ioaddr = NULL;
-	}
 
 	pltfm_host->clk = clk;
 	pdata->icnclk = icnclk;
-- 
2.25.1

