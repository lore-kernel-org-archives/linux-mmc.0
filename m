From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/4] Limit max_discard_sectors to UINT_MAX>>9
Date: Tue, 25 Mar 2014 16:48:23 -0700
Message-ID: <1395791307-23727-2-git-send-email-gwendal@chromium.org>
References: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, ulf.hansson@linaro.org
Cc: linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: linux-mmc@vger.kernel.org

max_discard_sectors can not be larger than UINT_MAX>>9,
otherwise, there is a risk that discard requests would be merged
into a request larger than 4GB.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2dc3b51..f30128b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -859,7 +859,7 @@ static int __init nbd_init(void)
 		 */
 		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, disk->queue);
 		disk->queue->limits.discard_granularity = 512;
-		disk->queue->limits.max_discard_sectors = UINT_MAX;
+		disk->queue->limits.max_discard_sectors = UINT_MAX >> 9;
 		disk->queue->limits.discard_zeroes_data = 0;
 		blk_queue_max_hw_sectors(disk->queue, 65536);
 		disk->queue->limits.max_sectors = 256;
-- 
1.9.1.423.g4596e3a
