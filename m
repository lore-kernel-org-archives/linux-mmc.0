From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6 v3] mmc: ops: export mmc_get_status()
Date: Thu,  8 Jun 2017 10:54:00 +0200
Message-ID: <20170608085403.11795-4-linus.walleij@linaro.org>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35997 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdFHIyW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:22 -0400
Received: by mail-lf0-f51.google.com with SMTP id o83so15230658lff.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:21 -0700 (PDT)
In-Reply-To: <20170608085403.11795-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

This function retrieves the status of the card with the default
number of retries. Since the block layer wants to use this, and
since the block layer is a loadable kernel module, we need to
export this symbol.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- New patch to fix a build error, enumerating v3 to keep it
  together with the other patches.
---
 drivers/mmc/core/mmc_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ae1fc4818240..e6e47aef3849 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -82,6 +82,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	return __mmc_send_status(card, status, MMC_CMD_RETRIES);
 }
+EXPORT_SYMBOL_GPL(mmc_send_status);
 
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
-- 
2.9.4

