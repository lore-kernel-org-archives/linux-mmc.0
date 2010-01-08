From: akpm@linux-foundation.org
Subject: [patch 22/42] mmc: allow for MMC v4.4
Date: Fri, 08 Jan 2010 14:43:01 -0800
Message-ID: <201001082243.o08Mh1RD018492@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35721 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753416Ab0AHWrk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2010 17:47:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@nokia.com>

JEDEC eMMC specification version 4.4 (MMCA 4.4) defines Extended CSD
structure versions up to 5.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/core/mmc.c~mmc-allow-for-mmc-v44 drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc-allow-for-mmc-v44
+++ a/drivers/mmc/core/mmc.c
@@ -207,7 +207,7 @@ static int mmc_read_ext_csd(struct mmc_c
 	}
 
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
-	if (card->ext_csd.rev > 3) {
+	if (card->ext_csd.rev > 5) {
 		printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
 			"version %d\n", mmc_hostname(card->host),
 			card->ext_csd.rev);
_
