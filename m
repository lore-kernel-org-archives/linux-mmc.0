From: <gregkh@suse.de>
Subject: patch mmc_block-add-dev_t-initialization-check.patch added to 2.6.32-stable tree
Date: Thu, 14 Jan 2010 07:32:27 -0800
Message-ID: <12634831471825@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43742 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266Ab0ANPdi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jan 2010 10:33:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: EXT-Anna.Lemehova@nokia.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc_block: add dev_t initialization check

to the 2.6.32-stable tree.  Its filename is

    mmc_block-add-dev_t-initialization-check.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From 7d92df692994472cab6045bbd9d0e2c4afa4365f Mon Sep 17 00:00:00 2001
From: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>
Date: Fri, 8 Jan 2010 14:42:58 -0800
Subject: mmc_block: add dev_t initialization check

From: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>

commit 7d92df692994472cab6045bbd9d0e2c4afa4365f upstream.

When a card is removed before mmc_blk_probe() has called add_disk(), then
the minor field is uninitialized and has value 0.  This caused
mmc_blk_put() to always release devidx 0 even if 0 was still in use.  Then
the next mmc_blk_probe() used the first free idx of 0, which oopses in
sysfs, since it is used by another card.

Signed-off-by: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/card/block.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -85,7 +85,12 @@ static void mmc_blk_put(struct mmc_blk_d
 	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
+		int devmaj = MAJOR(disk_devt(md->disk));
 		int devidx = MINOR(disk_devt(md->disk)) >> MMC_SHIFT;
+
+		if (!devmaj)
+			devidx = md->disk->first_minor >> MMC_SHIFT;
+
 		__clear_bit(devidx, dev_use);
 
 		put_disk(md->disk);


Patches currently in stable-queue which might be from EXT-Anna.Lemehova@nokia.com are

queue-2.6.32/mmc_block-add-dev_t-initialization-check.patch
