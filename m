From: akpm@linux-foundation.org
Subject: [patch 045/232] mmc: allow host claim / release nesting
Date: Tue, 22 Sep 2009 16:44:30 -0700
Message-ID: <200909222344.n8MNiVXY012318@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54643 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753335AbZIVXpQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Adrian Hunter <adrian.hunter@nokia.com>

This change allows the MMC host to be claimed in situations where the host
may or may not have already been claimed.  Also 'mmc_try_claim_host()' is
now exported.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/core.c  |   34 +++++++++++++++++++++++++---------
 include/linux/mmc/core.h |    1 +
 include/linux/mmc/host.h |    2 ++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff -puN drivers/mmc/core/core.c~mmc-allow-host-claim-release-nesting drivers/mmc/core/core.c
--- a/drivers/mmc/core/core.c~mmc-allow-host-claim-release-nesting
+++ a/drivers/mmc/core/core.c
@@ -461,16 +461,18 @@ int __mmc_claim_host(struct mmc_host *ho
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		stop = abort ? atomic_read(abort) : 0;
-		if (stop || !host->claimed)
+		if (stop || !host->claimed || host->claimer == current)
 			break;
 		spin_unlock_irqrestore(&host->lock, flags);
 		schedule();
 		spin_lock_irqsave(&host->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
-	if (!stop)
+	if (!stop) {
 		host->claimed = 1;
-	else
+		host->claimer = current;
+		host->claim_cnt += 1;
+	} else
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
@@ -481,29 +483,43 @@ int __mmc_claim_host(struct mmc_host *ho
 
 EXPORT_SYMBOL(__mmc_claim_host);
 
-static int mmc_try_claim_host(struct mmc_host *host)
+/**
+ *	mmc_try_claim_host - try exclusively to claim a host
+ *	@host: mmc host to claim
+ *
+ *	Returns %1 if the host is claimed, %0 otherwise.
+ */
+int mmc_try_claim_host(struct mmc_host *host)
 {
 	int claimed_host = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (!host->claimed) {
+	if (!host->claimed || host->claimer == current) {
 		host->claimed = 1;
+		host->claimer = current;
+		host->claim_cnt += 1;
 		claimed_host = 1;
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
 	return claimed_host;
 }
+EXPORT_SYMBOL(mmc_try_claim_host);
 
 static void mmc_do_release_host(struct mmc_host *host)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	host->claimed = 0;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	wake_up(&host->wq);
+	if (--host->claim_cnt) {
+		/* Release for nested claim */
+		spin_unlock_irqrestore(&host->lock, flags);
+	} else {
+		host->claimed = 0;
+		host->claimer = NULL;
+		spin_unlock_irqrestore(&host->lock, flags);
+		wake_up(&host->wq);
+	}
 }
 
 void mmc_host_deeper_disable(struct work_struct *work)
diff -puN include/linux/mmc/core.h~mmc-allow-host-claim-release-nesting include/linux/mmc/core.h
--- a/include/linux/mmc/core.h~mmc-allow-host-claim-release-nesting
+++ a/include/linux/mmc/core.h
@@ -139,6 +139,7 @@ extern unsigned int mmc_align_data_size(
 
 extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
 extern void mmc_release_host(struct mmc_host *host);
+extern int mmc_try_claim_host(struct mmc_host *host);
 
 /**
  *	mmc_claim_host - exclusively claim a host
diff -puN include/linux/mmc/host.h~mmc-allow-host-claim-release-nesting include/linux/mmc/host.h
--- a/include/linux/mmc/host.h~mmc-allow-host-claim-release-nesting
+++ a/include/linux/mmc/host.h
@@ -182,6 +182,8 @@ struct mmc_host {
 	struct mmc_card		*card;		/* device attached to this host */
 
 	wait_queue_head_t	wq;
+	struct task_struct	*claimer;	/* task that has host claimed */
+	int			claim_cnt;	/* "claim" nesting count */
 
 	struct delayed_work	detect;
 
_
