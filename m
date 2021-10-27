Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39383C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 03:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BA760ED4
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 03:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhJ0DPd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 23:15:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39064 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhJ0DPc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Oct 2021 23:15:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22F37202C64;
        Wed, 27 Oct 2021 05:13:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE9CE202C5F;
        Wed, 27 Oct 2021 05:13:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C7974183AD6D;
        Wed, 27 Oct 2021 11:13:05 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
Date:   Wed, 27 Oct 2021 10:47:21 +0800
Message-Id: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For ADMA with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it limit
the max segment size as 64K-1. Currently, linux kernel support
4K/16K/64K PAGE_SIZE. If choose 64K PAGE_SIZE, sdhci in ADMA mode
with the upper quirks will meet issue.

Though mmc driver give block layer the max segment size through
blk_queue_max_segment_size(), but in this function, it will compare
the argument with PAGE_SIZE, and will choose PAGE_SIZE if the argument
is smaller than PAGE_SIZE. When PAGE_SIZE is 64K, finally the mmc
request queue will get 64K as the max segment size. Once the sg data
length=64K, ADMA will meet issue. For this case, need to disable ADMA
mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dbe87995596c..47e0c0156b94 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4187,6 +4187,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) &&
+		PAGE_SIZE >= 65536 && (host->flags & SDHCI_USE_ADMA)) {
+		DBG("Disabling ADMA as it don't support >= 64K PAGE_SIZE\n");
+		host->flags &= ~SDHCI_USE_ADMA;
+	}
+
 	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
-- 
2.17.1

