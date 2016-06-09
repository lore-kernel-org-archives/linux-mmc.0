From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 36/46] mmc: core: Export mmc_retune_hold() and mmc_retune_release()
Date: Thu,  9 Jun 2016 14:52:36 +0300
Message-ID: <1465473166-22532-37-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbcFIL7K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:59:10 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Re-tuning can only be done when the Command Queue is empty, when means
holding and releasing re-tuning from the block driver, so export those
functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/host.c  | 2 ++
 drivers/mmc/core/host.h  | 2 --
 include/linux/mmc/core.h | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d7e86f9b3dab..946692cc0a06 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -112,6 +112,7 @@ void mmc_retune_hold(struct mmc_host *host)
 		host->retune_now = 1;
 	host->hold_retune += 1;
 }
+EXPORT_SYMBOL(mmc_retune_hold);
 
 void mmc_retune_release(struct mmc_host *host)
 {
@@ -120,6 +121,7 @@ void mmc_retune_release(struct mmc_host *host)
 	else
 		WARN_ON(1);
 }
+EXPORT_SYMBOL(mmc_retune_release);
 
 int mmc_retune(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 992bf5397633..0787b3002481 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -17,8 +17,6 @@ void mmc_unregister_host_class(void);
 
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
-void mmc_retune_hold(struct mmc_host *host);
-void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 
 #endif
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 63dc01257852..4c6d131cafc2 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -204,6 +204,9 @@ extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+extern void mmc_retune_hold(struct mmc_host *host);
+extern void mmc_retune_release(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
1.9.1

