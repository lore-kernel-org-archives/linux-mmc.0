Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858DFC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CCC61881
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhJEK03 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:26:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:3414 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhJEK02 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212636877"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="212636877"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="711770054"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2021 03:24:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26D2C355; Tue,  5 Oct 2021 13:24:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 6/6] mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)
Date:   Tue,  5 Oct 2021 13:24:30 +0300
Message-Id: <20211005102430.63716-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is no user of this member. Remove the dead code for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 27 ---------------------------
 drivers/mmc/host/sdhci-pci.h      |  2 --
 2 files changed, 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index a4279437bb5f..6c284e07675e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1900,21 +1900,6 @@ int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
-static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
-{
-	struct sdhci_pci_slot *slot = sdhci_priv(host);
-	int rst_n_gpio = slot->rst_n_gpio;
-
-	if (!gpio_is_valid(rst_n_gpio))
-		return;
-	gpio_set_value_cansleep(rst_n_gpio, 0);
-	/* For eMMC, minimum is 1us but give it 10us for good measure */
-	udelay(10);
-	gpio_set_value_cansleep(rst_n_gpio, 1);
-	/* For eMMC, minimum is 200us but give it 300us for good measure */
-	usleep_range(300, 1000);
-}
-
 static void sdhci_pci_hw_reset(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -2045,7 +2030,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 
 	slot->chip = chip;
 	slot->host = host;
-	slot->rst_n_gpio = -EINVAL;
 	slot->cd_idx = -1;
 
 	host->hw_name = "PCI";
@@ -2071,17 +2055,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 			goto cleanup;
 	}
 
-	if (gpio_is_valid(slot->rst_n_gpio)) {
-		if (!devm_gpio_request(&pdev->dev, slot->rst_n_gpio, "eMMC_reset")) {
-			gpio_direction_output(slot->rst_n_gpio, 1);
-			slot->host->mmc->caps |= MMC_CAP_HW_RESET;
-			slot->hw_reset = sdhci_pci_gpio_hw_reset;
-		} else {
-			dev_warn(&pdev->dev, "failed to request rst_n_gpio\n");
-			slot->rst_n_gpio = -EINVAL;
-		}
-	}
-
 	host->mmc->pm_caps = MMC_PM_KEEP_POWER;
 	host->mmc->slotno = slotno;
 	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 8bb3b9c78589..5e3193278ff9 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -157,8 +157,6 @@ struct sdhci_pci_slot {
 	struct sdhci_pci_chip	*chip;
 	struct sdhci_host	*host;
 
-	int			rst_n_gpio;
-
 	int			cd_idx;
 	bool			cd_override_level;
 
-- 
2.33.0

