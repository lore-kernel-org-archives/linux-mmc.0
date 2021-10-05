Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6286C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B056615A6
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhJEK00 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:26:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:42844 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhJEK0Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205826612"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="205826612"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="483724768"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2021 03:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C32E265; Tue,  5 Oct 2021 13:24:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 3/6] mmc: sdhci: Replace bxt_get_cd() with SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH
Date:   Tue,  5 Oct 2021 13:24:27 +0300
Message-Id: <20211005102430.63716-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The bxt_get_cd() repeats the functionality of sdhci_get_cd() when
SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH is set. Thus, replace the
method with the setting of the quirk.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c     | 24 +-----------------------
 drivers/mmc/host/sdhci-pci-core.c | 24 +-----------------------
 2 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8fe65f172a61..126c3afaf21b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -359,28 +359,6 @@ static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 
 #endif
 
-static int bxt_get_cd(struct mmc_host *mmc)
-{
-	int gpio_cd = mmc_gpio_get_cd(mmc);
-	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
-	int ret = 0;
-
-	if (!gpio_cd)
-		return 0;
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	if (host->flags & SDHCI_DEVICE_DEAD)
-		goto out;
-
-	ret = !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	return ret;
-}
-
 static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
@@ -393,7 +371,7 @@ static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *ad
 		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 
 	if (acpi_dev_hid_uid_match(adev, "80865ACA", NULL))
-		host->mmc_host_ops.get_cd = bxt_get_cd;
+		host->quirks2 |= SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH;
 
 	intel_dsm_init(intel_host, &pdev->dev, host->mmc);
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 70ab0a7a3de8..30caa0b325de 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -616,28 +616,6 @@ static int intel_select_drive_strength(struct mmc_card *card,
 	return intel_host->drv_strength;
 }
 
-static int bxt_get_cd(struct mmc_host *mmc)
-{
-	int gpio_cd = mmc_gpio_get_cd(mmc);
-	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
-	int ret = 0;
-
-	if (!gpio_cd)
-		return 0;
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	if (host->flags & SDHCI_DEVICE_DEAD)
-		goto out;
-
-	ret = !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	return ret;
-}
-
 #define SDHCI_INTEL_PWR_TIMEOUT_CNT	20
 #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
 
@@ -1171,7 +1149,7 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD)
-		slot->host->mmc_host_ops.get_cd = bxt_get_cd;
+		slot->host->quirks2 |= SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH;
 
 	if (slot->chip->pdev->subsystem_vendor == PCI_VENDOR_ID_NI &&
 	    slot->chip->pdev->subsystem_device == PCI_SUBDEVICE_ID_NI_78E3)
-- 
2.33.0

