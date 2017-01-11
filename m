From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 11/12] mmc: core: Move public functions from host.h to private headers
Date: Wed, 11 Jan 2017 12:51:17 +0100
Message-ID: <1484135478-2077-12-git-send-email-ulf.hansson@linaro.org>
References: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34772 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbdAKLwH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 06:52:07 -0500
Received: by mail-lf0-f49.google.com with SMTP id v186so80879448lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 03:52:07 -0800 (PST)
In-Reply-To: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

A significant amount of functions are available through the public mmc
host.h header file. Let's slim down this public mmc interface, as to
prevent users from abusing it, by moving some of the functions to private
mmc host.h header file.

This change concentrates on moving the functions into private mmc headers,
following changes may continue with additional clean-ups.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c    |  1 +
 drivers/mmc/core/bus.c      |  1 +
 drivers/mmc/core/debugfs.c  |  1 +
 drivers/mmc/core/host.h     | 49 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/mmc_test.c |  1 +
 drivers/mmc/core/sd.c       |  1 +
 drivers/mmc/core/sdio.c     |  1 +
 include/linux/mmc/host.h    | 48 ++------------------------------------------
 8 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a8300be..7bd0338 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -49,6 +49,7 @@
 #include "block.h"
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
 #include "sd_ops.h"
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 3be2e6a..3012465 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -24,6 +24,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "sdio_cis.h"
 #include "bus.h"
 
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 2843e6a..a1fba57 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -21,6 +21,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "mmc_ops.h"
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 366ce79..fb6a76a 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -11,7 +11,7 @@
 #ifndef _MMC_CORE_HOST_H
 #define _MMC_CORE_HOST_H
 
-struct mmc_host;
+#include <linux/mmc/host.h>
 
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
@@ -21,6 +21,53 @@
 void mmc_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
+void mmc_retune_pause(struct mmc_host *host);
+void mmc_retune_unpause(struct mmc_host *host);
+
+static inline void mmc_retune_recheck(struct mmc_host *host)
+{
+	if (host->hold_retune <= 1)
+		host->retune_now = 1;
+}
+
+static inline int mmc_host_cmd23(struct mmc_host *host)
+{
+	return host->caps & MMC_CAP_CMD23;
+}
+
+static inline int mmc_boot_partition_access(struct mmc_host *host)
+{
+	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
+}
+
+static inline int mmc_host_uhs(struct mmc_host *host)
+{
+	return host->caps &
+		(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+		 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
+		 MMC_CAP_UHS_DDR50);
+}
+
+static inline bool mmc_card_hs200(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_MMC_HS200;
+}
+
+static inline bool mmc_card_ddr52(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_MMC_DDR52;
+}
+
+static inline bool mmc_card_hs400(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
+}
+
+static inline bool mmc_card_hs400es(struct mmc_card *card)
+{
+	return card->host->ios.enhanced_strobe;
+}
+
 
 #endif
 
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 0eac632..1f667fc 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -24,6 +24,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "bus.h"
 
 #define RESULT_OK		0
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d66b08d..8b4f139 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -23,6 +23,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
 #include "sd.h"
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 558ddfc..2b47f02 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -21,6 +21,7 @@
 
 #include "core.h"
 #include "card.h"
+#include "host.h"
 #include "bus.h"
 #include "sd.h"
 #include "sdio_bus.h"
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7de0519..97699d5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -473,56 +473,20 @@ static inline int mmc_card_wake_sdio_irq(struct mmc_host *host)
 	return host->pm_flags & MMC_PM_WAKE_SDIO_IRQ;
 }
 
-static inline int mmc_host_cmd23(struct mmc_host *host)
-{
-	return host->caps & MMC_CAP_CMD23;
-}
-
-static inline int mmc_boot_partition_access(struct mmc_host *host)
-{
-	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
-}
-
-static inline int mmc_host_uhs(struct mmc_host *host)
-{
-	return host->caps &
-		(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-		 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
-		 MMC_CAP_UHS_DDR50);
-}
-
+/* TODO: Move to private header */
 static inline int mmc_card_hs(struct mmc_card *card)
 {
 	return card->host->ios.timing == MMC_TIMING_SD_HS ||
 		card->host->ios.timing == MMC_TIMING_MMC_HS;
 }
 
+/* TODO: Move to private header */
 static inline int mmc_card_uhs(struct mmc_card *card)
 {
 	return card->host->ios.timing >= MMC_TIMING_UHS_SDR12 &&
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
-static inline bool mmc_card_hs200(struct mmc_card *card)
-{
-	return card->host->ios.timing == MMC_TIMING_MMC_HS200;
-}
-
-static inline bool mmc_card_ddr52(struct mmc_card *card)
-{
-	return card->host->ios.timing == MMC_TIMING_MMC_DDR52;
-}
-
-static inline bool mmc_card_hs400(struct mmc_card *card)
-{
-	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
-}
-
-static inline bool mmc_card_hs400es(struct mmc_card *card)
-{
-	return card->host->ios.enhanced_strobe;
-}
-
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
@@ -531,12 +495,6 @@ static inline void mmc_retune_needed(struct mmc_host *host)
 		host->need_retune = 1;
 }
 
-static inline void mmc_retune_recheck(struct mmc_host *host)
-{
-	if (host->hold_retune <= 1)
-		host->retune_now = 1;
-}
-
 static inline bool mmc_can_retune(struct mmc_host *host)
 {
 	return host->can_retune == 1;
@@ -544,7 +502,5 @@ static inline bool mmc_can_retune(struct mmc_host *host)
 
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
-void mmc_retune_pause(struct mmc_host *host);
-void mmc_retune_unpause(struct mmc_host *host);
 
 #endif /* LINUX_MMC_HOST_H */
-- 
1.9.1

