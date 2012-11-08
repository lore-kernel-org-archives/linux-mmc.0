From: dragos.tatulea@intel.com
Subject: [PATCH v2 07/26] mmc: panic write: bypass host claiming
Date: Thu,  8 Nov 2012 15:06:05 +0200
Message-ID: <1352379984-18381-8-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

We don't want to claim/release host during a panic dump.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/mmc/core/core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06c42cf..dbe5332 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -767,6 +767,9 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	unsigned long flags;
 	int stop;
 
+	if (mmc_am_panic_task(host))
+		return 0;
+
 	might_sleep();
 
 	add_wait_queue(&host->wq, &wait);
@@ -807,6 +810,9 @@ int mmc_try_claim_host(struct mmc_host *host)
 	int claimed_host = 0;
 	unsigned long flags;
 
+	if (mmc_am_panic_task(host))
+		return 1;
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (!host->claimed || host->claimer == current) {
 		host->claimed = 1;
@@ -837,6 +843,9 @@ void mmc_release_host(struct mmc_host *host)
 	if (host->ops->disable && host->claim_cnt == 1)
 		host->ops->disable(host);
 
+	if (mmc_am_panic_task(host))
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (--host->claim_cnt) {
 		/* Release for nested claim */
-- 
1.7.9.5
