From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 21/21] mmc: core: Don't use extern declarations of public mmc functions
Date: Fri, 30 Dec 2016 13:47:34 +0100
Message-ID: <1483102054-1752-22-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34030 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbcL3Mst (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:49 -0500
Received: by mail-lf0-f42.google.com with SMTP id y21so236385724lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:48 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Using extern when declaring functions in the public header, core.h, is
redundant. Let's just remove the use of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/core.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6440e10..6dcb339 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -158,13 +158,14 @@ struct mmc_request {
 struct mmc_card;
 struct mmc_async_req;
 
-extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
-					   struct mmc_async_req *,
-					   enum mmc_blk_status *);
-extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
-extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
-
-extern int mmc_hw_reset(struct mmc_host *host);
-extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
+struct mmc_async_req *mmc_start_req(struct mmc_host *host,
+				struct mmc_async_req *areq,
+				enum mmc_blk_status *ret_stat);
+void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
+int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
+		int retries);
+
+int mmc_hw_reset(struct mmc_host *host);
+void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.9.1

