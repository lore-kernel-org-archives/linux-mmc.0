Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5507C388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 01:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7485D206D9
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgKFB4Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:56:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7149 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFB4X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 20:56:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CS3QT1NFcz15QQg;
        Fri,  6 Nov 2020 09:56:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 09:56:19 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jh80.chung@samsung.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: dw_mmc: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Fri, 6 Nov 2020 09:56:53 +0800
Message-ID: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/mmc/host/dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 43c5795..a524443 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2617,7 +2617,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	struct dw_mci *host = dev_id;
 	u32 pending;
 	struct dw_mci_slot *slot = host->slot;
-	unsigned long irqflags;
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2632,15 +2631,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			 * Hold the lock; we know cmd11_timer can't be kicked
 			 * off after the lock is released, so safe to delete.
 			 */
-			spin_lock_irqsave(&host->irq_lock, irqflags);
+			spin_lock(&host->irq_lock);
 			dw_mci_cmd_interrupt(host, pending);
-			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			spin_unlock(&host->irq_lock);
 
 			del_timer(&host->cmd11_timer);
 		}
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
-			spin_lock_irqsave(&host->irq_lock, irqflags);
+			spin_lock(&host->irq_lock);
 
 			del_timer(&host->cto_timer);
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
@@ -2648,7 +2647,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 
-			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			spin_unlock(&host->irq_lock);
 		}
 
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
@@ -2661,7 +2660,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_DATA_OVER) {
-			spin_lock_irqsave(&host->irq_lock, irqflags);
+			spin_lock(&host->irq_lock);
 
 			del_timer(&host->dto_timer);
 
@@ -2676,7 +2675,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
 
-			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			spin_unlock(&host->irq_lock);
 		}
 
 		if (pending & SDMMC_INT_RXDR) {
@@ -2692,12 +2691,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_CMD_DONE) {
-			spin_lock_irqsave(&host->irq_lock, irqflags);
+			spin_lock(&host->irq_lock);
 
 			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
 			dw_mci_cmd_interrupt(host, pending);
 
-			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			spin_unlock(&host->irq_lock);
 		}
 
 		if (pending & SDMMC_INT_CD) {
-- 
2.7.4

