Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E436CC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE31A6101E
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJMUT2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:19:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:37325 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhJMUT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 Oct 2021 16:19:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="207637833"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="207637833"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 13:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="592309558"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2021 13:17:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 373CE2E4; Wed, 13 Oct 2021 23:17:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 2/6] mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
Date:   Wed, 13 Oct 2021 23:17:19 +0300
Message-Id: <20211013201723.52212-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The analogue of the sdhci_get_cd_nogpio() is used in the sdhci-pci-core
and sdhci-acpi modules. Deduplicate it by moving to sdhci and exporting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c     | 14 +-------------
 drivers/mmc/host/sdhci-pci-core.c | 18 ------------------
 drivers/mmc/host/sdhci.c          | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci.h          |  1 +
 4 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8fe65f172a61..f1ef0d28b0dd 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -362,23 +362,11 @@ static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 static int bxt_get_cd(struct mmc_host *mmc)
 {
 	int gpio_cd = mmc_gpio_get_cd(mmc);
-	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
-	int ret = 0;
 
 	if (!gpio_cd)
 		return 0;
 
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
+	return sdhci_get_cd_nogpio(mmc);
 }
 
 static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index d0f2edfe296c..19e13dfae593 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -616,24 +616,6 @@ static int intel_select_drive_strength(struct mmc_card *card,
 	return intel_host->drv_strength;
 }
 
-static int sdhci_get_cd_nogpio(struct mmc_host *mmc)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
-	int ret = 0;
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
 static int bxt_get_cd(struct mmc_host *mmc)
 {
 	int gpio_cd = mmc_gpio_get_cd(mmc);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 357b365bf0ec..1f4b052f6f27 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2419,6 +2419,25 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
 
+int sdhci_get_cd_nogpio(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		goto out;
+
+	ret = !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
+
 static int sdhci_check_ro(struct sdhci_host *host)
 {
 	unsigned long flags;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e8d04e42a5af..c593af479832 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -775,6 +775,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
+int sdhci_get_cd_nogpio(struct mmc_host *mmc);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
-- 
2.33.0

