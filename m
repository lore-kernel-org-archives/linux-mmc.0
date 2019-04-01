From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 041/131] mmc: block: Allow more than 8 partitions per card
Date: Mon,  1 Apr 2019 19:01:51 +0200
Message-ID: <20190401170055.758383574@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>, Sasha Levin <sashal@kernel.org>
List-Id: linux-mmc@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 382c55f88ffeb218c446bf0c46d0fc25d2795fe2 ]

It is quite common for Android devices to utilize more
then 8 partitions on internal eMMC storage.

The vanilla kernel can support this via
CONFIG_MMC_BLOCK_MINORS, however that solution caps the
system to 256 minors total, which limits the number of
mmc cards the system can support.

This patch, which has been carried for quite awhile in
the AOSP common tree, provides an alternative solution
that doesn't seem to limit the total card count. So I
wanted to submit it for consideration upstream.

This patch sets the GENHD_FL_EXT_DEVT flag, which will
allocate minor number in major 259 for partitions past
disk->minors.

It also removes the use of disk_devt to determine devidx
from md->disk. md->disk->first_minor is always initialized
from devidx and can always be used to recover it.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Colin Cross <ccross@android.com>
[jstultz: Added context to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/card/block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f2b733275a0a..c15b879c3070 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -171,11 +171,7 @@ static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 
 static inline int mmc_get_devidx(struct gendisk *disk)
 {
-	int devmaj = MAJOR(disk_devt(disk));
-	int devidx = MINOR(disk_devt(disk)) / perdev_minors;
-
-	if (!devmaj)
-		devidx = disk->first_minor / perdev_minors;
+	int devidx = disk->first_minor / perdev_minors;
 	return devidx;
 }
 
@@ -2252,6 +2248,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
-- 
2.19.1
