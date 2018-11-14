From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 03/16] block: don't hold the queue_lock over
	blk_abort_request
Date: Wed, 14 Nov 2018 17:02:06 +0100
Message-ID: <20181114160219.28328-4-hch@lst.de>
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

There is nothing it could synchronize against, so don't go through
the pains of acquiring the lock.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 block/blk-timeout.c                 |  2 +-
 drivers/ata/libata-eh.c             |  4 ----
 drivers/block/mtip32xx/mtip32xx.c   |  5 +----
 drivers/scsi/libsas/sas_ata.c       |  5 -----
 drivers/scsi/libsas/sas_scsi_host.c | 10 ++--------
 5 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 3b0179fbdd6a..124c26128bf6 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -75,7 +75,7 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
  * This function requests that the block layer start recovery for the
  * request by deleting the timer and calling the q's timeout function.
  * LLDDs who implement their own error recovery MAY ignore the timeout
- * event if they generated blk_abort_req. Must hold queue lock.
+ * event if they generated blk_abort_request.
  */
 void blk_abort_request(struct request *req)
 {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 01306c018398..938ed513b070 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -919,8 +919,6 @@ static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct request_queue *q = qc->scsicmd->device->request_queue;
-	unsigned long flags;
 
 	WARN_ON(!ap->ops->error_handler);
 
@@ -932,9 +930,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
 	 * this function completes.
 	 */
-	spin_lock_irqsave(q->queue_lock, flags);
 	blk_abort_request(qc->scsicmd->request);
-	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
 /**
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index a4c44db097e0..2b0ac9d01e51 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2770,10 +2770,7 @@ static int mtip_service_thread(void *data)
 
 			blk_mq_quiesce_queue(dd->queue);
 
-			spin_lock(dd->queue->queue_lock);
-			blk_mq_tagset_busy_iter(&dd->tags,
-							mtip_queue_cmd, dd);
-			spin_unlock(dd->queue->queue_lock);
+			blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 4f6cdf53e913..c90b278cc28c 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -601,12 +601,7 @@ void sas_ata_task_abort(struct sas_task *task)
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
 	if (qc->scsicmd) {
-		struct request_queue *q = qc->scsicmd->device->request_queue;
-		unsigned long flags;
-
-		spin_lock_irqsave(q->queue_lock, flags);
 		blk_abort_request(qc->scsicmd->request);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 		return;
 	}
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 33229348dcb6..af085432c5fe 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -930,16 +930,10 @@ void sas_task_abort(struct sas_task *task)
 		return;
 	}
 
-	if (dev_is_sata(task->dev)) {
+	if (dev_is_sata(task->dev))
 		sas_ata_task_abort(task);
-	} else {
-		struct request_queue *q = sc->device->request_queue;
-		unsigned long flags;
-
-		spin_lock_irqsave(q->queue_lock, flags);
+	else
 		blk_abort_request(sc->request);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
 }
 
 void sas_target_destroy(struct scsi_target *starget)
-- 
2.19.1
