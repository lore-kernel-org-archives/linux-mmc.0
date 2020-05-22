Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F9C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 03:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D413E20723
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 03:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEVDR7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 23:17:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36964 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgEVDR7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 May 2020 23:17:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E2F181A091D;
        Fri, 22 May 2020 05:17:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D9E591A091A;
        Fri, 22 May 2020 05:17:54 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 03304402BB;
        Fri, 22 May 2020 11:17:51 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-esdhc: exit HS400 properly before setting any speed mode
Date:   Fri, 22 May 2020 11:12:56 +0800
Message-Id: <20200522031256.856-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The eSDHC HS400 timing requires many specific registers setting,
unlike other speed modes which need to set only host controller 2
register. When driver needs to downgrade HS400 mode to other speed
mode, the controller have to exit HS400 timing properly first.
This patch is to support the procedure of HS400 exiting at the
beginning of esdhc_set_uhs_signaling.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5d8dd87..7c73d24 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1135,6 +1135,40 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static void esdhc_set_uhs_signaling(struct sdhci_host *host,
 				   unsigned int timing)
 {
+	u32 val;
+
+	/*
+	 * There are specific registers setting for HS400 mode.
+	 * Clean all of them if controller is in HS400 mode to
+	 * exit HS400 mode before re-setting any speed mode.
+	 */
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	if (val & ESDHC_HS400_MODE) {
+		val = sdhci_readl(host, ESDHC_SDTIMNGCTL);
+		val &= ~ESDHC_FLW_CTL_BG;
+		sdhci_writel(host, val, ESDHC_SDTIMNGCTL);
+
+		val = sdhci_readl(host, ESDHC_SDCLKCTL);
+		val &= ~ESDHC_CMD_CLK_CTL;
+		sdhci_writel(host, val, ESDHC_SDCLKCTL);
+
+		esdhc_clock_enable(host, false);
+		val = sdhci_readl(host, ESDHC_TBCTL);
+		val &= ~ESDHC_HS400_MODE;
+		sdhci_writel(host, val, ESDHC_TBCTL);
+		esdhc_clock_enable(host, true);
+
+		val = sdhci_readl(host, ESDHC_DLLCFG0);
+		val &= ~(ESDHC_DLL_ENABLE | ESDHC_DLL_FREQ_SEL);
+		sdhci_writel(host, val, ESDHC_DLLCFG0);
+
+		val = sdhci_readl(host, ESDHC_TBCTL);
+		val &= ~ESDHC_HS400_WNDW_ADJUST;
+		sdhci_writel(host, val, ESDHC_TBCTL);
+
+		esdhc_tuning_block_enable(host, false);
+	}
+
 	if (timing == MMC_TIMING_MMC_HS400)
 		esdhc_tuning_block_enable(host, true);
 	else
-- 
2.7.4

