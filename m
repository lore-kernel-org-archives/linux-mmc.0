Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C0CC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4D6619D8
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhCaIRo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:17:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:34229 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234098AbhCaIRn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 31 Mar 2021 04:17:43 -0400
IronPort-SDR: PikBYEMNmoh3fKIGleDquR3mKfg/IDPIhy4tG0vf4TP9xDj5VFVkvBeJM3Hecojz02WFkpBfX4
 ShnUCzg8jkAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179485659"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="179485659"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 01:17:42 -0700
IronPort-SDR: k39yvb87oQPnCQsTrs5onTNk1xu3ys0nCy96l5l8wL1j+brNs+YD6B7Rld/x5jfdYSIAMrLWKA
 gXVQa+BpTXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="445541036"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2021 01:17:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Fix initialization of some SD cards for Intel BYT-based controllers
Date:   Wed, 31 Mar 2021 11:17:52 +0300
Message-Id: <20210331081752.23621-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Bus power may control card power, but the full reset done by SDHCI at
initialization still may not reset the power, whereas a direct write to
SDHCI_POWER_CONTROL can. That might be needed to initialize correctly, if
the card was left powered on previously.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b3caa174effe..be19785227fe 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -516,6 +516,7 @@ struct intel_host {
 	int	drv_strength;
 	bool	d3_retune;
 	bool	rpm_retune_ok;
+	bool	needs_pwr_off;
 	u32	glk_rx_ctrl1;
 	u32	glk_tun_val;
 	u32	active_ltr;
@@ -643,9 +644,25 @@ static int bxt_get_cd(struct mmc_host *mmc)
 static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 				  unsigned short vdd)
 {
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
 	int cntr;
 	u8 reg;
 
+	/*
+	 * Bus power may control card power, but a full reset still may not
+	 * reset the power, whereas a direct write to SDHCI_POWER_CONTROL can.
+	 * That might be needed to initialize correctly, if the card was left
+	 * powered on previously.
+	 */
+	if (intel_host->needs_pwr_off) {
+		intel_host->needs_pwr_off = false;
+		if (mode != MMC_POWER_OFF) {
+			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+			usleep_range(10000, 12500);
+		}
+	}
+
 	sdhci_set_power(host, mode, vdd);
 
 	if (mode == MMC_POWER_OFF)
@@ -1135,6 +1152,14 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static void byt_needs_pwr_off(struct sdhci_pci_slot *slot)
+{
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
+	u8 reg = sdhci_readb(slot->host, SDHCI_POWER_CONTROL);
+
+	intel_host->needs_pwr_off = reg  & SDHCI_POWER_ON;
+}
+
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
 	byt_probe_slot(slot);
@@ -1152,6 +1177,8 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	    slot->chip->pdev->subsystem_device == PCI_SUBDEVICE_ID_NI_78E3)
 		slot->host->mmc->caps2 |= MMC_CAP2_AVOID_3_3V;
 
+	byt_needs_pwr_off(slot);
+
 	return 0;
 }
 
-- 
2.17.1

