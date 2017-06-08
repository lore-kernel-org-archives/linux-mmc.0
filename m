From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/9] mmc: core: Make mmc_can_reset() static
Date: Thu,  8 Jun 2017 15:27:41 +0200
Message-ID: <1496928465-25004-6-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36283 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbdFHN17 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:27:59 -0400
Received: by mail-lf0-f41.google.com with SMTP id o83so18027993lff.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:27:58 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 3 +--
 drivers/mmc/core/mmc_ops.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e3b6bea..ff6cdc3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2097,7 +2097,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-int mmc_can_reset(struct mmc_card *card)
+static int mmc_can_reset(struct mmc_card *card)
 {
 	u8 rst_n_function;
 
@@ -2106,7 +2106,6 @@ int mmc_can_reset(struct mmc_card *card)
 		return 0;
 	return 1;
 }
-EXPORT_SYMBOL(mmc_can_reset);
 
 static int mmc_reset(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 063500c..9d6b15b 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -44,7 +44,6 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 int mmc_stop_bkops(struct mmc_card *card);
 int mmc_read_bkops_status(struct mmc_card *card);
 void mmc_start_bkops(struct mmc_card *card, bool from_exception);
-int mmc_can_reset(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
-- 
2.7.4

