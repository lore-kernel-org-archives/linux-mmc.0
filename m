Return-Path: <SRS0=abg9=DX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E6C433E7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 04:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492C5206DD
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 04:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgJPEez (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Oct 2020 00:34:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40198 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731434AbgJPEez (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 16 Oct 2020 00:34:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1345F20066A;
        Fri, 16 Oct 2020 06:34:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BB3D20020F;
        Fri, 16 Oct 2020 06:34:51 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2AE3940243;
        Fri, 16 Oct 2020 06:34:48 +0200 (CEST)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
Date:   Fri, 16 Oct 2020 12:25:59 +0800
Message-Id: <20201016042559.25618-1-yangbo.lu@nxp.com>
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
 drivers/mmc/host/sdhci-esdhc.h    |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 0b45eff..a39ff86 100644
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
@@ -743,6 +744,29 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
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
+		timeout = ktime_add_ms(ktime_get(), 20);
+		while (1) {
+			bool timedout = ktime_after(ktime_get(), timeout);
+
+			if (sdhci_readl(host, ESDHC_DLLSTAT0) &
+			    ESDHC_DLL_STS_SLV_LOCK)
+				break;
+			if (timedout) {
+				pr_err("%s: timeout for delay chain lock.\n",
+					mmc_hostname(host->mmc));
+				break;
+			}
+			usleep_range(10, 20);
+		}
+
 		temp = sdhci_readl(host, ESDHC_TBCTL);
 		sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
 
-- 
2.7.4

