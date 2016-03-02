From: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Subject: [PATCH 1/2] block: Allow to set max_dev_sectors for a queue.
Date: Wed,  2 Mar 2016 09:55:01 +0100
Message-ID: <75ce1abfb958565fa484390f514ac7c1b934c465.1456847028.git.pawelx.wodkowski@intel.com>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21083 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbcCBJGg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2016 04:06:36 -0500
In-Reply-To: <cover.1456847028.git.pawelx.wodkowski@intel.com>
In-Reply-To: <cover.1456847028.git.pawelx.wodkowski@intel.com>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-block@vger.kernel.org
Cc: Mateusz Nowak <mateusz.nowak@intel.com>, linux-mmc@vger.kernel.org

From: Mateusz Nowak <mateusz.nowak@intel.com>

max_dev_sectors is the upper limit for supported block size by the
block device. Since it is used for limiting up max_hw_sectors value
(and, as consequence maximum block size for request), lower level
driver may need to set it to non-default value.
This patch implements function allowing to do so.

Fixes: ca369d51b3e1 ("block/sd: Fix device-imposed transfer length limits")
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Mateusz Nowak <mateusz.nowak@intel.com>
---
 block/blk-settings.c   | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c7bb666aafd1..276920dfacd0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -253,6 +253,30 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
 /**
+ * blk_queue_max_dev_sectors - set max sectors supported by a device for
+ * this queue.
+ * @q:	the request queue for the device
+ * @max_dev_sectors:	max device sectors in the usual 512b unit
+ *
+ * Description:
+ *    Enables a low level driver to set a device supported upper limit,
+ *    max_dev_sectors, on the size of request. max_dev_sectors is set by
+ *    the device driver based upon the capabilities of the device.
+ *
+ *    max_dev_sectors is upper limit for max_hw_sectors value, thus
+ *    it should be set before changing the latter value.
+ **/
+void blk_queue_max_dev_sectors(struct request_queue *q,
+		unsigned int max_dev_sectors)
+{
+	struct queue_limits *limits = &q->limits;
+
+	limits->max_dev_sectors = min_t(unsigned int, max_dev_sectors,
+					BLK_DEF_MAX_SECTORS);
+}
+EXPORT_SYMBOL(blk_queue_max_dev_sectors);
+
+/**
  * blk_queue_chunk_sectors - set size of the chunk for this queue
  * @q:  the request queue for the device
  * @chunk_sectors:  chunk sectors in the usual 512b unit
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4571ef1a12a9..2752d3afcf1c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -967,6 +967,7 @@ extern void blk_cleanup_queue(struct request_queue *);
 extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
+extern void blk_queue_max_dev_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
-- 
1.9.1

