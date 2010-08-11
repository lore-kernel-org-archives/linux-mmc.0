From: akpm@linux-foundation.org
Subject: [patch 039/177] mmc: only set blockaddressed for > 2GiB cards
Date: Tue, 10 Aug 2010 18:01:45 -0700
Message-ID: <201008110101.o7B11jUT027061@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42950 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236Ab0HKBCV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:02:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, hanumath.prasad@stericsson.com, linus.walleij@stericsson.com, linux-mmc@vger.kernel.org, rabin.vincent@stericsson.com

From: Hanumath Prasad <hanumath.prasad@stericsson.com>

A non-zero value of SEC_COUNT does not indicate that the card is sector
addressed.  According to the MMC specification, cards with a density
greater than 2GiB are sector addressed.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/core/mmc.c~mmc-only-set-blockaddressed-for-2gib-cards drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc-only-set-blockaddressed-for-2gib-cards
+++ a/drivers/mmc/core/mmc.c
@@ -234,7 +234,9 @@ static int mmc_read_ext_csd(struct mmc_c
 			ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
 			ext_csd[EXT_CSD_SEC_CNT + 2] << 16 |
 			ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
-		if (card->ext_csd.sectors)
+
+		/* Cards with density > 2GiB are sector addressed */
+		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
 			mmc_card_set_blockaddr(card);
 	}
 
_
