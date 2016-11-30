From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: queue: add #ifdef around bounce buffer code
Date: Wed, 30 Nov 2016 22:03:59 +0100
Message-ID: <20161130210427.1721327-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@fb.com>, Harjani Ritesh <riteshh@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The two functions that got split out from the bounce
buffer handling are now unused when CONFIG_MMC_BLOCK_BOUNCE
is disabled:

mmc/card/queue.c:212:12: error: 'mmc_queue_alloc_bounce_sgs' defined but not used [-Werror=unused-function]
mmc/card/queue.c:189:13: error: 'mmc_queue_alloc_bounce_bufs' defined but not used [-Werror=unused-function]

This adds a new #ifdef around them.

Fixes: 0a6321310492 ("mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/card/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8d10fab701b6..6ae6bfb8b221 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -186,6 +186,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
 static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
 					unsigned int bouncesz)
 {
@@ -226,6 +227,7 @@ static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
 
 	return 0;
 }
+#endif
 
 static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 {
-- 
2.9.0
