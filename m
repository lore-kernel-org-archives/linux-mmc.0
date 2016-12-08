From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 08/11] mmc: core: Export mmc_retune_hold() and mmc_retune_release()
Date: Thu,  8 Dec 2016 10:44:35 +0200
Message-ID: <1481186678-6307-9-git-send-email-adrian.hunter@intel.com>
References: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbcLHIuQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:50:16 -0500
In-Reply-To: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Re-tuning can only be done when the Command Queue is empty, when means
holding and releasing re-tuning from the block driver, so export those
functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
---
 drivers/mmc/core/host.c  | 2 ++
 drivers/mmc/core/host.h  | 2 --
 include/linux/mmc/core.h | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ffb4258..878405e28bdb 100644
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
@@ -17,8 +17,6 @@
 
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
-void mmc_retune_hold(struct mmc_host *host);
-void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 
 #endif
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 5d2819b2f543..3152135af4fd 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -221,6 +221,9 @@ extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+extern void mmc_retune_hold(struct mmc_host *host);
+extern void mmc_retune_release(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
1.9.1

