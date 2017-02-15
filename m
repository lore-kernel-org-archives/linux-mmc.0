From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/5] mmc: core: change quirks.c to be a header file
Date: Wed, 15 Feb 2017 16:35:28 +0800
Message-ID: <1487147732-81724-2-git-send-email-shawn.lin@rock-chips.com>
References: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:56219 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdBOIiF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 03:38:05 -0500
In-Reply-To: <1487147732-81724-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Rename quirks.c to quirks.h, and include it for
individual C files which need it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- remove __maybe_unused and clean up the header files

Changes in v2:
- add __maybe_unused to make it cleanly compiled standalone
  suggested by Ulf
- add inline for mmc_fixup_device

 drivers/mmc/core/Makefile               | 2 +-
 drivers/mmc/core/block.c                | 1 +
 drivers/mmc/core/card.h                 | 2 --
 drivers/mmc/core/mmc.c                  | 1 +
 drivers/mmc/core/{quirks.c => quirks.h} | 8 ++------
 drivers/mmc/core/sdio.c                 | 1 +
 6 files changed, 6 insertions(+), 9 deletions(-)
 rename drivers/mmc/core/{quirks.c => quirks.h} (90%)

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 0f81464..7e3ed1a 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,7 +7,7 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   quirks.o slot-gpio.o
+				   slot-gpio.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 985477c..ce5e2a2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -52,6 +52,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd_ops.h"
 
 MODULE_ALIAS("mmc:block");
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 95e8fc5..f06cd91 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -218,6 +218,4 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_HPI;
 }
 
-void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table);
-
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f1a451e..d0e6b6f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -25,6 +25,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd_ops.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.h
similarity index 90%
rename from drivers/mmc/core/quirks.c
rename to drivers/mmc/core/quirks.h
index bf25a9c..1e56ec4 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.h
@@ -9,10 +9,6 @@
  *
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/mmc/card.h>
 #include <linux/mmc/sdio_ids.h>
 
 #include "card.h"
@@ -53,7 +49,8 @@
 	END_FIXUP
 };
 
-void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
+static inline void mmc_fixup_device(struct mmc_card *card,
+				    const struct mmc_fixup *table)
 {
 	const struct mmc_fixup *f;
 	u64 rev = cid_rev_card(card);
@@ -82,4 +79,3 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
 		}
 	}
 }
-EXPORT_SYMBOL(mmc_fixup_device);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index a64a870..f092a55 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -23,6 +23,7 @@
 #include "card.h"
 #include "host.h"
 #include "bus.h"
+#include "quirks.h"
 #include "sd.h"
 #include "sdio_bus.h"
 #include "mmc_ops.h"
-- 
1.9.1


