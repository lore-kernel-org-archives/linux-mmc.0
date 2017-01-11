From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 03/12] mmc: core: First step in cleaning up private mmc header files
Date: Wed, 11 Jan 2017 12:51:09 +0100
Message-ID: <1484135478-2077-4-git-send-email-ulf.hansson@linaro.org>
References: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35865 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbdAKLvk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 06:51:40 -0500
Received: by mail-lf0-f50.google.com with SMTP id o140so80118789lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 03:51:40 -0800 (PST)
In-Reply-To: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

This is the first step in cleaning up the private mmc header files. In this
change we makes sure each header file builds standalone, as that helps to
resolve dependencies.

While changing this, it also seems reasonable to stop including other
headers from inside a header itself which it don't depend upon.
Additionally, in some cases such dependencies are better resolved by
forward declaring the needed struct.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.h     | 8 ++++++++
 drivers/mmc/core/bus.h       | 4 ++++
 drivers/mmc/core/core.h      | 4 ++++
 drivers/mmc/core/host.h      | 3 ++-
 drivers/mmc/core/mmc_ops.h   | 5 +++++
 drivers/mmc/core/pwrseq.h    | 6 +++++-
 drivers/mmc/core/queue.h     | 6 +++++-
 drivers/mmc/core/sd.h        | 5 ++++-
 drivers/mmc/core/sd_ops.h    | 5 +++++
 drivers/mmc/core/sdio_bus.h  | 3 +++
 drivers/mmc/core/sdio_cis.h  | 3 +++
 drivers/mmc/core/sdio_ops.h  | 4 ++++
 drivers/mmc/core/slot-gpio.h | 2 ++
 13 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index cdabb2e..00b7483 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -1 +1,9 @@
+#ifndef _MMC_CORE_BLOCK_H
+#define _MMC_CORE_BLOCK_H
+
+struct mmc_queue;
+struct request;
+
 int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
+
+#endif
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 00a1971..93b516a 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -11,6 +11,10 @@
 #ifndef _MMC_CORE_BUS_H
 #define _MMC_CORE_BUS_H
 
+struct mmc_host;
+struct mmc_card;
+struct device_type;
+
 #define MMC_DEV_ATTR(name, fmt, args...)					\
 static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 0fa86a2..29b91ae 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -12,6 +12,10 @@
 #define _MMC_CORE_CORE_H
 
 #include <linux/delay.h>
+#include <linux/sched.h>
+
+struct mmc_host;
+struct mmc_card;
 
 #define MMC_CMD_RETRIES        3
 
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 992bf53..366ce79 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -10,7 +10,8 @@
  */
 #ifndef _MMC_CORE_HOST_H
 #define _MMC_CORE_HOST_H
-#include <linux/mmc/host.h>
+
+struct mmc_host;
 
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index abd525e..e76365a 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -12,6 +12,11 @@
 #ifndef _MMC_MMC_OPS_H
 #define _MMC_MMC_OPS_H
 
+#include <linux/types.h>
+
+struct mmc_host;
+struct mmc_card;
+
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index d69e751..39c911a 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -8,7 +8,11 @@
 #ifndef _MMC_CORE_PWRSEQ_H
 #define _MMC_CORE_PWRSEQ_H
 
-#include <linux/mmc/host.h>
+#include <linux/types.h>
+
+struct mmc_host;
+struct device;
+struct module;
 
 struct mmc_pwrseq_ops {
 	void (*pre_power_on)(struct mmc_host *host);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index dac8c3d..0cea02a 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -1,6 +1,11 @@
 #ifndef MMC_QUEUE_H
 #define MMC_QUEUE_H
 
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+
 static inline bool mmc_req_is_special(struct request *req)
 {
 	return req &&
@@ -9,7 +14,6 @@ static inline bool mmc_req_is_special(struct request *req)
 		 req_op(req) == REQ_OP_SECURE_ERASE);
 }
 
-struct request;
 struct task_struct;
 struct mmc_blk_data;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index aab824a..1ada980 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -1,10 +1,13 @@
 #ifndef _MMC_CORE_SD_H
 #define _MMC_CORE_SD_H
 
-#include <linux/mmc/card.h>
+#include <linux/types.h>
 
 extern struct device_type sd_type;
 
+struct mmc_host;
+struct mmc_card;
+
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index ffc2305..ac7223c 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -12,6 +12,11 @@
 #ifndef _MMC_SD_OPS_H
 #define _MMC_SD_OPS_H
 
+#include <linux/types.h>
+
+struct mmc_card;
+struct mmc_host;
+
 int mmc_app_set_bus_width(struct mmc_card *card, int width);
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
diff --git a/drivers/mmc/core/sdio_bus.h b/drivers/mmc/core/sdio_bus.h
index 567a768..b69a254 100644
--- a/drivers/mmc/core/sdio_bus.h
+++ b/drivers/mmc/core/sdio_bus.h
@@ -11,6 +11,9 @@
 #ifndef _MMC_CORE_SDIO_BUS_H
 #define _MMC_CORE_SDIO_BUS_H
 
+struct mmc_card;
+struct sdio_func;
+
 struct sdio_func *sdio_alloc_func(struct mmc_card *card);
 int sdio_add_func(struct sdio_func *func);
 void sdio_remove_func(struct sdio_func *func);
diff --git a/drivers/mmc/core/sdio_cis.h b/drivers/mmc/core/sdio_cis.h
index 4d903c2..16aa563 100644
--- a/drivers/mmc/core/sdio_cis.h
+++ b/drivers/mmc/core/sdio_cis.h
@@ -14,6 +14,9 @@
 #ifndef _MMC_SDIO_CIS_H
 #define _MMC_SDIO_CIS_H
 
+struct mmc_card;
+struct sdio_func;
+
 int sdio_read_common_cis(struct mmc_card *card);
 void sdio_free_common_cis(struct mmc_card *card);
 
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index 5660c7f..e1c36d6 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -12,8 +12,12 @@
 #ifndef _MMC_SDIO_OPS_H
 #define _MMC_SDIO_OPS_H
 
+#include <linux/types.h>
 #include <linux/mmc/sdio.h>
 
+struct mmc_host;
+struct mmc_card;
+
 int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, u8 in, u8* out);
diff --git a/drivers/mmc/core/slot-gpio.h b/drivers/mmc/core/slot-gpio.h
index 8c1854d..a06fd84 100644
--- a/drivers/mmc/core/slot-gpio.h
+++ b/drivers/mmc/core/slot-gpio.h
@@ -8,6 +8,8 @@
 #ifndef _MMC_CORE_SLOTGPIO_H
 #define _MMC_CORE_SLOTGPIO_H
 
+struct mmc_host;
+
 int mmc_gpio_alloc(struct mmc_host *host);
 
 #endif
-- 
1.9.1

