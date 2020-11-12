Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B28C388F7
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3020022248
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLNhT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:37:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:47757 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKLNhT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 08:37:19 -0500
IronPort-SDR: 0wDdeUnwiI513Fmjj3904I3r+wakdw2meu6Ns6aAwGS0QA1WKN1B0YClIVAChVPEkONxX4QApt
 wT4+Bhjc0SwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="234470031"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="234470031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:37:15 -0800
IronPort-SDR: WyvI/wmReSta3Z9z/ipOPEoT+DA1nrACXkaqVv22GK4nqZ8M3FA7+EH0FxQ9V1IWofAEQeQznB
 H1eHrfXujrhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="308846227"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.94])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2020 05:37:12 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH V2] mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode for BYT-based Intel controllers
Date:   Thu, 12 Nov 2020 15:36:56 +0200
Message-Id: <20201112133656.20317-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A UHS setting of SDR25 can give better results for High Speed mode.
This is because there is no setting corresponding to high speed.  Currently
SDHCI sets no value, which means zero which is also the setting for SDR12.
There was an attempt to change this in sdhci.c but it caused problems for
some drivers, so it was reverted and the change was made to sdhci-brcmstb
in commit 2fefc7c5f7d16e ("mmc: sdhci-brcmstb: Fix incorrect switch to HS
mode").  Several other drivers also do this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v5.4+
---


Changes in V2:

	Expand commit message.


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

