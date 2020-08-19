Return-Path: <SRS0=2cKM=B5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E16C433E3
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EB5206FA
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHSMTa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:19:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:33926 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbgHSMTW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Aug 2020 08:19:22 -0400
IronPort-SDR: FO+o1Jbm9s7aRh63wj99UJdkli5KkX+0qJIv16AGc92acUbFbN2zGTqtl3nqXHsG5lLqT1szVq
 J/fA0g0IY7Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135163089"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135163089"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 05:19:22 -0700
IronPort-SDR: Lpu1stuNTgWYH/6IJRfB4fHxLhb97RnZ8pD/q75L3KsH+37eH/zTOzbp0QhZCb2RPcPYqc3Xdi
 o9NWigKCor+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="334662913"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2020 05:19:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Ramuthevar Vadivel Muruganx 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH] mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers
Date:   Wed, 19 Aug 2020 15:18:48 +0300
Message-Id: <20200819121848.16967-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For Intel controllers, SDHCI_RESET_ALL resets also CQHCI registers.
Normally, SDHCI_RESET_ALL is not used while CQHCI is enabled, but that can
happen on the error path. e.g. if mmc_cqe_recovery() fails, mmc_blk_reset()
is called which, for a eMMC that does not support HW Reset, will cycle the
bus power and the driver will perform SDHCI_RESET_ALL.

So whenever performing SDHCI_RESET_ALL ensure CQHCI is deactivated.
That will force the driver to reinitialize CQHCI when it is next used.

A similar change was done already for sdhci-msm, and other drivers using
CQHCI might benefit from a similar change, if they also have CQHCI reset
by SDHCI_RESET_ALL.

Fixes: 8ee82bda230fc9 ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
Cc: stable@vger.kernel.org # 5.4.x: 0ffa6cfbd949: mmc: cqhci: Add cqhci_deactivate()
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index c0e081e48d3f..d0c8d39d5dbd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -234,6 +234,14 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
+static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
+{
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    host->mmc->cqe_private)
+		cqhci_deactivate(host->mmc);
+	sdhci_reset(host, mask);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -722,7 +730,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_cqhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 	.irq			= sdhci_cqhci_irq,
-- 
2.17.1

