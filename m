Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46570C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhKXJwC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 04:52:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:39511 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhKXJwC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Nov 2021 04:52:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233966599"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="233966599"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="571428681"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2021 01:48:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-pci: Add PCI ID for Intel ADL
Date:   Wed, 24 Nov 2021 11:48:50 +0200
Message-Id: <20211124094850.1783220-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add PCI ID for Intel ADL eMMC host controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 6f9877546830..ed53276f6ad9 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1866,6 +1866,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, LKF_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, LKF_SD,    intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, ADL_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
 	SDHCI_PCI_DEVICE(O2, 8220,     o2),
 	SDHCI_PCI_DEVICE(O2, 8221,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 5e3193278ff9..3661a224fb04 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -59,6 +59,7 @@
 #define PCI_DEVICE_ID_INTEL_JSL_SD	0x4df8
 #define PCI_DEVICE_ID_INTEL_LKF_EMMC	0x98c4
 #define PCI_DEVICE_ID_INTEL_LKF_SD	0x98f8
+#define PCI_DEVICE_ID_INTEL_ADL_EMMC	0x54c4
 
 #define PCI_DEVICE_ID_SYSKONNECT_8000	0x8000
 #define PCI_DEVICE_ID_VIA_95D0		0x95d0
-- 
2.25.1

