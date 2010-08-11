From: akpm@linux-foundation.org
Subject: [patch 18/24] block: add secure discard
Date: Wed, 11 Aug 2010 14:17:49 -0700
Message-ID: <201008112117.o7BLHn6x015025@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46383 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753717Ab0HKVSO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 17:18:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, axboe@kernel.dk, bengardiner@nanometrics.ca, hch@lst.de, kmpark@infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

From: Adrian Hunter <adrian.hunter@nokia.com>

Secure discard is the same as discard except that all copies of the
discarded sectors (perhaps created by garbage collection) must also be
erased.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Cc: Kyungmin Park <kmpark@infradead.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 block/blk-core.c          |    5 ++++-
 block/blk-lib.c           |    6 ++++++
 block/compat_ioctl.c      |    1 +
 block/elevator.c          |    6 ++++++
 block/ioctl.c             |   15 ++++++++++-----
 include/linux/blk_types.h |    2 ++
 include/linux/blkdev.h    |    7 ++++++-
 include/linux/fs.h        |    2 ++
 kernel/trace/blktrace.c   |    8 ++++++++
 9 files changed, 45 insertions(+), 7 deletions(-)

diff -puN block/blk-core.c~block-add-secure-discard block/blk-core.c
--- a/block/blk-core.c~block-add-secure-discard
+++ a/block/blk-core.c
@@ -1514,7 +1514,10 @@ static inline void __generic_make_reques
 		if (bio_check_eod(bio, nr_sectors))
 			goto end_io;
 
