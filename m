From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/8 v5] mmc: ops: export mmc_get_status()
Date: Sun, 20 Aug 2017 23:39:07 +0200
Message-ID: <20170820213913.9737-3-linus.walleij@linaro.org>
References: <20170820213913.9737-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:37275 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTVj0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 17:39:26 -0400
Received: by mail-lf0-f46.google.com with SMTP id f7so39962699lfg.4
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 14:39:25 -0700 (PDT)
In-Reply-To: <20170820213913.9737-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

This function retrieves the status of the card with the default
number of retries. Since the block layer wants to use this, and
since the block layer is a loadable kernel module, we need to
export this symbol.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- No changes just resending
ChangeLog v3->v4:
- No changes just resending
ChangeLog v2->v3:
- New patch to fix a build error, enumerating v3 to keep it
  together with the other patches.
---
 drivers/mmc/core/mmc_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 6dd8ecde5079..54686ca4bfb7 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -83,6 +83,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	return __mmc_send_status(card, status, MMC_CMD_RETRIES);
 }
+EXPORT_SYMBOL_GPL(mmc_send_status);
 
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
-- 
2.13.5

