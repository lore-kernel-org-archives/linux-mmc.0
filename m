From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc: export function mmc_do_release_host
Date: Sat, 5 Mar 2011 14:07:44 +0100
Message-ID: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:34834 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753214Ab1CENIY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 08:08:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Ulf Hansson <ulf.hansson@stericsson.com>

When using mmc_try_claim_host the corresponding release
function is mmc_do_release_host, which then also must
be exported.

Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
Reviewed-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c  |    3 ++-
 include/linux/mmc/core.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 579ba1e..2521794 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -527,7 +527,7 @@ int mmc_try_claim_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_try_claim_host);
 
-static void mmc_do_release_host(struct mmc_host *host)
+void mmc_do_release_host(struct mmc_host *host)
 {
 	unsigned long flags;
 
@@ -542,6 +542,7 @@ static void mmc_do_release_host(struct mmc_host *host)
 		wake_up(&host->wq);
 	}
 }
+EXPORT_SYMBOL(mmc_do_release_host);
 
 void mmc_host_deeper_disable(struct work_struct *work)
 {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e013f..07f27af 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -160,6 +160,7 @@ extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
 
 extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
 extern void mmc_release_host(struct mmc_host *host);
+extern void mmc_do_release_host(struct mmc_host *host);
 extern int mmc_try_claim_host(struct mmc_host *host);
 
 /**
-- 
1.7.3.2

