Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C51DC433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 09:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727FF61108
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIJq0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:46:26 -0400
Received: from www.zeus03.de ([194.117.254.33]:49648 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIJqX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Apr 2021 05:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=0Mu+/ALnJs4s2b3c+YHbQJNQv4k
        +Ikwow96fnquIaUw=; b=sVVlDbV55MjRLh5C6H2SJPshtWuvzaUc//CQMhBMhG3
        7kGEsmDfU1ZEZ39S+7g5Eki9DSZ+16V7/Nnx866SGRlPjW5rnj+pNjbKGAwfH1e6
        MaUKUc6fHnq0ZQQjEGcz1UVmHZGJ1LPck4D6cHUCutakOJck1Y+8YUtPBdz+nDBI
        =
Received: (qmail 3723855 invoked from network); 9 Apr 2021 11:46:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Apr 2021 11:46:09 +0200
X-UD-Smtp-Session: l3s3148p1@/82SCIe/6LMgARa4RVM+AT5wAMFZBfoZ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT v2] mmc: renesas_sdhi: enable WAIT_WHILE_BUSY
Date:   Fri,  9 Apr 2021 11:46:06 +0200
Message-Id: <20210409094606.4317-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Now that we got the timeout handling in the driver correct, we can use
this capability to avoid polling via the MMC core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1:
* moved wrongly set flags from tmio_flags to capabilities

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ff97f15e317c..e8f4863d8f1a 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -97,7 +97,7 @@ static const struct renesas_sdhi_of_data of_rza2_compatible = {
 			  TMIO_MMC_HAVE_CBSY,
 	.tmio_ocr_mask	= MMC_VDD_32_33,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_CMD23,
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.bus_shift	= 2,
 	.scc_offset	= 0 - 0x1000,
 	.taps		= rcar_gen3_scc_taps,
@@ -111,7 +111,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_CMD23,
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c5f789675302..ffa64211f4de 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -33,12 +33,14 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT |
 			  TMIO_MMC_HAVE_CBSY,
 	.tmio_ocr_mask	= MMC_VDD_32_33,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_WAIT_WHILE_BUSY,
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 };
 
@@ -58,7 +60,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
-			  MMC_CAP_CMD23,
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
-- 
2.30.0

