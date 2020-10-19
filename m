Return-Path: <SRS0=rHuV=D2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594AAC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Oct 2020 00:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C22622272
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Oct 2020 00:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgJSAmf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Oct 2020 20:42:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgJSAmf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 18 Oct 2020 20:42:35 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7656D88266D34F4C0099;
        Mon, 19 Oct 2020 08:42:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 08:42:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <haotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.or>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: mediatek: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Mon, 19 Oct 2020 08:43:13 +0800
Message-ID: <1603068193-44688-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/mmc/host/mtk-sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a704745..fb3e419 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1536,13 +1536,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 	struct mmc_host *mmc = mmc_from_priv(host);
 
 	while (true) {
-		unsigned long flags;
 		struct mmc_request *mrq;
 		struct mmc_command *cmd;
 		struct mmc_data *data;
 		u32 events, event_mask;
 
-		spin_lock_irqsave(&host->lock, flags);
+		spin_lock(&host->lock);
 		events = readl(host->base + MSDC_INT);
 		event_mask = readl(host->base + MSDC_INTEN);
 		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
@@ -1553,7 +1552,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		mrq = host->mrq;
 		cmd = host->cmd;
 		data = host->data;
-		spin_unlock_irqrestore(&host->lock, flags);
+		spin_unlock(&host->lock);
 
 		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
 			sdio_signal_irq(mmc);
-- 
2.7.4

