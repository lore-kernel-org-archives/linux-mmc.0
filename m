Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2EC4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8629E61251
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhJEK0Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:26:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:3414 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233928AbhJEK0Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="212636871"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="212636871"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="711770038"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2021 03:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC2AD86; Tue,  5 Oct 2021 13:24:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 1/6] mmc: sdhci: Introduce couple of quirks to ignore particular state of CD GPIO
Date:   Tue,  5 Oct 2021 13:24:25 +0300
Message-Id: <20211005102430.63716-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some platforms may provide contradictory info in some states of CD GPIO line,
and hence that state or states should be ignored. Introduce couple of quirks
for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c | 13 ++++++++-----
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 357b365bf0ec..a7960ee3ef4f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2395,7 +2395,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_ios);
 static int sdhci_get_cd(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	int gpio_cd = mmc_gpio_get_cd(mmc);
+	int gpio_cd;
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		return 0;
@@ -2405,11 +2405,14 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 		return 1;
 
 	/*
-	 * Try slot gpio detect, if defined it take precedence
-	 * over build in controller functionality
+	 * Try slot GPIO detect, if defined it take precedence
+	 * over build in controller functionality.
 	 */
-	if (gpio_cd >= 0)
-		return !!gpio_cd;
+	gpio_cd = mmc_gpio_get_cd(mmc);
+	if (gpio_cd == 0 && !(host->quirks2 & SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_LOW))
+		return 0;
+	if (gpio_cd > 0 && !(host->quirks2 & SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH))
+		return 1;
 
 	/* If polling, assume that the card is always present. */
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e8d04e42a5af..fb7910d22b18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -464,6 +464,10 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
 /* Controller has CRC in 136 bit Command Response */
 #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+/* Controller requires additional card detection test on GPIO low */
+#define SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_LOW		(1<<17)
+/* Controller requires additional card detection test on GPIO high */
+#define SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH		(1<<18)
 /*
  * Disable HW timeout if the requested timeout is more than the maximum
  * obtainable timeout.
-- 
2.33.0

