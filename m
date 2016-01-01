From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 5/7] mmc: usdhi6rol0: use to_delayed_work
Date: Fri,  1 Jan 2016 22:59:10 +0800
Message-ID: <a595f073abf2bc9fca98c411e20a1af593b9719d.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:48999 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbcAAPAV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jan 2016 10:00:21 -0500
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rabin Vincent <rabin.vincent@axis.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/mmc/host/usdhi6rol0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index b47122d..b2752fe 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1630,7 +1630,7 @@ static irqreturn_t usdhi6_cd(int irq, void *dev_id)
  */
 static void usdhi6_timeout_work(struct work_struct *work)
 {
-	struct delayed_work *d = container_of(work, struct delayed_work, work);
+	struct delayed_work *d = to_delayed_work(work);
 	struct usdhi6_host *host = container_of(d, struct usdhi6_host, timeout_work);
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_data *data = mrq ? mrq->data : NULL;
-- 
2.5.0


