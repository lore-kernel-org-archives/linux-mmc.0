From: Qiang Liu <b32616@freescale.com>
Subject: [PATCH 1/2] SD/MMC: add an interface to re-initialize bounce buffer
Date: Thu, 24 Nov 2011 11:06:16 +0800
Message-ID: <1322103977-7155-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:30040
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab1KXDiN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 22:38:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: leoli@freescale.com, Qiang Liu <b32616@freescale.com>

1. use variable instead of MMC_QUEUE_BOUNCESZ;
2. Re-initialize bounce buffer accorinding to new bounce size at run-time;

Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
Here is the test results with different mmc bounce size, IOzone is used to
test performance of mass data transmission.
Environment:
PowerPC P1022DS platform, Sandisk Class 10, 4G memory card, EXT4 filesystem
[root@p2020ds root]# cat /sys/fs/   block/mmcblk0/bouncesz
65536
[root@p2020ds root]# mount /dev/mmcblk0p1 /mnt/
EXT4-fs (mmcblk0p1): mounted filesystem without journal. Opts: 
[root@p2020ds root]# iozone -Rab result -i0 -i1 -r64 =-  -n1g -g4g -f /mnt/ff
........
              KB  reclen   write rewrite    read    reread
         1048576      64   14229   13286   662028   663372
         2097152      64   13758   12605    49549    47443
         4194304      64   13435   12215    21974    22096
........
[root@p2020ds root]# echo 262144 > /sys/block/mmcblk0/bouncesz
[root@p2020ds root]# cat /sys/block/mmcblk0/bouncesz
262144
[root@p2020ds root]# iozone -Rab result -i0 -i1 -r64 -n1g -g4g -f /mnt/ff
........
              KB  reclen   write rewrite    read    reread
         1048576      64   19228   19416   676659   677785
         2097152      64   18512   18499    26978    27055
         4194304      64   17932   18185    21945    21805
........
[root@p2020ds root]# echo 8192 > /sys/block/mmcblk0/bouncesz
[root@p2020ds root]# cat /sys/block/mmcblk0/bouncesz
8192
[root@p2020ds root]# iozone -Rab result -i0 -i1 -r64 -n1g -g1g -f /mnt/ff
              KB  reclen   write rewrite    read    reread
         1048576      64    5068    3324   640266   641609
-------------------------------------------------------------------------------
 drivers/mmc/card/queue.c |  102 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.h |    6 +++
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index dcad59c..c563e33 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -21,7 +21,9 @@
 #include "queue.h"

 #define MMC_QUEUE_BOUNCESZ	65536
-
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+unsigned mmc_queue_bouncesz = MMC_QUEUE_BOUNCESZ;
+#endif
 #define MMC_QUEUE_SUSPENDED	(1 << 0)

 /*
@@ -185,7 +187,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (host->max_segs == 1) {
 		unsigned int bouncesz;

-		bouncesz = MMC_QUEUE_BOUNCESZ;
+		bouncesz = mmc_queue_bouncesz;

 		if (bouncesz > host->max_req_size)
 			bouncesz = host->max_req_size;
@@ -329,6 +331,102 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 EXPORT_SYMBOL(mmc_cleanup_queue);

 /**
+ * mmc_reinit_bounce_queue - re-initialise a bounce buffer.
+ * @mq: mmc queue
+ * @card: mmc card to attach this queue
+ * @bouncesz: the bounce size that need re-initializing
+ *
+ * Initialise a MMC card request queue.
+ */
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+int mmc_reinit_bounce_queue(struct mmc_queue *mq, struct mmc_card *card,
+		   unsigned int bouncesz)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_queue_req *mqrq_cur = &mq->mqrq[0];
+	struct mmc_queue_req *mqrq_prev = &mq->mqrq[1];
+	int ret;
+	struct scatterlist *curr_bounce_sg, *prev_bounce_sg;
+	char *curr_bounce_buf, *prev_bounce_buf;
+
+	mmc_claim_host(card->host);
+
+	bouncesz = min(bouncesz, host->max_req_size);
+	bouncesz = min(bouncesz, host->max_seg_size);
+	bouncesz = min(bouncesz, host->max_blk_count * 512);
+
+	/* store current using addr of bounce_buf and bounce_sg */
+	curr_bounce_sg = mqrq_cur->bounce_sg;
+	prev_bounce_sg = mqrq_prev->bounce_sg;
+	curr_bounce_buf = mqrq_cur->bounce_buf;
+	prev_bounce_buf = mqrq_prev->bounce_buf;
+
+	if (host->max_segs != 1)
+		goto restore_queue;
+
+	/* realloc bounce queue use given bounce size */
+	mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+	if (!mqrq_cur->bounce_buf) {
+		printk(KERN_WARNING "%s: unable to "
+			"allocate bounce cur buffer\n",
+			mmc_card_name(card));
+		ret = -ENOMEM;
+		goto restore_queue;
+	}
+
+	mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+	if (!mqrq_prev->bounce_buf) {
+		printk(KERN_WARNING "%s: unable to "
+			"allocate bounce prev buffer\n",
+			mmc_card_name(card));
+		kfree(mqrq_cur->bounce_buf);
+		mqrq_cur->bounce_buf = NULL;
+		ret = -ENOMEM;
+		goto restore_queue;
+	}
+
+	mqrq_cur->bounce_sg =
+		mmc_alloc_sg(bouncesz / 512, &ret);
+	if (ret)
+		goto cleanup_queue;
+
+	mqrq_prev->bounce_sg =
+		mmc_alloc_sg(bouncesz / 512, &ret);
+	if (ret)
+		goto cleanup_queue;
+
+	blk_queue_max_hw_sectors(mq->queue, bouncesz / 512);
+	blk_queue_max_segments(mq->queue, bouncesz / 512);
+	blk_queue_max_segment_size(mq->queue, bouncesz);
+	mmc_queue_bouncesz = bouncesz;
+
+	kfree(curr_bounce_sg);
+	kfree(prev_bounce_sg);
+	kfree(curr_bounce_buf);
+	kfree(prev_bounce_buf);
+
+	mmc_release_host(card->host);
+	return 0;
+
+cleanup_queue:
+	/* cleanup bounce queue first */
+	kfree(mqrq_cur->sg);
+	kfree(mqrq_cur->bounce_buf);
+	kfree(mqrq_prev->sg);
+	kfree(mqrq_prev->bounce_buf);
+
+restore_queue:
+	mqrq_cur->bounce_buf = curr_bounce_buf;
+	mqrq_prev->bounce_buf = prev_bounce_buf;
+	mqrq_cur->bounce_sg = curr_bounce_sg;
+	mqrq_prev->bounce_sg = prev_bounce_sg;
+
+	mmc_release_host(card->host);
+	return ret;
+}
+#endif
+
+/**
  * mmc_queue_suspend - suspend a MMC request queue
  * @mq: MMC queue to suspend
  *
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index d2a1eb4..468356f 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -37,6 +37,8 @@ struct mmc_queue {

 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 			  const char *);
+extern int mmc_reinit_bounce_queue(struct mmc_queue *, struct mmc_card *,
+		unsigned int);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
@@ -46,4 +48,8 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
 extern void mmc_queue_bounce_post(struct mmc_queue_req *);

+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+extern unsigned mmc_queue_bouncesz;
+#endif
+
 #endif
--
1.6.4


