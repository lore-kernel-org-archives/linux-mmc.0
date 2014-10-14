From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/7] mmc: core: Remove unused mmc_list_to_card() macro
Date: Tue, 14 Oct 2014 13:45:20 +0200
Message-ID: <1413287120-10914-8-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:45173 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:43 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so8363242lab.27
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:42 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/card.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 64f4136..0ba8f25 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -509,8 +509,6 @@ static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
 
 #define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
 
-#define mmc_list_to_card(l)	container_of(l, struct mmc_card, node)
-
 extern int mmc_register_driver(struct device_driver *);
 extern void mmc_unregister_driver(struct device_driver *);
 
-- 
1.9.1

