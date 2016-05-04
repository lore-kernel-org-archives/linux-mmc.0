From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2] mmc: mmc: Attempt to flush cache before reset
Date: Wed, 4 May 2016 10:38:21 +0300
Message-ID: <5729A6ED.4010009@intel.com>
References: <1461829739-19772-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFrzfoR9xDVvSnVuwMFQRABh3jfgRGbjPp=754F3hn8bZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26315 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbcEDHmN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 May 2016 03:42:13 -0400
In-Reply-To: <CAPDyKFrzfoR9xDVvSnVuwMFQRABh3jfgRGbjPp=754F3hn8bZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

CMD0 or hardware reset may invalidate the cache, so it needs to be
flushed before reset.

In the case of recovery, we can't expect flushing the cache to work
always, but have a go and ignore errors.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Do flush in mmc_reset() instead of mmc_hw_reset()


 drivers/mmc/core/mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0cf42af33d0f..d4d1b77c1c1e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1965,6 +1965,12 @@ static int mmc_reset(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
 
+	/*
+	 * In the case of recovery, we can't expect flushing the cache to work
+	 * always, but we have a go and ignore errors.
+	 */
+	mmc_flush_cache(host->card);
+
 	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
 	     mmc_can_reset(card)) {
 		/* If the card accept RST_n signal, send it. */
-- 
1.9.1


