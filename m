From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/3] mmc_block: add dev_t initialization check
Date: Fri, 18 Dec 2009 14:15:33 +0200
Message-ID: <20091218121533.4351.45325.sendpatchset@ahunter-work.research.nokia.com>
References: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56077 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZLRMQ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2009 07:16:56 -0500
In-Reply-To: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

>From 96404dc52f2cfa73541ed221febf83e54d7556a9 Mon Sep 17 00:00:00 2001
From: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>
Date: Fri, 30 Oct 2009 10:45:54 +0100
Subject: [PATCH] mmc_block: add dev_t initialization check

When a card is removed before mmc_blk_probe() has called add_disk(),
then the minor field is uninitialized and has value 0. This caused
mmc_blk_put() to always release devidx 0 even if 0 was still in use.
Then the next mmc_blk_probe() used the first free idx of 0, which
oopses in sysfs, since it is used by another card.

Signed-off-by: Anna Lemehova <EXT-Anna.Lemehova@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/block.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 85f0e8c..5988573 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -85,7 +85,12 @@ static void mmc_blk_put(struct mmc_blk_data *md)
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
-- 
1.6.0.4

