From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH]mmc: check if mmc cards < 2GB do sector addressing
Date: Thu, 27 Jan 2011 13:00:51 -0800
Message-ID: <F2990CF4-0E5C-40AF-9BF8-80345C28FF2E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48220 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753783Ab1A0VA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jan 2011 16:00:56 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hanumath Prasad <hanumath.prasad@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hanumath,

There is one other case we came across were sector addressing for mmc cards is required.
I don't know if you have seen this case but the patch is below.

Philip


Some TOSHIBA MMC cards only support sector addressing
even though the size is < 2GB.  According to JEDEC
Spec JESD84-A441-1 the ocr register (bits 30, 29)
determine byte/sector mode.  Use them.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/mmc.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c139a5e..9303a57 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -378,6 +378,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	int err, ddr = 0;
 	u32 cid[4];
 	unsigned int max_dtr;
+	u32 rocr;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -391,7 +392,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	mmc_go_idle(host);
 
 	/* The extra bit indicates that we support high capacity */
-	err = mmc_send_op_cond(host, ocr | (1 << 30), NULL);
+	err = mmc_send_op_cond(host, ocr | (1 << 30), &rocr);
 	if (err)
 		goto err;
 
@@ -479,6 +480,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_read_ext_csd(card);
 		if (err)
 			goto free_card;
+
+		/* if doing byte addressing check if required to do sector */
+		/* addressing.  Handle case of cards < 2GB needing sector */
+		/* addressing.  See section 8.1 JEDEC Standard JED84-A441 */
+		/* ocr register has bit 30 set for sector addressing */
+		if (!(mmc_card_blockaddr(card)) && (rocr & (1<<30)))
+			mmc_card_set_blockaddr(card);
 		/* Erase size depends on CSD and Extended CSD */
 		mmc_set_erase_size(card);
 	}
-- 
1.7.0.4