-		if ((bio->bi_rw & REQ_DISCARD) && !blk_queue_discard(q)) {
+		if ((bio->bi_rw & REQ_DISCARD) &&
+		    (!blk_queue_discard(q) ||
+		     ((bio->bi_rw & REQ_SECURE) &&
+		      !blk_queue_secdiscard(q)))) {
 			err = -EOPNOTSUPP;
 			goto end_io;
 		}
diff -puN block/blk-lib.c~block-add-secure-discard block/blk-lib.c
--- a/block/blk-lib.c~block-add-secure-discard
+++ a/block/blk-lib.c
@@ -62,6 +62,12 @@ int blkdev_issue_discard(struct block_de
 		max_discard_sectors &= ~(disc_sects - 1);
 	}
 
+	if (flags & BLKDEV_IFL_SECURE) {
+		if (!blk_queue_secdiscard(q))
+			return -EOPNOTSUPP;
+		type |= DISCARD_SECURE;
+	}
+
 	while (nr_sects && !ret) {
 		bio = bio_alloc(gfp_mask, 1);
 		if (!bio) {
diff -puN block/compat_ioctl.c~block-add-secure-discard block/compat_ioctl.c
--- a/block/compat_ioctl.c~block-add-secure-discard
+++ a/block/compat_ioctl.c
@@ -703,6 +703,7 @@ long compat_blkdev_ioctl(struct file *fi
 	case BLKFLSBUF:
 	case BLKROSET:
 	case BLKDISCARD:
+	case BLKSECDISCARD:
 	/*
 	 * the ones below are implemented in blkdev_locked_ioctl,
 	 * but we call blkdev_ioctl, which gets the lock for us
diff -puN block/elevator.c~block-add-secure-discard block/elevator.c
--- a/block/elevator.c~block-add-secure-discard
+++ a/block/elevator.c
@@ -83,6 +83,12 @@ int elv_rq_merge_ok(struct request *rq, 
 		return 0;
 
 	/*
+	 * Don't merge discard requests and secure discard requests
+	 */
+	if ((bio->bi_rw & REQ_SECURE) != (rq->bio->bi_rw & REQ_SECURE))
+		return 0;
+
+	/*
 	 * different data direction or already started, don't merge
 	 */
 	if (bio_data_dir(bio) != rq_data_dir(rq))
diff -puN block/ioctl.c~block-add-secure-discard block/ioctl.c
--- a/block/ioctl.c~block-add-secure-discard
+++ a/block/ioctl.c
@@ -114,8 +114,10 @@ static int blkdev_reread_part(struct blo
 }
 
 static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
-			     uint64_t len)
+			     uint64_t len, int secure)
 {
+	unsigned long flags = BLKDEV_IFL_WAIT;
+
 	if (start & 511)
 		return -EINVAL;
 	if (len & 511)
@@ -125,8 +127,9 @@ static int blk_ioctl_discard(struct bloc
 
 	if (start + len > (bdev->bd_inode->i_size >> 9))
 		return -EINVAL;
-	return blkdev_issue_discard(bdev, start, len, GFP_KERNEL,
-				    BLKDEV_IFL_WAIT);
+	if (secure)
+		flags |= BLKDEV_IFL_SECURE;
+	return blkdev_issue_discard(bdev, start, len, GFP_KERNEL, flags);
 }
 
 static int put_ushort(unsigned long arg, unsigned short val)
@@ -213,7 +216,8 @@ int blkdev_ioctl(struct block_device *bd
 		set_device_ro(bdev, n);
 		return 0;
 
-	case BLKDISCARD: {
+	case BLKDISCARD:
+	case BLKSECDISCARD: {
 		uint64_t range[2];
 
 		if (!(mode & FMODE_WRITE))
@@ -222,7 +226,8 @@ int blkdev_ioctl(struct block_device *bd
 		if (copy_from_user(range, (void __user *)arg, sizeof(range)))
 			return -EFAULT;
 
-		return blk_ioctl_discard(bdev, range[0], range[1]);
+		return blk_ioctl_discard(bdev, range[0], range[1],
+					 cmd == BLKSECDISCARD);
 	}
 
 	case HDIO_GETGEO: {
diff -puN include/linux/blk_types.h~block-add-secure-discard include/linux/blk_types.h
--- a/include/linux/blk_types.h~block-add-secure-discard
+++ a/include/linux/blk_types.h
@@ -150,6 +150,7 @@ enum rq_flag_bits {
 	__REQ_FLUSH,		/* request for cache flush */
 	__REQ_IO_STAT,		/* account I/O stat */
 	__REQ_MIXED_MERGE,	/* merge of different types, fail separately */
+	__REQ_SECURE,		/* secure discard (used with __REQ_DISCARD) */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -190,5 +191,6 @@ enum rq_flag_bits {
 #define REQ_FLUSH		(1 << __REQ_FLUSH)
 #define REQ_IO_STAT		(1 << __REQ_IO_STAT)
 #define REQ_MIXED_MERGE		(1 << __REQ_MIXED_MERGE)
+#define REQ_SECURE		(1 << __REQ_SECURE)
 
 #endif /* __LINUX_BLK_TYPES_H */
diff -puN include/linux/blkdev.h~block-add-secure-discard include/linux/blkdev.h
--- a/include/linux/blkdev.h~block-add-secure-discard
+++ a/include/linux/blkdev.h
@@ -389,6 +389,7 @@ struct request_queue
 #define QUEUE_FLAG_DISCARD     16	/* supports DISCARD */
 #define QUEUE_FLAG_NOXMERGES   17	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM  18	/* Contributes to random pool */
+#define QUEUE_FLAG_SECDISCARD  19	/* supports SECDISCARD */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_CLUSTER) |		\
@@ -524,6 +525,8 @@ enum {
 #define blk_queue_stackable(q)	\
 	test_bit(QUEUE_FLAG_STACKABLE, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_secdiscard(q)	(blk_queue_discard(q) && \
+	test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flags))
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
@@ -918,10 +921,12 @@ static inline struct request *blk_map_qu
 }
 enum{
 	BLKDEV_WAIT,	/* wait for completion */
-	BLKDEV_BARRIER,	/*issue request with barrier */
+	BLKDEV_BARRIER,	/* issue request with barrier */
+	BLKDEV_SECURE,	/* secure discard */
 };
 #define BLKDEV_IFL_WAIT		(1 << BLKDEV_WAIT)
 #define BLKDEV_IFL_BARRIER	(1 << BLKDEV_BARRIER)
+#define BLKDEV_IFL_SECURE	(1 << BLKDEV_SECURE)
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *,
 			unsigned long);
 extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
diff -puN include/linux/fs.h~block-add-secure-discard include/linux/fs.h
--- a/include/linux/fs.h~block-add-secure-discard
+++ a/include/linux/fs.h
@@ -174,6 +174,7 @@ struct inodes_stat_t {
  */
 #define DISCARD_NOBARRIER	(WRITE | REQ_DISCARD)
 #define DISCARD_BARRIER		(WRITE | REQ_DISCARD | REQ_HARDBARRIER)
+#define DISCARD_SECURE		(DISCARD_NOBARRIER | REQ_SECURE)
 
 #define SEL_IN		1
 #define SEL_OUT		2
@@ -317,6 +318,7 @@ struct inodes_stat_t {
 #define BLKALIGNOFF _IO(0x12,122)
 #define BLKPBSZGET _IO(0x12,123)
 #define BLKDISCARDZEROES _IO(0x12,124)
+#define BLKSECDISCARD _IO(0x12,125)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
diff -puN kernel/trace/blktrace.c~block-add-secure-discard kernel/trace/blktrace.c
--- a/kernel/trace/blktrace.c~block-add-secure-discard
+++ a/kernel/trace/blktrace.c
@@ -710,6 +710,9 @@ static void blk_add_trace_rq(struct requ
 	if (rq->cmd_flags & REQ_DISCARD)
 		rw |= REQ_DISCARD;
 
+	if (rq->cmd_flags & REQ_SECURE)
+		rw |= REQ_SECURE;
+
 	if (rq->cmd_type == REQ_TYPE_BLOCK_PC) {
 		what |= BLK_TC_ACT(BLK_TC_PC);
 		__blk_add_trace(bt, 0, blk_rq_bytes(rq), rw,
@@ -1816,6 +1819,8 @@ void blk_fill_rwbs(char *rwbs, u32 rw, i
 		rwbs[i++] = 'S';
 	if (rw & REQ_META)
 		rwbs[i++] = 'M';
+	if (rw & REQ_SECURE)
+		rwbs[i++] = 'E';
 
 	rwbs[i] = '\0';
 }
@@ -1828,6 +1833,9 @@ void blk_fill_rwbs_rq(char *rwbs, struct
 	if (rq->cmd_flags & REQ_DISCARD)
 		rw |= REQ_DISCARD;
 
+	if (rq->cmd_flags & REQ_SECURE)
+		rw |= REQ_SECURE;
+
 	bytes = blk_rq_bytes(rq);
 
 	blk_fill_rwbs(rwbs, rw, bytes);
_
