From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 15/21] mmc: core: Move erase/trim/discard defines from public core.h to mmc.h
Date: Fri, 30 Dec 2016 13:47:28 +0100
Message-ID: <1483102054-1752-16-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33959 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbcL3Msb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:31 -0500
Received: by mail-lf0-f54.google.com with SMTP id y21so236382458lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:30 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

As the public mmc.h header already contains similar defines for other mmc
commands and arguments, let's move those for erase/trim/discard into here
as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/core.h | 10 ----------
 include/linux/mmc/mmc.h  | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index faacc90..6440e10 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -164,16 +164,6 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 
-#define MMC_ERASE_ARG		0x00000000
-#define MMC_SECURE_ERASE_ARG	0x80000000
-#define MMC_TRIM_ARG		0x00000001
-#define MMC_DISCARD_ARG		0x00000003
-#define MMC_SECURE_TRIM1_ARG	0x80000001
-#define MMC_SECURE_TRIM2_ARG	0x80008000
-
-#define MMC_SECURE_ARGS		0x80000000
-#define MMC_TRIM_ARGS		0x00008001
-
 extern int mmc_hw_reset(struct mmc_host *host);
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 261772e..8f78543 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -462,12 +462,23 @@ struct _mmc_csd {
 /*
  * MMC_SWITCH access modes
  */
-
 #define MMC_SWITCH_MODE_CMD_SET		0x00	/* Change the command set */
 #define MMC_SWITCH_MODE_SET_BITS	0x01	/* Set bits which are 1 in value */
 #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
+/*
+ * Erase/trim/discard
+ */
+#define MMC_ERASE_ARG			0x00000000
+#define MMC_SECURE_ERASE_ARG		0x80000000
+#define MMC_TRIM_ARG			0x00000001
+#define MMC_DISCARD_ARG			0x00000003
+#define MMC_SECURE_TRIM1_ARG		0x80000001
+#define MMC_SECURE_TRIM2_ARG		0x80008000
+#define MMC_SECURE_ARGS			0x80000000
+#define MMC_TRIM_ARGS			0x00008001
+
 #define mmc_driver_type_mask(n)		(1 << (n))
 
 #endif /* LINUX_MMC_MMC_H */
-- 
1.9.1

