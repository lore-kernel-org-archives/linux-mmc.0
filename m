From: akpm@linux-foundation.org
Subject: [patch 19/42] mmc_block: add dev_t initialization check
Date: Fri, 08 Jan 2010 14:42:58 -0800
Message-ID: <201001082242.o08Mgw16018479@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41828 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab0AHWuH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2010 17:50:07 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, EXT-Anna.Lemehova@nokia.com, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org, stable@kernel.org

From: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>

When a card is removed before mmc_blk_probe() has called add_disk(), then
the minor field is uninitialized and has value 0.  This caused
mmc_blk_put() to always release devidx 0 even if 0 was still in use.  Then
the next mmc_blk_probe() used the first free idx of 0, which oopses in
sysfs, since it is used by another card.

Signed-off-by: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/card/block.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN drivers/mmc/card/block.c~mmc_block-add-dev_t-initialization-check drivers/mmc/card/block.c
--- a/drivers/mmc/card/block.c~mmc_block-add-dev_t-initialization-check
+++ a/drivers/mmc/card/block.c
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
_
