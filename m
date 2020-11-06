Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C49EC2D0A3
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 13:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B665620735
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 13:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKFNsX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Nov 2020 08:48:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:1057 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgKFNsX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Nov 2020 08:48:23 -0500
IronPort-SDR: D323Q490w/AG4PBOjvcLmFwowteghFT9UrzXu8SuTFGeCREPAbX5zdKCzUT6xqP/P+NiTR6WML
 vlv7MYK3lLxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="149396949"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="149396949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 05:48:22 -0800
IronPort-SDR: Gkdp8fHyVQomYQIB+QNKfRsPJVYFJlgn1PVm+U+6T3XpNriJs03Yz/6+ygMQ2RzqAtO0igkFIV
 OSUcJzp/umKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="358800847"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.94])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2020 05:48:21 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode for BYT-based Intel controllers
Date:   Fri,  6 Nov 2020 15:48:07 +0200
Message-Id: <20201106134807.9076-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A UHS setting of SDR25 can give better results for High Speed mode.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v5.4+
---
 drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 23da7f7fe093..9552708846ca 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -665,6 +665,15 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	}
 }
 
+static void sdhci_intel_set_uhs_signaling(struct sdhci_host *host,
+					  unsigned int timing)
+{
+	/* Set UHS timing to SDR25 for High Speed mode */
+	if (timing == MMC_TIMING_MMC_HS || timing == MMC_TIMING_SD_HS)
+		timing = MMC_TIMING_UHS_SDR25;
+	sdhci_set_uhs_signaling(host, timing);
+}
+
 #define INTEL_HS400_ES_REG 0x78
 #define INTEL_HS400_ES_BIT BIT(0)
 
@@ -721,7 +730,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_reset,
-	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.set_uhs_signaling	= sdhci_intel_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 };
 
@@ -731,7 +740,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= sdhci_cqhci_reset,
-	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.set_uhs_signaling	= sdhci_intel_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 	.irq			= sdhci_cqhci_irq,
 };
-- 
2.17.1

