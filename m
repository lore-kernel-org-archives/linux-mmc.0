Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99BC433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4285F610A4
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 03:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhDGDPb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Apr 2021 23:15:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16005 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhDGDPb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Apr 2021 23:15:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFTwL6jXDzNtCX;
        Wed,  7 Apr 2021 11:12:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 11:15:13 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, "Tian Tao" <tiantao6@hisilicon.com>
Subject: [PATCH] mmc: s3cmci: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Wed, 7 Apr 2021 11:15:39 +0800
Message-ID: <1617765339-28946-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable because of requesting.

this patch is made base on "add IRQF_NO_AUTOEN for request_irq" which
is being merged: https://lore.kernel.org/patchwork/patch/1388765/

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mmc/host/s3cmci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 0ca6f6d..8d5929a 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1578,17 +1578,12 @@ static int s3cmci_probe(struct platform_device *pdev)
 		goto probe_iounmap;
 	}
 
-	if (request_irq(host->irq, s3cmci_irq, 0, DRIVER_NAME, host)) {
+	if (request_irq(host->irq, s3cmci_irq, IRQF_NO_AUTOEN, DRIVER_NAME, host)) {
 		dev_err(&pdev->dev, "failed to request mci interrupt.\n");
 		ret = -ENOENT;
 		goto probe_iounmap;
 	}
 
-	/* We get spurious interrupts even when we have set the IMSK
-	 * register to ignore everything, so use disable_irq() to make
-	 * ensure we don't lock the system with un-serviceable requests. */
-
-	disable_irq(host->irq);
 	host->irq_state = false;
 
 	/* Depending on the dma state, get a DMA channel to use. */
-- 
2.7.4

