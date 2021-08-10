Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC7C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CC460EB5
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbhHJIRS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:17:18 -0400
Received: from muru.com ([72.249.23.125]:40652 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238025AbhHJIRS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Aug 2021 04:17:18 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 922E180CF;
        Tue, 10 Aug 2021 08:17:15 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Jonas Jensen <jonas.jensen@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH 3/3] mmc: moxart: Fix issue with uninitialized dma_slave_config
Date:   Tue, 10 Aug 2021 11:16:44 +0300
Message-Id: <20210810081644.19353-3-tony@atomide.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810081644.19353-1-tony@atomide.com>
References: <20210810081644.19353-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Depending on the DMA driver being used, the struct dma_slave_config may
need to be initialized to zero for the unused data.

For example, we have three DMA drivers using src_port_window_size and
dst_port_window_size. If these are left uninitialized, it can cause DMA
failures.

For moxart, this is probably not currently an issue but is still good to
fix though.

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/moxart-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -628,6 +628,7 @@ static int moxart_probe(struct platform_device *pdev)
 			 host->dma_chan_tx, host->dma_chan_rx);
 		host->have_dma = true;
 
+		memset(&cfg, 0, sizeof(cfg));
 		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-- 
2.32.0
