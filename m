Return-Path: <SRS0=q8Wp=7D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F39FC433E5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 07:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC42083E
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 07:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgEUHBW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 03:01:22 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:14295 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728000AbgEUHBW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2020 03:01:22 -0400
X-IronPort-AV: E=Sophos;i="5.73,416,1583161200"; 
   d="scan'208";a="47438475"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 May 2020 16:01:19 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 854BA400C4C1;
        Thu, 21 May 2020 16:01:19 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] mmc: renesas_sdhi_internal_dmac: clean up the code for dma complete
Date:   Thu, 21 May 2020 16:01:05 +0900
Message-Id: <1590044466-28372-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590044466-28372-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1590044466-28372-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To add end() operation in the future, clean the code of
renesas_sdhi_internal_dmac_complete_tasklet_fn(). No behavior change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 47ac53e..201b8ed 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -229,15 +229,12 @@ static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
 					    DTRAN_CTRL_DM_START);
 }
 
-static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
+static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
 	enum dma_data_direction dir;
 
-	spin_lock_irq(&host->lock);
-
 	if (!host->data)
-		goto out;
+		return false;
 
 	if (host->data->flags & MMC_DATA_READ)
 		dir = DMA_FROM_DEVICE;
@@ -250,6 +247,17 @@ static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
 	if (dir == DMA_FROM_DEVICE)
 		clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
 
+	return true;
+}
+
+static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	spin_lock_irq(&host->lock);
+	if (!renesas_sdhi_internal_dmac_complete(host))
+		goto out;
+
 	tmio_mmc_do_data_irq(host);
 out:
 	spin_unlock_irq(&host->lock);
-- 
2.7.4

