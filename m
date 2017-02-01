From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/9] mmc: meson-gx: minor improvements in meson_mmc_set_ios
Date: Wed, 1 Feb 2017 07:48:28 +0100
Message-ID: <6c3b7dbe-fb65-b40d-2625-342e2bd48776@gmail.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35188 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGtr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 01:49:47 -0500
Received: by mail-wj0-f195.google.com with SMTP id i7so12152225wjf.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 22:49:47 -0800 (PST)
In-Reply-To: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

val isn't used in the switch clause and afterwards there's an
identical statement. So remove it.

In case of an unexpected bus width the error message indicates
the intention to set the bus width to 4 and to go on.
So remove the return statement. This return statement also
conflicts with "setting to 4" because nothing would be set
actually before returning.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index da3cce31..38edc60d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -379,7 +379,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	meson_mmc_clk_set(host, ios->clock);
 
 	/* Bus width */
-	val = readl(host->regs + SD_EMMC_CFG);
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
 		bus_width = CFG_BUS_WIDTH_1;
@@ -394,7 +393,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
 			ios->bus_width);
 		bus_width = CFG_BUS_WIDTH_4;
-		return;
 	}
 
 	val = readl(host->regs + SD_EMMC_CFG);
-- 
2.11.0



