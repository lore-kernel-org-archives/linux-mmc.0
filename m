From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: fix mmc_{un,}register_pm_notifier prototypes
Date: Fri, 20 Nov 2015 11:28:42 +0100
Message-ID: <7826361.qqKATxLhCV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56522 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375AbbKTK3K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 05:29:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The mmc pm notifiers were recently reworked, but the new
code produces a lot of warnings when CONFIG_PM_SLEEP is disabled:

In file included from ../drivers/mmc/core/sdio_bus.c:27:0:
drivers/mmc/core/core.h:97:13: warning: 'mmc_register_pm_notifier' defined but not used [-Wunused-function]

The obvious solution is to add the 'inline' keyword at the
function definition, as it should be for any function defined
in a header file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0e40be7c20e0 ("mmc: core: Refactor code to register the MMC PM notifier")

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index bd00ac2cdc1b..0fa86a2afc26 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -94,8 +94,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card);
 void mmc_register_pm_notifier(struct mmc_host *host);
 void mmc_unregister_pm_notifier(struct mmc_host *host);
 #else
-static void mmc_register_pm_notifier(struct mmc_host *host) { }
-static void mmc_unregister_pm_notifier(struct mmc_host *host) { }
+static inline void mmc_register_pm_notifier(struct mmc_host *host) { }
+static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
 #endif
 
 #endif

