From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: core: Add functions for SDIO to hold re-tuning
Date: Tue, 28 Apr 2015 17:45:40 +0300
Message-ID: <1430232341-8307-2-git-send-email-adrian.hunter@intel.com>
References: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26082 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030298AbbD1Orw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Apr 2015 10:47:52 -0400
In-Reply-To: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

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
index 86c495b..63479fa 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -330,6 +330,12 @@ void mmc_retune_hold(struct mmc_host *host)
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
index 992bf53..5e9a129 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -18,6 +18,7 @@ void mmc_unregister_host_class(void);
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
+void mmc_retune_hold_now(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 78cb4d5..01bce0c 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -15,6 +15,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
 
+#include "host.h"
 #include "sdio_ops.h"
 
 /**
@@ -720,3 +721,15 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
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
index aab032a..50d667b 100644
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

