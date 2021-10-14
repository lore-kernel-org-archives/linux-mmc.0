Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E542C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF2610E7
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJNN2T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:28:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:20897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhJNN2S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 09:28:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="288543198"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="288543198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="548740861"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2021 06:26:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0B5C2E4; Thu, 14 Oct 2021 16:26:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v3 1/5] mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
Date:   Thu, 14 Oct 2021 16:26:09 +0300
Message-Id: <20211014132613.27861-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
References: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The analogue of the sdhci_get_cd_nogpio() is used in the sdhci-pci-core
and sdhci-acpi modules. Deduplicate it by moving to sdhci and exporting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
index dbe87995596c..269c86569402 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2425,6 +2425,25 @@ static int sdhci_get_cd(struct mmc_host *mmc)
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

