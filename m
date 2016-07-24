From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] mmc: moxart: fix spin_lock flags type
Date: Sun, 24 Jul 2016 18:43:55 +0200
Message-ID: <1469378635-15942-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:41527 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbcGXQk5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 24 Jul 2016 12:40:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Luis de Bethencourt <luis@debethencourt.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

fix compile warning due to flags being declared long rather than
unsigned long.

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
 
 drivers/mmc/host/moxart-mmc.c: In function 'moxart_request':
 drivers/mmc/host/moxart-mmc.c:403:2: warning: comparison of distinct pointer
 types lacks a cast [enabled by default]
 drivers/mmc/host/moxart-mmc.c:427:4: warning: comparison of distinct pointer
 types lacks a cast [enabled by default]
 drivers/mmc/host/moxart-mmc.c:438:4: warning: comparison of distinct pointer
 types lacks a cast [enabled by default]

Compile tested with: moxart_defconfig + ARCH_MULTI_V4=y,
CONFIG_ARCH_MOXART=y, CONFIG_MMC_MOXART=y

Patch is against 4.7.0-rc7 (localversion-next -next-20160724)

 drivers/mmc/host/moxart-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 2e5c25f..bbad309 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -397,7 +397,8 @@ static void moxart_prepare_data(struct moxart_host *host)
 static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct moxart_host *host = mmc_priv(mmc);
-	long pio_time, flags;
+	long pio_time;
+	unsigned long flags;
 	u32 status;
 
 	spin_lock_irqsave(&host->lock, flags);
-- 
2.1.4

