From: Colin Cross <ccross@android.com>
Subject: [PATCH] mmc_block: Allow more than 8 partitions per card
Date: Wed,  8 Sep 2010 09:50:37 -0700
Message-ID: <1283964637-28246-1-git-send-email-ccross@android.com>
References: <AANLkTinUNpWsu=AY+1EeG8xznPaESL8XnjGo7613yoMt@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinUNpWsu=AY+1EeG8xznPaESL8XnjGo7613yoMt@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Lei Wen <adrian.wenl@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mandeep Baines <msb@chromium.org>, Colin Cross <ccross@android.com>
List-Id: linux-mmc@vger.kernel.org

Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
in major 259 for partitions past disk->minors.

Also remove the use of disk_devt to determine devidx from md->disk.
md->disk->first_minor is always initialized from devidx and can
always be used to recover it.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/mmc/card/block.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d545f79..07d8eb0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -87,11 +87,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
-		int devmaj = MAJOR(disk_devt(md->disk));
-		int devidx = MINOR(disk_devt(md->disk)) >> MMC_SHIFT;
-
-		if (!devmaj)
-			devidx = md->disk->first_minor >> MMC_SHIFT;
+		int devidx = md->disk->first_minor >> MMC_SHIFT;
 
 		blk_cleanup_queue(md->queue.queue);
 
@@ -607,6 +603,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	md->disk->private_data = md;
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = &card->dev;
+	md->disk->flags = GENHD_FL_EXT_DEVT;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
1.7.1
