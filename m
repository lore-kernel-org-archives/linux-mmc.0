Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1FC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A24E61371
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhJEK0Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:26:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:3414 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhJEK0Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212636867"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="212636867"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="544699896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2021 03:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0363F252; Tue,  5 Oct 2021 13:24:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 2/6] mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield
Date:   Tue,  5 Oct 2021 13:24:26 +0300
Message-Id: <20211005102430.63716-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Intel Merrifield platform had been converted to use ACPI enumeration.
However, the driver missed an update to retrieve card detect GPIO.
Fix it here.

Unfortunately we can't rely on CD GPIO state because there are two
different PCB designs in the wild that are using an opposite card
detection sense and there is no way to distinguish those platforms,
that's why ignore CD GPIO completely and use it only as an card plug
or unplug event.

Fixes: 4590d98f5a4f ("sfi: Remove framework for deprecated firmware")
BugLink: https://github.com/edison-fw/meta-intel-edison/issues/135
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index be19785227fe..70ab0a7a3de8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1341,6 +1341,14 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 					 MMC_CAP_1_8V_DDR;
 		break;
 	case INTEL_MRFLD_SD:
+		slot->cd_idx = 0;
+		/*
+		 * There are two PCB designs of SD card slot with the opposite
+		 * card detection sense. Quirk this out by ignoring GPIO state
+		 * completely.
+		 */
+		slot->host->quirks2 |= SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_LOW |
+				       SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH;
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
-- 
2.33.0

