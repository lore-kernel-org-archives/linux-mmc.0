Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA4C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A73610CC
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhJNN2V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:28:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:20897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhJNN2U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 09:28:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="288543199"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="288543199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="548740863"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2021 06:26:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0EE8C5C4; Thu, 14 Oct 2021 16:26:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v3 4/5] mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
Date:   Thu, 14 Oct 2021 16:26:12 +0300
Message-Id: <20211014132613.27861-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
References: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The last user of this struct gone couple of releases ago.
Remove the dead code for good and encourage people to use
MMC core functionality for that.

The removal is dependent on the previous removal of the
struct sdhci_pci_data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 76 +------------------------------
 drivers/mmc/host/sdhci-pci.h      |  2 -
 2 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 8938c63b1e77..e2b6f60e9f01 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -345,73 +345,6 @@ static int pch_hc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
-static irqreturn_t sdhci_pci_sd_cd(int irq, void *dev_id)
-{
-	struct sdhci_pci_slot *slot = dev_id;
-	struct sdhci_host *host = slot->host;
-
-	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
-	return IRQ_HANDLED;
-}
-
-static void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
-{
-	int err, irq, gpio = slot->cd_gpio;
-
-	slot->cd_gpio = -EINVAL;
-	slot->cd_irq = -EINVAL;
-
-	if (!gpio_is_valid(gpio))
-		return;
-
-	err = devm_gpio_request(&slot->chip->pdev->dev, gpio, "sd_cd");
-	if (err < 0)
-		goto out;
-
-	err = gpio_direction_input(gpio);
-	if (err < 0)
-		goto out_free;
-
-	irq = gpio_to_irq(gpio);
-	if (irq < 0)
-		goto out_free;
-
-	err = request_irq(irq, sdhci_pci_sd_cd, IRQF_TRIGGER_RISING |
-			  IRQF_TRIGGER_FALLING, "sd_cd", slot);
-	if (err)
-		goto out_free;
-
-	slot->cd_gpio = gpio;
-	slot->cd_irq = irq;
-
-	return;
-
-out_free:
-	devm_gpio_free(&slot->chip->pdev->dev, gpio);
-out:
-	dev_warn(&slot->chip->pdev->dev, "failed to setup card detect wake up\n");
-}
-
-static void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
-{
-	if (slot->cd_irq >= 0)
-		free_irq(slot->cd_irq, slot);
-}
-
-#else
-
-static inline void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
-{
-}
-
-static inline void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
-{
-}
-
-#endif
-
 static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
@@ -2128,7 +2061,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	slot->chip = chip;
 	slot->host = host;
 	slot->rst_n_gpio = -EINVAL;
-	slot->cd_gpio = -EINVAL;
 	slot->cd_idx = -1;
 
 	host->hw_name = "PCI";
@@ -2199,15 +2131,11 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (ret)
 		goto remove;
 
-	sdhci_pci_add_own_cd(slot);
-
 	/*
 	 * Check if the chip needs a separate GPIO for card detect to wake up
 	 * from runtime suspend.  If it is not there, don't allow runtime PM.
-	 * Note sdhci_pci_add_own_cd() sets slot->cd_gpio to -EINVAL on failure.
 	 */
-	if (chip->fixes && chip->fixes->own_cd_for_runtime_pm &&
-	    !gpio_is_valid(slot->cd_gpio) && slot->cd_idx < 0)
+	if (chip->fixes && chip->fixes->own_cd_for_runtime_pm && slot->cd_idx < 0)
 		chip->allow_runtime_pm = false;
 
 	return slot;
@@ -2227,8 +2155,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	int dead;
 	u32 scratch;
 
-	sdhci_pci_remove_own_cd(slot);
-
 	dead = 0;
 	scratch = readl(slot->host->ioaddr + SDHCI_INT_STATUS);
 	if (scratch == (u32)-1)
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 15b36cd47860..8bb3b9c78589 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -158,8 +158,6 @@ struct sdhci_pci_slot {
 	struct sdhci_host	*host;
 
 	int			rst_n_gpio;
-	int			cd_gpio;
-	int			cd_irq;
 
 	int			cd_idx;
 	bool			cd_override_level;
-- 
2.33.0

