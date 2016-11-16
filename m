From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Wed, 16 Nov 2016 11:51:04 +0100
Message-ID: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

The MMC/SD block core request processing thread is taking a
semaphore in the request processing section and the same
semaphore is taken around suspend/resume operations.

The purpose of the semaphore is to block any request from being
issued to the MMC/SD host controllers when the system is
suspended. A semaphore is used in place of a mutex since the
calls are coming from different threads.

This construction predates the kernel thread freezer mechanism:
we can easily replace the semaphore by instead activating the
freezer with set_freezable() and call try_to_freeze() instead
of the up(); schedule(); down(); construction that is devised
to let the suspend/resume calls get in and grab the semaphore.

Tested with a few suspend/resume to memory cycles on the Ux500
when doing intense dd operations in the background: the
thread thaws and resumes operation after resume.

Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I haven't seen any need to preserve the call to schedule()
in the request processing thread, but I want advice on whether
that has a point. I would guess the thread will just anyway
be preempted if needed anyway as it is marked interruptible?
---
 drivers/mmc/card/queue.c | 13 ++-----------
 drivers/mmc/card/queue.h |  1 -
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8037f73a109a..09a932ffe46e 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -55,8 +55,8 @@ static int mmc_queue_thread(void *d)
 	struct request_queue *q = mq->queue;
 
 	current->flags |= PF_MEMALLOC;
+	set_freezable();
 
-	down(&mq->thread_sem);
 	do {
 		struct request *req = NULL;
 
@@ -95,12 +95,9 @@ static int mmc_queue_thread(void *d)
 				set_current_state(TASK_RUNNING);
 				break;
 			}
-			up(&mq->thread_sem);
-			schedule();
-			down(&mq->thread_sem);
+			try_to_freeze();
 		}
 	} while (1);
-	up(&mq->thread_sem);
 
 	return 0;
 }
@@ -289,8 +286,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			goto cleanup_queue;
 	}
 
-	sema_init(&mq->thread_sem, 1);
-
 	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
 		host->index, subname ? subname : "");
 
@@ -424,8 +419,6 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
 		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		down(&mq->thread_sem);
 	}
 }
 
@@ -441,8 +434,6 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	if (mq->flags & MMC_QUEUE_SUSPENDED) {
 		mq->flags &= ~MMC_QUEUE_SUSPENDED;
 
-		up(&mq->thread_sem);
-
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
 		spin_unlock_irqrestore(q->queue_lock, flags);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 3c15a75bae86..fe10f94795de 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -53,7 +53,6 @@ struct mmc_queue_req {
 struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
-	struct semaphore	thread_sem;
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
-- 
2.7.4

