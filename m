From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] mmc: block: remove unused name_idx
Date: Mon, 6 Aug 2012 09:25:00 +0200
Message-ID: <1344237900-14815-2-git-send-email-dirk.behme@de.bosch.com>
References: <1344237900-14815-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1344237900-14815-1-git-send-email-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-embedded-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

With the previous patch "mmc: block: mmcblkN: use slot index instead of
dynamic name index" name_idx is not needed any more.

Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
CC: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/card/block.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a01d306..555d840 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -74,7 +74,6 @@ static int max_devices;
 
 /* 256 minors, so at most 256 separate devices */
 static DECLARE_BITMAP(dev_use, 256);
-static DECLARE_BITMAP(name_use, 256);
 
 /*
  * There is one mmc_blk_data per slot.
@@ -92,7 +91,6 @@ struct mmc_blk_data {
 	unsigned int	usage;
 	unsigned int	read_only;
 	unsigned int	part_type;
-	unsigned int	name_idx;
 	unsigned int	reset_done;
 #define MMC_BLK_READ		BIT(0)
 #define MMC_BLK_WRITE		BIT(1)
@@ -1458,19 +1456,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		goto out;
 	}
 
-	/*
-	 * !subname implies we are creating main mmc_blk_data that will be
-	 * associated with mmc_card with mmc_set_drvdata. Due to device
-	 * partitions, devidx will not coincide with a per-physical card
-	 * index anymore so we keep track of a name index.
-	 */
-	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
-		__set_bit(md->name_idx, name_use);
-	} else
-		md->name_idx = ((struct mmc_blk_data *)
-				dev_to_disk(parent)->private_data)->name_idx;
-
 	md->area_type = area_type;
 
 	/*
@@ -1660,7 +1645,6 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 	struct list_head *pos, *q;
 	struct mmc_blk_data *part_md;
 
-	__clear_bit(md->name_idx, name_use);
 	list_for_each_safe(pos, q, &md->part) {
 		part_md = list_entry(pos, struct mmc_blk_data, part);
 		list_del(pos);
-- 
1.7.0.4
