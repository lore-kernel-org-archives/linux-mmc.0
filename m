Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D8C4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ACF2333E
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 10:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLPKaK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:30:10 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:42612 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgLPKaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 05:30:10 -0500
X-IronPort-AV: E=Sophos;i="5.78,424,1599490800"; 
   d="scan'208";a="66169015"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2020 19:29:39 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 38E9142C8FC1;
        Wed, 16 Dec 2020 19:29:39 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/2] mmc: renesas_sdhi_internal_dmac: Fix DMA buffer alignment from 8 to 128-bytes
Date:   Wed, 16 Dec 2020 19:29:31 +0900
Message-Id: <1608114572-1892-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608114572-1892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1608114572-1892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

According to the latest datasheet, the internal DMAC buffer alignment
R-Car Gen3 SDHI HW should be 128-bytes. So, fix it.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[shimoda: revise commit description, rebase]
Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index fe13e1e..f3e76d6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -186,8 +186,8 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 			mmc_get_dma_dir(data)))
 		goto force_pio;
 
-	/* This DMAC cannot handle if buffer is not 8-bytes alignment */
-	if (!IS_ALIGNED(sg_dma_address(sg), 8))
+	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	if (!IS_ALIGNED(sg_dma_address(sg), 128))
 		goto force_pio_with_unmap;
 
 	if (data->flags & MMC_DATA_READ) {
-- 
2.7.4

