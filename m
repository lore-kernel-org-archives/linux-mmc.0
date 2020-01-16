Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D367C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE5920684
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgAPOnk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:43:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbgAPOnj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 09:43:39 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A556629ABDF8C6D0FF45;
        Thu, 16 Jan 2020 22:43:37 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 22:43:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <orito.takao@socionext.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mmc: sdhci-milbeaut:  Remove redundant platform_get_irq error message
Date:   Thu, 16 Jan 2020 22:43:22 +0800
Message-ID: <20200116144322.57308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

platform_get_irq() will call dev_err() itself on failure,
so there is no need for the driver to also do this.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/sdhci-milbeaut.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index e6245b7..92f30a1 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -246,10 +246,8 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	struct f_sdhost_priv *priv;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "%s: no irq specified\n", __func__);
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
-- 
2.7.4


