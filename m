From: akpm@linux-foundation.org
Subject: [patch 01/41] mmc: avoid getting CID on SDIO-only cards
Date: Thu, 09 Sep 2010 16:37:24 -0700
Message-ID: <201009092337.o89NbO08014159@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33043 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208Ab0IIXiG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 19:38:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, david.vrabel@csr.com, linux-mmc@vger.kernel.org, mirq-linux@rere.qmqm.pl

From: David Vrabel <david.vrabel@csr.com>

The introduction of support for SD combo cards breaks the initialization
of all CSR SDIO chips.  The GO_IDLE (CMD0) in mmc_sd_get_cid() causes CSR
chips to be reset (this is non-standard behavior).

When initializing an SDIO card check for a combo card by using the memory
present bit in the R4 response to IO_SEND_OP_COND (CMD5).  This avoids the
call to mmc_sd_get_cid() on an SDIO-only card.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
Acked-by: Michal Mirolaw <mirq-linux@rere.qmqm.pl>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio.c  |    5 ++---
 include/linux/mmc/sdio.h |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/core/sdio.c~mmc-avoid-getting-cid-on-sdio-only-cards drivers/mmc/core/sdio.c
--- a/drivers/mmc/core/sdio.c~mmc-avoid-getting-cid-on-sdio-only-cards
+++ a/drivers/mmc/core/sdio.c
@@ -362,9 +362,8 @@ static int mmc_sdio_init_card(struct mmc
 		goto err;
 	}
 
-	err = mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
-
-	if (!err) {
+	if (ocr & R4_MEMORY_PRESENT
+	    && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
diff -puN include/linux/mmc/sdio.h~mmc-avoid-getting-cid-on-sdio-only-cards include/linux/mmc/sdio.h
--- a/include/linux/mmc/sdio.h~mmc-avoid-getting-cid-on-sdio-only-cards
+++ a/include/linux/mmc/sdio.h
@@ -38,6 +38,8 @@
  *      [8:0] Byte/block count
  */
 
+#define R4_MEMORY_PRESENT (1 << 27)
+
 /*
   SDIO status in R5
   Type
_
