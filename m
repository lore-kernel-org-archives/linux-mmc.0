Return-Path: <SRS0=MzOG=D3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B559FC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6585D223BF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgJTCyh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:54:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51336 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgJTCyg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Oct 2020 22:54:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56672200431;
        Tue, 20 Oct 2020 04:54:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F6932004F1;
        Tue, 20 Oct 2020 04:54:33 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8D10B402FC;
        Tue, 20 Oct 2020 04:54:30 +0200 (CEST)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [v2] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Date:   Tue, 20 Oct 2020 10:45:34 +0800
Message-Id: <20201020024534.29355-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For eMMC HS400 mode initialization, the DLL reset is a required step
if DLL is enabled to use previously, like in bootloader.
This step has not been documented in reference manual, but the RM will
be fixed sooner or later.

This patch is to add the step of DLL reset, and make sure delay chain
locked for HS400.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Converted to use read_poll_timeout.
---
 drivers/mmc/host/sdhci-esdhc.h    |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a30796e..6de02f0 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -5,6 +5,7 @@
  * Copyright (c) 2007 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
+ * Copyright 2020 NXP
  *   Author: Wolfram Sang <kernel@pengutronix.de>
  */
 
@@ -88,6 +89,7 @@
 /* DLL Config 0 Register */
 #define ESDHC_DLLCFG0			0x160
 #define ESDHC_DLL_ENABLE		0x80000000
+#define ESDHC_DLL_RESET			0x40000000
 #define ESDHC_DLL_FREQ_SEL		0x08000000
 
 /* DLL Config 1 Register */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 0b45eff..5a9bda3 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2007, 2010, 2012 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
+ * Copyright 2020 NXP
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
  *	    Anton Vorontsov <avorontsov@ru.mvista.com>
@@ -743,6 +744,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		if (host->mmc->actual_clock == MMC_HS200_MAX_DTR)
 			temp |= ESDHC_DLL_FREQ_SEL;
 		sdhci_writel(host, temp, ESDHC_DLLCFG0);
+
+		temp |= ESDHC_DLL_RESET;
+		sdhci_writel(host, temp, ESDHC_DLLCFG0);
+		udelay(1);
+		temp &= ~ESDHC_DLL_RESET;
+		sdhci_writel(host, temp, ESDHC_DLLCFG0);
+
+		/* Wait max 20 ms */
+		if (read_poll_timeout(sdhci_readl, temp,
+				      temp & ESDHC_DLL_STS_SLV_LOCK,
+				      10, 20000, false,
+				      host, ESDHC_DLLSTAT0))
+			pr_err("%s: timeout for delay chain lock.\n",
+			       mmc_hostname(host->mmc));
+
 		temp = sdhci_readl(host, ESDHC_TBCTL);
 		sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
 
-- 
2.7.4

