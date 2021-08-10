Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE94C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0673361076
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhHJIRL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:17:11 -0400
Received: from muru.com ([72.249.23.125]:40632 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhHJIRL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Aug 2021 04:17:11 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4139380CF;
        Tue, 10 Aug 2021 08:17:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/3] mmc: sdhci: Fix issue with uninitialized dma_slave_config
Date:   Tue, 10 Aug 2021 11:16:42 +0300
Message-Id: <20210810081644.19353-1-tony@atomide.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Depending on the DMA driver being used, the struct dma_slave_config may
need to be initialized to zero for the unused data.

For example, we have three DMA drivers using src_port_window_size and
dst_port_window_size. If these are left uninitialized, it can cause DMA
failures at least if external TI SDMA is ever configured for sdhci.

For other external DMA cases, this is probably not currently an issue but
is still good to fix though.

Fixes: 18e762e3b7a7 ("mmc: sdhci: add support for using external DMA devices")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1222,6 +1222,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 	if (!host->mapbase)
 		return -EINVAL;
 
+	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
 	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-- 
2.32.0
