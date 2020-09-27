Return-Path: <SRS0=02U7=DE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B63C4346E
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A864F23977
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 08:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgI0Ibb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:31:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58096 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbgI0Ibb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 27 Sep 2020 04:31:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B8881A0F87;
        Sun, 27 Sep 2020 10:31:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 910B21A0E29;
        Sun, 27 Sep 2020 10:31:27 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C1410402F7;
        Sun, 27 Sep 2020 10:31:24 +0200 (CEST)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-esdhc: fix reference clock source selection
Date:   Sun, 27 Sep 2020 16:23:04 +0800
Message-Id: <20200927082304.9232-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The bit ESDHC_PERIPHERAL_CLK_SEL to select using peripheral clock
or platform clock is not able to be reset by SDHCI_RESET_ALL.
So driver needs to initialize it as 1 or 0 once, to override the
different value which may be configured in bootloader.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 3a3340c..0b45eff 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1360,13 +1360,19 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 		clk_put(clk);
 	}
 
-	if (esdhc->peripheral_clock) {
-		esdhc_clock_enable(host, false);
-		val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	esdhc_clock_enable(host, false);
+	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	/*
+	 * This bit is not able to be reset by SDHCI_RESET_ALL. Need to
+	 * initialize it as 1 or 0 once, to override the different value
+	 * which may be configured in bootloader.
+	 */
+	if (esdhc->peripheral_clock)
 		val |= ESDHC_PERIPHERAL_CLK_SEL;
-		sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
-		esdhc_clock_enable(host, true);
-	}
+	else
+		val &= ~ESDHC_PERIPHERAL_CLK_SEL;
+	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+	esdhc_clock_enable(host, true);
 }
 
 static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
-- 
2.7.4

