Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA021C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C1264F4E
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Feb 2021 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBDHKo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Feb 2021 02:10:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12124 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhBDHKZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 02:10:25 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWV536Q3Bz162SJ;
        Thu,  4 Feb 2021 15:08:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 15:09:33 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rric@kernel.org>, <ulf.hansson@linaro.org>, <rmfrfs@gmail.com>,
        <linus.walleij@linaro.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH] mmc: cavium: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Thu, 4 Feb 2021 15:07:18 +0800
Message-ID: <1612422438-32525-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It is redundant to do irqsave and irqrestore in hardIRQ context, where
it has been in a irq-disabled context.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/mmc/host/cavium.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index c5da3aa..4bb8f28 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -436,12 +436,11 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 {
 	struct cvm_mmc_host *host = dev_id;
 	struct mmc_request *req;
-	unsigned long flags = 0;
 	u64 emm_int, rsp_sts;
 	bool host_done;
 
 	if (host->need_irq_handler_lock)
-		spin_lock_irqsave(&host->irq_handler_lock, flags);
+		spin_lock(&host->irq_handler_lock);
 	else
 		__acquire(&host->irq_handler_lock);
 
@@ -504,7 +503,7 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 		host->release_bus(host);
 out:
 	if (host->need_irq_handler_lock)
-		spin_unlock_irqrestore(&host->irq_handler_lock, flags);
+		spin_unlock(&host->irq_handler_lock);
 	else
 		__release(&host->irq_handler_lock);
 	return IRQ_RETVAL(emm_int != 0);
-- 
2.8.1

