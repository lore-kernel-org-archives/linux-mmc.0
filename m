Return-Path: <SRS0=Uv8K=7S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C97C433DF
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA11206A2
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFEMzx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:55:53 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44396 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbgFEMzw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2020 08:55:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2249545|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00490445-0.00740592-0.98769;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Hib7hso_1591361738;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Hib7hso_1591361738)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 05 Jun 2020 20:55:44 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, mripard@kernel.org, wens@csie.org,
        tiny.windzz@gmail.com, rmfrfs@gmail.com, frank@allwinnertech.com,
        marex@denx.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sunxi-mmc: do not hide address in sunxi_mmc_irq()
Date:   Fri,  5 Jun 2020 20:55:44 +0800
Message-Id: <20200605125545.31974-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Using %px to show the actual address in sunxi_mmc_irq()
to help us to debug issue.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 5e95bbc51644..dcd30c3e1fac 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -574,7 +574,7 @@ static irqreturn_t sunxi_mmc_irq(int irq, void *dev_id)
 	idma_int  = mmc_readl(host, REG_IDST);
 	msk_int   = mmc_readl(host, REG_MISTA);
 
-	dev_dbg(mmc_dev(host->mmc), "irq: rq %p mi %08x idi %08x\n",
+	dev_dbg(mmc_dev(host->mmc), "irq: rq %px mi %08x idi %08x\n",
 		host->mrq, msk_int, idma_int);
 
 	mrq = host->mrq;
-- 
2.24.0

