From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] mmc: block: mmcblkN: use slot index instead of dynamic
	name index
Date: Mon, 6 Aug 2012 09:24:59 +0200
Message-ID: <1344237900-14815-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
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

On embedded devices, often there is a combination of removable mmc
devices (e.g. MMC/SD cards) and hard wired ones (e.g. eMMC).
Depending on the hardware configuration, the 'mmcblkN' node might
change if the removable device is available or not at boot time.

E.g. if the removable device is attached at boot time, it might
become mmxblk0. And the hard wired one mmcblk1. But if the removable
device isn't there at boot time, the hard wired one will become
mmcblk0. This makes it somehow difficult to hard code the root device
to the non-removable device and boot fast.

This change does simply associate 'N' of 'mmcblkN' with the slot index
instead of the dynamic name index. The slot index is always the same,
ensuring that the non-removable mmc device is associated always
with the same mmcblkN. Independent of the availability of the removable
one.

This issue has a long history. One prominent one is e.g. from the
Maemo based Nokia N810 device:

https://bugs.maemo.org/show_bug.cgi?id=2747

Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
CC: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f1c84de..a01d306 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1517,7 +1517,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 */
 
 	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
+		 "mmcblk%d%s", card->host->index, subname ? subname : "");
 
 	if (mmc_card_mmc(card))
 		blk_queue_logical_block_size(md->queue.queue,
-- 
1.7.0.4
