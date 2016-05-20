From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/3] mmc: longer timeout for long read time quirk
Date: Fri, 20 May 2016 10:33:46 +0300
Message-ID: <1463729628-3517-2-git-send-email-adrian.hunter@intel.com>
References: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbcETHhq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2016 03:37:46 -0400
In-Reply-To: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

From: Matt Gumbel <matthew.k.gumbel@intel.com>

008GE0 Toshiba mmc in some Intel Baytrail tablets responds to
MMC_SEND_EXT_CSD in 450-600ms.

This patch will...

() Increase the long read time quirk timeout from 300ms to 600ms. Original
   author of that quirk says 300ms was only a guess and that the number
   may need to be raised in the future.

() Add this specific MMC to the quirk

Signed-off-by: Matt Gumbel <matthew.k.gumbel@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/card/block.c | 5 +++--
 drivers/mmc/core/core.c  | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 33b98595d8d7..a92d183907ed 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2536,11 +2536,12 @@ static const struct mmc_fixup blk_fixups[] =
 		  MMC_QUIRK_BLK_NO_CMD23),
 
 	/*
-	 * Some Micron MMC cards needs longer data read timeout than
-	 * indicated in CSD.
+	 * Some MMC cards need longer data read timeout than indicated in CSD.
 	 */
 	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
 		  MMC_QUIRK_LONG_READ_TIME),
+	MMC_FIXUP("008GE0", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_LONG_READ_TIME),
 
 	/*
 	 * On these Samsung MoviNAND parts, performing secure erase or
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 99275e40bf2f..8b4dfd45433b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -875,11 +875,11 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	/*
 	 * Some cards require longer data read timeout than indicated in CSD.
 	 * Address this by setting the read timeout to a "reasonably high"
-	 * value. For the cards tested, 300ms has proven enough. If necessary,
+	 * value. For the cards tested, 600ms has proven enough. If necessary,
 	 * this value can be increased if other problematic cards require this.
 	 */
 	if (mmc_card_long_read_time(card) && data->flags & MMC_DATA_READ) {
-		data->timeout_ns = 300000000;
+		data->timeout_ns = 600000000;
 		data->timeout_clks = 0;
 	}
 
-- 
1.9.1

