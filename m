From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: core: Substitute mmc_flush_cash for mmc_cache_ctrl in
 suspend
Date: Fri, 10 Feb 2012 12:56:35 +0900
Message-ID: <000101cce7a7$fc0df6b0$f429e410$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57713 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab2BJD4i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 22:56:38 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZ500FY5SA8Z4A0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 10 Feb 2012 12:56:36 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZ5008ESSAC4470@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 10 Feb 2012 12:56:36 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, saugata.das@linaro.org, ygardi@codeaurora.org

After the cache is disabled in suspend, enabling cache can be done by
mmc_init_card in resume. Currently this call path has been changed. In
case of sleep mode mmc_init_card isn't called. So mmc_cache_ctrl need to
be replaced with mmc_flush_cache in suspend.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8a19143..70e25d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2329,9 +2329,14 @@ EXPORT_SYMBOL(mmc_card_can_sleep);
  */
 int mmc_flush_cache(struct mmc_card *card)
 {
-	struct mmc_host *host = card->host;
+	struct mmc_host *host;
 	int err = 0;
 
+	if (!card)
+		return err;
+
+	host = card->host;
+
 	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
 		return err;
 
@@ -2401,7 +2406,7 @@ int mmc_suspend_host(struct mmc_host *host)
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
 	if (mmc_try_claim_host(host)) {
-		err = mmc_cache_ctrl(host, 0);
+		err = mmc_flush_cache(host->card);
 		mmc_do_release_host(host);
 	} else {
 		err = -EBUSY;
-- 
1.7.0.4


