From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/21] mmc: core: Move public functions from core.h to private headers
Date: Fri, 30 Dec 2016 13:47:26 +0100
Message-ID: <1483102054-1752-14-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33929 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbcL3MsY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:24 -0500
Received: by mail-lf0-f42.google.com with SMTP id y21so236381199lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:24 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

A significant amount of functions are available through the public mmc
core.h header file. Let's slim down this public mmc interface, as to
prevent users from abusing it, by moving some of the functions to private
mmc header files.

This change concentrates on moving the functions into private mmc headers,
following changes may continue with additional clean-ups, as an example
some functions can be turned into static.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c    |  3 +++
 drivers/mmc/core/core.h     | 37 ++++++++++++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.h  |  9 ++++++++
 drivers/mmc/core/mmc_test.c |  2 ++
 drivers/mmc/core/queue.c    |  1 +
 drivers/mmc/core/sd_ops.h   |  4 ++++
 drivers/mmc/core/sdio_io.c  |  1 +
 drivers/mmc/core/sdio_irq.c |  1 +
 drivers/mmc/core/sdio_ops.h |  1 +
 include/linux/mmc/core.h    | 50 ---------------------------------------------
 10 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6648a17..7246995 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -47,6 +47,9 @@
 
 #include "queue.h"
 #include "block.h"
+#include "core.h"
+#include "mmc_ops.h"
+#include "sd_ops.h"
 
 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 29b91ae..8a95c825 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -16,6 +16,7 @@
 
 struct mmc_host;
 struct mmc_card;
+struct mmc_request;
 
 #define MMC_CMD_RETRIES        3
 
@@ -73,6 +74,7 @@ static inline void mmc_delay(unsigned int ms)
 void mmc_stop_host(struct mmc_host *host);
 
 int _mmc_detect_card_removed(struct mmc_host *host);
+int mmc_detect_card_removed(struct mmc_host *host);
 
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
@@ -102,5 +104,38 @@ static inline void mmc_register_pm_notifier(struct mmc_host *host) { }
 static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
 #endif
 
-#endif
+void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq);
+bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
+
+int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+		unsigned int arg);
+int mmc_can_erase(struct mmc_card *card);
+int mmc_can_trim(struct mmc_card *card);
+int mmc_can_discard(struct mmc_card *card);
+int mmc_can_sanitize(struct mmc_card *card);
+int mmc_can_secure_erase_trim(struct mmc_card *card);
+int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
+			unsigned int nr);
+unsigned int mmc_calc_max_discard(struct mmc_card *card);
+
+int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
+int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
+			bool is_rel_write);
+
+int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
+void mmc_release_host(struct mmc_host *host);
+void mmc_get_card(struct mmc_card *card);
+void mmc_put_card(struct mmc_card *card);
+
+/**
+ *	mmc_claim_host - exclusively claim a host
+ *	@host: mmc host to claim
+ *
+ *	Claim a host for a set of operations.
+ */
+static inline void mmc_claim_host(struct mmc_host *host)
+{
+	__mmc_claim_host(host, NULL);
+}
 
+#endif
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index e76365a..74beea8 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -31,12 +31,21 @@
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
+int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
+int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);
+int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+		unsigned int timeout_ms);
+int mmc_stop_bkops(struct mmc_card *card);
+int mmc_read_bkops_status(struct mmc_card *card);
+void mmc_start_bkops(struct mmc_card *card, bool from_exception);
+int mmc_can_reset(struct mmc_card *card);
+int mmc_flush_cache(struct mmc_card *card);
 
 #endif
 
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 3ab6e52..9f1c05d4 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -22,6 +22,8 @@
 #include <linux/seq_file.h>
 #include <linux/module.h>
 
+#include "core.h"
+
 #define RESULT_OK		0
 #define RESULT_FAIL		1
 #define RESULT_UNSUP_HOST	2
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a6496d8..8be0a63 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -20,6 +20,7 @@
 
 #include "queue.h"
 #include "block.h"
+#include "core.h"
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index ac7223c..784f8e6 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -16,6 +16,7 @@
 
 struct mmc_card;
 struct mmc_host;
+struct mmc_command;
 
 int mmc_app_set_bus_width(struct mmc_card *card, int width);
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
@@ -25,6 +26,9 @@
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
+int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
+	struct mmc_command *cmd, int retries);
 
 #endif
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 406e5f0..76fe6d5 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sdio_func.h>
 
 #include "sdio_ops.h"
+#include "core.h"
 
 /**
  *	sdio_claim_host - exclusively claim a bus for a certain SDIO function
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index f1faf9a..d084635 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,7 @@
 #include <linux/mmc/sdio_func.h>
 
 #include "sdio_ops.h"
+#include "core.h"
 
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index e1c36d6..bed8a83 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -24,6 +24,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
 int sdio_reset(struct mmc_host *host);
+unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz);
 
 static inline bool mmc_is_io_op(u32 opcode)
 {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e2ddf..e679a86 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -158,25 +158,13 @@ struct mmc_request {
 struct mmc_card;
 struct mmc_async_req;
 
-extern int mmc_stop_bkops(struct mmc_card *);
-extern int mmc_read_bkops_status(struct mmc_card *);
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *,
 					   enum mmc_blk_status *);
-extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
-extern void mmc_wait_for_req_done(struct mmc_host *host,
-				  struct mmc_request *mrq);
-extern bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
-extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
-extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
-	struct mmc_command *, int);
-extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
-extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
-extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
@@ -188,46 +176,8 @@ extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 #define MMC_SECURE_ARGS		0x80000000
 #define MMC_TRIM_ARGS		0x00008001
 
-extern int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
-		     unsigned int arg);
-extern int mmc_can_erase(struct mmc_card *card);
-extern int mmc_can_trim(struct mmc_card *card);
-extern int mmc_can_discard(struct mmc_card *card);
-extern int mmc_can_sanitize(struct mmc_card *card);
-extern int mmc_can_secure_erase_trim(struct mmc_card *card);
-extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
-				   unsigned int nr);
-extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
-
-extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
-extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
-			      bool is_rel_write);
 extern int mmc_hw_reset(struct mmc_host *host);
-extern int mmc_can_reset(struct mmc_card *card);
-
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
-extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
-
-extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
-extern void mmc_release_host(struct mmc_host *host);
-
-extern void mmc_get_card(struct mmc_card *card);
-extern void mmc_put_card(struct mmc_card *card);
-
-extern int mmc_flush_cache(struct mmc_card *);
-
-extern int mmc_detect_card_removed(struct mmc_host *host);
-
-/**
- *	mmc_claim_host - exclusively claim a host
- *	@host: mmc host to claim
- *
- *	Claim a host for a set of operations.
- */
-static inline void mmc_claim_host(struct mmc_host *host)
-{
-	__mmc_claim_host(host, NULL);
-}
 
 struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
-- 
1.9.1

