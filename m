From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 12/16] umem: don't override the queue_lock
Date: Wed, 14 Nov 2018 17:02:15 +0100
Message-ID: <20181114160219.28328-13-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
In-Reply-To: <20181114160219.28328-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The umem card->lock and the block layer queue_lock are used for entirely
different resources.  Stop using card->lock as the block layer
queue_lock.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/block/umem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index be3e3ab79950..8a27b5adc2b3 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,8 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->biotail = &card->bio;
 	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE,
-					   &card->lock);
+	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!card->queue)
 		goto failed_alloc;
 
-- 
2.19.1
