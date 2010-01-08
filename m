From: akpm@linux-foundation.org
Subject: [patch 20/42] mmc_block: fix probe error cleanup bug
Date: Fri, 08 Jan 2010 14:42:59 -0800
Message-ID: <201001082243.o08Mgx1N018483@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754063Ab0AHWtb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2010 17:49:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org, stable@kernel.org

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

If mmc_blk_set_blksize() fails mmc_blk_probe() the request queue and its
thread have been set up and they need to be shut down properly before
putting the disk.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/card/block.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/mmc/card/block.c~mmc_block-fix-probe-error-cleanup-bug drivers/mmc/card/block.c
--- a/drivers/mmc/card/block.c~mmc_block-fix-probe-error-cleanup-bug
+++ a/drivers/mmc/card/block.c
@@ -618,6 +618,7 @@ static int mmc_blk_probe(struct mmc_card
 	return 0;
 
  out:
+	mmc_cleanup_queue(&md->queue);
 	mmc_blk_put(md);
 
 	return err;
_
