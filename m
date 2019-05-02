From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH] mmc: Fix tag set memory leak
Date: Thu,  2 May 2019 13:07:14 -0600
Message-ID: <20190502190714.181664-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com, djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Ming Lei <ming.lei@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The tag set is allocated in mmc_init_queue but never freed. This results
in a memory leak. This change makes sure we free the tag set when the
queue is also freed.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I found this using kmemleak and plugging and unplugging an SD card in a
few times.

Here is an example of the output of kmemleak:
unreferenced object 0xffff888125be4ce8 (size 8):
  comm "kworker/1:0", pid 17, jiffies 4294901575 (age 204.773s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<0000000061cb8887>] blk_mq_alloc_tag_set+0xe9/0x234
    [<00000000cf532a0f>] mmc_init_queue+0xa9/0x2f0
    [<000000001e085171>] mmc_blk_alloc_req+0x125/0x2f9
    [<00000000eae1bd01>] mmc_blk_probe+0x1e2/0x6c1
    [<00000000a0b4a87d>] really_probe+0x1bd/0x3b0
    [<00000000e58f3eb9>] driver_probe_device+0xe1/0x115
    [<00000000358f3b3c>] bus_for_each_drv+0x89/0xac
    [<00000000ef52ccbe>] __device_attach+0xb0/0x14a
    [<00000000c9daafa7>] bus_probe_device+0x33/0x9f
    [<0000000008ac5779>] device_add+0x34b/0x5e2
    [<00000000b42623cc>] mmc_add_card+0x1f5/0x20d
    [<00000000f114ebc3>] mmc_attach_sd+0xc5/0x14b
    [<000000006e915e0d>] mmc_rescan+0x261/0x2b6
    [<00000000e5b49c26>] process_one_work+0x1d3/0x31f
    [<0000000068c8cd3c>] worker_thread+0x1cd/0x2bf
    [<00000000326e2e22>] kthread+0x14f/0x157

Once I applied this patch the leak went away.

p.s., I included a small white space fix. Hope that's ok.

 drivers/mmc/core/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7c364a9c4eeb..176a08748cf1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -402,7 +402,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 
 	mq->card = card;
 	mq->use_cqe = host->cqe_enabled;
-	
+
 	spin_lock_init(&mq->lock);
 
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
@@ -472,6 +472,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 		blk_mq_unquiesce_queue(q);
 
 	blk_cleanup_queue(q);
+	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*
 	 * A request can be completed before the next request, potentially
-- 
2.21.0.593.g511ec345e18-goog
