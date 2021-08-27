Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5089CC432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B9D60F92
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 07:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbhH0HQc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:16:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41216 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244274AbhH0HQc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2021 03:16:32 -0400
X-UUID: 32bfc58617334ef286f85314b60c1b0a-20210827
X-UUID: 32bfc58617334ef286f85314b60c1b0a-20210827
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <derong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 366452259; Fri, 27 Aug 2021 15:15:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 15:15:40 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 15:15:39 +0800
From:   Derong Liu <derong.liu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsp_upstream@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Derong Liu <derong.liu@mediatek.com>
Subject: [PATCH v3] mmc: mediatek: add wait dma stop done flow
Date:   Fri, 27 Aug 2021 15:15:37 +0800
Message-ID: <20210827071537.1034-1-derong.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.
According to the programming guide of mtk mmc host, it needs to wait for dma stop done after set dma stop.
This change should be applied to all SoCs.

Change-Id: I9b87523f19b24ca73958bbcb83bb418413c5a180
Signed-off-by: Derong Liu <derong.liu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..b99330bad6a5 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/of_address.h>
@@ -2330,6 +2331,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
 static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+	unsigned int val = 0;
 
 	/* disable cmdq irq */
 	sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INT_CMDQ);
@@ -2339,6 +2341,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 	if (recovery) {
 		sdr_set_field(host->base + MSDC_DMA_CTRL,
 			      MSDC_DMA_CTRL_STOP, 1);
+		if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
+			!(val & MSDC_DMA_CFG_STS), 1, 3000)))
+			return;
 		msdc_reset_hw(host);
 	}
 }
-- 
2.18.0

