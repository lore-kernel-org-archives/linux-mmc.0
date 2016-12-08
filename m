From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/2] mmc: core: Add functions for SDIO to hold re-tuning
Date: Thu,  8 Dec 2016 11:56:39 +0200
Message-ID: <1481191000-19305-2-git-send-email-adrian.hunter@intel.com>
References: <1481191000-19305-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31588 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbcLHKBp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 05:01:45 -0500
In-Reply-To: <1481191000-19305-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>

Add sdio_retune_hold_now() and sdio_retune_release()
in order to allow SDIO function drivers to prevent
re-tuning in cases where it conflicts with the
device state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/host.c       |  6 ++++++
 drivers/mmc/core/host.h       |  1 +
 drivers/mmc/core/sdio_io.c    | 13 +++++++++++++
 include/linux/mmc/sdio_func.h |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ffb4258..6c0f33c70b4a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -113,6 +113,12 @@ void mmc_retune_hold(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
+void mmc_retune_hold_now(struct mmc_host *host)
+{
+	host->retune_now = 0;
+	host->hold_retune += 1;
+}
+
 void mmc_retune_release(struct mmc_host *host)
 {
 	if (host->hold_retune)
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 992bf5397633..5e9a1293091b 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -18,6 +18,7 @@
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
+void mmc_retune_hold_now(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 406e5f037e32..a840d8c76a24 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -15,6 +15,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
 
+#include "host.h"
 #include "sdio_ops.h"
 
 /**
@@ -735,3 +736,15 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
+
+void sdio_retune_hold_now(struct sdio_func *func)
+{
+	mmc_retune_hold_now(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
+
+void sdio_retune_release(struct sdio_func *func)
+{
+	mmc_retune_release(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_release);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index aab032a6ae61..50d667b76a08 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -159,4 +159,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 
+extern void sdio_retune_hold_now(struct sdio_func *func);
+extern void sdio_retune_release(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */
-- 
1.9.1

