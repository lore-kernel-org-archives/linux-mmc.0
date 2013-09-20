From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH] mmc: core: remove dead function mmc_try_claim_host
Date: Thu, 19 Sep 2013 18:21:36 -0700
Message-ID: <1379640096-32383-1-git-send-email-grundler@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>
List-Id: linux-mmc@vger.kernel.org

cscsope says there are no callers for mmc_try_claim_host in the kernel.
No reason to keep it.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/mmc/core/core.c  | 25 -------------------------
 include/linux/mmc/core.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bf18b6b..006ead2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -918,31 +918,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 EXPORT_SYMBOL(__mmc_claim_host);
 
 /**
- *	mmc_try_claim_host - try exclusively to claim a host
- *	@host: mmc host to claim
- *
- *	Returns %1 if the host is claimed, %0 otherwise.
- */
-int mmc_try_claim_host(struct mmc_host *host)
-{
-	int claimed_host = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	if (!host->claimed || host->claimer == current) {
-		host->claimed = 1;
-		host->claimer = current;
-		host->claim_cnt += 1;
-		claimed_host = 1;
-	}
-	spin_unlock_irqrestore(&host->lock, flags);
-	if (host->ops->enable && claimed_host && host->claim_cnt == 1)
-		host->ops->enable(host);
-	return claimed_host;
-}
-EXPORT_SYMBOL(mmc_try_claim_host);
-
-/**
  *	mmc_release_host - release a host
  *	@host: mmc host to release
  *
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index da51bec..a00fc49 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -188,7 +188,6 @@ extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
 
 extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
 extern void mmc_release_host(struct mmc_host *host);
-extern int mmc_try_claim_host(struct mmc_host *host);
 
 extern void mmc_get_card(struct mmc_card *card);
 extern void mmc_put_card(struct mmc_card *card);
-- 
1.8.4
