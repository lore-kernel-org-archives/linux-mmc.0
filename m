Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8D6C4338F
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 07:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7561051
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhHIH0B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:26:01 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55490 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232094AbhHIHZ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2021 03:25:59 -0400
X-UUID: 2574f97aa48d4b3da3cff3efa9822d64-20210809
X-UUID: 2574f97aa48d4b3da3cff3efa9822d64-20210809
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <derong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 664108739; Mon, 09 Aug 2021 15:25:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Aug 2021 15:25:28 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Aug 2021 15:25:27 +0800
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
Subject: [PATCH v2] mmc: mediatek: add wait dma stop done flow
Date:   Mon, 9 Aug 2021 15:23:16 +0800
Message-ID: <20210809072315.1127-1-derong.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.

According to the programming guide of mtk mmc host,it needs to wait for dma stop done after set dma stop.
This change should be applied to all SoCs.

Signed-off-by: Derong Liu <derong.liu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..1dfd2842471b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2339,6 +2339,8 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
 	if (recovery) {
 		sdr_set_field(host->base + MSDC_DMA_CTRL,
 			      MSDC_DMA_CTRL_STOP, 1);
+		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
+			cpu_relax();
 		msdc_reset_hw(host);
 	}
 }
-- 
2.18.0

