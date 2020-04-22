Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF809C55185
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FE32082E
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 11:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDVLRI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:17:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:48144 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgDVLRE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Apr 2020 07:17:04 -0400
IronPort-SDR: T+DdBuc/T6mSb2pbZrpH3fiDwcaMZpg8VuepJfnB6jb/EtqkULhXu4RBCXK7DbUQy5yVtjSmuy
 ggU3hNGOT6Hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 04:17:04 -0700
IronPort-SDR: C2DUaIrZs/HXnunaSQvXMixT9WgjqJkrELSjw9u7o44wkaZwQKqj6GTqJJzK9LBIXqqA4joHHT
 B03jscWATp4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="279982003"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2020 04:17:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers
Date:   Wed, 22 Apr 2020 14:16:29 +0300
Message-Id: <20200422111629.4899-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

BIOS writers have begun the practice of setting 40 ohm eMMC driver strength
even though the eMMC may not support it, on the assumption that the kernel
will validate the value against the eMMC (Extended CSD DRIVER_STRENGTH
[offset 197]) and revert to the default 50 ohm value if 40 ohm is invalid.

This is done to avoid changing the value for different boards.

Putting aside the merits of this approach, it is clear the eMMC's mask
of supported driver strengths is more reliable than the value provided
by BIOS. Add validation accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 51ced59cc02e ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index a98c9476bfc8..af736afb4b91 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -597,6 +597,9 @@ static int intel_select_drive_strength(struct mmc_card *card,
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
+	if (!(mmc_driver_type_mask(intel_host->drv_strength) & card_drv))
+		return 0;
+
 	return intel_host->drv_strength;
 }
 
-- 
2.17.1

