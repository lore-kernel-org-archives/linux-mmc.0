Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE0C2D0A3
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 00:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BD122273
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 00:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgKBAvs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 1 Nov 2020 19:51:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6686 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgKBAvs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Nov 2020 19:51:48 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPZ9s1fsPz15Q0f;
        Mon,  2 Nov 2020 08:51:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 08:51:41 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>, <afaerber@suse.de>,
        <manivannan.sadhasivam@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: owl-mmc: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Mon, 2 Nov 2020 08:52:17 +0800
Message-ID: <1604278337-55624-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/mmc/host/owl-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index ccf214a..82d2bad 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -134,10 +134,9 @@ static void owl_mmc_update_reg(void __iomem *reg, unsigned int val, bool state)
 static irqreturn_t owl_irq_handler(int irq, void *devid)
 {
 	struct owl_mmc_host *owl_host = devid;
-	unsigned long flags;
 	u32 state;
 
-	spin_lock_irqsave(&owl_host->lock, flags);
+	spin_lock(&owl_host->lock);
 
 	state = readl(owl_host->base + OWL_REG_SD_STATE);
 	if (state & OWL_SD_STATE_TEI) {
@@ -147,7 +146,7 @@ static irqreturn_t owl_irq_handler(int irq, void *devid)
 		complete(&owl_host->sdc_complete);
 	}
 
-	spin_unlock_irqrestore(&owl_host->lock, flags);
+	spin_unlock(&owl_host->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

