From: <gregkh@suse.de>
Subject: patch mmc_block-fix-probe-error-cleanup-bug.patch added to 2.6.32-stable tree
Date: Thu, 14 Jan 2010 07:32:28 -0800
Message-ID: <1263483148287@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43759 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757256Ab0ANPdm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jan 2010 10:33:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jarkko.lavinen@nokia.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc_block: fix probe error cleanup bug

to the 2.6.32-stable tree.  Its filename is

    mmc_block-fix-probe-error-cleanup-bug.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From 0a74ff29b8dd8b748f8856352f9a9b5c6cc362cc Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 8 Jan 2010 14:42:59 -0800
Subject: mmc_block: fix probe error cleanup bug

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

commit 0a74ff29b8dd8b748f8856352f9a9b5c6cc362cc upstream.

If mmc_blk_set_blksize() fails mmc_blk_probe() the request queue and its
thread have been set up and they need to be shut down properly before
putting the disk.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/card/block.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -618,6 +618,7 @@ static int mmc_blk_probe(struct mmc_card
 	return 0;
 
  out:
+	mmc_cleanup_queue(&md->queue);
 	mmc_blk_put(md);
 
 	return err;


Patches currently in stable-queue which might be from jarkko.lavinen@nokia.com are

queue-2.6.32/mmc_block-fix-probe-error-cleanup-bug.patch
