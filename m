From: NeilBrown <neil@brown.name>
Subject: [PATCH 1/4] mmc: core: fold mmc_set_bus_width calls into
 sdio_enable_4bit_bus.
Date: Wed, 25 Mar 2015 07:56:10 +1100
Message-ID: <20150324205610.20572.86108.stgit@notabene.brown>
References: <20150324205316.20572.30538.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55412 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbCXVI3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 17:08:29 -0400
In-Reply-To: <20150324205316.20572.30538.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mmc <linux-mmc@vger.kernel.org>

From: NeilBrown <neilb@suse.de>

Every call to sdio_enable_4bit_bus is followed (on success) but a call
to mmc_set_bus_width().

To simplify the code, include those calls directly in
sdio_enable_4bit_bus().

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/sdio.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ce6cc47206b0..5bc6c7dbbd60 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -293,19 +293,22 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
 	int err;
 
 	if (card->type == MMC_TYPE_SDIO)
-		return sdio_enable_wide(card);
-
-	if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
-		(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		err = sdio_enable_wide(card);
+	else if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
+		 (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
 		err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
 		if (err)
 			return err;
+		err = sdio_enable_wide(card);
+		if (err <= 0)
+			mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
 	} else
 		return 0;
 
-	err = sdio_enable_wide(card);
-	if (err <= 0)
-		mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
+	if (err > 0) {
+		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
+		err = 0;
+	}
 
 	return err;
 }
@@ -547,13 +550,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	/*
 	 * Switch to wider bus (if supported).
 	 */
-	if (card->host->caps & MMC_CAP_4_BIT_DATA) {
+	if (card->host->caps & MMC_CAP_4_BIT_DATA)
 		err = sdio_enable_4bit_bus(card);
-		if (err > 0) {
-			mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
-			err = 0;
-		}
-	}
 
 	/* Set the driver strength for the card */
 	sdio_select_driver_type(card);
@@ -803,9 +801,7 @@ try_again:
 		 * Switch to wider bus (if supported).
 		 */
 		err = sdio_enable_4bit_bus(card);
-		if (err > 0)
-			mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
-		else if (err)
+		if (err)
 			goto remove;
 	}
 finish:
@@ -983,10 +979,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
-		if (err > 0) {
-			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
-			err = 0;
-		}
 	}
 
 	if (!err && host->sdio_irqs) {


