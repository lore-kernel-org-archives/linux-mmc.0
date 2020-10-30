Return-Path: <SRS0=VXdQ=EF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6AC2D0A3
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 01:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CE1206ED
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 01:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgJ3B2J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Oct 2020 21:28:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ3B2I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2020 21:28:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMl7D23Q5zhctk;
        Fri, 30 Oct 2020 09:28:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 09:28:00 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: moxart: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Fri, 30 Oct 2020 09:28:39 +0800
Message-ID: <1604021319-31338-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/mmc/host/moxart-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index f25079b..89bff4e 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -465,9 +465,8 @@ static irqreturn_t moxart_irq(int irq, void *devid)
 {
 	struct moxart_host *host = (struct moxart_host *)devid;
 	u32 status;
-	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	spin_lock(&host->lock);
 
 	status = readl(host->base + REG_STATUS);
 	if (status & CARD_CHANGE) {
@@ -484,7 +483,7 @@ static irqreturn_t moxart_irq(int irq, void *devid)
 	if (status & (FIFO_ORUN | FIFO_URUN) && host->mrq)
 		moxart_transfer_pio(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

