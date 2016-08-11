From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [REGRESSION] Secure discard is broken
Date: Thu, 11 Aug 2016 11:43:30 +0300
Message-ID: <d0e18115-0b63-207f-4350-29d6a5085e52@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbcHKIsC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Aug 2016 04:48:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi

I noticed some changes in the mmc block driver that did not go
through the mmc tree and they looked wrong so I gave them a test.
And it does seem like secure discard is broken, not just for mmc
but in general too.  The commit was:
288dab8a35a0 ("block: add a separate operation type for secure erase")
When I tried it, it gets stuck in blk_queue_bio:

# Performing secure-erase from 5120000000 count 4096 (from sector 10000000 sector count 8)
[  942.771946] INFO: rcu_sched self-detected stall on CPU
[  942.777800]  2-...: (20998 ticks this GP) idle=3ed/140000000000001/0 softirq=2568/2568 fqs=5250 
[  942.787765]   (t=21000 jiffies g=1729 c=1728 q=202)
[  942.793307] Task dump for CPU 2:
[  942.796956] mmc-erase4.stat R  running task    14512  1936   1605 0x00000008
[  942.804984]  0000000000000087 ffff880173c83dd8 ffffffff81080eef 0000000000000002
[  942.813414]  0000000000000087 ffff880173c83df0 ffffffff810833e4 0000000000000002
[  942.821850]  ffff880173c83e20 ffffffff81123635 ffff880173c988c0 ffffffff81e431c0
[  942.830292] Call Trace:
[  942.833056]  <IRQ>  [<ffffffff81080eef>] sched_show_task+0xbf/0x120
[  942.840179]  [<ffffffff810833e4>] dump_cpu_task+0x34/0x40
[  942.846307]  [<ffffffff81123635>] rcu_dump_cpu_stacks+0x79/0xb4
[  942.853023]  [<ffffffff810aff07>] rcu_check_callbacks+0x717/0x870
[  942.859937]  [<ffffffff810f0bfc>] ? __acct_update_integrals+0x2c/0xb0
[  942.867244]  [<ffffffff810c3980>] ? tick_sched_do_timer+0x30/0x30
[  942.874158]  [<ffffffff810b4e8a>] update_process_times+0x2a/0x50
[  942.880971]  [<ffffffff810c33e1>] tick_sched_handle.isra.13+0x31/0x40
[  942.888273]  [<ffffffff810c39b8>] tick_sched_timer+0x38/0x70
[  942.894688]  [<ffffffff810b5b0a>] __hrtimer_run_queues+0xda/0x250
[  942.901602]  [<ffffffff810b5f53>] hrtimer_interrupt+0xa3/0x190
[  942.908219]  [<ffffffff8103e643>] local_apic_timer_interrupt+0x33/0x60
[  942.915627]  [<ffffffff8103f148>] smp_apic_timer_interrupt+0x38/0x50
[  942.922837]  [<ffffffff8199cfcf>] apic_timer_interrupt+0x7f/0x90
[  942.929651]  <EOI>  [<ffffffff81329501>] ? blk_queue_split+0x251/0x520
[  942.937074]  [<ffffffff8132891c>] ? create_task_io_context+0x1c/0xf0
[  942.944282]  [<ffffffff81325490>] blk_queue_bio+0x40/0x350
[  942.950506]  [<ffffffff81323a3b>] generic_make_request+0xcb/0x1a0
[  942.957403]  [<ffffffff81323b76>] submit_bio+0x66/0x120
[  942.963328]  [<ffffffff8132b608>] ? next_bio+0x18/0x40
[  942.969159]  [<ffffffff8132b783>] ? __blkdev_issue_discard+0x153/0x1b0
[  942.976564]  [<ffffffff8131aeb9>] submit_bio_wait+0x49/0x60
[  942.982886]  [<ffffffff8132b975>] blkdev_issue_discard+0x65/0xa0
[  942.989701]  [<ffffffff81092b0f>] ? __wake_up+0x3f/0x50
[  942.995632]  [<ffffffff813fd241>] ? tty_ldisc_deref+0x11/0x20
[  943.002151]  [<ffffffff81331848>] blk_ioctl_discard+0x78/0x90
[  943.008658]  [<ffffffff81332454>] blkdev_ioctl+0x714/0x8a0
[  943.014880]  [<ffffffff811b62d8>] block_ioctl+0x38/0x40
[  943.020801]  [<ffffffff8119265b>] do_vfs_ioctl+0x8b/0x590
[  943.026925]  [<ffffffff81192bd4>] SyS_ioctl+0x74/0x80
[  943.032656]  [<ffffffff8199c41b>] entry_SYSCALL_64_fastpath+0x13/0x8f

