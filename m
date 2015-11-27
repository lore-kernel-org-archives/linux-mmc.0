From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH] mmc: usdhi6rol0: handle NULL data in timeout
Date: Fri, 27 Nov 2015 12:59:11 +0100
Message-ID: <1448625551-32328-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:42909 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbbK0L7S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Nov 2015 06:59:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Rabin Vincent <rabinv@axis.com>

bb08a7d489bd22 ("mmc: usdhi6rol0: fix NULL pointer deref in debug
print") fixed one NULL pointer dereference but unfortunately introduced
another.  "data" may be NULL if this is a command timeout for a command
without any data, so we should only use it if we're actually waiting for
data.

Fixes: bb08a7d("mmc: usdhi6rol0: fix NULL pointer deref in debug print")
Cc: stable@vger.kernel.org # v4.3
Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 4498e92..b47122d 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1634,7 +1634,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	struct usdhi6_host *host = container_of(d, struct usdhi6_host, timeout_work);
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_data *data = mrq ? mrq->data : NULL;
-	struct scatterlist *sg = host->sg ?: data->sg;
+	struct scatterlist *sg;
 
 	dev_warn(mmc_dev(host->mmc),
 		 "%s timeout wait %u CMD%d: IRQ 0x%08x:0x%08x, last IRQ 0x%08x\n",
@@ -1666,6 +1666,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	case USDHI6_WAIT_FOR_MWRITE:
 	case USDHI6_WAIT_FOR_READ:
 	case USDHI6_WAIT_FOR_WRITE:
+		sg = host->sg ?: data->sg;
 		dev_dbg(mmc_dev(host->mmc),
 			"%c: page #%u @ +0x%zx %ux%u in SG%u. Current SG %u bytes @ %u\n",
 			data->flags & MMC_DATA_READ ? 'R' : 'W', host->page_idx,
-- 
1.7.10.4

