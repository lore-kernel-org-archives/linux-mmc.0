From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 2/9] mmc: meson-gx: minor improvements in meson_mmc_set_ios
Date: Tue, 7 Feb 2017 22:34:06 +0100
Message-ID: <07e0b346-1ae8-6745-0e9b-de15a6525823@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34150 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbdBGVp3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:45:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so30745942wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:45:29 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

val isn't used in the switch clause and afterwards there's an
identical statement. So remove it.

In case of an unexpected bus width the error message indicates
the intention to set the bus width to 4 and to go on.
So remove the return statement. This return statement also
conflicts with "setting to 4" because nothing would be set
actually before returning. 4bit bus width are chosen as
default as the vendor driver does it too.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- extended commit message
---
 drivers/mmc/host/meson-gx-mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index ef2ce725..9d79df7c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -371,7 +371,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	meson_mmc_clk_set(host, ios->clock);
 
 	/* Bus width */
-	val = readl(host->regs + SD_EMMC_CFG);
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
 		bus_width = CFG_BUS_WIDTH_1;
@@ -386,7 +385,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
 			ios->bus_width);
 		bus_width = CFG_BUS_WIDTH_4;
-		return;
 	}
 
 	val = readl(host->regs + SD_EMMC_CFG);
-- 
2.11.0