I made a few hacks that seemed to make it go but I expect there are more
places to change:

diff --git a/block/bio.c b/block/bio.c
index f39477538fef..8a69af062b9c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -667,7 +667,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
-	if (bio_op(bio) == REQ_OP_DISCARD)
+	if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
 		goto integrity_clone;
 
 	if (bio_op(bio) == REQ_OP_WRITE_SAME) {
@@ -1788,7 +1788,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	 * Discards need a mutable bio_vec to accommodate the payload
 	 * required by the DSM TRIM and UNMAP commands.
 	 */
-	if (bio_op(bio) == REQ_OP_DISCARD)
+	if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
 		split = bio_clone_bioset(bio, gfp, bs);
 	else
 		split = bio_clone_fast(bio, gfp, bs);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3eec75a9e91d..b995ab078755 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -172,7 +172,8 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 	struct bio *split, *res;
 	unsigned nsegs;
 
-	if (bio_op(*bio) == REQ_OP_DISCARD)
+	if (bio_op(*bio) == REQ_OP_DISCARD ||
+	    bio_op(*bio) == REQ_OP_SECURE_ERASE)
 		split = blk_bio_discard_split(q, *bio, bs, &nsegs);
 	else if (bio_op(*bio) == REQ_OP_WRITE_SAME)
 		split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
@@ -213,7 +214,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	 * This should probably be returning 0, but blk_add_request_payload()
 	 * (Christoph!!!!)
 	 */
-	if (bio_op(bio) == REQ_OP_DISCARD)
+	if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
 		return 1;
 
 	if (bio_op(bio) == REQ_OP_WRITE_SAME)
@@ -385,7 +386,8 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	nsegs = 0;
 	cluster = blk_queue_cluster(q);
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
+	if (bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_SECURE_ERASE) {
 		/*
 		 * This is a hack - drivers should be neither modifying the
 		 * biovec, nor relying on bi_vcnt - but because of
diff --git a/block/elevator.c b/block/elevator.c
index 7096c22041e7..f5e2cec71f15 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -368,6 +368,8 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
 
 		if ((req_op(rq) == REQ_OP_DISCARD) != (req_op(pos) == REQ_OP_DISCARD))
 			break;
+		if ((req_op(rq) == REQ_OP_SECURE_ERASE) != (req_op(pos) == REQ_OP_SECURE_ERASE))
+			break;
 		if (rq_data_dir(rq) != rq_data_dir(pos))
 			break;
 		if (pos->cmd_flags & stop_flags)
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd740f3b..82503e6f04b3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1726,6 +1726,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
 			break;
 
 		if (req_op(next) == REQ_OP_DISCARD ||
+		    req_op(next) == REQ_OP_SECURE_ERASE ||
 		    req_op(next) == REQ_OP_FLUSH)
 			break;
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index bf14642a576a..29578e98603d 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -33,7 +33,8 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	/*
 	 * We only like normal block requests and discards.
 	 */
-	if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD) {
+	if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD &&
+	    req_op(req) != REQ_OP_SECURE_ERASE) {
 		blk_dump_rq_flags(req, "MMC bad request");
 		return BLKPREP_KILL;
 	}
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index d62531124d54..fee5e1271465 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -4,7 +4,9 @@
 static inline bool mmc_req_is_special(struct request *req)
 {
 	return req &&
-		(req_op(req) == REQ_OP_FLUSH || req_op(req) == REQ_OP_DISCARD);
+		(req_op(req) == REQ_OP_FLUSH ||
+		 req_op(req) == REQ_OP_DISCARD ||
+		 req_op(req) == REQ_OP_SECURE_ERASE);
 }
 
 struct request;


Regards
Adrian
